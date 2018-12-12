Received: from eggs.gnu.org ([2001:4830:134:3::10]:46175)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Yf-0002YK-VX
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1gX4Ya-00013m-EA
	for qemu-devel@nongnu.org; Wed, 12 Dec 2018 08:28:13 -0500
From: Kevin Wolf <kwolf@redhat.com>
Date: Wed, 12 Dec 2018 14:27:01 +0100
Message-Id: <20181212132735.16080-8-kwolf@redhat.com>
In-Reply-To: <20181212132735.16080-1-kwolf@redhat.com>
References: <20181212132735.16080-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 07/41] qcow2: use Z_OK instead of 0 for
 deflateInit2 return code check
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: kwolf@redhat.com, peter.maydell@linaro.org, qemu-devel@nongnu.org

From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

Use appropriate macro, corresponding to deflateInit2 spec.

Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Reviewed-by: Alberto Garcia <berto@igalia.com>
Signed-off-by: Kevin Wolf <kwolf@redhat.com>
---
 block/qcow2.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/qcow2.c b/block/qcow2.c
index 991d6ac91b..225fcbde67 100644
--- a/block/qcow2.c
+++ b/block/qcow2.c
@@ -3738,7 +3738,7 @@ static ssize_t qcow2_compress(void *dest, const voi=
d *src, size_t size)
     memset(&strm, 0, sizeof(strm));
     ret =3D deflateInit2(&strm, Z_DEFAULT_COMPRESSION, Z_DEFLATED,
                        -12, 9, Z_DEFAULT_STRATEGY);
-    if (ret !=3D 0) {
+    if (ret !=3D Z_OK) {
         return -2;
     }
=20
--=20
2.19.2
