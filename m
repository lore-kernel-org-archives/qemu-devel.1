Received: from eggs.gnu.org ([2001:4830:134:3::10]:47331)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwON-0007c3-L1
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOH-0006yE-H6
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51294)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cDwOH-0006xc-2J
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:21 -0500
Received: from int-mx11.intmail.prod.int.phx2.redhat.com
	(int-mx11.intmail.prod.int.phx2.redhat.com [10.5.11.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 328778F890
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 16:45:20 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  5 Dec 2016 17:45:13 +0100
Message-Id: <1480956313-31322-10-git-send-email-armbru@redhat.com>
In-Reply-To: <1480956313-31322-1-git-send-email-armbru@redhat.com>
References: <1480956313-31322-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 9/9] qapi: add missing colon-ending for section
 name
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

The documentation parser we are going to add expects a section name to
end with ':', otherwise the comment is treated as free-form text body.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Message-Id: <20161117155504.21843-9-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json     | 300 +++++++++++++++++++++++++--------------------=
------
 qapi/block-core.json | 196 ++++++++++++++++-----------------
 qapi/block.json      |  16 +--
 qapi/common.json     |   8 +-
 qapi/event.json      |  58 +++++-----
 qapi/introspect.json |  28 ++---
 qapi/trace.json      |   8 +-
 qga/qapi-schema.json |  44 ++++----
 8 files changed, 329 insertions(+), 329 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index 918a79f..a0d3b5d 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -66,7 +66,7 @@
   'data': ['discard', 'delay', 'merge', 'slew' ] }
=20
 ##
-# @add_client
+# @add_client:
 #
 # Allow client connections for VNC, Spice and socket based
 # character devices to be passed in to QEMU via SCM_RIGHTS.
@@ -97,7 +97,7 @@
 #
 # @name: #optional The name of the guest
 #
-# Since 0.14.0
+# Since: 0.14.0
 ##
 { 'struct': 'NameInfo', 'data': {'*name': 'str'} }
=20
@@ -108,7 +108,7 @@
 #
 # Returns: @NameInfo of the guest
 #
-# Since 0.14.0
+# Since: 0.14.0
 ##
 { 'command': 'query-name', 'returns': 'NameInfo' }
=20
@@ -137,7 +137,7 @@
 { 'command': 'query-kvm', 'returns': 'KvmInfo' }
=20
 ##
-# @RunState
+# @RunState:
 #
 # An enumeration of VM run states.
 #
@@ -236,7 +236,7 @@
 #
 # Returns: The @UuidInfo for the guest
 #
-# Since 0.14.0
+# Since: 0.14.0
 ##
 { 'command': 'query-uuid', 'returns': 'UuidInfo' }
=20
@@ -383,7 +383,7 @@
 { 'command': 'query-events', 'returns': ['EventInfo'] }
=20
 ##
-# @MigrationStats
+# @MigrationStats:
 #
 # Detailed migration status.
 #
@@ -397,7 +397,7 @@
 #
 # @skipped: number of skipped zero pages (since 1.5)
 #
-# @normal : number of normal pages (since 1.2)
+# @normal: number of normal pages (since 1.2)
 #
 # @normal-bytes: number of normal bytes sent (since 1.2)
 #
@@ -421,7 +421,7 @@
            'postcopy-requests' : 'int' } }
=20
 ##
-# @XBZRLECacheStats
+# @XBZRLECacheStats:
 #
 # Detailed XBZRLE migration cache statistics
 #
@@ -476,7 +476,7 @@
             'active', 'postcopy-active', 'completed', 'failed', 'colo' ]=
 }
=20
 ##
-# @MigrationInfo
+# @MigrationInfo:
 #
 # Information about current migration process.
 #
@@ -536,7 +536,7 @@
            '*error-desc': 'str'} }
=20
 ##
-# @query-migrate
+# @query-migrate:
 #
 # Returns information about current migration process.
 #
@@ -547,7 +547,7 @@
 { 'command': 'query-migrate', 'returns': 'MigrationInfo' }
=20
 ##
-# @MigrationCapability
+# @MigrationCapability:
 #
 # Migration capabilities enumeration
 #
@@ -595,7 +595,7 @@
            'compress', 'events', 'postcopy-ram', 'x-colo'] }
=20
 ##
-# @MigrationCapabilityStatus
+# @MigrationCapabilityStatus:
 #
 # Migration capability information
 #
@@ -609,7 +609,7 @@
   'data': { 'capability' : 'MigrationCapability', 'state' : 'bool' } }
=20
 ##
-# @migrate-set-capabilities
+# @migrate-set-capabilities:
 #
 # Enable/Disable the following migration capabilities (like xbzrle)
 #
@@ -621,7 +621,7 @@
   'data': { 'capabilities': ['MigrationCapabilityStatus'] } }
=20
 ##
-# @query-migrate-capabilities
+# @query-migrate-capabilities:
 #
 # Returns information about the current migration capabilities status
 #
@@ -632,7 +632,7 @@
 { 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapab=
ilityStatus']}
=20
 ##
-# @MigrationParameter
+# @MigrationParameter:
 #
 # Migration parameters enumeration
 #
@@ -691,7 +691,7 @@
            'downtime-limit', 'x-checkpoint-delay' ] }
=20
 ##
-# @migrate-set-parameters
+# @migrate-set-parameters:
 #
 # Set various migration parameters.  See MigrationParameters for details=
.
 #
@@ -701,7 +701,7 @@
   'data': 'MigrationParameters' }
=20
 ##
-# @MigrationParameters
+# @MigrationParameters:
 #
 # Optional members can be omitted on input ('migrate-set-parameters')
 # but most members will always be present on output
@@ -760,7 +760,7 @@
             '*x-checkpoint-delay': 'int'} }
=20
 ##
-# @query-migrate-parameters
+# @query-migrate-parameters:
 #
 # Returns information about the current migration parameters
 #
@@ -772,7 +772,7 @@
   'returns': 'MigrationParameters' }
=20
 ##
-# @client_migrate_info
+# @client_migrate_info:
 #
 # Set migration information for remote display.  This makes the server
 # ask the client to automatically reconnect using the new parameters
@@ -791,7 +791,7 @@
             '*tls-port': 'int', '*cert-subject': 'str' } }
=20
 ##
-# @migrate-start-postcopy
+# @migrate-start-postcopy:
 #
 # Followup to a migration command to switch the migration to postcopy mo=
de.
 # The postcopy-ram capability must be set before the original migration
@@ -802,7 +802,7 @@
 { 'command': 'migrate-start-postcopy' }
=20
 ##
-# @COLOMessage
+# @COLOMessage:
 #
 # The message transmission between Primary side and Secondary side.
 #
@@ -828,7 +828,7 @@
             'vmstate-loaded' ] }
=20
 ##
-# @COLOMode
+# @COLOMode:
 #
 # The colo mode
 #
@@ -844,7 +844,7 @@
   'data': [ 'unknown', 'primary', 'secondary'] }
=20
 ##
-# @FailoverStatus
+# @FailoverStatus:
 #
 # An enumeration of COLO failover status
 #
@@ -862,7 +862,7 @@
   'data': [ 'none', 'require', 'active', 'completed'] }
=20
 ##
-# @x-colo-lost-heartbeat
+# @x-colo-lost-heartbeat:
 #
 # Tell qemu that heartbeat is lost, request it to do takeover procedures=
.
 # If this command is sent to the PVM, the Primary side will exit COLO mo=
de.
@@ -956,7 +956,7 @@
 #
 # @pc: the 64-bit instruction pointer
 #
-# Since 2.6
+# Since: 2.6
 ##
 { 'struct': 'CpuInfoX86', 'data': { 'pc': 'int' } }
=20
@@ -969,7 +969,7 @@
 #
 # @npc: the NPC component of the instruction pointer
 #
-# Since 2.6
+# Since: 2.6
 ##
 { 'struct': 'CpuInfoSPARC', 'data': { 'pc': 'int', 'npc': 'int' } }
=20
@@ -980,7 +980,7 @@
 #
 # @nip: the instruction pointer
 #
-# Since 2.6
+# Since: 2.6
 ##
 { 'struct': 'CpuInfoPPC', 'data': { 'nip': 'int' } }
=20
@@ -991,7 +991,7 @@
 #
 # @PC: the instruction pointer
 #
-# Since 2.6
+# Since: 2.6
 ##
 { 'struct': 'CpuInfoMIPS', 'data': { 'PC': 'int' } }
=20
@@ -1002,7 +1002,7 @@
 #
 # @PC: the instruction pointer
 #
-# Since 2.6
+# Since: 2.6
 ##
 { 'struct': 'CpuInfoTricore', 'data': { 'PC': 'int' } }
=20
@@ -1011,7 +1011,7 @@
 #
 # No additional information is available about the virtual CPU
 #
-# Since 2.6
+# Since: 2.6
 #
 ##
 { 'struct': 'CpuInfoOther', 'data': { } }
@@ -1046,7 +1046,7 @@
 #
 # Returns a list of information about each iothread.
 #
-# Note this list excludes the QEMU main loop thread, which is not declar=
ed
+# Note: this list excludes the QEMU main loop thread, which is not decla=
red
 # using the -object iothread command-line option.  It is always the main=
 thread
 # of the process.
 #
@@ -1057,7 +1057,7 @@
 { 'command': 'query-iothreads', 'returns': ['IOThreadInfo'] }
=20
 ##
-# @NetworkAddressFamily
+# @NetworkAddressFamily:
 #
 # The network address family
 #
@@ -1077,7 +1077,7 @@
   'data': [ 'ipv4', 'ipv6', 'unix', 'vsock', 'unknown' ] }
=20
 ##
-# @VncBasicInfo
+# @VncBasicInfo:
 #
 # The basic information for vnc network connection
 #
@@ -1100,7 +1100,7 @@
             'websocket': 'bool' } }
=20
 ##
-# @VncServerInfo
+# @VncServerInfo:
 #
 # The network connection information for server
 #
@@ -1250,7 +1250,7 @@
 { 'command': 'query-vnc-servers', 'returns': ['VncInfo2'] }
=20
 ##
-# @SpiceBasicInfo
+# @SpiceBasicInfo:
 #
 # The basic information for SPICE network connection
 #
@@ -1268,7 +1268,7 @@
             'family': 'NetworkAddressFamily' } }
