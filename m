Return-Path: <SRS0=9yXi=U7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B0F7C06510
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:07:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4C8420836
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jul 2019 11:07:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4C8420836
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hiGdD-0006rK-1z
	for qemu-devel@archiver.kernel.org; Tue, 02 Jul 2019 07:07:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51019)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <armbru@redhat.com>) id 1hiGJw-0005pm-GT
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <armbru@redhat.com>) id 1hiGJp-0007o1-Ss
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33668)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <armbru@redhat.com>) id 1hiGJo-0007g8-2U
 for qemu-devel@nongnu.org; Tue, 02 Jul 2019 06:47:24 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 3631530832DA
 for <qemu-devel@nongnu.org>; Tue,  2 Jul 2019 10:47:21 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-102.ams2.redhat.com
 [10.36.116.102])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A6A7060C43;
 Tue,  2 Jul 2019 10:47:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B42291132986; Tue,  2 Jul 2019 12:47:16 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: qemu-devel@nongnu.org
Date: Tue,  2 Jul 2019 12:47:03 +0200
Message-Id: <20190702104716.9140-6-armbru@redhat.com>
In-Reply-To: <20190702104716.9140-1-armbru@redhat.com>
References: <20190702104716.9140-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.44]); Tue, 02 Jul 2019 10:47:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 05/18] qapi: Split qom.json and qdev.json off
 misc.json
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Move commands object-add, object-del, qom-get, qom-list,
qom-list-properties, qom-list-types, and qom-set with their types from
misc.json to new qom.json.

Move commands device-list-properties, device_add, device-del, and
event DEVICE_DELETED from misc.json to new qdev.json.

Add both new files to MAINTAINERS section QOM.

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Daniel P. Berrange" <berrange@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20190619201050.19040-5-armbru@redhat.com>
Reviewed-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
[Straightforwardly updated for "MAINTAINERS: Make section "QOM" cover
qdev as well"]
---
 MAINTAINERS           |   2 +
 hw/block/xen-block.c  |   2 +-
 hw/core/qdev.c        |   2 +-
 monitor/hmp-cmds.c    |   1 +
 monitor/qmp-cmds.c    |   1 +
 qapi/Makefile.objs    |   5 +-
 qapi/misc.json        | 351 ------------------------------------------
 qapi/qapi-schema.json |   2 +
 qapi/qdev.json        | 125 +++++++++++++++
 qapi/qom.json         | 244 +++++++++++++++++++++++++++++
 qdev-monitor.c        |   2 +-
 11 files changed, 381 insertions(+), 356 deletions(-)
 create mode 100644 qapi/qdev.json
 create mode 100644 qapi/qom.json

diff --git a/MAINTAINERS b/MAINTAINERS
index 3d139b61ff..ecab4310a3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2039,6 +2039,8 @@ F: include/hw/qdev*
 F: include/monitor/qdev.h
 F: include/qom/
 X: include/qom/cpu.h
+F: qapi/qom.json
+F: qapi/qdev.json
 F: qdev-monitor.c
 F: qom/
 X: qom/cpu.c
diff --git a/hw/block/xen-block.c b/hw/block/xen-block.c
index 8f224ef81d..69d73196e2 100644
--- a/hw/block/xen-block.c
+++ b/hw/block/xen-block.c
@@ -11,7 +11,7 @@
 #include "qemu/option.h"
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block-core.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-qom.h"
 #include "qapi/qapi-visit-block-core.h"
 #include "qapi/qobject-input-visitor.h"
 #include "qapi/visitor.h"
diff --git a/hw/core/qdev.c b/hw/core/qdev.c
index f9b6efe509..94ebc0a4a1 100644
--- a/hw/core/qdev.c
+++ b/hw/core/qdev.c
@@ -29,7 +29,7 @@
 #include "hw/qdev.h"
 #include "sysemu/sysemu.h"
 #include "qapi/error.h"
-#include "qapi/qapi-events-misc.h"
+#include "qapi/qapi-events-qdev.h"
 #include "qapi/qmp/qerror.h"
 #include "qapi/visitor.h"
 #include "qemu/error-report.h"
diff --git a/monitor/hmp-cmds.c b/monitor/hmp-cmds.c
index 5082fcd016..d94ab7563e 100644
--- a/monitor/hmp-cmds.c
+++ b/monitor/hmp-cmds.c
@@ -34,6 +34,7 @@
 #include "qapi/qapi-commands-migration.h"
 #include "qapi/qapi-commands-misc.h"
 #include "qapi/qapi-commands-net.h"
+#include "qapi/qapi-commands-qdev.h"
 #include "qapi/qapi-commands-rocker.h"
 #include "qapi/qapi-commands-run-state.h"
 #include "qapi/qapi-commands-tpm.h"
diff --git a/monitor/qmp-cmds.c b/monitor/qmp-cmds.c
index 01ce77e129..33f32ad72a 100644
--- a/monitor/qmp-cmds.c
+++ b/monitor/qmp-cmds.c
@@ -34,6 +34,7 @@
 #include "qapi/error.h"
 #include "qapi/qapi-commands-block-core.h"
 #include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-qdev.h"
 #include "qapi/qapi-commands-ui.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
diff --git a/qapi/Makefile.objs b/qapi/Makefile.objs
index 729e5185c5..40b1dcffc4 100644
--- a/qapi/Makefile.objs
+++ b/qapi/Makefile.objs
@@ -6,8 +6,9 @@ util-obj-y +=3D qmp-event.o
 util-obj-y +=3D qapi-util.o
=20
 QAPI_COMMON_MODULES =3D audio authz block-core block char common crypto
-QAPI_COMMON_MODULES +=3D introspect job migration misc net rdma rocker
-QAPI_COMMON_MODULES +=3D run-state sockets tpm trace transaction ui
+QAPI_COMMON_MODULES +=3D introspect job migration misc net
+QAPI_COMMON_MODULES +=3D qdev qom rdma rocker run-state sockets tpm
+QAPI_COMMON_MODULES +=3D trace transaction ui
 QAPI_TARGET_MODULES =3D target
 QAPI_MODULES =3D $(QAPI_COMMON_MODULES) $(QAPI_TARGET_MODULES)
=20
diff --git a/qapi/misc.json b/qapi/misc.json
index dc4cf9da20..5fbda70ad8 100644
--- a/qapi/misc.json
+++ b/qapi/misc.json
@@ -1342,140 +1342,6 @@
   'data': {'command-line': 'str', '*cpu-index': 'int'},
   'returns': 'str' }
