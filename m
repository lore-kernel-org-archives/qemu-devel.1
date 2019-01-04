Received: from eggs.gnu.org ([208.118.235.92]:51713)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gfNYn-000393-9J
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:22:42 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gfNYm-0005eW-H5
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 06:22:41 -0500
From: Stefan Hajnoczi <stefanha@redhat.com>
Date: Fri,  4 Jan 2019 11:21:44 +0000
Message-Id: <20190104112145.12413-4-stefanha@redhat.com>
In-Reply-To: <20190104112145.12413-1-stefanha@redhat.com>
References: <20190104112145.12413-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 3/4] dmg: use enumeration type instead of hard
 coding number
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-block@nongnu.org, yuchenlin <npes87184@gmail.com>, Julio Faracco <jcfaracco@gmail.com>

From: yuchenlin <npes87184@gmail.com>

Signed-off-by: yuchenlin <npes87184@gmail.com>
Reviewed-by: Julio Faracco <jcfaracco@gmail.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190103114700.9686-3-npes87184@gmail.com
Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 block/dmg.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/dmg.c b/block/dmg.c
index b26ddb1f68..84732a64c1 100644
--- a/block/dmg.c
+++ b/block/dmg.c
@@ -267,7 +267,7 @@ static int dmg_read_mish_block(BDRVDMGState *s, DmgHe=
aderState *ds,
=20
         /* all-zeroes sector (type 2) does not need to be "uncompressed"=
 and can
          * therefore be unbounded. */
-        if (s->types[i] !=3D 2 && s->sectorcounts[i] > DMG_SECTORCOUNTS_=
MAX) {
+        if (s->types[i] !=3D UDIG && s->sectorcounts[i] > DMG_SECTORCOUN=
TS_MAX) {
             error_report("sector count %" PRIu64 " for chunk %" PRIu32
                          " is larger than max (%u)",
                          s->sectorcounts[i], i, DMG_SECTORCOUNTS_MAX);
@@ -710,7 +710,7 @@ dmg_co_preadv(BlockDriverState *bs, uint64_t offset, =
uint64_t bytes,
         /* Special case: current chunk is all zeroes. Do not perform a m=
emcpy as
          * s->uncompressed_chunk may be too small to cover the large all=
-zeroes
          * section. dmg_read_chunk is called to find s->current_chunk */
-        if (s->types[s->current_chunk] =3D=3D 2) { /* all zeroes block e=
ntry */
+        if (s->types[s->current_chunk] =3D=3D UDIG) { /* all zeroes bloc=
k entry */
             qemu_iovec_memset(qiov, i * 512, 0, 512);
             continue;
         }
--=20
2.20.1