=20
 ##
-# @SpiceServerInfo
+# @SpiceServerInfo:
 #
 # Information about a SPICE server
 #
@@ -1281,7 +1281,7 @@
   'data': { '*auth': 'str' } }
=20
 ##
-# @SpiceChannel
+# @SpiceChannel:
 #
 # Information about a SPICE client channel.
 #
@@ -1306,7 +1306,7 @@
            'tls': 'bool'} }
=20
 ##
-# @SpiceQueryMouseMode
+# @SpiceQueryMouseMode:
 #
 # An enumeration of Spice mouse states.
 #
@@ -1325,7 +1325,7 @@
   'data': [ 'client', 'server', 'unknown' ] }
=20
 ##
-# @SpiceInfo
+# @SpiceInfo:
 #
 # Information about the SPICE session.
 #
@@ -1364,7 +1364,7 @@
            'mouse-mode': 'SpiceQueryMouseMode', '*channels': ['SpiceChan=
nel']} }
=20
 ##
-# @query-spice
+# @query-spice:
 #
 # Returns information about the current SPICE server
 #
@@ -1414,7 +1414,7 @@
 { 'struct': 'PciMemoryRange', 'data': {'base': 'int', 'limit': 'int'} }
=20
 ##
-# @PciMemoryRegion
+# @PciMemoryRegion:
 #
 # Information about a PCI device I/O region.
 #
@@ -1623,7 +1623,7 @@
 { 'command': 'cpu', 'data': {'index': 'int'} }
=20
 ##
-# @cpu-add
+# @cpu-add:
 #
 # Adds CPU with specified ID
 #
@@ -1631,7 +1631,7 @@
 #
 # Returns: Nothing on success
 #
-# Since 1.5
+# Since: 1.5
 ##
 { 'command': 'cpu-add', 'data': {'id': 'int'} }
=20
@@ -1762,17 +1762,17 @@
 { 'command': 'balloon', 'data': {'value': 'int'} }
=20
 ##
-# @Abort
+# @Abort:
 #
 # This action can be used to test transaction failure.
 #
 # Since: 1.6
-###
+##
 { 'struct': 'Abort',
   'data': { } }
=20
 ##
-# @ActionCompletionMode
+# @ActionCompletionMode:
 #
 # An enumeration of Transactional completion modes.
 #
@@ -1792,12 +1792,12 @@
   'data': [ 'individual', 'grouped' ] }
=20
 ##
-# @TransactionAction
+# @TransactionAction:
 #
 # A discriminated record of operations that can be performed with
 # @transaction.
 #
-# Since 1.1
+# Since: 1.1
 #
 # drive-backup since 1.6
 # abort since 1.6
@@ -1820,7 +1820,7 @@
    } }
=20
 ##
-# @TransactionProperties
+# @TransactionProperties:
 #
 # Optional arguments to modify the behavior of a Transaction.
 #
@@ -1837,7 +1837,7 @@
 }
=20
 ##
-# @transaction
+# @transaction:
 #
 # Executes a number of transactionable QMP commands atomically. If any
 # operation fails, then the entire set of actions will be abandoned and =
the
@@ -1857,7 +1857,7 @@
 # information on only one failed operation returned in an error conditio=
n, and
 # subsequent actions will not have been attempted.
 #
-# Since 1.1
+# Since: 1.1
 ##
 { 'command': 'transaction',
   'data': { 'actions': [ 'TransactionAction' ],
@@ -1894,7 +1894,7 @@
   'returns': 'str' }
=20
 ##
-# @migrate_cancel
+# @migrate_cancel:
 #
 # Cancel the current executing migration process.
 #
@@ -1907,7 +1907,7 @@
 { 'command': 'migrate_cancel' }
=20
 ##
-# @migrate_set_downtime
+# @migrate_set_downtime:
 #
 # Set maximum tolerated downtime for migration.
 #
@@ -1922,7 +1922,7 @@
 { 'command': 'migrate_set_downtime', 'data': {'value': 'number'} }
=20
 ##
-# @migrate_set_speed
+# @migrate_set_speed:
 #
 # Set maximum speed for migration.
 #
@@ -1937,7 +1937,7 @@
 { 'command': 'migrate_set_speed', 'data': {'value': 'int'} }
=20
 ##
-# @migrate-set-cache-size
+# @migrate-set-cache-size:
 #
 # Set XBZRLE cache size
 #
@@ -1953,7 +1953,7 @@
 { 'command': 'migrate-set-cache-size', 'data': {'value': 'int'} }
=20
 ##
-# @query-migrate-cache-size
+# @query-migrate-cache-size:
 #
 # query XBZRLE cache size
 #
@@ -2218,7 +2218,7 @@
   'returns': [ 'DevicePropertyInfo' ] }
=20
 ##
-# @migrate
+# @migrate:
 #
 # Migrates the current running guest to another Virtual Machine.
 #
@@ -2239,7 +2239,7 @@
   'data': {'uri': 'str', '*blk': 'bool', '*inc': 'bool', '*detach': 'boo=
l' } }
=20
 ##
-# @migrate-incoming
+# @migrate-incoming:
 #
 # Start an incoming migration, the qemu must have been started
 # with -incoming defer
@@ -2273,7 +2273,7 @@
 { 'command': 'xen-save-devices-state', 'data': {'filename': 'str'} }
=20
 ##
-# @xen-set-global-dirty-log
+# @xen-set-global-dirty-log:
 #
 # Enable or disable the global dirty log mode.
 #
@@ -2365,7 +2365,7 @@
   'data': [ 'elf', 'kdump-zlib', 'kdump-lzo', 'kdump-snappy' ] }
=20
 ##
-# @dump-guest-memory
+# @dump-guest-memory:
 #
 # Dump guest's memory to vmcore. It is a synchronous operation that can =
take
 # very long depending on the amount of guest memory.
@@ -2419,7 +2419,7 @@
             '*format': 'DumpGuestMemoryFormat'} }
=20
 ##
-# @DumpStatus
+# @DumpStatus:
 #
 # Describe the status of a long-running background guest memory dump.
 #
@@ -2431,13 +2431,13 @@
 #
 # @failed: the last dump has failed.
 #
-# Since 2.6
+# Since: 2.6
 ##
 { 'enum': 'DumpStatus',
   'data': [ 'none', 'active', 'completed', 'failed' ] }
=20
 ##
-# @DumpQueryResult
+# @DumpQueryResult:
 #
 # The result format for 'query-dump'.
 #
@@ -2447,7 +2447,7 @@
 #
 # @total: total bytes to be written in latest dump (uncompressed)
 #
-# Since 2.6
+# Since: 2.6
 ##
 { 'struct': 'DumpQueryResult',
   'data': { 'status': 'DumpStatus',
@@ -2455,7 +2455,7 @@
             'total': 'int' } }
=20
 ##
-# @query-dump
+# @query-dump:
 #
 # Query latest dump status.
 #
@@ -2490,7 +2490,7 @@
   'returns': 'DumpGuestMemoryCapability' }
=20
 ##
-# @dump-skeys
+# @dump-skeys:
 #
 # Dump guest's storage keys
 #
@@ -2577,17 +2577,17 @@
 { 'command': 'object-del', 'data': {'id': 'str'} }
=20
 ##
-# @NetdevNoneOptions
+# @NetdevNoneOptions:
 #
 # Use it alone to have zero network devices.
 #
-# Since 1.2
+# Since: 1.2
 ##
 { 'struct': 'NetdevNoneOptions',
   'data': { } }
=20
 ##
-# @NetLegacyNicOptions
+# @NetLegacyNicOptions:
 #
 # Create a new Network Interface Card.
 #
@@ -2601,7 +2601,7 @@
 #
 # @vectors: #optional number of MSI-x vectors, 0 to disable MSI-X
 #
-# Since 1.2
+# Since: 1.2
 ##
 { 'struct': 'NetLegacyNicOptions',
   'data': {
@@ -2612,18 +2612,18 @@
     '*vectors': 'uint32' } }
=20
 ##
-# @String
+# @String:
 #
 # A fat type wrapping 'str', to be embedded in lists.
 #
-# Since 1.2
+# Since: 1.2
 ##
 { 'struct': 'String',
   'data': {
     'str': 'str' } }
=20
 ##
-# @NetdevUserOptions
+# @NetdevUserOptions:
 #
 # Use the user mode network stack which requires no administrator privil=
ege to
 # run.
@@ -2680,7 +2680,7 @@
 #
 # @guestfwd: #optional forward guest TCP connections
 #
-# Since 1.2
+# Since: 1.2
 ##
 { 'struct': 'NetdevUserOptions',
   'data': {
@@ -2706,7 +2706,7 @@
     '*guestfwd':  ['String'] } }
=20
 ##
-# @NetdevTapOptions
+# @NetdevTapOptions:
 #
 # Connect the host TAP network interface name to the VLAN.
 #
@@ -2743,7 +2743,7 @@
 # @poll-us: #optional maximum number of microseconds that could
 # be spent on busy polling for tap (since 2.7)
 #
-# Since 1.2
+# Since: 1.2
 ##
 { 'struct': 'NetdevTapOptions',
   'data': {
@@ -2764,7 +2764,7 @@
     '*poll-us':    'uint32'} }
=20
 ##
-# @NetdevSocketOptions
+# @NetdevSocketOptions:
 #
 # Connect the VLAN to a remote VLAN in another QEMU virtual machine usin=
g a TCP
 # socket connection.
@@ -2781,7 +2781,7 @@
 #
 # @udp: #optional UDP unicast address and port number
 #
-# Since 1.2
+# Since: 1.2
 ##
 { 'struct': 'NetdevSocketOptions',
   'data': {
@@ -2793,7 +2793,7 @@
     '*udp':       'str' } }
=20
 ##
-# @NetdevL2TPv3Options
+# @NetdevL2TPv3Options:
 #
 # Connect the VLAN to Ethernet over L2TPv3 Static tunnel
 #
@@ -2829,7 +2829,7 @@
 # @offset: #optional additional offset - allows the insertion of
 #          additional application-specific data before the packet payloa=
d
 #
-# Since 2.1
+# Since: 2.1
 ##
 { 'struct': 'NetdevL2TPv3Options',
   'data': {
@@ -2849,7 +2849,7 @@
     '*offset':      'uint32' } }
=20
 ##
