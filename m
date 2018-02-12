Received: from eggs.gnu.org ([2001:4830:134:3::10]:38170)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1el8RN-0000jD-Bq
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1el8RK-0005un-AV
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:17 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:42988 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>) id 1el8RK-0005ts-3O
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 02:22:14 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Mon, 12 Feb 2018 08:21:54 +0100
Message-Id: <20180212072207.9367-2-armbru@redhat.com>
In-Reply-To: <20180212072207.9367-1-armbru@redhat.com>
References: <20180212072207.9367-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH RFC 01/14] qlit: use QType instead of int
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

From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Suggested-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 include/qapi/qmp/qlit.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/qapi/qmp/qlit.h b/include/qapi/qmp/qlit.h
index 56f9d97bd9..f1ed082df8 100644
--- a/include/qapi/qmp/qlit.h
+++ b/include/qapi/qmp/qlit.h
@@ -20,7 +20,7 @@ typedef struct QLitDictEntry QLitDictEntry;
 typedef struct QLitObject QLitObject;
=20
 struct QLitObject {
-    int type;
+    QType type;
     union {
         bool qbool;
         int64_t qnum;
--=20
2.13.6
