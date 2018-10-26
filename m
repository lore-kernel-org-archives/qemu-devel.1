Received: from eggs.gnu.org ([2001:4830:134:3::10]:50586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gG4JI-0004rD-QI
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:46:05 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gG46n-0005Kq-M6
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:33:13 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 26 Oct 2018 17:31:07 +0200
Message-Id: <20181026153125.24738-3-laurent@vivier.eu>
In-Reply-To: <20181026153125.24738-1-laurent@vivier.eu>
References: <20181026153125.24738-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 02/20] vga_int: remove unused function protype
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org, Michael Walle <michael@walle.cc>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cleber Rosa <crosa@redhat.com>, Igor Mammedov <imammedo@redhat.com>, xen-devel@lists.xenproject.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Anthony Perard <anthony.perard@citrix.com>, Aurelien Jarno <aurelien@aurel32.net>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>, yuchenlin <yuchenlin@synology.com>

From: yuchenlin <yuchenlin@synology.com>

Signed-off-by: yuchenlin <yuchenlin@synology.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20181022080053.9379-1-yuchenlin@synology.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/display/vga_int.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/display/vga_int.h b/hw/display/vga_int.h
index 6e4fa48a79..55c418eab5 100644
--- a/hw/display/vga_int.h
+++ b/hw/display/vga_int.h
@@ -166,7 +166,6 @@ MemoryRegion *vga_init_io(VGACommonState *s, Object *obj,
                           const MemoryRegionPortio **vbe_ports);
 void vga_common_reset(VGACommonState *s);
 
-void vga_sync_dirty_bitmap(VGACommonState *s);
 void vga_dirty_log_start(VGACommonState *s);
 void vga_dirty_log_stop(VGACommonState *s);
 
-- 
2.17.2
