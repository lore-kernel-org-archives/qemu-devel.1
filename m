Received: from eggs.gnu.org ([2001:4830:134:3::10]:44555)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cEGVs-000492-11
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:14:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1cEGVp-00066d-UT
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:14:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1cEGVp-000668-L2
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 09:14:29 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id DE9D78E3EA
	for <qemu-devel@nongnu.org>; Tue,  6 Dec 2016 14:14:28 +0000 (UTC)
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Tue,  6 Dec 2016 17:13:36 +0300
Message-Id: <20161206141343.28044-11-marcandre.lureau@redhat.com>
In-Reply-To: <20161206141343.28044-1-marcandre.lureau@redhat.com>
References: <20161206141343.28044-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v6 10/17] json: reorder documentation body
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: eblake@redhat.com, armbru@redhat.com, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

Place the body of expression documentation at the top (after the
@symbol:). This prevents ambiguity with other argument or
tagged-section documentation.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 qapi-schema.json     | 83 ++++++++++++++++++++++++++--------------------=
------
 qapi/block-core.json | 14 ++++-----
 qapi/introspect.json | 28 ++++++++----------
 qapi/trace.json      | 16 +++++-----
 qga/qapi-schema.json | 27 +++++++++--------
 5 files changed, 83 insertions(+), 85 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index fbea3b18d9..f11b3bd178 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -1946,11 +1946,11 @@
 #
 # Set XBZRLE cache size
 #
-# @value: cache size in bytes
-#
-# The size will be rounded down to the nearest power of 2.
 # The cache size can be modified before and during ongoing migration
 #
+# @value: cache size in bytes. The size will be rounded down to the
+#         nearest power of 2.
+#
 # Returns: nothing on success
 #
 # Since: 1.2
@@ -2293,16 +2293,16 @@
 ##
 # @device_add:
 #
+# Add a device.
+#
+# Additional arguments depend on the type.
+#
 # @driver: the name of the new device's driver
 #
 # @bus: #optional the device's parent bus (device tree path)
 #
 # @id: #optional the device's ID, must be unique
 #
-# Additional arguments depend on the type.
-#
-# Add a device.
-#
 # Notes:
 # 1. For detailed information about this command, please refer to the
 #    'docs/qdev-device-use.txt' file.
@@ -2319,13 +2319,13 @@
 #                     "mac": "52:54:00:12:34:56" } }
 # <- { "return": {} }
 #
+# Since: 0.13
+##
 # TODO This command effectively bypasses QAPI completely due to its
 # "additional arguments" business.  It shouldn't have been added to
 # the schema in this form.  It should be qapified properly, or
 # replaced by a properly qapified command.
 #
-# Since: 0.13
-##
 { 'command': 'device_add',
   'data': {'driver': 'str', '*bus': 'str', '*id': 'str'},
   'gen': false } # so we can get the additional arguments
@@ -2499,10 +2499,10 @@
 #
 # Dump guest's storage keys
 #
-# @filename: the path to the file to dump to
-#
 # This command is only supported on s390 architecture.
 #
