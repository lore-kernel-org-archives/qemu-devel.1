Received: from eggs.gnu.org ([2001:4830:134:3::10]:56228)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNGov-0004p9-IX
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:32:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kraxel@redhat.com>) id 1gNGot-000620-QC
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:32:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:41998)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kraxel@redhat.com>) id 1gNGor-00060N-HN
	for qemu-devel@nongnu.org; Thu, 15 Nov 2018 07:32:27 -0500
From: Gerd Hoffmann <kraxel@redhat.com>
Date: Thu, 15 Nov 2018 13:32:16 +0100
Message-Id: <20181115123218.25387-3-kraxel@redhat.com>
In-Reply-To: <20181115123218.25387-1-kraxel@redhat.com>
References: <20181115123218.25387-1-kraxel@redhat.com>
Subject: [Qemu-devel] [PATCH 2/4] keymaps: drop nl-be map
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, Li Qiang <liq3ea@gmail.com>

It doesn't define any keys, only includes "common".
Which makes it effectively an "en-us" map.

Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
---
 pc-bios/keymaps/nl-be | 3 ---
 1 file changed, 3 deletions(-)
 delete mode 100644 pc-bios/keymaps/nl-be

diff --git a/pc-bios/keymaps/nl-be b/pc-bios/keymaps/nl-be
deleted file mode 100644
index 34fc881ad0..0000000000
--- a/pc-bios/keymaps/nl-be
+++ /dev/null
@@ -1,3 +0,0 @@
-# Dutch (Belgium)
-map 0x813
-include common
-- 
2.9.3
