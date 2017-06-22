Received: from eggs.gnu.org ([2001:4830:134:3::10]:45943)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1TK-0007tA-UE
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dO1TK-0006yh-9M
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:31 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46352)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcandre.lureau@redhat.com>)
	id 1dO1TK-0006yb-3Q
	for qemu-devel@nongnu.org; Thu, 22 Jun 2017 08:44:30 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 22 Jun 2017 14:42:01 +0200
Message-Id: <20170622124204.19407-29-marcandre.lureau@redhat.com>
In-Reply-To: <20170622124204.19407-1-marcandre.lureau@redhat.com>
References: <20170622124204.19407-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 28/31] 9pfs: replace g_malloc()+memcpy() with
 g_memdup()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Greg Kurz <groug@kaod.org>

I found these pattern via grepping the source tree. I don't have a
coccinelle script for it!

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 hw/9pfs/9p-synth.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/hw/9pfs/9p-synth.c b/hw/9pfs/9p-synth.c
index 4b6d4e6a3f..df0a8de08a 100644
--- a/hw/9pfs/9p-synth.c
+++ b/hw/9pfs/9p-synth.c
@@ -494,8 +494,7 @@ static int synth_name_to_path(FsContext *ctx, V9fsPat=
h *dir_path,
     }
 out:
     /* Copy the node pointer to fid */
-    target->data =3D g_malloc(sizeof(void *));
-    memcpy(target->data, &node, sizeof(void *));
+    target->data =3D g_memdup(&node, sizeof(void *));
     target->size =3D sizeof(void *);
     return 0;
 }
--=20
2.13.1.395.gf7b71de06