=20
-##
-# @ObjectPropertyInfo:
-#
-# @name: the name of the property
-#
-# @type: the type of the property.  This will typically come in one of f=
our
-#        forms:
-#
-#        1) A primitive type such as 'u8', 'u16', 'bool', 'str', or 'dou=
ble'.
-#           These types are mapped to the appropriate JSON type.
-#
-#        2) A child type in the form 'child<subtype>' where subtype is a=
 qdev
-#           device type name.  Child properties create the composition t=
ree.
-#
-#        3) A link type in the form 'link<subtype>' where subtype is a q=
dev
-#           device type name.  Link properties form the device model gra=
ph.
-#
-# @description: if specified, the description of the property.
-#
-# Since: 1.2
-##
-{ 'struct': 'ObjectPropertyInfo',
-  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
-
-##
-# @qom-list:
-#
-# This command will list any properties of a object given a path in the =
object
-# model.
-#
-# @path: the path within the object model.  See @qom-get for a descripti=
on of
-#        this parameter.
-#
-# Returns: a list of @ObjectPropertyInfo that describe the properties of=
 the
-#          object.
-#
-# Since: 1.2
-#
-# Example:
-#
-# -> { "execute": "qom-list",
-#      "arguments": { "path": "/chardevs" } }
-# <- { "return": [ { "name": "type", "type": "string" },
-#                  { "name": "parallel0", "type": "child<chardev-vc>" },
-#                  { "name": "serial0", "type": "child<chardev-vc>" },
-#                  { "name": "mon0", "type": "child<chardev-stdio>" } ] =
}
-#
-##
-{ 'command': 'qom-list',
-  'data': { 'path': 'str' },
-  'returns': [ 'ObjectPropertyInfo' ],
-  'allow-preconfig': true }
-
-##
-# @qom-get:
-#
-# This command will get a property from a object model path and return t=
he
-# value.
-#
-# @path: The path within the object model.  There are two forms of suppo=
rted
-#        paths--absolute and partial paths.
-#
-#        Absolute paths are derived from the root object and can follow =
child<>
-#        or link<> properties.  Since they can follow link<> properties,=
 they