+# @filename: the path to the file to dump to
+#
 # Since: 2.5
 ##
 { 'command': 'dump-skeys',
@@ -2513,23 +2513,24 @@
 #
 # Add a network backend.
 #
+# Additional arguments depend on the type.
+#
 # @type: the type of network backend.  Current valid values are 'user', =
'tap',
 #        'vde', 'socket', 'dump' and 'bridge'
 #
 # @id: the name of the new network backend
 #
-# Additional arguments depend on the type.
+# Since: 0.14.0
+#
+# Returns: Nothing on success
+#          If @type is not a valid network backend, DeviceNotFound
+##
 #
 # TODO This command effectively bypasses QAPI completely due to its
 # "additional arguments" business.  It shouldn't have been added to
 # the schema in this form.  It should be qapified properly, or
 # replaced by a properly qapified command.
 #
-# Since: 0.14.0
-#
-# Returns: Nothing on success
-#          If @type is not a valid network backend, DeviceNotFound
-##
 { 'command': 'netdev_add',
   'data': {'type': 'str', 'id': 'str'},
   'gen': false }                # so we can get the additional arguments
@@ -3209,6 +3210,22 @@
 #
 # Virtual CPU definition.
 #
+# @unavailable-features is a list of QOM property names that
+# represent CPU model attributes that prevent the CPU from running.
+# If the QOM property is read-only, that means there's no known
+# way to make the CPU model run in the current host. Implementations
+# that choose not to provide specific information return the
+# property name "type".
+# If the property is read-write, it means that it MAY be possible
+# to run the CPU model in the current host if that property is
+# changed. Management software can use it as hints to suggest or
+# choose an alternative for the user, or just to generate meaningful
+# error messages explaining why the CPU model can't be used.
+# If @unavailable-features is an empty list, the CPU model is
+# runnable using the current host and machine-type.
+# If @unavailable-features is not present, runnability
+# information for the CPU is not available.
+#
 # @name: the name of the CPU definition
 #
 # @migration-safe: #optional whether a CPU definition can be safely used=
 for
@@ -3227,22 +3244,6 @@
 #                        the CPU model from running in the current
 #                        host. (since 2.8)
 #
-# @unavailable-features is a list of QOM property names that
-# represent CPU model attributes that prevent the CPU from running.
-# If the QOM property is read-only, that means there's no known
-# way to make the CPU model run in the current host. Implementations
-# that choose not to provide specific information return the
-# property name "type".
-# If the property is read-write, it means that it MAY be possible
-# to run the CPU model in the current host if that property is
-# changed. Management software can use it as hints to suggest or
-# choose an alternative for the user, or just to generate meaningful
-# error messages explaining why the CPU model can't be used.
-# If @unavailable-features is an empty list, the CPU model is
-# runnable using the current host and machine-type.
-# If @unavailable-features is not present, runnability
-# information for the CPU is not available.
-#
 # Since: 1.2.0
 ##
 { 'struct': 'CpuDefinitionInfo',
@@ -3381,10 +3382,6 @@
 #
 # The result of a CPU model comparison.
 #
-# @result: The result of the compare operation.
-# @responsible-properties: List of properties that led to the comparison=
 result
-#                          not being identical.
-#
 # @responsible-properties is a list of QOM property names that led to
 # both CPUs not being detected as identical. For identical models, this
 # list is empty.
@@ -3392,6 +3389,10 @@
 # CPU models identical. If the special property name "type" is included,=
 the
 # models are by definition not identical and cannot be made identical.
 #
+# @result: The result of the compare operation.
+# @responsible-properties: List of properties that led to the comparison=
 result
+#                          not being identical.
+#
 # Since: 2.8.0
 ##
 { 'struct': 'CpuModelCompareInfo',
@@ -3617,6 +3618,10 @@
 ##
 # @QKeyCode:
 #
+# An enumeration of key name.
+#
+# This is used by the send-key command.
+#
 # @unmapped: since 2.0
 # @pause: since 2.0
 # @ro: since 2.4
@@ -3624,10 +3629,6 @@
 # @kp_equals: since 2.6
 # @power: since 2.6
 #
-# An enumeration of key name.
-#
-# This is used by the send-key command.
-#
 # Since: 1.3.0
 #
 ##
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 05cedc3f23..e1ab80e419 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -1977,10 +1977,9 @@
 # @user:                #optional user as which to connect, defaults to =
current
 #                       local user name
 #
-# TODO: Expose the host_key_check option in QMP
-#
 # Since: 2.8
 ##
+# TODO: Expose the host_key_check option in QMP
 { 'struct': 'BlockdevOptionsSsh',
   'data': { 'server': 'InetSocketAddress',
             'path': 'str',
@@ -2164,8 +2163,6 @@
 #
 # Details for connecting to a gluster server
 #
-# @type:       Transport type used for gluster connection
-#
 # This is similar to SocketAddress, only distinction:
 #
 # 1. GlusterServer is a flat union, SocketAddress is a simple union.
@@ -2178,6 +2175,8 @@
 # GlusterServer is actually not Gluster-specific, its a
 # compatibility evolved into an alternate for SocketAddress.
 #
+# @type:       Transport type used for gluster connection
+#
 # Since: 2.7
 ##
 { 'union': 'GlusterServer',
@@ -2356,8 +2355,9 @@
 ##
 # @BlockdevOptions:
 #
-# Options for creating a block device.  Many options are available for a=
ll
-# block devices, independent of the block driver:
+# Options for creating a block device.  Many options are available for
+# all block devices, independent of the block driver, remaining
+# options are determined by the block driver.
 #
 # @driver:        block driver name
 # @node-name:     #optional the node name of the new node (Since 2.0).
@@ -2369,8 +2369,6 @@
 # @detect-zeroes: #optional detect and optimize zero writes (Since 2.1)
 #                 (default: off)
 #
-# Remaining options are determined by the block driver.
-#
 # Since: 1.7
 ##
 { 'union': 'BlockdevOptions',
diff --git a/qapi/introspect.json b/qapi/introspect.json
index fd4dc84196..b1661c5b7c 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -77,19 +77,18 @@
 ##
 # @SchemaInfo:
 #
+# Additional members depend on the value of @meta-type.
+#
 # @name: the entity's name, inherited from @base.
 #        Commands and events have the name defined in the QAPI schema.
 #        Unlike command and event names, type names are not part of
 #        the wire ABI.  Consequently, type names are meaningless
 #        strings here, although they are still guaranteed unique
-#        regardless of @meta-type.
-#
-# All references to other SchemaInfo are by name.
+#        regardless of @meta-type. All references to other SchemaInfo
+#        are by name.
 #
 # @meta-type: the entity's meta type, inherited from @base.
 #
-# Additional members depend on the value of @meta-type.
-#
 # Since: 2.5
 ##
 { 'union': 'SchemaInfo',
@@ -134,10 +133,10 @@
 #
 # Additional SchemaInfo members for meta-type 'enum'.
 #
-# @values: the enumeration type's values, in no particular order.
-#
 # Values of this type are JSON string on the wire.
 #
+# @values: the enumeration type's values, in no particular order.
+#
 # Since: 2.5
 ##
 { 'struct': 'SchemaInfoEnum',
@@ -148,10 +147,10 @@
 #
 # Additional SchemaInfo members for meta-type 'array'.
 #
-# @element-type: the array type's element type.
-#
 # Values of this type are JSON array on the wire.
 #
+# @element-type: the array type's element type.
+#
 # Since: 2.5
 ##
 { 'struct': 'SchemaInfoArray',
@@ -162,6 +161,8 @@
 #
 # Additional SchemaInfo members for meta-type 'object'.
 #
+# Values of this type are JSON object on the wire.
+#
 # @members: the object type's (non-variant) members, in no particular or=
der.
 #
 # @tag: #optional the name of the member serving as type tag.
@@ -173,8 +174,6 @@
 #            and may even differ from the order of the values of the
 #            enum type of the @tag.
 #
-# Values of this type are JSON object on the wire.
-#
 # Since: 2.5
 ##
 { 'struct': 'SchemaInfoObject',
@@ -225,12 +224,12 @@
 #
 # Additional SchemaInfo members for meta-type 'alternate'.
 #
+# On the wire, this can be any of the members.
+#
 # @members: the alternate type's members, in no particular order.
 #           The members' wire encoding is distinct, see
 #           docs/qapi-code-gen.txt section Alternate types.
 #
-# On the wire, this can be any of the members.
-#
 # Since: 2.5
 ##
 { 'struct': 'SchemaInfoAlternate',
@@ -258,10 +257,9 @@
 #
 # @ret-type: the name of the command's result type.
 #
-# TODO @success-response (currently irrelevant, because it's QGA, not QM=
P)
-#
 # Since: 2.5
 ##
+# TODO @success-response (currently irrelevant, because it's QGA, not QM=
P)
 { 'struct': 'SchemaInfoCommand',
   'data': { 'arg-type': 'str', 'ret-type': 'str' } }
=20
diff --git a/qapi/trace.json b/qapi/trace.json
index 3ad7df7fdb..c52352cfb6 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -30,13 +30,13 @@
 #
 # Information of a tracing event.
 #
+# An event is per-vCPU if it has the "vcpu" property in the "trace-event=
s"
+# files.
+#
 # @name: Event name.
 # @state: Tracing state.
 # @vcpu: Whether this is a per-vCPU event (since 2.7).
 #
-# An event is per-vCPU if it has the "vcpu" property in the "trace-event=
s"
-# files.
-#
 # Since: 2.2
 ##
 { 'struct': 'TraceEventInfo',
@@ -72,11 +72,6 @@
 #
 # Set the dynamic tracing state of events.
 #
-# @name: Event name pattern (case-sensitive glob).
-# @enable: Whether to enable tracing.
-# @ignore-unavailable: #optional Do not match unavailable events with @n=
ame.
-# @vcpu: #optional The vCPU to act upon (all by default; since 2.7).
-#
 # An event's state is modified if:
 # - its name matches the @name pattern, and
 # - if @vcpu is given, the event has the "vcpu" property.
@@ -86,6 +81,11 @@
 # match, @vcpu is given and the event does not have the "vcpu" property,=
 an
 # error is returned.
 #
+# @name: Event name pattern (case-sensitive glob).
+# @enable: Whether to enable tracing.
+# @ignore-unavailable: #optional Do not match unavailable events with @n=
ame.
+# @vcpu: #optional The vCPU to act upon (all by default; since 2.7).
+#
 # Since: 2.2
 ##
 { 'command': 'trace-event-set-state',
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index ad63737fce..8c881dd5d5 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -186,13 +186,13 @@
 # Initiate guest-activated shutdown. Note: this is an asynchronous
 # shutdown request, with no guarantee of successful shutdown.
 #
-# @mode: #optional "halt", "powerdown" (default), or "reboot"
-#
 # This command does NOT return a response on success. Success condition
 # is indicated by the VM exiting with a zero exit status or, when
 # running with --no-shutdown, by issuing the query-status QMP command
 # to confirm the VM status is "shutdown".
 #
+# @mode: #optional "halt", "powerdown" (default), or "reboot"
+#
 # Since: 0.15.0
 ##
 { 'command': 'guest-shutdown', 'data': { '*mode': 'str' },
@@ -815,20 +815,21 @@
 #
 # @username: the user account whose password to change
 # @password: the new password entry string, base64 encoded
-# @crypted: true if password is already crypt()d, false if raw
 #
-# If the @crypted flag is true, it is the caller's responsibility
-# to ensure the correct crypt() encryption scheme is used. This
-# command does not attempt to interpret or report on the encryption
-# scheme. Refer to the documentation of the guest operating system
-# in question to determine what is supported.
+#            The @password parameter must always be base64 encoded befor=
e
+#            transmission, even if already crypt()d, to ensure it is 8-b=
it
+#            safe when passed as JSON.
+#
+# @crypted: true if password is already crypt()d, false if raw
 #
-# Not all guest operating systems will support use of the
-# @crypted flag, as they may require the clear-text password
+#           If the @crypted flag is true, it is the caller's responsibil=
ity
+#           to ensure the correct crypt() encryption scheme is used. Thi=
s
+#           command does not attempt to interpret or report on the encry=
ption
+#           scheme. Refer to the documentation of the guest operating sy=
stem
+#           in question to determine what is supported.
 #
-# The @password parameter must always be base64 encoded before
-# transmission, even if already crypt()d, to ensure it is 8-bit
-# safe when passed as JSON.
+#           Not all guest operating systems will support use of the
+#           @crypted flag, as they may require the clear-text password
 #
 # Returns: Nothing on success.
 #
--=20
2.11.0
