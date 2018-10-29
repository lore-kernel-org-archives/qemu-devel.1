Received: from eggs.gnu.org ([2001:4830:134:3::10]:44724)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH6x3-00082m-Ep
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:47:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gH6wt-0005ic-5H
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:47:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51350)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gH6wq-0005XI-3W
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 08:47:13 -0400
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Mon, 29 Oct 2018 13:47:03 +0100
Message-Id: <20181029124703.11123-3-kraxel@redhat.com>
In-Reply-To: <20181029124703.11123-1-kraxel@redhat.com>
References: <20181029124703.11123-1-kraxel@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: [Qemu-devel] [PULL 2/2] vga_int: remove unused function protype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, yuchenlin <yuchenlin@synology.com>

From: yuchenlin <yuchenlin@synology.com>

Signed-off-by: yuchenlin <yuchenlin@synology.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Message-id: 20181022080053.9379-1-yuchenlin@synology.com
Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 hw/display/vga_int.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index 6e4fa48a79..55c418eab5 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -166,7 +166,6 @@ MemoryRegion *vga_init_io(VGACommonState *s, Object *=
obj,
                           const MemoryRegionPortio **vbe_ports);
 void vga_common_reset(VGACommonState *s);
=20
-void vga_sync_dirty_bitmap(VGACommonState *s);
 void vga_dirty_log_start(VGACommonState *s);
 void vga_dirty_log_stop(VGACommonState *s);
=20
--=20
2.9.3