-#        can be arbitrarily long.  Absolute paths look like absolute fil=
enames
-#        and are prefixed  with a leading slash.
-#
-#        Partial paths look like relative filenames.  They do not begin
-#        with a prefix.  The matching rules for partial paths are subtle=
 but
-#        designed to make specifying objects easy.  At each level of the
-#        composition tree, the partial path is matched as an absolute pa=
th.
-#        The first match is not returned.  At least two matches are sear=
ched
-#        for.  A successful result is only returned if only one match is
-#        found.  If more than one match is found, a flag is return to
-#        indicate that the match was ambiguous.
-#
-# @property: The property name to read
-#
-# Returns: The property value.  The type depends on the property
-#          type. child<> and link<> properties are returned as #str
-#          pathnames.  All integer property types (u8, u16, etc) are
-#          returned as #int.
-#
-# Since: 1.2
-#
-# Example:
-#
-# 1. Use absolute path
-#
-# -> { "execute": "qom-get",
-#      "arguments": { "path": "/machine/unattached/device[0]",
-#                     "property": "hotplugged" } }
-# <- { "return": false }
-#
-# 2. Use partial path
-#
-# -> { "execute": "qom-get",
-#      "arguments": { "path": "unattached/sysbus",
-#                     "property": "type" } }
-# <- { "return": "System" }
-#
-##
-{ 'command': 'qom-get',
-  'data': { 'path': 'str', 'property': 'str' },
-  'returns': 'any',
-  'allow-preconfig': true }
-
-##
-# @qom-set:
-#
-# This command will set a property from a object model path.
-#
-# @path: see @qom-get for a description of this parameter
-#
-# @property: the property name to set
-#
-# @value: a value who's type is appropriate for the property type.  See =
@qom-get
-#         for a description of type mapping.
-#
-# Since: 1.2
-#
-# Example:
-#
-# -> { "execute": "qom-set",
-#      "arguments": { "path": "/machine",
-#                     "property": "graphics",
-#                     "value": false } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'qom-set',
-  'data': { 'path': 'str', 'property': 'str', 'value': 'any' },
-  'allow-preconfig': true }
-
 ##
 # @change:
 #
@@ -1524,80 +1390,6 @@
 { 'command': 'change',
   'data': {'device': 'str', 'target': 'str', '*arg': 'str'} }