-# @NetdevVdeOptions
+# @NetdevVdeOptions:
 #
 # Connect the VLAN to a vde switch running on the host.
 #
@@ -2861,7 +2861,7 @@
 #
 # @mode: #optional permissions for socket
 #
-# Since 1.2
+# Since: 1.2
 ##
 { 'struct': 'NetdevVdeOptions',
   'data': {
@@ -2871,7 +2871,7 @@
     '*mode':  'uint16' } }
=20
 ##
-# @NetdevDumpOptions
+# @NetdevDumpOptions:
 #
 # Dump VLAN network traffic to a file.
 #
@@ -2880,7 +2880,7 @@
 #
 # @file: #optional dump file path (default is qemu-vlan0.pcap)
 #
-# Since 1.2
+# Since: 1.2
 ##
 { 'struct': 'NetdevDumpOptions',
   'data': {
@@ -2888,7 +2888,7 @@
     '*file': 'str' } }
=20
 ##
-# @NetdevBridgeOptions
+# @NetdevBridgeOptions:
 #
 # Connect a host TAP network interface to a host bridge device.
 #
@@ -2896,7 +2896,7 @@
 #
 # @helper: #optional command to execute to configure bridge
 #
-# Since 1.2
+# Since: 1.2
 ##
 { 'struct': 'NetdevBridgeOptions',
   'data': {
@@ -2904,20 +2904,20 @@
     '*helper': 'str' } }
=20
 ##
-# @NetdevHubPortOptions
+# @NetdevHubPortOptions:
 #
 # Connect two or more net clients through a software hub.
 #
 # @hubid: hub identifier number
 #
-# Since 1.2
+# Since: 1.2
 ##
 { 'struct': 'NetdevHubPortOptions',
   'data': {
     'hubid':     'int32' } }
=20
 ##
-# @NetdevNetmapOptions
+# @NetdevNetmapOptions:
 #
 # Connect a client to a netmap-enabled NIC or to a VALE switch port
 #
@@ -2930,7 +2930,7 @@
 #
 # @devname: #optional path of the netmap device (default: '/dev/netmap')=
.
 #
-# Since 2.0
+# Since: 2.0
 ##
 { 'struct': 'NetdevNetmapOptions',
   'data': {
@@ -2938,7 +2938,7 @@
     '*devname':    'str' } }
=20
 ##
-# @NetdevVhostUserOptions
+# @NetdevVhostUserOptions:
 #
 # Vhost-user network backend
 #
@@ -2949,7 +2949,7 @@
 # @queues: #optional number of queues to be created for multiqueue vhost=
-user
 #          (default: 1) (Since 2.5)
 #
-# Since 2.1
+# Since: 2.1
 ##
 { 'struct': 'NetdevVhostUserOptions',
   'data': {
@@ -2958,18 +2958,18 @@
     '*queues':        'int' } }
=20
 ##
-# @NetClientDriver
+# @NetClientDriver:
 #
 # Available netdev drivers.
 #
-# Since 2.7
+# Since: 2.7
 ##
 { 'enum': 'NetClientDriver',
   'data': [ 'none', 'nic', 'user', 'tap', 'l2tpv3', 'socket', 'vde', 'du=
mp',
             'bridge', 'hubport', 'netmap', 'vhost-user' ] }
=20
 ##
-# @Netdev
+# @Netdev:
 #
 # Captures the configuration of a network device.
 #
@@ -2977,7 +2977,7 @@
 #
 # @type: Specify the driver used for interpreting remaining arguments.
 #
-# Since 1.2
+# Since: 1.2
 #
 # 'l2tpv3' - since 2.1
 ##
@@ -2999,7 +2999,7 @@
     'vhost-user': 'NetdevVhostUserOptions' } }
=20
 ##
-# @NetLegacy
+# @NetLegacy:
 #
 # Captures the configuration of a network device; legacy.
 #
@@ -3011,7 +3011,7 @@
 #
 # @opts: device type specific properties (legacy)
 #
-# Since 1.2
+# Since: 1.2
 ##
 { 'struct': 'NetLegacy',
   'data': {
@@ -3021,11 +3021,11 @@
     'opts':  'NetLegacyOptions' } }
=20
 ##
-# @NetLegacyOptions
+# @NetLegacyOptions:
 #
 # Like Netdev, but for use only by the legacy command line options
 #
-# Since 1.2
+# Since: 1.2
 ##
 { 'union': 'NetLegacyOptions',
   'data': {
@@ -3042,7 +3042,7 @@
     'vhost-user': 'NetdevVhostUserOptions' } }
=20
 ##
-# @NetFilterDirection
+# @NetFilterDirection:
 #
 # Indicates whether a netfilter is attached to a netdev's transmit queue=
 or
 # receive queue or both.
@@ -3056,13 +3056,13 @@
 # @tx: the filter is attached to the transmit queue of the netdev,
 #      where it will receive packets sent by the netdev.
 #
-# Since 2.5
+# Since: 2.5
 ##
 { 'enum': 'NetFilterDirection',
   'data': [ 'all', 'rx', 'tx' ] }
=20
 ##
-# @InetSocketAddress
+# @InetSocketAddress:
 #
 # Captures a socket address or address range in the Internet namespace.
 #
@@ -3078,7 +3078,7 @@
 # @ipv6: whether to accept IPv6 addresses, default try both IPv4 and IPv=
6
 #        #optional
 #
-# Since 1.3
+# Since: 1.3
 ##
 { 'struct': 'InetSocketAddress',
   'data': {
@@ -3089,30 +3089,30 @@
     '*ipv6': 'bool' } }
=20
 ##
-# @UnixSocketAddress
+# @UnixSocketAddress:
 #
 # Captures a socket address in the local ("Unix socket") namespace.
 #
 # @path: filesystem path to use
 #
-# Since 1.3
+# Since: 1.3
 ##
 { 'struct': 'UnixSocketAddress',
   'data': {
     'path': 'str' } }
=20
 ##
-# @VsockSocketAddress
+# @VsockSocketAddress:
 #
 # Captures a socket address in the vsock namespace.
 #
 # @cid: unique host identifier
 # @port: port
 #
-# Note that string types are used to allow for possible future hostname =
or
+# Note: string types are used to allow for possible future hostname or
 # service resolution support.
 #
-# Since 2.8
+# Since: 2.8
 ##
 { 'struct': 'VsockSocketAddress',
   'data': {
@@ -3120,11 +3120,11 @@
     'port': 'str' } }
=20
 ##
-# @SocketAddress
+# @SocketAddress:
 #
 # Captures the address of a socket, which could also be a named file des=
criptor
 #
-# Since 1.3
+# Since: 1.3
 ##
 { 'union': 'SocketAddress',
   'data': {
@@ -3275,7 +3275,7 @@
             '*props': 'any' } }
=20
 ##
-# @CpuModelExpansionType
+# @CpuModelExpansionType:
 #
 # An enumeration of CPU model expansion types.
 #
@@ -3298,7 +3298,7 @@
=20
=20
 ##
-# @CpuModelExpansionInfo
+# @CpuModelExpansionInfo:
 #
 # The result of a cpu model expansion.
 #
@@ -3372,7 +3372,7 @@
   'data': [ 'incompatible', 'identical', 'superset', 'subset' ] }
=20
 ##
-# @CpuModelCompareInfo
+# @CpuModelCompareInfo:
 #
 # The result of a CPU model comparison.
 #
@@ -3436,7 +3436,7 @@
   'returns': 'CpuModelCompareInfo' }
=20
 ##
-# @CpuModelBaselineInfo
+# @CpuModelBaselineInfo:
 #
 # The result of a CPU model baseline.
 #
@@ -3646,7 +3646,7 @@
             'kp_comma', 'kp_equals', 'power' ] }
=20
 ##
-# @KeyValue
+# @KeyValue:
 #
 # Represents a keyboard key.
 #
@@ -4032,7 +4032,7 @@
 { 'command': 'query-tpm', 'returns': ['TPMInfo'] }
=20
 ##
-# @AcpiTableOptions
+# @AcpiTableOptions:
 #
 # Specify an ACPI table on the command line to load.
 #
@@ -4075,7 +4075,7 @@
 #        ACPI table header. At least one file is required. This field ex=
cludes
 #        @file.
 #
-# Since 1.5
+# Since: 1.5
 ##
 { 'struct': 'AcpiTableOptions',
   'data': {
@@ -4103,7 +4103,7 @@
 # @size: accepts a number followed by an optional suffix (K)ilo,
 #        (M)ega, (G)iga, (T)era
 #
-# Since 1.5
+# Since: 1.5
 ##
 { 'enum': 'CommandLineParameterType',
   'data': ['string', 'boolean', 'number', 'size'] }
@@ -4121,7 +4121,7 @@
 #
 # @default: #optional default value string (since 2.1)
 #
-# Since 1.5
+# Since: 1.5
 ##
 { 'struct': 'CommandLineParameterInfo',
   'data': { 'name': 'str',
@@ -4138,7 +4138,7 @@
 #
 # @parameters: an array of @CommandLineParameterInfo
 #
-# Since 1.5
+# Since: 1.5
 ##
 { 'struct': 'CommandLineOptionInfo',
   'data': { 'option': 'str', 'parameters': ['CommandLineParameterInfo'] =
} }
@@ -4153,13 +4153,13 @@
 # Returns: list of @CommandLineOptionInfo for all options (or for the gi=
ven
 #          @option).  Returns an error if the given @option doesn't exis=
t.
 #
-# Since 1.5
+# Since: 1.5
 ##
 {'command': 'query-command-line-options', 'data': { '*option': 'str' },
  'returns': ['CommandLineOptionInfo'] }
=20
 ##
-# @X86CPURegister32
+# @X86CPURegister32:
 #
 # A X86 32-bit register
 #
@@ -4169,7 +4169,7 @@
   'data': [ 'EAX', 'EBX', 'ECX', 'EDX', 'ESP', 'EBP', 'ESI', 'EDI' ] }
=20
 ##
-# @X86CPUFeatureWordInfo
+# @X86CPUFeatureWordInfo:
 #
 # Information about a X86 CPU feature word
 #
@@ -4191,11 +4191,11 @@
             'features': 'int' } }
=20
 ##
-# @DummyForceArrays
+# @DummyForceArrays:
 #
 # Not used by QMP; hack to let us use X86CPUFeatureWordInfoList internal=
ly
 #
-# Since 2.5
+# Since: 2.5
 ##
 { 'struct': 'DummyForceArrays',
   'data': { 'unused': ['X86CPUFeatureWordInfo'] } }
@@ -4245,7 +4245,7 @@
 #
 # @multicast-table: a list of multicast macaddr string
 #
-# Since 1.6
+# Since: 1.6
 ##
 { 'struct': 'RxFilterInfo',
   'data': {
@@ -4280,7 +4280,7 @@
   'returns': ['RxFilterInfo'] }
=20
 ##
-# @InputButton
+# @InputButton:
 #
 # Button of a pointer input device (mouse, tablet).
 #
@@ -4290,7 +4290,7 @@
   'data'  : [ 'left', 'middle', 'right', 'wheel-up', 'wheel-down' ] }
=20
 ##
-# @InputAxis
+# @InputAxis:
 #
 # Position axis of a pointer input device (mouse, tablet).
 #
@@ -4300,7 +4300,7 @@
   'data'  : [ 'x', 'y' ] }
