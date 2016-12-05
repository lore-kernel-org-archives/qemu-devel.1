Received: from eggs.gnu.org ([2001:4830:134:3::10]:47268)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOG-0007VN-Lx
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1cDwOF-0006wu-Fp
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:54712)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1cDwOF-0006wN-7J
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 11:45:19 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com
	(int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6240C64D5
	for <qemu-devel@nongnu.org>; Mon,  5 Dec 2016 16:45:18 +0000 (UTC)
From: Markus Armbruster <armbru@redhat.com>
Date: Mon,  5 Dec 2016 17:45:09 +0100
Message-Id: <1480956313-31322-6-git-send-email-armbru@redhat.com>
In-Reply-To: <1480956313-31322-1-git-send-email-armbru@redhat.com>
References: <1480956313-31322-1-git-send-email-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 5/9] qapi: fix schema symbol sections
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

According to docs/qapi-code-gen.txt, there needs to be '##' to start a
and end a symbol section, that's also what the documentation parser
expects.

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Message-Id: <20161117155504.21843-5-marcandre.lureau@redhat.com>
Reviewed-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 qapi-schema.json     | 18 +++++++++++++-----
 qapi/block-core.json |  1 +
 qga/qapi-schema.json |  3 +++
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/qapi-schema.json b/qapi-schema.json
index f3e9bfc..af488a8 100644
--- a/qapi-schema.json
+++ b/qapi-schema.json
@@ -65,6 +65,7 @@
 { 'enum': 'LostTickPolicy',
   'data': ['discard', 'delay', 'merge', 'slew' ] }
=20
+##
 # @add_client
 #
 # Allow client connections for VNC, Spice and socket based
@@ -443,6 +444,7 @@
            'cache-miss': 'int', 'cache-miss-rate': 'number',
            'overflow': 'int' } }
=20
+##
 # @MigrationStatus:
 #
 # An enumeration of migration status.
@@ -629,6 +631,7 @@
 ##
 { 'command': 'query-migrate-capabilities', 'returns':   ['MigrationCapab=
ilityStatus']}
=20
+##
 # @MigrationParameter
 #
 # Migration parameters enumeration
@@ -687,7 +690,7 @@
            'tls-creds', 'tls-hostname', 'max-bandwidth',
            'downtime-limit', 'x-checkpoint-delay' ] }
=20
-#
+##
 # @migrate-set-parameters
 #
 # Set various migration parameters.  See MigrationParameters for details=
.
@@ -699,7 +702,7 @@
 { 'command': 'migrate-set-parameters', 'boxed': true,
   'data': 'MigrationParameters' }
=20
-#
+##
 # @MigrationParameters
 #
 # Optional members can be omitted on input ('migrate-set-parameters')
@@ -797,6 +800,7 @@
 # command.
 #
 # Since: 2.5
+##
 { 'command': 'migrate-start-postcopy' }
=20
 ##
@@ -2254,6 +2258,7 @@
 ##
 { 'command': 'migrate-incoming', 'data': {'uri': 'str' } }
=20
+##
 # @xen-save-devices-state:
 #
 # Save the state of all devices to file. The RAM and the block devices
@@ -3484,6 +3489,7 @@
             'modelb': 'CpuModelInfo' },
   'returns': 'CpuModelBaselineInfo' }
=20
+##
 # @AddfdInfo:
 #
 # Information about a file descriptor that was added to an fd set.
@@ -4532,14 +4538,16 @@
 ##
 { 'command': 'query-memory-devices', 'returns': ['MemoryDeviceInfo'] }
=20
-## @ACPISlotType
+##
+# @ACPISlotType
 #
 # @DIMM: memory slot
 # @CPU: logical CPU slot (since 2.7)
-#
+##
 { 'enum': 'ACPISlotType', 'data': [ 'DIMM', 'CPU' ] }
=20
-## @ACPIOSTInfo
+##
+# @ACPIOSTInfo
 #
 # OSPM Status Indication for a device
 # For description of possible values of @source and @status fields
diff --git a/qapi/block-core.json b/qapi/block-core.json
index c29bef7..39cdaba 100644
--- a/qapi/block-core.json
+++ b/qapi/block-core.json
@@ -2809,6 +2809,7 @@
             'offset': 'int',
             'speed' : 'int' } }
=20
+##
 # @PreallocMode
 #
 # Preallocation mode of QEMU image file
diff --git a/qga/qapi-schema.json b/qga/qapi-schema.json
index 758803a..7a35267 100644
--- a/qga/qapi-schema.json
+++ b/qga/qapi-schema.json
@@ -837,6 +837,7 @@
 { 'command': 'guest-set-user-password',
   'data': { 'username': 'str', 'password': 'str', 'crypted': 'bool' } }
=20
+##
 # @GuestMemoryBlock:
 #
 # @phys-index: Arbitrary guest-specific unique identifier of the MEMORY =
BLOCK.
@@ -936,6 +937,7 @@
   'data':    {'mem-blks': ['GuestMemoryBlock'] },
   'returns': ['GuestMemoryBlockResponse'] }
=20
+##
 # @GuestMemoryBlockInfo:
 #
 # @size: the size (in bytes) of the guest memory blocks,
@@ -959,6 +961,7 @@
 { 'command': 'guest-get-memory-block-info',
   'returns': 'GuestMemoryBlockInfo' }
=20
+##
 # @GuestExecStatus:
 #
 # @exited: true if process has already terminated.
--=20
2.5.5
