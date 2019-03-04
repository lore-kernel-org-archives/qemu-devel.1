Received: from eggs.gnu.org ([209.51.188.92]:42898)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0taQ-0001ZR-QE
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:49:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1h0taQ-0000RL-2q
	for qemu-devel@nongnu.org; Mon, 04 Mar 2019 14:49:18 -0500
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Date: Mon,  4 Mar 2019 20:48:54 +0100
Message-Id: <20190304194857.9780-2-philmd@redhat.com>
In-Reply-To: <20190304194857.9780-1-philmd@redhat.com>
References: <20190304194857.9780-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH 1/4] pflash_cfi01: Add pflash_cfi01_get_blk()
 helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Cc: Laszlo Ersek <lersek@redhat.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>

Add an helper to access the opaque struct PFlashCFI01.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
[PMD: Extracted from bigger patch]
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/block/pflash_cfi01.c  | 5 +++++
 include/hw/block/flash.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 9d1c356eb6..9ecab693e8 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -972,6 +972,11 @@ MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *f=
l)
     return &fl->mem;
 }
=20
+BlockBackend *pflash_cfi01_get_blk(PFlashCFI01 *fl)
+{
+    return fl->blk;
+}
+
 static void postload_update_cb(void *opaque, int running, RunState state=
)
 {
     PFlashCFI01 *pfl =3D opaque;
diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
index 914932eaec..a0f488732a 100644
--- a/include/hw/block/flash.h
+++ b/include/hw/block/flash.h
@@ -22,6 +22,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
                                    uint16_t id0, uint16_t id1,
                                    uint16_t id2, uint16_t id3,
                                    int be);
+BlockBackend *pflash_cfi01_get_blk(PFlashCFI01 *fl);
 MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl);
=20
 /* pflash_cfi02.c */
--=20
2.20.1
