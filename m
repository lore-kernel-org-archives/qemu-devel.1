Received: from eggs.gnu.org ([2001:4830:134:3::10]:54485)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gB0W1-0008AX-DE
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:42:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gB0Vw-0003Gx-F6
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:42:17 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:46390 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gB0Vw-0003FX-71
	for qemu-devel@nongnu.org; Fri, 12 Oct 2018 12:42:12 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Fri, 12 Oct 2018 18:39:14 +0200
Message-Id: <1539362376-12010-7-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1539362376-12010-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v5 06/28] linux-user: Add fields that
 correspond to kernel arch_elf_state
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, laurent@vivier.eu, riku.voipio@iki.fi

From: Stefan Markovic <smarkovic@wavecomp.com>

Add fields that correspond to kernel arch_elf_state.

This is essentially copied from kernel arch/mips/kernel/elf.c.

Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 linux-user/qemu.h | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/linux-user/qemu.h b/linux-user/qemu.h
index b4959e4..e5e7bcd 100644
--- a/linux-user/qemu.h
+++ b/linux-user/qemu.h
@@ -60,6 +60,15 @@ struct image_info {
         abi_ulong       pt_dynamic_addr;
         abi_ulong       interpreter_loadmap_addr;
         abi_ulong       interpreter_pt_dynamic_addr;
+
+        /* The fields that correspond to kernel arch_elf_state structure. */
+#if defined TARGET_MIPS
+        uint32_t        nan_2008;
+        uint32_t        fp_abi;
+        uint32_t        interp_fp_abi;
+        uint32_t        overall_fp_mode;
+#endif /* TARGET_MIPS */
+
         struct image_info *other_info;
 };
 
-- 
2.7.4
