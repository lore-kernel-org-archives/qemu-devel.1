Received: from eggs.gnu.org ([2001:4830:134:3::10]:54666)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1gG30h-0007Uk-Ff
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:22:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1gG30g-0002XC-QY
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:22:47 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:51805 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1gG30g-0001V0-J1
	for qemu-devel@nongnu.org; Fri, 26 Oct 2018 10:22:46 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Fri, 26 Oct 2018 16:21:02 +0200
Message-Id: <1540563667-23300-2-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1540563667-23300-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1540563667-23300-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH 1/6] Define MIPS_ABI_FP_UNKNOWN macro
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
 include/elf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index 5f45f9b..c151164 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -87,6 +87,8 @@ typedef int64_t  Elf64_Sxword;
 #define EF_MIPS_MACH_LS3A     0x00a20000  /* ST Microelectronics Loongson 3A */
 #define EF_MIPS_MACH          0x00ff0000  /* EF_MIPS_MACH_xxx selection mask */
 
+#define MIPS_ABI_FP_UNKNOWN   (-1)        /* Unknown FP ABI (internal)       */
+
 #define MIPS_ABI_FP_ANY       0x0         /* FP ABI doesn't matter           */
 #define MIPS_ABI_FP_DOUBLE    0x1         /* -mdouble-float                  */
 #define MIPS_ABI_FP_SINGLE    0x2         /* -msingle-float                  */
-- 
1.9.1
