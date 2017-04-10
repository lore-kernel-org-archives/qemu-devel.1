Received: from eggs.gnu.org ([2001:4830:134:3::10]:37478)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <Prerna.Garg@live.com>) id 1cxymK-0006t6-DC
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <Prerna.Garg@live.com>) id 1cxymH-0005TS-8n
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:36:28 -0400
Received: from mail-oln040092253094.outbound.protection.outlook.com
	([40.92.253.94]:4135
	helo=APC01-SG2-obe.outbound.protection.outlook.com)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <Prerna.Garg@live.com>)
	id 1cxymG-0005SD-Jl
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 12:36:25 -0400
From: Prerna Garg <Prerna.Garg@live.com>
Date: Mon, 10 Apr 2017 19:59:57 +0000
Message-ID: <BM1PR01MB07224A0D4D1815F66D26EB7C84010@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
References: <BM1PR01MB072283BB7A3BC4BB287D35A784010@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
In-Reply-To: <BM1PR01MB072283BB7A3BC4BB287D35A784010@BM1PR01MB0722.INDPRD01.PROD.OUTLOOK.COM>
Content-Language: en-US
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] First contribution - Interested in Outreachy
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


The previous patch was incorrect. Sorry for the inconvenience. Please consi=
der this as my first contribution.


diff --git a/block/iscsi.c b/block/iscsi.c
index 716e74a..b926ed4 100644
--- a/block/iscsi.c
+++ b/block/iscsi.c
@@ -1034,7 +1034,7 @@ static BlockAIOCB *iscsi_aio_ioctl(BlockDriverState *=
bs,
         return NULL;
     }

-    acb->task =3D malloc(sizeof(struct scsi_task));
+    acb->task =3D g_malloc(sizeof(struct scsi_task));
     if (acb->task =3D=3D NULL) {
         error_report("iSCSI: Failed to allocate task for scsi command. %s"=
,
                      iscsi_get_error(iscsi));




________________________________
From: Prerna Garg
Sent: Tuesday, April 11, 2017 12:51 AM
To: qemu-devel@nongnu.org
Cc: stefanha@redhat.com; kwolf@redhat.com; Alberto Garcia
Subject: First contribution - Interested in Outreachy


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
