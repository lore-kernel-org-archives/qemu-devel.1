Received: from eggs.gnu.org ([2001:4830:134:3::10]:39646)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gKhRv-0004BH-W5
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:22:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lizhijian@cn.fujitsu.com>) id 1gKhIC-00008I-IH
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:12:05 -0500
Received: from mga09.intel.com ([134.134.136.24]:7267)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <lizhijian@cn.fujitsu.com>)
	id 1gKhIB-00006D-Lz
	for qemu-devel@nongnu.org; Thu, 08 Nov 2018 05:12:04 -0500
From: Li Zhijian <lizhijian@cn.fujitsu.com>
Date: Thu,  8 Nov 2018 18:59:43 +0800
Message-Id: <1541674784-25936-3-git-send-email-lizhijian@cn.fujitsu.com>
In-Reply-To: <1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
References: <1541674784-25936-1-git-send-email-lizhijian@cn.fujitsu.com>
	<1541674784-25936-2-git-send-email-lizhijian@cn.fujitsu.com>
Subject: [Qemu-devel] [RFC/PoC PATCH 2/3] change size type from int to
 int64_t on load_image()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: zhijianx.li@intel.com, Li Zhijian <lizhijian@cn.fujitsu.com>, Philip Li <philip.li@intel.com>

allow load_image to load >= 2G file

CC: Philip Li <philip.li@intel.com>
Signed-off-by: Li Zhijian <lizhijian@cn.fujitsu.com>
---
 hw/core/loader.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/loader.c b/hw/core/loader.c
index aa0b3fc..8fbc4bd 100644
--- a/hw/core/loader.c
+++ b/hw/core/loader.c
@@ -77,7 +77,8 @@ int64_t get_image_size(const char *filename)
 /* deprecated, because caller does not specify buffer size! */
 int load_image(const char *filename, uint8_t *addr)
 {
-    int fd, size;
+    int fd;
+    int64_t size;
     fd = open(filename, O_RDONLY | O_BINARY);
     if (fd < 0)
         return -1;
-- 
2.7.4