=20
 ##
-# @InputKeyEvent
+# @InputKeyEvent:
 #
 # Keyboard input event.
 #
@@ -4314,7 +4314,7 @@
               'down'    : 'bool' } }
=20
 ##
-# @InputBtnEvent
+# @InputBtnEvent:
 #
 # Pointer button input event.
 #
@@ -4328,7 +4328,7 @@
               'down'    : 'bool' } }
=20
 ##
-# @InputMoveEvent
+# @InputMoveEvent:
 #
 # Pointer motion input event.
 #
@@ -4343,7 +4343,7 @@
               'value'   : 'int' } }
=20
 ##
-# @InputEvent
+# @InputEvent:
 #
 # Input event union.
 #
@@ -4362,7 +4362,7 @@
               'abs'     : 'InputMoveEvent' } }
=20
 ##
-# @input-send-event
+# @input-send-event:
 #
 # Send input event(s) to guest.
 #
@@ -4392,18 +4392,18 @@
             'events' : [ 'InputEvent' ] } }
=20
 ##
-# @NumaOptions
+# @NumaOptions:
 #
 # A discriminated record of NUMA options. (for OptsVisitor)
 #
-# Since 2.1
+# Since: 2.1
 ##
 { 'union': 'NumaOptions',
   'data': {
     'node': 'NumaNodeOptions' }}
=20
 ##
-# @NumaNodeOptions
+# @NumaNodeOptions:
 #
 # Create a guest NUMA node. (for OptsVisitor)
 #
@@ -4429,7 +4429,7 @@
    '*memdev': 'str' }}
=20
 ##
-# @HostMemPolicy
+# @HostMemPolicy:
 #
 # Host memory policy types
 #
@@ -4443,7 +4443,7 @@
 # @interleave: memory allocations are interleaved across the set
 #              of host nodes specified
 #
-# Since 2.1
+# Since: 2.1
 ##
 { 'enum': 'HostMemPolicy',
   'data': [ 'default', 'preferred', 'bind', 'interleave' ] }
@@ -4532,7 +4532,7 @@
 { 'union': 'MemoryDeviceInfo', 'data': {'dimm': 'PCDIMMDeviceInfo'} }
=20
 ##
-# @query-memory-devices
+# @query-memory-devices:
 #
 # Lists available memory devices and their state
 #
@@ -4541,7 +4541,7 @@
 { 'command': 'query-memory-devices', 'returns': ['MemoryDeviceInfo'] }
=20
 ##
-# @ACPISlotType
+# @ACPISlotType:
 #
 # @DIMM: memory slot
 # @CPU: logical CPU slot (since 2.7)
@@ -4549,7 +4549,7 @@
 { 'enum': 'ACPISlotType', 'data': [ 'DIMM', 'CPU' ] }
=20
 ##
-# @ACPIOSTInfo
+# @ACPIOSTInfo:
 #
 # OSPM Status Indication for a device
 # For description of possible values of @source and @status fields
@@ -4575,7 +4575,7 @@
               'status': 'int' } }
=20
 ##
-# @query-acpi-ospm-status
+# @query-acpi-ospm-status:
 #
 # Lists ACPI OSPM status of ACPI device objects,
 # which might be reported via _OST method
@@ -4585,7 +4585,7 @@
 { 'command': 'query-acpi-ospm-status', 'returns': ['ACPIOSTInfo'] }
=20
 ##
-# @WatchdogExpirationAction
+# @WatchdogExpirationAction:
 #
 # An enumeration of the actions taken when the watchdog device's timer i=
s
 # expired
@@ -4613,7 +4613,7 @@
             'inject-nmi' ] }
=20
 ##
-# @IoOperationType
+# @IoOperationType:
 #
 # An enumeration of the I/O operation types
 #
@@ -4627,7 +4627,7 @@
   'data': [ 'read', 'write' ] }
=20
 ##
-# @GuestPanicAction
+# @GuestPanicAction:
 #
 # An enumeration of the actions taken when guest OS panic is detected
 #
@@ -4639,7 +4639,7 @@
   'data': [ 'pause', 'poweroff' ] }
=20
 ##
-# @rtc-reset-reinjection
+# @rtc-reset-reinjection:
 #
 # This command will reset the RTC interrupt reinjection backlog.
 # Can be used if another mechanism to synchronize guest time
@@ -4722,7 +4722,7 @@
 { 'command': 'query-gic-capabilities', 'returns': ['GICCapability'] }
=20
 ##
-# @CpuInstanceProperties
+# @CpuInstanceProperties:
 #
 # List of properties to be used for hotplugging a CPU instance,
 # it should be passed by management with device_add command when
@@ -4750,7 +4750,7 @@
 }
=20
 ##
-# @HotpluggableCPU
+# @HotpluggableCPU:
 #
 # @type: CPU object type for usage with device_add command
 # @props: list of properties to be used for hotplugging CPU
@@ -4769,7 +4769,7 @@
 }
=20
 ##
-# @query-hotpluggable-cpus
+# @query-hotpluggable-cpus:
 #
 # Returns: a list of HotpluggableCPU objects.
 #
diff --git a/qapi/block-core.json b/qapi/block-core.json
index 96d0859..ec1da2a 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -6,7 +6,7 @@
 { 'include': 'common.json' }
=20
 ##
-# @SnapshotInfo
+# @SnapshotInfo:
 #
 # @id: unique snapshot id
 #
@@ -213,7 +213,7 @@
            '*filename': 'str' } }
=20
 ##
-# @BlockdevCacheInfo
+# @BlockdevCacheInfo:
 #
 # Cache mode information for a block device
 #
@@ -378,7 +378,7 @@
 # @offset: if present, the image file stores the data for this range in
 #          raw format at the given offset.
 #
-# Since 1.7
+# Since: 1.7
 ##
 { 'struct': 'BlockDeviceMapEntry',
   'data': { 'start': 'int', 'length': 'int', 'depth': 'int', 'zero': 'bo=
ol',
@@ -790,7 +790,7 @@
                                       '*node-name': 'str', 'password': '=
str'} }
=20
 ##
-# @block_resize
+# @block_resize:
 #
 # Resize a block image while a guest is running.
 #
@@ -812,7 +812,7 @@
                                        'size': 'int' }}
=20
 ##
-# @NewImageMode
+# @NewImageMode:
 #
 # An enumeration that tells QEMU how to set the backing file path in
 # a new image file.
@@ -829,7 +829,7 @@
   'data': [ 'existing', 'absolute-paths' ] }
=20
 ##
-# @BlockdevSnapshotSync
+# @BlockdevSnapshotSync:
 #
 # Either @device or @node-name must be set but not both.
 #
@@ -852,7 +852,7 @@
             '*format': 'str', '*mode': 'NewImageMode' } }
=20
 ##
-# @BlockdevSnapshot
+# @BlockdevSnapshot:
 #
 # @node: device or node name that will have a snapshot created.
 #
@@ -861,13 +861,13 @@
 #           It must not have a current backing file (this can be
 #           achieved by passing "backing": "" to blockdev-add).
 #
-# Since 2.5
+# Since: 2.5
 ##
 { 'struct': 'BlockdevSnapshot',
   'data': { 'node': 'str', 'overlay': 'str' } }
=20
 ##
-# @DriveBackup
+# @DriveBackup:
 #
 # @job-id: #optional identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
@@ -905,9 +905,9 @@
 #                   default 'report' (no limitations, since this applies=
 to
 #                   a different block device than @device).
 #
-# Note that @on-source-error and @on-target-error only affect background=
 I/O.
-# If an error occurs during a guest write request, the device's rerror/w=
error
-# actions will be used.
+# Note: @on-source-error and @on-target-error only affect background
+# I/O.  If an error occurs during a guest write request, the device's
+# rerror/werror actions will be used.
 #
 # Since: 1.6
 ##
@@ -919,7 +919,7 @@
             '*on-target-error': 'BlockdevOnError' } }
=20
 ##
-# @BlockdevBackup
+# @BlockdevBackup:
 #
 # @job-id: #optional identifier for the newly-created block job. If
 #          omitted, the device name will be used. (Since 2.7)
@@ -946,9 +946,9 @@
 #                   default 'report' (no limitations, since this applies=
 to
 #                   a different block device than @device).
 #
-# Note that @on-source-error and @on-target-error only affect background=
 I/O.
-# If an error occurs during a guest write request, the device's rerror/w=
error
-# actions will be used.
+# Note: @on-source-error and @on-target-error only affect background
+# I/O.  If an error occurs during a guest write request, the device's
+# rerror/werror actions will be used.
 #
 # Since: 2.3
 ##
@@ -961,7 +961,7 @@
             '*on-target-error': 'BlockdevOnError' } }
=20
 ##
-# @blockdev-snapshot-sync
+# @blockdev-snapshot-sync:
 #
 # Generates a synchronous snapshot of a block device.
 #
@@ -970,26 +970,26 @@
 # Returns: nothing on success
 #          If @device is not a valid block device, DeviceNotFound
 #
-# Since 0.14.0
+# Since: 0.14.0
 ##
 { 'command': 'blockdev-snapshot-sync',
   'data': 'BlockdevSnapshotSync' }
=20
=20
 ##
-# @blockdev-snapshot
+# @blockdev-snapshot:
 #
 # Generates a snapshot of a block device.
 #
 # For the arguments, see the documentation of BlockdevSnapshot.
 #
