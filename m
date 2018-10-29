Received: from eggs.gnu.org ([2001:4830:134:3::10]:34434)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH9Lh-0008TC-7P
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1gH9Ld-0003RM-OO
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:21:01 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:39619 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1gH9Ld-0003JN-Ge
	for qemu-devel@nongnu.org; Mon, 29 Oct 2018 11:20:57 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon, 29 Oct 2018 16:20:14 +0100
Message-Id: <1540826418-5501-24-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1540826418-5501-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 23/27] linux-user: Extend image_info struct with
 MIPS fp_abi and interp_fp_abi fields
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org, amarkovic@wavecomp.com

From: Stefan Markovic <smarkovic@wavecomp.com>

Add MIPS specific image_info struct fields fp_abi and interp_fp_abi
to store executable and interpreter fp_abi values (based on kernel
struct arch_elf_state in mips/include/asm/elf.h).

Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
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
2.7.4
