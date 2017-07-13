Received: from eggs.gnu.org ([2001:4830:134:3::10]:42584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh3W-0003JB-JP
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:33:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcandre.lureau@redhat.com>) id 1dVh3V-0004bA-IC
	for qemu-devel@nongnu.org; Thu, 13 Jul 2017 12:33:34 -0400
From: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Date: Thu, 13 Jul 2017 18:31:58 +0200
Message-Id: <20170713163219.9024-9-marcandre.lureau@redhat.com>
In-Reply-To: <20170713163219.9024-1-marcandre.lureau@redhat.com>
References: <20170713163219.9024-1-marcandre.lureau@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v2 08/29] qcow2: use DIV_ROUND_UP
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-trivial@nongnu.org, peter.maydell@linaro.org, =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, "open list:qcow2" <qemu-block@nongnu.org>

I used the clang-tidy qemu-round check to generate the fix:
https://github.com/elmarco/clang-tools-extra

Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
---
 block/qcow2-cluster.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
index f06c08f64c..30db942dde 100644
--- a/block/qcow2-cluster.c
+++ b/block/qcow2-cluster.c
@@ -61,7 +61,7 @@ int qcow2_grow_l1_table(BlockDriverState *bs, uint64_t =
min_size,
             new_l1_size =3D 1;
         }
         while (min_size > new_l1_size) {
-            new_l1_size =3D (new_l1_size * 3 + 1) / 2;
+            new_l1_size =3D DIV_ROUND_UP(new_l1_size * 3, 2);
         }
     }
=20
--=20
2.13.1.395.gf7b71de06