-# Since 2.5
+# Since: 2.5
 ##
 { 'command': 'blockdev-snapshot',
   'data': 'BlockdevSnapshot' }
=20
 ##
-# @change-backing-file
+# @change-backing-file:
 #
 # Change the backing file in the image file metadata.  This does not
 # cause QEMU to reopen the image file to reparse the backing filename
@@ -1016,7 +1016,7 @@
             'backing-file': 'str' } }
=20
 ##
-# @block-commit
+# @block-commit:
 #
 # Live commit of data from overlay image nodes into backing nodes - i.e.=
,
 # writes data between 'top' and 'base' into 'base'.
@@ -1079,7 +1079,7 @@
             '*backing-file': 'str', '*speed': 'int' } }
=20
 ##
-# @drive-backup
+# @drive-backup:
 #
 # Start a point-in-time copy of a block device to a new destination.  Th=
e
 # status of ongoing drive-backup operations can be checked with
@@ -1092,13 +1092,13 @@
 # Returns: nothing on success
 #          If @device is not a valid block device, GenericError
 #
-# Since 1.6
+# Since: 1.6
 ##
 { 'command': 'drive-backup', 'boxed': true,
   'data': 'DriveBackup' }
=20
 ##
-# @blockdev-backup
+# @blockdev-backup:
 #
 # Start a point-in-time copy of a block device to a new destination.  Th=
e
 # status of ongoing blockdev-backup operations can be checked with
@@ -1111,25 +1111,25 @@
 # Returns: nothing on success
 #          If @device is not a valid block device, DeviceNotFound
 #
-# Since 2.3
+# Since: 2.3
 ##
 { 'command': 'blockdev-backup', 'boxed': true,
   'data': 'BlockdevBackup' }
=20
=20
 ##
-# @query-named-block-nodes
+# @query-named-block-nodes:
 #
 # Get the named block driver list
 #
 # Returns: the list of BlockDeviceInfo
 #
-# Since 2.0
+# Since: 2.0
 ##
 { 'command': 'query-named-block-nodes', 'returns': [ 'BlockDeviceInfo' ]=
 }
=20
 ##
-# @drive-mirror
+# @drive-mirror:
 #
 # Start mirroring a block device's writes to a new destination.
 #
@@ -1138,13 +1138,13 @@
 # Returns: nothing on success
 #          If @device is not a valid block device, GenericError
 #
-# Since 1.3
+# Since: 1.3
 ##
 { 'command': 'drive-mirror', 'boxed': true,
   'data': 'DriveMirror' }
=20
 ##
-# @DriveMirror
+# @DriveMirror:
 #
 # A set of parameters describing drive mirror setup.
 #
@@ -1198,7 +1198,7 @@
 #         written. Both will result in identical contents.
 #         Default is true. (Since 2.4)
 #
-# Since 1.3
+# Since: 1.3
 ##
 { 'struct': 'DriveMirror',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
@@ -1210,19 +1210,19 @@
             '*unmap': 'bool' } }
=20
 ##
-# @BlockDirtyBitmap
+# @BlockDirtyBitmap:
 #
 # @node: name of device/node which the bitmap is tracking
 #
 # @name: name of the dirty bitmap
 #
-# Since 2.4
+# Since: 2.4
 ##
 { 'struct': 'BlockDirtyBitmap',
   'data': { 'node': 'str', 'name': 'str' } }
=20
 ##
-# @BlockDirtyBitmapAdd
+# @BlockDirtyBitmapAdd:
 #
 # @node: name of device/node which the bitmap is tracking
 #
@@ -1231,13 +1231,13 @@
 # @granularity: #optional the bitmap granularity, default is 64k for
 #               block-dirty-bitmap-add
 #
-# Since 2.4
+# Since: 2.4
 ##
 { 'struct': 'BlockDirtyBitmapAdd',
   'data': { 'node': 'str', 'name': 'str', '*granularity': 'uint32' } }
=20
 ##
-# @block-dirty-bitmap-add
+# @block-dirty-bitmap-add:
 #
 # Create a dirty bitmap with a name on the node
 #
@@ -1245,13 +1245,13 @@
 #          If @node is not a valid block device or node, DeviceNotFound
 #          If @name is already taken, GenericError with an explanation
 #
-# Since 2.4
+# Since: 2.4
 ##
 { 'command': 'block-dirty-bitmap-add',
   'data': 'BlockDirtyBitmapAdd' }
=20
 ##
-# @block-dirty-bitmap-remove
+# @block-dirty-bitmap-remove:
 #
 # Remove a dirty bitmap on the node
 #
@@ -1260,13 +1260,13 @@
 #          If @name is not found, GenericError with an explanation
 #          if @name is frozen by an operation, GenericError
 #
-# Since 2.4
+# Since: 2.4
 ##
 { 'command': 'block-dirty-bitmap-remove',
   'data': 'BlockDirtyBitmap' }
=20
 ##
-# @block-dirty-bitmap-clear
+# @block-dirty-bitmap-clear:
 #
 # Clear (reset) a dirty bitmap on the device
 #
@@ -1274,13 +1274,13 @@
 #          If @node is not a valid block device, DeviceNotFound
 #          If @name is not found, GenericError with an explanation
 #
-# Since 2.4
+# Since: 2.4
 ##
 { 'command': 'block-dirty-bitmap-clear',
   'data': 'BlockDirtyBitmap' }
=20
 ##
-# @blockdev-mirror
+# @blockdev-mirror:
 #
 # Start mirroring a block device's writes to a new destination.
 #
@@ -1321,7 +1321,7 @@
 #
 # Returns: nothing on success.
 #
-# Since 2.6
+# Since: 2.6
 ##
 { 'command': 'blockdev-mirror',
   'data': { '*job-id': 'str', 'device': 'str', 'target': 'str',
@@ -1368,7 +1368,7 @@
   'data': 'BlockIOThrottle' }
=20
 ##
-# @BlockIOThrottle
+# @BlockIOThrottle:
 #
 # A set of parameters describing block throttling.
 #
@@ -1650,7 +1650,7 @@
 { 'command': 'block-job-complete', 'data': { 'device': 'str' } }
=20
 ##
-# @BlockdevDiscardOptions
+# @BlockdevDiscardOptions:
 #
 # Determines how to handle discard requests.
 #
@@ -1663,7 +1663,7 @@
   'data': [ 'ignore', 'unmap' ] }
=20
 ##
-# @BlockdevDetectZeroesOptions
+# @BlockdevDetectZeroesOptions:
 #
 # Describes the operation mode for the automatic conversion of plain
 # zero writes by the OS to driver specific optimized zero write commands=
.
@@ -1679,7 +1679,7 @@
   'data': [ 'off', 'on', 'unmap' ] }
=20
 ##
-# @BlockdevAioOptions
+# @BlockdevAioOptions:
 #
 # Selects the AIO backend to handle I/O requests
 #
@@ -1692,7 +1692,7 @@
   'data': [ 'threads', 'native' ] }
=20
 ##
-# @BlockdevCacheOptions
+# @BlockdevCacheOptions:
 #
 # Includes cache-related options for block devices
 #
@@ -1708,7 +1708,7 @@
             '*no-flush': 'bool' } }
=20
 ##
-# @BlockdevDriver
+# @BlockdevDriver:
 #
 # Drivers that are supported in block device operations.
 #
@@ -1731,7 +1731,7 @@
             'vvfat' ] }
=20
 ##
-# @BlockdevOptionsFile
+# @BlockdevOptionsFile:
 #
 # Driver specific block device options for the file backend.
 #
@@ -1745,7 +1745,7 @@
             '*aio': 'BlockdevAioOptions' } }
=20
 ##
-# @BlockdevOptionsNull
+# @BlockdevOptionsNull:
 #
 # Driver specific block device options for the null backend.
 #
@@ -1760,7 +1760,7 @@
   'data': { '*size': 'int', '*latency-ns': 'uint64' } }
=20
 ##
-# @BlockdevOptionsVVFAT
+# @BlockdevOptionsVVFAT:
 #
 # Driver specific block device options for the vvfat protocol.
 #
@@ -1781,7 +1781,7 @@
             '*label': 'str', '*rw': 'bool' } }
=20
 ##
-# @BlockdevOptionsGenericFormat
+# @BlockdevOptionsGenericFormat:
 #
 # Driver specific block device options for image format that have no opt=
ion
 # besides their data source.
@@ -1794,7 +1794,7 @@
   'data': { 'file': 'BlockdevRef' } }
=20
 ##
-# @BlockdevOptionsLUKS
+# @BlockdevOptionsLUKS:
 #
 # Driver specific block device options for LUKS.
 #
@@ -1810,7 +1810,7 @@
=20
=20
 ##
-# @BlockdevOptionsGenericCOWFormat
+# @BlockdevOptionsGenericCOWFormat:
 #
 # Driver specific block device options for image format that have no opt=
ion
 # besides their data source and an optional backing file.
@@ -1827,7 +1827,7 @@
   'data': { '*backing': 'BlockdevRef' } }
=20
 ##
-# @Qcow2OverlapCheckMode
+# @Qcow2OverlapCheckMode:
 #
 # General overlap check modes.
 #
@@ -1847,7 +1847,7 @@
   'data': [ 'none', 'constant', 'cached', 'all' ] }
=20
 ##
-# @Qcow2OverlapCheckFlags
+# @Qcow2OverlapCheckFlags:
 #
 # Structure of flags for each metadata structure. Setting a field to 'tr=
ue'
 # makes qemu guard that structure against unintended overwriting. The de=
fault
@@ -1870,7 +1870,7 @@
             '*inactive-l2':    'bool' } }
=20
 ##
-# @Qcow2OverlapChecks
+# @Qcow2OverlapChecks:
 #
 # Specifies which metadata structures should be guarded against unintend=
ed
 # overwriting.
@@ -1887,7 +1887,7 @@
             'mode':  'Qcow2OverlapCheckMode' } }
=20
 ##
-# @BlockdevOptionsQcow2
+# @BlockdevOptionsQcow2:
 #
 # Driver specific block device options for qcow2.
 #
@@ -1937,7 +1937,7 @@
=20
=20
 ##
-# @BlockdevOptionsArchipelago
+# @BlockdevOptionsArchipelago:
 #
 # Driver specific block device options for Archipelago.
 #
