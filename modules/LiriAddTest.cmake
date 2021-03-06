#
# Copyright (C) 2018 Pier Luigi Fiorini <pierluigi.fiorini@gmail.com>
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
#
# 1. Redistributions of source code must retain the copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. The name of the author may not be used to endorse or promote products
#    derived from this software without specific prior written permission.
#
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
#

function(liri_add_test name)
    # Find packages we need
    find_package(Qt5 "5.0" CONFIG REQUIRED COMPONENTS Core Test)

    # Parse arguments
    _liri_parse_all_arguments(
        _arg "liri_add_test"
        "RUN_SERIAL"
        ""
        "${__default_private_args}"
        ${ARGN}
    )

    # Target
    liri_add_executable("${name}"
        SOURCES ${_arg_SOURCES}
        OUTPUT_DIRECTORY "${CMAKE_CURRENT_BINARY_DIR}"
        INCLUDE_DIRECTORIES
            "${CMAKE_CURRENT_SOURCE_DIR}"
            "${CMAKE_CURRENT_BINARY_DIR}"
            ${_arg_INCLUDE_DIRECTORIES}
        DEFINES ${_arg_DEFINES}
        LIBRARIES "Qt5::Core;Qt5::Test;${_arg_LIBRARIES}"
        DBUS_ADAPTOR_SOURCES ${_arg_DBUS_ADAPTOR_SOURCES}
        DBUS_ADAPTOR_FLAGS ${_arg_DBUS_ADAPTOR_FLAGS}
        DBUS_INTERFACE_SOURCES ${_arg_DBUS_INTERFACE_SOURCES}
        DBUS_INTERFACE_FLAGS ${_arg_DBUS_INTERFACE_FLAGS}
        NO_TARGET_INSTALLATION
    )
    add_test(
        NAME "${name}"
        COMMAND "${name}"
        WORKING_DIRECTORY "${CMAKE_CURRENT_SOURCE_DIR}"
    )
    set_tests_properties("${name}" PROPERTIES RUN_SERIAL ${_arg_RUN_SERIAL})
    set_property(TEST "${name}" APPEND PROPERTY ENVIRONMENT "PATH=${CMAKE_INSTALL_PREFIX}/${INSTALL_BINDIR}${LIRI_PATH_SEPARATOR}$ENV{PATH}")
    set_property(TEST "${name}" APPEND PROPERTY ENVIRONMENT "QT_PLUGIN_PATH=${CMAKE_INSTALL_PREFIX}/${INSTALL_PLUGINSDIR}${LIRI_PATH_SEPARATOR}$ENV{QT_PLUGIN_PATH}")
    set_property(TEST "${name}" APPEND PROPERTY ENVIRONMENT "QML2_IMPORT_PATH=${CMAKE_INSTALL_PREFIX}/${INSTALL_QMLDIR}${LIRI_PATH_SEPARATOR}$ENV{QML2_IMPORT_PATH}")
endfunction()
