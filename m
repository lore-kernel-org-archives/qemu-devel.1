Received: from eggs.gnu.org ([2001:4830:134:3::10]:41037)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU7j-0001ei-3n
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:44:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1erU7i-0000Ln-4c
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:44:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47384)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1erU7h-0000LG-Uk
	for qemu-devel@nongnu.org; Thu, 01 Mar 2018 14:44:14 -0500
From: Eric Blake <eblake@redhat.com>
Date: Thu,  1 Mar 2018 13:42:44 -0600
Message-Id: <20180301194245.29854-30-eblake@redhat.com>
In-Reply-To: <20180301194245.29854-1-eblake@redhat.com>
References: <20180301194245.29854-1-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 29/30] Fix up dangling references to
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
Cc: Markus Armbruster <armbru@redhat.com>, Stefano Stabellini <sstabellini@kernel.org>, Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>

From: Markus Armbruster <armbru@redhat.com>

Fix up the reference to qmp-commands.hx in qmp.c.  Missed in commit
5032a16d1d.

Fix up the reference to qmp-commands.txt in
docs/xen-save-devices-state.txt.  Missed in commit 4d8bb958fa.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Message-Id: <20180211093607.27351-29-armbru@redhat.com>
Reviewed-by: Eric Blake <eblake@redhat.com>
Reviewed-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Michael Roth <mdroth@linux.vnet.ibm.com>
Signed-off-by: Eric Blake <eblake@redhat.com>
---
 docs/xen-save-devices-state.txt |  3 +--
 qmp.c                           | 14 +++++++-------
 2 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/docs/xen-save-devices-state.txt b/docs/xen-save-devices-stat=
e.txt
index a72ecc80818..1912ecad258 100644
--- a/docs/xen-save-devices-state.txt
+++ b/docs/xen-save-devices-state.txt
@@ -8,8 +8,7 @@ These operations are normally used with migration (see mi=
gration.txt),
 however it is also possible to save the state of all devices to file,
 without saving the RAM or the block devices of the VM.

-This operation is called "xen-save-devices-state" (see
-qmp-commands.txt)
+The save operation is available as QMP command xen-save-devices-state.


 The binary format used in the file is the following:
diff --git a/qmp.c b/qmp.c
index a8d4eba973e..ba82e1df9f4 100644
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
--=20
2.14.3