@@ -1966,7 +1966,7 @@
             '*segment': 'str' } }
=20
 ##
-# @BlockdevOptionsSsh
+# @BlockdevOptionsSsh:
 #
 # @server:              host address
 #
@@ -1977,7 +1977,7 @@
 #
 # TODO: Expose the host_key_check option in QMP
 #
-# Since 2.8
+# Since: 2.8
 ##
 { 'struct': 'BlockdevOptionsSsh',
   'data': { 'server': 'InetSocketAddress',
@@ -1986,7 +1986,7 @@
=20
=20
 ##
-# @BlkdebugEvent
+# @BlkdebugEvent:
 #
 # Trigger events supported by blkdebug.
 #
@@ -2009,7 +2009,7 @@
             'pwritev_zero', 'pwritev_done', 'empty_image_prepare' ] }
=20
 ##
-# @BlkdebugInjectErrorOptions
+# @BlkdebugInjectErrorOptions:
 #
 # Describes a single error injection for blkdebug.
 #
@@ -2041,7 +2041,7 @@
             '*immediately': 'bool' } }
=20
 ##
-# @BlkdebugSetStateOptions
+# @BlkdebugSetStateOptions:
 #
 # Describes a single state-change event for blkdebug.
 #
@@ -2061,7 +2061,7 @@
             'new_state': 'int' } }
=20
 ##
-# @BlockdevOptionsBlkdebug
+# @BlockdevOptionsBlkdebug:
 #
 # Driver specific block device options for blkdebug.
 #
@@ -2086,7 +2086,7 @@
             '*set-state': ['BlkdebugSetStateOptions'] } }
=20
 ##
-# @BlockdevOptionsBlkverify
+# @BlockdevOptionsBlkverify:
 #
 # Driver specific block device options for blkverify.
 #
@@ -2101,7 +2101,7 @@
             'raw': 'BlockdevRef' } }
=20
 ##
-# @QuorumReadPattern
+# @QuorumReadPattern:
 #
 # An enumeration of quorum read patterns.
 #
@@ -2114,7 +2114,7 @@
 { 'enum': 'QuorumReadPattern', 'data': [ 'quorum', 'fifo' ] }
=20
 ##
-# @BlockdevOptionsQuorum
+# @BlockdevOptionsQuorum:
 #
 # Driver specific block device options for Quorum
 #
@@ -2141,7 +2141,7 @@
             '*read-pattern': 'QuorumReadPattern' } }
=20
 ##
-# @GlusterTransport
+# @GlusterTransport:
 #
 # An enumeration of Gluster transport types
 #
@@ -2156,7 +2156,7 @@
=20
=20
 ##
-# @GlusterServer
+# @GlusterServer:
 #
 # Captures the address of a socket
 #
@@ -2185,7 +2185,7 @@
             'tcp': 'InetSocketAddress' } }
=20
 ##
-# @BlockdevOptionsGluster
+# @BlockdevOptionsGluster:
 #
 # Driver specific block device options for Gluster
 #
@@ -2209,7 +2209,7 @@
             '*logfile': 'str' } }
=20
 ##
-# @ReplicationMode
+# @ReplicationMode:
 #
 # An enumeration of replication modes.
 #
@@ -2222,7 +2222,7 @@
 { 'enum' : 'ReplicationMode', 'data' : [ 'primary', 'secondary' ] }
=20
 ##
-# @BlockdevOptionsReplication
+# @BlockdevOptionsReplication:
 #
 # Driver specific block device options for replication
 #
@@ -2240,19 +2240,19 @@
             '*top-id': 'str' } }
=20
 ##
-# @NFSTransport
+# @NFSTransport:
 #
 # An enumeration of NFS transport types
 #
 # @inet:        TCP transport
 #
-# Since 2.8
+# Since: 2.8
 ##
 { 'enum': 'NFSTransport',
   'data': [ 'inet' ] }
=20
 ##
-# @NFSServer
+# @NFSServer:
 #
 # Captures the address of the socket
 #
@@ -2260,14 +2260,14 @@
 #
 # @host:        host address for NFS server
 #
-# Since 2.8
+# Since: 2.8
 ##
 { 'struct': 'NFSServer',
   'data': { 'type': 'NFSTransport',
             'host': 'str' } }
=20
 ##
-# @BlockdevOptionsNfs
+# @BlockdevOptionsNfs:
 #
 # Driver specific block device option for NFS
 #
@@ -2295,7 +2295,7 @@
 # @debug-level:             #optional set the NFS debug level (max 2) (d=
efaults
 #                           to libnfs default)
 #
-# Since 2.8
+# Since: 2.8
 ##
 { 'struct': 'BlockdevOptionsNfs',
   'data': { 'server': 'NFSServer',
@@ -2308,7 +2308,7 @@
             '*debug-level': 'int' } }
=20
 ##
-# @BlockdevOptionsCurl
+# @BlockdevOptionsCurl:
 #
 # Driver specific block device options for the curl backend.
 #
@@ -2320,7 +2320,7 @@
   'data': { 'filename': 'str' } }
=20
 ##
-# @BlockdevOptionsNbd
+# @BlockdevOptionsNbd:
 #
 # Driver specific block device options for NBD.
 #
@@ -2338,7 +2338,7 @@
             '*tls-creds': 'str' } }
=20
 ##
-# @BlockdevOptionsRaw
+# @BlockdevOptionsRaw:
 #
 # Driver specific block device options for the raw driver.
 #
@@ -2352,7 +2352,7 @@
   'data': { '*offset': 'int', '*size': 'int' } }
=20
 ##
-# @BlockdevOptions
+# @BlockdevOptions:
 #
 # Options for creating a block device.  Many options are available for a=
ll
 # block devices, independent of the block driver:
@@ -2418,7 +2418,7 @@
   } }
=20
 ##
-# @BlockdevRef
+# @BlockdevRef:
 #
 # Reference to a block device.
 #
@@ -2616,7 +2616,7 @@
=20
=20
 ##
-# @BlockErrorAction
+# @BlockErrorAction:
 #
 # An enumeration of action that has been taken when a DISK I/O occurs
 #
@@ -2633,7 +2633,7 @@
=20
=20
 ##
-# @BLOCK_IMAGE_CORRUPTED
+# @BLOCK_IMAGE_CORRUPTED:
 #
 # Emitted when a corruption has been detected in a disk image
 #
@@ -2668,7 +2668,7 @@
             'fatal'      : 'bool' } }
=20
 ##
-# @BLOCK_IO_ERROR
+# @BLOCK_IO_ERROR:
 #
 # Emitted when a disk I/O error occurs
 #
@@ -2704,7 +2704,7 @@
             'reason': 'str' } }
=20
 ##
-# @BLOCK_JOB_COMPLETED
+# @BLOCK_JOB_COMPLETED:
 #
 # Emitted when a block job has completed
 #
@@ -2736,7 +2736,7 @@
             '*error': 'str' } }
=20
 ##
-# @BLOCK_JOB_CANCELLED
+# @BLOCK_JOB_CANCELLED:
 #
 # Emitted when a block job has been cancelled
 #
@@ -2762,7 +2762,7 @@
             'speed' : 'int' } }
=20
 ##
-# @BLOCK_JOB_ERROR
+# @BLOCK_JOB_ERROR:
 #
 # Emitted when a block job encounters an error
 #
@@ -2781,7 +2781,7 @@
             'action'   : 'BlockErrorAction' } }
=20
 ##
-# @BLOCK_JOB_READY
+# @BLOCK_JOB_READY:
 #
 # Emitted when a block job is ready to complete
 #
@@ -2810,7 +2810,7 @@
             'speed' : 'int' } }
=20
 ##
-# @PreallocMode
+# @PreallocMode:
 #
 # Preallocation mode of QEMU image file
 #
@@ -2822,13 +2822,13 @@
 #        space is really available. @full preallocation also sets up
 #        metadata correctly.
 #
-# Since 2.2
+# Since: 2.2
 ##
 { 'enum': 'PreallocMode',
   'data': [ 'off', 'metadata', 'falloc', 'full' ] }
=20
 ##
-# @BLOCK_WRITE_THRESHOLD
+# @BLOCK_WRITE_THRESHOLD:
 #
 # Emitted when writes on block device reaches or exceeds the
 # configured write threshold. For thin-provisioned devices, this
@@ -2851,7 +2851,7 @@
             'write-threshold': 'uint64' } }
=20
 ##
-# @block-set-write-threshold
+# @block-set-write-threshold:
 #
 # Change the write threshold for a block drive. An event will be deliver=
ed
 # if a write to this block drive crosses the configured threshold.
@@ -2869,7 +2869,7 @@
   'data': { 'node-name': 'str', 'write-threshold': 'uint64' } }
=20
 ##
-# @x-blockdev-change
+# @x-blockdev-change:
 #
 # Dynamically reconfigure the block driver state graph. It can be used
 # to add, remove, insert or replace a graph node. Currently only the
diff --git a/qapi/block.json b/qapi/block.json
index 4661fc9..937df05 100644
--- a/qapi/block.json
+++ b/qapi/block.json
@@ -40,7 +40,7 @@
   'data': ['auto', 'none', 'lba', 'large', 'rechs']}
=20
 ##
-# @FloppyDriveType
+# @FloppyDriveType:
 #
 # Type of Floppy drive to be emulated by the Floppy Disk Controller.
 #
@@ -56,7 +56,7 @@
   'data': ['144', '288', '120', 'none', 'auto']}
=20
 ##
-# @BlockdevSnapshotInternal
+# @BlockdevSnapshotInternal:
 #
 # @device: the device name or node-name of a root node to generate the s=
napshot
 #          from
@@ -73,7 +73,7 @@
   'data': { 'device': 'str', 'name': 'str' } }
=20
 ##
-# @blockdev-snapshot-internal-sync
+# @blockdev-snapshot-internal-sync:
 #
 # Synchronously take an internal snapshot of a block device, when the fo=
rmat
 # of the image used supports it.
@@ -87,13 +87,13 @@
 #          If the format of the image used does not support it,
 #          BlockFormatFeatureNotSupported
 #
-# Since 1.7
+# Since: 1.7
 ##
 { 'command': 'blockdev-snapshot-internal-sync',
   'data': 'BlockdevSnapshotInternal' }
=20
 ##