=20
-##
-# @ObjectTypeInfo:
-#
-# This structure describes a search result from @qom-list-types
-#
-# @name: the type name found in the search
-#
-# @abstract: the type is abstract and can't be directly instantiated.
-#            Omitted if false. (since 2.10)
-#
-# @parent: Name of parent type, if any (since 2.10)
-#
-# Since: 1.1
-##
-{ 'struct': 'ObjectTypeInfo',
-  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str' } }
-
-##
-# @qom-list-types:
-#
-# This command will return a list of types given search parameters
-#
-# @implements: if specified, only return types that implement this type =
name
-#
-# @abstract: if true, include abstract types in the results
-#
-# Returns: a list of @ObjectTypeInfo or an empty list if no results are =
found
-#
-# Since: 1.1
-##
-{ 'command': 'qom-list-types',
-  'data': { '*implements': 'str', '*abstract': 'bool' },
-  'returns': [ 'ObjectTypeInfo' ],
-  'allow-preconfig': true }
-
-##
-# @device-list-properties:
-#
-# List properties associated with a device.
-#
-# @typename: the type name of a device
-#
-# Returns: a list of ObjectPropertyInfo describing a devices properties
-#
-# Note: objects can create properties at runtime, for example to describ=
e
-# links between different devices and/or objects. These properties
-# are not included in the output of this command.
-#
-# Since: 1.2
-##
-{ 'command': 'device-list-properties',
-  'data': { 'typename': 'str'},
-  'returns': [ 'ObjectPropertyInfo' ] }
-
-##
-# @qom-list-properties:
-#
-# List properties associated with a QOM object.
-#
-# @typename: the type name of an object
-#
-# Note: objects can create properties at runtime, for example to describ=
e
-# links between different devices and/or objects. These properties
-# are not included in the output of this command.
-#
-# Returns: a list of ObjectPropertyInfo describing object properties
-#
-# Since: 2.12
-##
-{ 'command': 'qom-list-properties',
-  'data': { 'typename': 'str'},
-  'returns': [ 'ObjectPropertyInfo' ],
-  'allow-preconfig': true }
-
 ##
 # @xen-set-global-dirty-log:
 #
@@ -1618,102 +1410,6 @@
 ##
 { 'command': 'xen-set-global-dirty-log', 'data': { 'enable': 'bool' } }
=20
-##
-# @device_add:
-#
-# @driver: the name of the new device's driver
-#
-# @bus: the device's parent bus (device tree path)
-#
-# @id: the device's ID, must be unique
-#
-# Additional arguments depend on the type.
-#
-# Add a device.
-#
-# Notes:
-# 1. For detailed information about this command, please refer to the
-#    'docs/qdev-device-use.txt' file.
-#
-# 2. It's possible to list device properties by running QEMU with the
-#    "-device DEVICE,help" command-line argument, where DEVICE is the
-#    device's name
-#
-# Example:
-#
-# -> { "execute": "device_add",
-#      "arguments": { "driver": "e1000", "id": "net1",
-#                     "bus": "pci.0",
-#                     "mac": "52:54:00:12:34:56" } }
-# <- { "return": {} }
-#
-# TODO: This command effectively bypasses QAPI completely due to its
-# "additional arguments" business.  It shouldn't have been added to
-# the schema in this form.  It should be qapified properly, or
-# replaced by a properly qapified command.
-#
-# Since: 0.13
-##
-{ 'command': 'device_add',
-  'data': {'driver': 'str', '*bus': 'str', '*id': 'str'},
-  'gen': false } # so we can get the additional arguments
-
-##
-# @device_del:
-#
-# Remove a device from a guest
-#
-# @id: the device's ID or QOM path
-#
-# Returns: Nothing on success
-#          If @id is not a valid device, DeviceNotFound
-#
-# Notes: When this command completes, the device may not be removed from=
 the
-#        guest.  Hot removal is an operation that requires guest coopera=
tion.
-#        This command merely requests that the guest begin the hot remov=
al
-#        process.  Completion of the device removal process is signaled =
with a
-#        DEVICE_DELETED event. Guest reset will automatically complete r=
emoval
-#        for all devices.
-#
-# Since: 0.14.0
-#
-# Example:
-#
-# -> { "execute": "device_del",
-#      "arguments": { "id": "net1" } }
-# <- { "return": {} }
-#
-# -> { "execute": "device_del",
-#      "arguments": { "id": "/machine/peripheral-anon/device[0]" } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'device_del', 'data': {'id': 'str'} }
-
-##
-# @DEVICE_DELETED:
-#
-# Emitted whenever the device removal completion is acknowledged by the =
guest.
-# At this point, it's safe to reuse the specified device ID. Device remo=
val can
-# be initiated by the guest or by HMP/QMP commands.
-#
-# @device: device name
-#
-# @path: device path
-#
-# Since: 1.5
-#
-# Example:
-#
-# <- { "event": "DEVICE_DELETED",
-#      "data": { "device": "virtio-net-pci-0",
-#                "path": "/machine/peripheral/virtio-net-pci-0" },
-#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
-#
-##
-{ 'event': 'DEVICE_DELETED',
-  'data': { '*device': 'str', 'path': 'str' } }
-
 ##
 # @DumpGuestMemoryFormat:
 #
@@ -1906,53 +1602,6 @@
 { 'command': 'query-dump-guest-memory-capability',
   'returns': 'DumpGuestMemoryCapability' }
=20
-##
-# @object-add:
-#
-# Create a QOM object.
-#
-# @qom-type: the class name for the object to be created
-#
-# @id: the name of the new object
-#
-# @props: a dictionary of properties to be passed to the backend
-#
-# Returns: Nothing on success
-#          Error if @qom-type is not a valid class name
-#
-# Since: 2.0
-#
-# Example:
-#
-# -> { "execute": "object-add",
-#      "arguments": { "qom-type": "rng-random", "id": "rng1",
-#                     "props": { "filename": "/dev/hwrng" } } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'object-add',
-  'data': {'qom-type': 'str', 'id': 'str', '*props': 'any'} }
-
-##
-# @object-del:
-#
-# Remove a QOM object.
-#
-# @id: the name of the QOM object to remove
-#
-# Returns: Nothing on success
-#          Error if @id is not a valid id for a QOM object
-#
-# Since: 2.0
-#
-# Example:
-#
-# -> { "execute": "object-del", "arguments": { "id": "rng1" } }
-# <- { "return": {} }
-#
-##
-{ 'command': 'object-del', 'data': {'id': 'str'} }
-
 ##
 # @getfd:
 #
