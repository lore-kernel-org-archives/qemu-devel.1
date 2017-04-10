Received: from eggs.gnu.org ([2001:4830:134:3::10]:41594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Prerna.Garg@live.com>) id 1cyNpH-0007QF-3a
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 15:21:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Prerna.Garg@live.com>) id 1cyNob-0001xQ-FD
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 15:20:34 -0400
Received: from mail-oln040092255010.outbound.protection.outlook.com
	([40.92.255.10]:37568
	helo=APC01-HK2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Prerna.Garg@live.com>)
	id 1cyNoa-0001wB-Qm
	for qemu-devel@nongnu.org; Wed, 12 Apr 2017 15:20:29 -0400
From: Prerna Garg <Prerna.Garg@live.com>
Date: Mon, 10 Apr 2017 19:21:53 +0000
Message-ID: <BM1PR01MB072283BB7A3BC4BB287D35A784010@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] First contribution - Interested in Outreachy
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "stefanha@redhat.com" <stefanha@redhat.com>, "kwolf@redhat.com" <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>

Hello,


This is my first patch submission. I am interested in the block filter proj=
ect for this round of Outreachy.


diff --git a/backends/hostmem.c b/backends/hostmem.c
index 89feb9e..f056a25 100644
--- a/backends/hostmem.c
+++ b/backends/hostmem.c
@@ -263,7 +263,7 @@ host_memory_backend_memory_complete(UserCreatable *uc, =
Error **errp)
     uint64_t sz;

     if (bc->alloc) {
-        bc->alloc(backend, &local_err);
+        bc->g_alloc(backend, &local_err);
         if (local_err) {
             goto out;
         }