-# @blockdev-snapshot-delete-internal-sync
+# @blockdev-snapshot-delete-internal-sync:
 #
 # Synchronously delete an internal snapshot of a block device, when the =
format
 # of the image used support it. The snapshot is identified by name or id=
 or
@@ -114,7 +114,7 @@
 #          BlockFormatFeatureNotSupported
 #          If @id and @name are both not specified, GenericError
 #
-# Since 1.7
+# Since: 1.7
 ##
 { 'command': 'blockdev-snapshot-delete-internal-sync',
   'data': { 'device': 'str', '*id': 'str', '*name': 'str'},
@@ -190,7 +190,7 @@
 { 'command': 'nbd-server-stop' }
=20
 ##
-# @DEVICE_TRAY_MOVED
+# @DEVICE_TRAY_MOVED:
 #
 # Emitted whenever the tray of a removable device is moved by the guest =
or by
 # HMP/QMP commands
@@ -209,7 +209,7 @@
   'data': { 'device': 'str', 'id': 'str', 'tray-open': 'bool' } }
=20
 ##
-# @QuorumOpType
+# @QuorumOpType:
 #
 # An enumeration of the quorum operation types
 #
diff --git a/qapi/common.json b/qapi/common.json
index 6987100..624a861 100644
--- a/qapi/common.json
+++ b/qapi/common.json
@@ -3,7 +3,7 @@
 # QAPI common definitions
=20
 ##
-# @QapiErrorClass
+# @QapiErrorClass:
 #
 # QEMU error classes
 #
@@ -30,7 +30,7 @@
             'DeviceNotActive', 'DeviceNotFound', 'KVMMissingCap' ] }
=20
 ##
-# @VersionTriple
+# @VersionTriple:
 #
 # A three-part version number.
 #
@@ -101,7 +101,7 @@
 { 'command': 'query-commands', 'returns': ['CommandInfo'] }
=20
 ##
-# @OnOffAuto
+# @OnOffAuto:
 #
 # An enumeration of three options: on, off, and auto
 #
@@ -117,7 +117,7 @@
   'data': [ 'auto', 'on', 'off' ] }
=20
 ##
-# @OnOffSplit
+# @OnOffSplit:
 #
 # An enumeration of three values: on, off, and split
 #
diff --git a/qapi/event.json b/qapi/event.json
index 8642052..37bf34e 100644
--- a/qapi/event.json
+++ b/qapi/event.json
@@ -1,5 +1,5 @@
 ##
-# @SHUTDOWN
+# @SHUTDOWN:
 #
 # Emitted when the virtual machine has shut down, indicating that qemu i=
s
 # about to exit.
@@ -12,7 +12,7 @@
 { 'event': 'SHUTDOWN' }
=20
 ##
-# @POWERDOWN
+# @POWERDOWN:
 #
 # Emitted when the virtual machine is powered down through the power con=
trol
 # system, such as via ACPI.
@@ -22,7 +22,7 @@
 { 'event': 'POWERDOWN' }
=20
 ##
-# @RESET
+# @RESET:
 #
 # Emitted when the virtual machine is reset
 #
@@ -31,7 +31,7 @@
 { 'event': 'RESET' }
=20
 ##
-# @STOP
+# @STOP:
 #
 # Emitted when the virtual machine is stopped
 #
@@ -40,7 +40,7 @@
 { 'event': 'STOP' }
=20
 ##
-# @RESUME
+# @RESUME:
 #
 # Emitted when the virtual machine resumes execution
 #
@@ -49,7 +49,7 @@
 { 'event': 'RESUME' }
=20
 ##
-# @SUSPEND
+# @SUSPEND:
 #
 # Emitted when guest enters a hardware suspension state, for example, S3=
 state,
 # which is sometimes called standby state
@@ -59,7 +59,7 @@
 { 'event': 'SUSPEND' }
=20
 ##
-# @SUSPEND_DISK
+# @SUSPEND_DISK:
 #
 # Emitted when guest enters a hardware suspension state with data saved =
on
 # disk, for example, S4 state, which is sometimes called hibernate state
@@ -71,7 +71,7 @@
 { 'event': 'SUSPEND_DISK' }
=20
 ##
-# @WAKEUP
+# @WAKEUP:
 #
 # Emitted when the guest has woken up from suspend state and is running
 #
@@ -80,7 +80,7 @@
 { 'event': 'WAKEUP' }
=20
 ##
-# @RTC_CHANGE
+# @RTC_CHANGE:
 #
 # Emitted when the guest changes the RTC time.
 #
@@ -93,7 +93,7 @@
   'data': { 'offset': 'int' } }
=20
 ##
-# @WATCHDOG
+# @WATCHDOG:
 #
 # Emitted when the watchdog device's timer is expired
 #
@@ -108,7 +108,7 @@
   'data': { 'action': 'WatchdogExpirationAction' } }
=20
 ##
-# @DEVICE_DELETED
+# @DEVICE_DELETED:
 #
 # Emitted whenever the device removal completion is acknowledged by the =
guest.
 # At this point, it's safe to reuse the specified device ID. Device remo=
val can
@@ -124,7 +124,7 @@
   'data': { '*device': 'str', 'path': 'str' } }
=20
 ##
-# @NIC_RX_FILTER_CHANGED
+# @NIC_RX_FILTER_CHANGED:
 #
 # Emitted once until the 'query-rx-filter' command is executed, the firs=
t event
 # will always be emitted
@@ -139,7 +139,7 @@
   'data': { '*name': 'str', 'path': 'str' } }
=20
 ##
-# @VNC_CONNECTED
+# @VNC_CONNECTED:
 #
 # Emitted when a VNC client establishes a connection
 #
@@ -157,7 +157,7 @@
             'client': 'VncBasicInfo' } }
=20
 ##
-# @VNC_INITIALIZED
+# @VNC_INITIALIZED:
 #
 # Emitted after authentication takes place (if any) and the VNC session =
is
 # made active
@@ -173,7 +173,7 @@
             'client': 'VncClientInfo' } }
=20
 ##
-# @VNC_DISCONNECTED
+# @VNC_DISCONNECTED:
 #
 # Emitted when the connection is closed
 #
@@ -188,7 +188,7 @@
             'client': 'VncClientInfo' } }
=20
 ##
-# @SPICE_CONNECTED
+# @SPICE_CONNECTED:
 #
 # Emitted when a SPICE client establishes a connection
 #
@@ -203,7 +203,7 @@
             'client': 'SpiceBasicInfo' } }
=20
 ##
-# @SPICE_INITIALIZED
+# @SPICE_INITIALIZED:
 #
 # Emitted after initial handshake and authentication takes place (if any=
)
 # and the SPICE channel is up and running
@@ -219,7 +219,7 @@
             'client': 'SpiceChannel' } }
=20
 ##
-# @SPICE_DISCONNECTED
+# @SPICE_DISCONNECTED:
 #
 # Emitted when the SPICE connection is closed
 #
@@ -234,7 +234,7 @@
             'client': 'SpiceBasicInfo' } }
=20
 ##
-# @SPICE_MIGRATE_COMPLETED
+# @SPICE_MIGRATE_COMPLETED:
 #
 # Emitted when SPICE migration has completed
 #
@@ -243,7 +243,7 @@
 { 'event': 'SPICE_MIGRATE_COMPLETED' }
=20
 ##
-# @MIGRATION
+# @MIGRATION:
 #
 # Emitted when a migration event happens
 #
@@ -255,7 +255,7 @@
   'data': {'status': 'MigrationStatus'}}
=20
 ##
-# @MIGRATION_PASS
+# @MIGRATION_PASS:
 #
 # Emitted from the source side of a migration at the start of each pass
 # (when it syncs the dirty bitmap)
@@ -268,7 +268,7 @@
   'data': { 'pass': 'int' } }
=20
 ##
-# @ACPI_DEVICE_OST
+# @ACPI_DEVICE_OST:
 #
 # Emitted when guest executes ACPI _OST method.
 #
@@ -280,7 +280,7 @@
      'data': { 'info': 'ACPIOSTInfo' } }
=20
 ##
-# @BALLOON_CHANGE
+# @BALLOON_CHANGE:
 #
 # Emitted when the guest changes the actual BALLOON level. This value is
 # equivalent to the @actual field return by the 'query-balloon' command
@@ -293,7 +293,7 @@
   'data': { 'actual': 'int' } }
=20
 ##
-# @GUEST_PANICKED
+# @GUEST_PANICKED:
 #
 # Emitted when guest OS panic is detected
 #
@@ -305,7 +305,7 @@
   'data': { 'action': 'GuestPanicAction' } }
=20
 ##
-# @QUORUM_FAILURE
+# @QUORUM_FAILURE:
 #
 # Emitted by the Quorum block driver if it fails to establish a quorum
 #
@@ -321,7 +321,7 @@
   'data': { 'reference': 'str', 'sector-num': 'int', 'sectors-count': 'i=
nt' } }
=20
 ##
-# @QUORUM_REPORT_BAD
+# @QUORUM_REPORT_BAD:
 #
 # Emitted to report a corruption of a Quorum file
 #
@@ -345,7 +345,7 @@
             'sector-num': 'int', 'sectors-count': 'int' } }
=20
 ##
-# @VSERPORT_CHANGE
+# @VSERPORT_CHANGE:
 #
 # Emitted when the guest opens or closes a virtio-serial port.
 #
@@ -359,7 +359,7 @@
   'data': { 'id': 'str', 'open': 'bool' } }
=20
 ##
-# @MEM_UNPLUG_ERROR
+# @MEM_UNPLUG_ERROR:
 #
 # Emitted when memory hot unplug error occurs.
 #
@@ -373,7 +373,7 @@
   'data': { 'device': 'str', 'msg': 'str' } }
=20
 ##
-# @DUMP_COMPLETED
+# @DUMP_COMPLETED:
 #
 # Emitted when background dump has completed
 #
diff --git a/qapi/introspect.json b/qapi/introspect.json
index 3fd81fb..fd4dc84 100644
--- a/qapi/introspect.json
+++ b/qapi/introspect.json
@@ -11,7 +11,7 @@
 # See the COPYING file in the top-level directory.
=20
 ##
-# @query-qmp-schema
+# @query-qmp-schema:
 #
 # Command query-qmp-schema exposes the QMP wire ABI as an array of
 # SchemaInfo.  This lets QMP clients figure out what commands and
