Received: from eggs.gnu.org ([2001:4830:134:3::10]:54510)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1gG30B-0006yp-Bx
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:22:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1gG30A-00029v-PT
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:22:15 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:53273 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1gG30A-00029P-Fh
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:22:14 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Fri, 26 Oct 2018 16:21:03 +0200
Message-Id: <1540563667-23300-3-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1540563667-23300-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1540563667-23300-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 2/6] Extend image_info struct with MIPS
 specific fp_abi and interp_fp_abi fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, amarkovic@wavecomp.com, pjovanovic@wavecomp.com, riku.voipio@iki.fi, laurent@vivier.eu

From: Stefan Markovic <smarkovic@wavecomp.com>

Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/qemu.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index 1beb6a2..a752c1c 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -61,6 +61,10 @@ struct image_info {
         abi_ulong       interpreter_loadmap_addr;
         abi_ulong       interpreter_pt_dynamic_addr;
         struct image_info *other_info;
+#ifdef TARGET_MIPS
+        int             fp_abi;
+        int             interp_fp_abi;
+#endif
 };
 
 #ifdef TARGET_I386
-- 
1.9.1
