Received: from eggs.gnu.org ([2001:4830:134:3::10]:49850)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gG4JH-0003mJ-H4
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:46:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1gG46t-0005QI-O4
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 11:33:17 -0400
From: Laurent Vivier <laurent@vivier.eu>
Date: Fri, 26 Oct 2018 17:31:08 +0200
Message-Id: <20181026153125.24738-4-laurent@vivier.eu>
In-Reply-To: <20181026153125.24738-1-laurent@vivier.eu>
References: <20181026153125.24738-1-laurent@vivier.eu>
Subject: [Qemu-devel] [PULL 03/20] memory.h: fix typos in comments
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>, Jason Wang <jasowang@redhat.com>, qemu-arm@nongnu.org, Michael Walle <michael@walle.cc>, Laurent Vivier <lvivier@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Cleber Rosa <crosa@redhat.com>, Igor Mammedov <imammedo@redhat.com>, xen-devel@lists.xenproject.org, Aleksandar Markovic <amarkovic@wavecomp.com>, Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>, Fam Zheng <famz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Anthony Perard <anthony.perard@citrix.com>, Aurelien Jarno <aurelien@aurel32.net>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Gerd Hoffmann <kraxel@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-trivial@nongnu.org, Riku Voipio <riku.voipio@iki.fi>, Eduardo Habkost <ehabkost@redhat.com>, Li Qiang <liq3ea@gmail.com>

From: Li Qiang <liq3ea@gmail.com>

Signed-off-by: Li Qiang <liq3ea@gmail.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <1539080467-2976-1-git-send-email-liq3ea@gmail.com>
[lv: s/types/typos/]
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 include/exec/memory.h | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/include/exec/memory.h b/include/exec/memory.h
index 667466b8f3..d0c7f0d9e9 100644
--- a/include/exec/memory.h
+++ b/include/exec/memory.h
@@ -935,7 +935,7 @@ uint64_t memory_region_size(MemoryRegion *mr);
 /**
  * memory_region_is_ram: check whether a memory region is random access
  *
- * Returns %true is a memory region is random access.
+ * Returns %true if a memory region is random access.
  *
  * @mr: the memory region being queried
  */
@@ -947,7 +947,7 @@ static inline bool memory_region_is_ram(MemoryRegion *mr)
 /**
  * memory_region_is_ram_device: check whether a memory region is a ram device
  *
- * Returns %true is a memory region is a device backed ram region
+ * Returns %true if a memory region is a device backed ram region
  *
  * @mr: the memory region being queried
  */
@@ -1161,7 +1161,7 @@ uint8_t memory_region_get_dirty_log_mask(MemoryRegion *mr);
 /**
  * memory_region_is_rom: check whether a memory region is ROM
  *
- * Returns %true is a memory region is read-only memory.
+ * Returns %true if a memory region is read-only memory.
  *
  * @mr: the memory region being queried
  */
-- 
2.17.2