diff --git a/qapi/qapi-schema.json b/qapi/qapi-schema.json
index 4bd1223637..d6cf90a85a 100644
--- a/qapi/qapi-schema.json
+++ b/qapi/qapi-schema.json
@@ -97,6 +97,8 @@
 { 'include': 'transaction.json' }
 { 'include': 'trace.json' }
 { 'include': 'introspect.json' }
+{ 'include': 'qom.json' }
+{ 'include': 'qdev.json' }
 { 'include': 'misc.json' }
 { 'include': 'target.json' }
 { 'include': 'audio.json' }
diff --git a/qapi/qdev.json b/qapi/qdev.json
new file mode 100644
index 0000000000..c6d05032f4
--- /dev/null
+++ b/qapi/qdev.json
@@ -0,0 +1,125 @@
+# -*- Mode: Python -*-
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+# See the COPYING file in the top-level directory.
+
+##
+# =3D Device infrastructure (qdev)
+##
+
+{ 'include': 'qom.json' }
+
+##
+# @device-list-properties:
+#
+# List properties associated with a device.
+#
+# @typename: the type name of a device
+#
+# Returns: a list of ObjectPropertyInfo describing a devices properties
+#
+# Note: objects can create properties at runtime, for example to describ=
e
+# links between different devices and/or objects. These properties
+# are not included in the output of this command.
+#
+# Since: 1.2
+##
+{ 'command': 'device-list-properties',
+  'data': { 'typename': 'str'},
+  'returns': [ 'ObjectPropertyInfo' ] }
+
+##
+# @device_add:
+#
+# @driver: the name of the new device's driver
+#
+# @bus: the device's parent bus (device tree path)
+#
+# @id: the device's ID, must be unique
+#
+# Additional arguments depend on the type.
+#
+# Add a device.
+#
+# Notes:
+# 1. For detailed information about this command, please refer to the
+#    'docs/qdev-device-use.txt' file.
+#
+# 2. It's possible to list device properties by running QEMU with the
+#    "-device DEVICE,help" command-line argument, where DEVICE is the
+#    device's name
+#
+# Example:
+#
+# -> { "execute": "device_add",
+#      "arguments": { "driver": "e1000", "id": "net1",
+#                     "bus": "pci.0",
+#                     "mac": "52:54:00:12:34:56" } }
+# <- { "return": {} }
+#
+# TODO: This command effectively bypasses QAPI completely due to its
+# "additional arguments" business.  It shouldn't have been added to
+# the schema in this form.  It should be qapified properly, or
+# replaced by a properly qapified command.
+#
+# Since: 0.13
+##
+{ 'command': 'device_add',
+  'data': {'driver': 'str', '*bus': 'str', '*id': 'str'},
+  'gen': false } # so we can get the additional arguments
+
+##
+# @device_del:
+#
+# Remove a device from a guest
+#
+# @id: the device's ID or QOM path
+#
+# Returns: Nothing on success
+#          If @id is not a valid device, DeviceNotFound
+#
+# Notes: When this command completes, the device may not be removed from=
 the
