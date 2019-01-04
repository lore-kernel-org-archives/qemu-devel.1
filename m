Received: from eggs.gnu.org ([208.118.235.92]:51372)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gfNY8-0002IZ-0j
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:22:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gfNY7-0005Jl-BP
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:22:00 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  4 Jan 2019 11:21:42 +0000
Message-Id: <20190104112145.12413-2-stefanha@redhat.com>
In-Reply-To: <20190104112145.12413-1-stefanha@redhat.com>
References: <20190104112145.12413-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 1/4] dmg: Fixing wrong dmg block type value for
 block terminator.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, Julio Faracco <jcfaracco@gmail.com>, yuchenlin <yuchenlin@synology.com>

From: Julio Faracco <jcfaracco@gmail.com>

This is a trivial patch to fix a wrong value for block terminator.
The old value was 0x7fffffff which is wrong. It was not affecting the
code because QEMU dmg block is not handling block terminator right now.
Neverthless, it should be fixed.

Signed-off-by: Julio Faracco <jcfaracco@gmail.com>
Reviewed-by: yuchenlin <yuchenlin@synology.com>
Message-id: 20181228145055.18039-1-jcfaracco@gmail.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/dmg.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/dmg.c b/block/dmg.c
index 50e91aef6d..2c806e3389 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -54,7 +54,7 @@ enum {
     UDBZ,
     ULFO,
     UDCM =3D 0x7ffffffe, /* Comments */
-    UDLE               /* Last Entry */
+    UDLE =3D 0xffffffff  /* Last Entry */
 };
=20
 static int dmg_probe(const uint8_t *buf, int buf_size, const char *filen=
ame)
--=20
2.20.1
