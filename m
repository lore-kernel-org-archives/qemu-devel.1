Received: from eggs.gnu.org ([2001:4830:134:3::10]:54018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3b-00070o-92
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1eko3Y-0006M2-48
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:23 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:36016 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1eko3X-0006I1-H8
	for qemu-devel@nongnu.org; Sun, 11 Feb 2018 04:36:19 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Sun, 11 Feb 2018 10:36:06 +0100
Message-Id: <20180211093607.27351-29-armbru@redhat.com>
In-Reply-To: <20180211093607.27351-1-armbru@redhat.com>
References: <20180211093607.27351-1-armbru@redhat.com>
Subject: [Qemu-devel] [PATCH v2 28/29] Fix up dangling references to
 qmp-commands.* in comment and doc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: mdroth@linux.vnet.ibm.com, marcandre.lureau@redhat.com, eblake@redhat.com

Fix up the reference to qmp-commands.hx in qmp.c.  Missed in commit
5032a16d1d.

Fix up the reference to qmp-commands.txt in
docs/xen-save-devices-state.txt.  Missed in commit 4d8bb958fa.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
---
 docs/xen-save-devices-state.txt |  3 +--
 qmp.c                           | 14 +++++++-------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/docs/xen-save-devices-state.txt b/docs/xen-save-devices-state.txt
index a72ecc8081..1912ecad25 100644
--- a/docs/xen-save-devices-state.txt
+++ b/docs/xen-save-devices-state.txt
@@ -8,8 +8,7 @@ These operations are normally used with migration (see migration.txt),
 however it is also possible to save the state of all devices to file,
 without saving the RAM or the block devices of the VM.
 
-This operation is called "xen-save-devices-state" (see
-qmp-commands.txt)
+The save operation is available as QMP command xen-save-devices-state.
 
 
 The binary format used in the file is the following:
diff --git a/qmp.c b/qmp.c
index a8d4eba973..ba82e1df9f 100644
--- a/qmp.c
+++ b/qmp.c
@@ -147,13 +147,13 @@ VncInfo2List *qmp_query_vnc_servers(Error **errp)
 
 #ifndef CONFIG_SPICE
 /*
- * qmp-commands.hx ensures that QMP command query-spice exists only
- * #ifdef CONFIG_SPICE.  Necessary for an accurate query-commands
- * result.  However, the QAPI schema is blissfully unaware of that,
- * and the QAPI code generator happily generates a dead
- * qmp_marshal_query_spice() that calls qmp_query_spice().  Provide it
- * one, or else linking fails.  FIXME Educate the QAPI schema on
- * CONFIG_SPICE.
+ * qmp_unregister_commands_hack() ensures that QMP command query-spice
+ * exists only #ifdef CONFIG_SPICE.  Necessary for an accurate
+ * query-commands result.  However, the QAPI schema is blissfully
+ * unaware of that, and the QAPI code generator happily generates a
+ * dead qmp_marshal_query_spice() that calls qmp_query_spice().
+ * Provide it one, or else linking fails.  FIXME Educate the QAPI
+ * schema on CONFIG_SPICE.
  */
 SpiceInfo *qmp_query_spice(Error **errp)
 {
-- 
2.13.6