@@ -49,7 +49,7 @@
   'gen': false }                # just to simplify qmp_query_json()
=20
 ##
-# @SchemaMetaType
+# @SchemaMetaType:
 #
 # This is a @SchemaInfo's meta type, i.e. the kind of entity it
 # describes.
@@ -75,7 +75,7 @@
             'command', 'event' ] }
=20
 ##
-# @SchemaInfo
+# @SchemaInfo:
 #
 # @name: the entity's name, inherited from @base.
 #        Commands and events have the name defined in the QAPI schema.
@@ -105,7 +105,7 @@
       'event': 'SchemaInfoEvent' } }
=20
 ##
-# @SchemaInfoBuiltin
+# @SchemaInfoBuiltin:
 #
 # Additional SchemaInfo members for meta-type 'builtin'.
 #
@@ -117,7 +117,7 @@
   'data': { 'json-type': 'JSONType' } }
=20
 ##
-# @JSONType
+# @JSONType:
 #
 # The four primitive and two structured types according to RFC 7159
 # section 1, plus 'int' (split off 'number'), plus the obvious top
@@ -130,7 +130,7 @@
             'object', 'array', 'value' ] }
=20
 ##
-# @SchemaInfoEnum
+# @SchemaInfoEnum:
 #
 # Additional SchemaInfo members for meta-type 'enum'.
 #
@@ -144,7 +144,7 @@
   'data': { 'values': ['str'] } }
=20
 ##
-# @SchemaInfoArray
+# @SchemaInfoArray:
 #
 # Additional SchemaInfo members for meta-type 'array'.
 #
@@ -158,7 +158,7 @@
   'data': { 'element-type': 'str' } }
=20
 ##
-# @SchemaInfoObject
+# @SchemaInfoObject:
 #
 # Additional SchemaInfo members for meta-type 'object'.
 #
@@ -183,7 +183,7 @@
             '*variants': [ 'SchemaInfoObjectVariant' ] } }
=20
 ##
-# @SchemaInfoObjectMember
+# @SchemaInfoObjectMember:
 #
 # An object member.
 #
@@ -206,7 +206,7 @@
 # @default's type must be null or match @type
=20
 ##
-# @SchemaInfoObjectVariant
+# @SchemaInfoObjectVariant:
 #
 # The variant members for a value of the type tag.
 #
@@ -221,7 +221,7 @@
   'data': { 'case': 'str', 'type': 'str' } }
=20
 ##
-# @SchemaInfoAlternate
+# @SchemaInfoAlternate:
 #
 # Additional SchemaInfo members for meta-type 'alternate'.
 #
@@ -237,7 +237,7 @@
   'data': { 'members': [ 'SchemaInfoAlternateMember' ] } }
=20
 ##
-# @SchemaInfoAlternateMember
+# @SchemaInfoAlternateMember:
 #
 # An alternate member.
 #
@@ -249,7 +249,7 @@
   'data': { 'type': 'str' } }
=20
 ##
-# @SchemaInfoCommand
+# @SchemaInfoCommand:
 #
 # Additional SchemaInfo members for meta-type 'command'.
 #
@@ -266,7 +266,7 @@
   'data': { 'arg-type': 'str', 'ret-type': 'str' } }
=20
 ##
-# @SchemaInfoEvent
+# @SchemaInfoEvent:
 #
 # Additional SchemaInfo members for meta-type 'event'.
 #
diff --git a/qapi/trace.json b/qapi/trace.json
index e872146..4fd39b7 100644
--- a/qapi/trace.json
+++ b/qapi/trace.json
@@ -17,7 +17,7 @@
 #
 # @enabled: The event is dynamically enabled.
 #
-# Since 2.2
+# Since: 2.2
 ##
 { 'enum': 'TraceEventState',
   'data': ['unavailable', 'disabled', 'enabled'] }
@@ -34,7 +34,7 @@
 # An event is per-vCPU if it has the "vcpu" property in the "trace-event=
s"
 # files.
 #
-# Since 2.2
+# Since: 2.2
 ##
 { 'struct': 'TraceEventInfo',
   'data': {'name': 'str', 'state': 'TraceEventState', 'vcpu': 'bool'} }
@@ -58,7 +58,7 @@
 # exact match, @vcpu is given and the event does not have the "vcpu" pro=
perty,
 # an error is returned.
 #
-# Since 2.2
+# Since: 2.2
 ##
 { 'command': 'trace-event-get-state',
   'data': {'name': 'str', '*vcpu': 'int'},
@@ -83,7 +83,7 @@
 # match, @vcpu is given and the event does not have the "vcpu" property,=
 an
 # error is returned.
 #
-# Since 2.2
+# Since: 2.2
 ##
 { 'command': 'trace-event-set-state',
   'data': {'name': 'str', 'enable': 'bool', '*ignore-unavailable': 'bool=
',
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index ad0a31d..94c0312 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -102,7 +102,7 @@
 #
 # Returns: Time in nanoseconds.
 #
-# Since 1.5
+# Since: 1.5
 ##
 { 'command': 'guest-get-time',
   'returns': 'int' }
@@ -149,13 +149,13 @@
 # @success-response: whether command returns a response on success
 #                    (since 1.7)
 #
-# Since 1.1.0
+# Since: 1.1.0
 ##
 { 'struct': 'GuestAgentCommandInfo',
   'data': { 'name': 'str', 'enabled': 'bool', 'success-response': 'bool'=
 } }
=20
 ##
-# @GuestAgentInfo
+# @GuestAgentInfo:
 #
 # Information about guest agent.
 #
@@ -163,7 +163,7 @@
 #
 # @supported_commands: Information about guest agent commands
 #
-# Since 0.15.0
+# Since: 0.15.0
 ##
 { 'struct': 'GuestAgentInfo',
   'data': { 'version': 'str',
@@ -230,7 +230,7 @@
   'data': { 'handle': 'int' } }
=20
 ##
-# @GuestFileRead
+# @GuestFileRead:
 #
 # Result of guest agent file-read operation
 #
@@ -264,7 +264,7 @@
   'returns': 'GuestFileRead' }
=20
 ##
-# @GuestFileWrite
+# @GuestFileWrite:
 #
 # Result of guest agent file-write operation
 #
@@ -300,7 +300,7 @@
=20
=20
 ##
-# @GuestFileSeek
+# @GuestFileSeek:
 #
 # Result of guest agent file-seek operation
 #
@@ -378,7 +378,7 @@
   'data': { 'handle': 'int' } }
=20
 ##
-# @GuestFsfreezeStatus
+# @GuestFsfreezeStatus:
 #
 # An enumeration of filesystem freeze states
 #
@@ -455,7 +455,7 @@
   'returns': 'int' }
=20
 ##
-# @GuestFilesystemTrimResult
+# @GuestFilesystemTrimResult:
 #
 # @path: path that was trimmed
 # @error: an error message when trim failed
@@ -469,7 +469,7 @@
            '*trimmed': 'int', '*minimum': 'int', '*error': 'str'} }
=20
 ##
-# @GuestFilesystemTrimResponse
+# @GuestFilesystemTrimResponse:
 #
 # @paths: list of @GuestFilesystemTrimResult per path that was trimmed
 #
@@ -501,7 +501,7 @@
   'returns': 'GuestFilesystemTrimResponse' }
=20
 ##
-# @guest-suspend-disk
+# @guest-suspend-disk:
 #
 # Suspend guest to disk.
 #
@@ -529,7 +529,7 @@
 { 'command': 'guest-suspend-disk', 'success-response': false }
=20
 ##
-# @guest-suspend-ram
+# @guest-suspend-ram:
 #
 # Suspend guest to ram.
 #
@@ -561,7 +561,7 @@
 { 'command': 'guest-suspend-ram', 'success-response': false }
=20
 ##
-# @guest-suspend-hybrid
+# @guest-suspend-hybrid:
 #
 # Save guest state to disk and suspend to ram.
 #
@@ -720,7 +720,7 @@
   'returns': 'int' }
=20
 ##
-# @GuestDiskBusType
+# @GuestDiskBusType:
 #
 # An enumeration of bus type of disks
 #
@@ -783,7 +783,7 @@
            'bus': 'int', 'target': 'int', 'unit': 'int'} }
=20
 ##
-# @GuestFilesystemInfo
+# @GuestFilesystemInfo:
 #
 # @name: disk name
 # @mountpoint: mount point path
@@ -811,7 +811,7 @@
   'returns': ['GuestFilesystemInfo'] }
=20
 ##
-# @guest-set-user-password
+# @guest-set-user-password:
 #
 # @username: the user account whose password to change
 # @password: the new password entry string, base64 encoded
@@ -832,7 +832,7 @@
 #
 # Returns: Nothing on success.
 #
-# Since 2.3
+# Since: 2.3
 ##
 { 'command': 'guest-set-user-password',
   'data': { 'username': 'str', 'password': 'str', 'crypted': 'bool' } }
@@ -873,7 +873,7 @@
   'returns': ['GuestMemoryBlock'] }
=20
 ##
-# @GuestMemoryBlockResponseType
+# @GuestMemoryBlockResponseType:
 #
 # An enumeration of memory block operation result.
 #
@@ -956,7 +956,7 @@
 #
 # Returns: @GuestMemoryBlockInfo
 #
-# Since 2.3
+# Since: 2.3
 ##
 { 'command': 'guest-get-memory-block-info',
   'returns': 'GuestMemoryBlockInfo' }
@@ -984,7 +984,7 @@
             '*out-data': 'str', '*err-data': 'str',
             '*out-truncated': 'bool', '*err-truncated': 'bool' }}
 ##
-# @guest-exec-status
+# @guest-exec-status:
 #
 # Check status of process associated with PID retrieved via guest-exec.
 # Reap the process and associated metadata if it has exited.
@@ -993,7 +993,7 @@
 #
 # Returns: GuestExecStatus on success.
 #
-# Since 2.5
+# Since: 2.5
 ##
 { 'command': 'guest-exec-status',
   'data':    { 'pid': 'int' },
@@ -1003,7 +1003,7 @@
 # @GuestExec:
 # @pid: pid of child process in guest OS
 #
-#Since: 2.5
+# Since: 2.5
 ##
 { 'struct': 'GuestExec',
   'data': { 'pid': 'int'} }
--=20
2.5.5
