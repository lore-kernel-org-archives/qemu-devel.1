Received: from eggs.gnu.org ([2001:4830:134:3::10]:55951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8ZW-0004Q7-0m
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:03:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8Wu-0007Eo-0k
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 09:02:18 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:58034 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8Wt-0007EG-Gg
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:59:35 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:55:05 +0200
Message-Id: <1532004912-13899-34-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004912-13899-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v3 33/40] elf: Relax MIPS' elf_check_arch() to
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
Cc: laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Starting from nanoMIPS introduction, machine variant can be
EM_MIPS or EM_NANOMIPS.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 linux-user/elfload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 942a1b6..1900556 100644
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
