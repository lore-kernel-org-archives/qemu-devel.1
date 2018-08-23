Received: from eggs.gnu.org ([2001:4830:134:3::10]:45940)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fspmG-000542-Br
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:36:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fspmA-0000Ei-Dm
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:35:56 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41933 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fspm9-0000Am-Tq
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:35:50 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 23 Aug 2018 15:34:30 +0200
Message-Id: <1535031276-22911-41-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1535031276-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1535031276-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v4 40/46] elf: Relax MIPS' elf_check_arch() to
 accept EM_NANOMIPS too
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: peter.maydell@linaro.org

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Starting from nanoMIPS introduction, machine variant can be
EM_MIPS or EM_NANOMIPS.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/elfload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index df07055..8638612 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -853,6 +853,8 @@ static void elf_core_copy_regs(target_elf_gregset_t *regs, const CPUPPCState *en
 #endif
 #define ELF_ARCH    EM_MIPS
 
+#define elf_check_arch(x) ((x) == EM_MIPS || (x) == EM_NANOMIPS)
+
 static inline void init_thread(struct target_pt_regs *regs,
                                struct image_info *infop)
 {
-- 
2.7.4
