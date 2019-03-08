Received: from eggs.gnu.org ([209.51.188.92]:36376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2FL7-0004rS-TV
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:15:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1h2FL3-0006Of-2L
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 08:15:05 -0500
From: Markus Armbruster <armbru@redhat.com>
Date: Fri,  8 Mar 2019 14:14:41 +0100
Message-Id: <20190308131445.17502-9-armbru@redhat.com>
In-Reply-To: <20190308131445.17502-1-armbru@redhat.com>
References: <20190308131445.17502-1-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PATCH v3 08/12] pflash_cfi01: Add
 pflash_cfi01_get_blk() helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, lersek@redhat.com, kwolf@redhat.com, mreitz@redhat.com, qemu-block@nongnu.org, pkrempa@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, marcandre.lureau@redhat.com, philmd@redhat.com

From: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>

Add an helper to access the opaque struct PFlashCFI01.

Signed-off-by: Markus Armbruster <armbru@redhat.com>
Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Reviewed-by: Laszlo Ersek <lersek@redhat.com>
---
 hw/block/pflash_cfi01.c  | 5 +++++
 include/hw/block/flash.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
index 9d1c356eb6..125f70b8e4 100644
--- a/hw/block/pflash_cfi01.c
+++ b/hw/block/pflash_cfi01.c
@@ -967,6 +967,11 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
     return PFLASH_CFI01(dev);
 }
=20
+BlockBackend *pflash_cfi01_get_blk(PFlashCFI01 *fl)
+{
+    return fl->blk;
+}
+
 MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl)
 {
     return &fl->mem;
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
2.17.2