+#        guest.  Hot removal is an operation that requires guest coopera=
tion.
+#        This command merely requests that the guest begin the hot remov=
al
+#        process.  Completion of the device removal process is signaled =
with a
+#        DEVICE_DELETED event. Guest reset will automatically complete r=
emoval
+#        for all devices.
+#
+# Since: 0.14.0
+#
+# Example:
+#
+# -> { "execute": "device_del",
+#      "arguments": { "id": "net1" } }
+# <- { "return": {} }
+#
+# -> { "execute": "device_del",
+#      "arguments": { "id": "/machine/peripheral-anon/device[0]" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'device_del', 'data': {'id': 'str'} }
+
+##
+# @DEVICE_DELETED:
+#
+# Emitted whenever the device removal completion is acknowledged by the =
guest.
+# At this point, it's safe to reuse the specified device ID. Device remo=
val can
+# be initiated by the guest or by HMP/QMP commands.
+#
+# @device: device name
+#
+# @path: device path
+#
+# Since: 1.5
+#
+# Example:
+#
+# <- { "event": "DEVICE_DELETED",
+#      "data": { "device": "virtio-net-pci-0",
+#                "path": "/machine/peripheral/virtio-net-pci-0" },
+#      "timestamp": { "seconds": 1265044230, "microseconds": 450486 } }
+#
+##
+{ 'event': 'DEVICE_DELETED',
+  'data': { '*device': 'str', 'path': 'str' } }
diff --git a/qapi/qom.json b/qapi/qom.json
new file mode 100644
index 0000000000..32db96ffc4
--- /dev/null
+++ b/qapi/qom.json
@@ -0,0 +1,244 @@
+# -*- Mode: Python -*-
+#
+# This work is licensed under the terms of the GNU GPL, version 2 or lat=
er.
+# See the COPYING file in the top-level directory.
+
+##
+# =3D QEMU Object Model (QOM)
+##
+
+##
+# @ObjectPropertyInfo:
+#
+# @name: the name of the property
+#
+# @type: the type of the property.  This will typically come in one of f=
our
+#        forms:
+#
+#        1) A primitive type such as 'u8', 'u16', 'bool', 'str', or 'dou=
ble'.
+#           These types are mapped to the appropriate JSON type.
+#
+#        2) A child type in the form 'child<subtype>' where subtype is a=
 qdev
+#           device type name.  Child properties create the composition t=
ree.
+#
+#        3) A link type in the form 'link<subtype>' where subtype is a q=
dev
+#           device type name.  Link properties form the device model gra=
ph.
+#
+# @description: if specified, the description of the property.
+#
+# Since: 1.2
+##
+{ 'struct': 'ObjectPropertyInfo',
+  'data': { 'name': 'str', 'type': 'str', '*description': 'str' } }
+
+##
+# @qom-list:
+#
+# This command will list any properties of a object given a path in the =
object
+# model.
+#
+# @path: the path within the object model.  See @qom-get for a descripti=
on of
+#        this parameter.
+#
+# Returns: a list of @ObjectPropertyInfo that describe the properties of=
 the
+#          object.
+#
+# Since: 1.2
+#
+# Example:
+#
+# -> { "execute": "qom-list",
+#      "arguments": { "path": "/chardevs" } }
+# <- { "return": [ { "name": "type", "type": "string" },
+#                  { "name": "parallel0", "type": "child<chardev-vc>" },
+#                  { "name": "serial0", "type": "child<chardev-vc>" },
+#                  { "name": "mon0", "type": "child<chardev-stdio>" } ] =
}
+#
+##
+{ 'command': 'qom-list',
+  'data': { 'path': 'str' },
+  'returns': [ 'ObjectPropertyInfo' ],
+  'allow-preconfig': true }
+
+##
+# @qom-get:
+#
+# This command will get a property from a object model path and return t=
he
+# value.
+#
+# @path: The path within the object model.  There are two forms of suppo=
rted
+#        paths--absolute and partial paths.
+#
+#        Absolute paths are derived from the root object and can follow =
child<>
+#        or link<> properties.  Since they can follow link<> properties,=
 they
+#        can be arbitrarily long.  Absolute paths look like absolute fil=
enames
+#        and are prefixed  with a leading slash.
+#
+#        Partial paths look like relative filenames.  They do not begin
+#        with a prefix.  The matching rules for partial paths are subtle=
 but
+#        designed to make specifying objects easy.  At each level of the
+#        composition tree, the partial path is matched as an absolute pa=
th.
+#        The first match is not returned.  At least two matches are sear=
ched
+#        for.  A successful result is only returned if only one match is
+#        found.  If more than one match is found, a flag is return to
+#        indicate that the match was ambiguous.
+#
+# @property: The property name to read
+#
+# Returns: The property value.  The type depends on the property
+#          type. child<> and link<> properties are returned as #str
+#          pathnames.  All integer property types (u8, u16, etc) are
+#          returned as #int.
+#
+# Since: 1.2
+#
+# Example:
+#
+# 1. Use absolute path
+#
+# -> { "execute": "qom-get",
+#      "arguments": { "path": "/machine/unattached/device[0]",
+#                     "property": "hotplugged" } }
+# <- { "return": false }
+#
+# 2. Use partial path
+#
+# -> { "execute": "qom-get",
+#      "arguments": { "path": "unattached/sysbus",
+#                     "property": "type" } }
+# <- { "return": "System" }
+#
+##
+{ 'command': 'qom-get',
+  'data': { 'path': 'str', 'property': 'str' },
+  'returns': 'any',
+  'allow-preconfig': true }
+
+##
+# @qom-set:
+#
+# This command will set a property from a object model path.
+#
+# @path: see @qom-get for a description of this parameter
+#
+# @property: the property name to set
+#
+# @value: a value who's type is appropriate for the property type.  See =
@qom-get
+#         for a description of type mapping.
+#
+# Since: 1.2
+#
+# Example:
+#
+# -> { "execute": "qom-set",
+#      "arguments": { "path": "/machine",
+#                     "property": "graphics",
+#                     "value": false } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'qom-set',
+  'data': { 'path': 'str', 'property': 'str', 'value': 'any' },
+  'allow-preconfig': true }
+
+##
+# @ObjectTypeInfo:
+#
+# This structure describes a search result from @qom-list-types
+#
+# @name: the type name found in the search
+#
+# @abstract: the type is abstract and can't be directly instantiated.
+#            Omitted if false. (since 2.10)
+#
+# @parent: Name of parent type, if any (since 2.10)
+#
+# Since: 1.1
+##
+{ 'struct': 'ObjectTypeInfo',
+  'data': { 'name': 'str', '*abstract': 'bool', '*parent': 'str' } }
+
+##
+# @qom-list-types:
+#
+# This command will return a list of types given search parameters
+#
+# @implements: if specified, only return types that implement this type =
name
+#
+# @abstract: if true, include abstract types in the results
+#
+# Returns: a list of @ObjectTypeInfo or an empty list if no results are =
found
+#
+# Since: 1.1
+##
+{ 'command': 'qom-list-types',
+  'data': { '*implements': 'str', '*abstract': 'bool' },
+  'returns': [ 'ObjectTypeInfo' ],
+  'allow-preconfig': true }
+
+##
+# @qom-list-properties:
+#
+# List properties associated with a QOM object.
+#
+# @typename: the type name of an object
+#
+# Note: objects can create properties at runtime, for example to describ=
e
+# links between different devices and/or objects. These properties
+# are not included in the output of this command.
+#
+# Returns: a list of ObjectPropertyInfo describing object properties
+#
+# Since: 2.12
+##
+{ 'command': 'qom-list-properties',
+  'data': { 'typename': 'str'},
+  'returns': [ 'ObjectPropertyInfo' ],
+  'allow-preconfig': true }
+
+##
+# @object-add:
+#
+# Create a QOM object.
+#
+# @qom-type: the class name for the object to be created
+#
+# @id: the name of the new object
+#
+# @props: a dictionary of properties to be passed to the backend
+#
+# Returns: Nothing on success
+#          Error if @qom-type is not a valid class name
+#
+# Since: 2.0
+#
+# Example:
+#
+# -> { "execute": "object-add",
+#      "arguments": { "qom-type": "rng-random", "id": "rng1",
+#                     "props": { "filename": "/dev/hwrng" } } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'object-add',
+  'data': {'qom-type': 'str', 'id': 'str', '*props': 'any'} }
+
+##
+# @object-del:
+#
+# Remove a QOM object.
+#
+# @id: the name of the QOM object to remove
+#
+# Returns: Nothing on success
+#          Error if @id is not a valid id for a QOM object
+#
+# Since: 2.0
+#
+# Example:
+#
+# -> { "execute": "object-del", "arguments": { "id": "rng1" } }
+# <- { "return": {} }
+#
+##
+{ 'command': 'object-del', 'data': {'id': 'str'} }
diff --git a/qdev-monitor.c b/qdev-monitor.c
index 373b9ad445..63a87e9632 100644
--- a/qdev-monitor.c
+++ b/qdev-monitor.c
@@ -24,7 +24,7 @@
 #include "monitor/qdev.h"
 #include "sysemu/arch_init.h"
 #include "qapi/error.h"
-#include "qapi/qapi-commands-misc.h"
+#include "qapi/qapi-commands-qdev.h"
 #include "qapi/qmp/qdict.h"
 #include "qapi/qmp/qerror.h"
 #include "qemu/config-file.h"
--=20
2.21.0


