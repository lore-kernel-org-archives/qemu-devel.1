Received: from eggs.gnu.org ([2001:4830:134:3::10]:48285)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8UU-00033z-Fr
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:58:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefan.markovic@rt-rk.com>) id 1fg8Re-0003Cx-LQ
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:57:06 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:54641 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefan.markovic@rt-rk.com>)
	id 1fg8Re-0003CR-8l
	for qemu-devel@nongnu.org; Thu, 19 Jul 2018 08:54:10 -0400
From: Stefan Markovic <stefan.markovic@rt-rk.com>
Date: Thu, 19 Jul 2018 14:52:04 +0200
Message-Id: <1532004727-13778-9-git-send-email-stefan.markovic@rt-rk.com>
In-Reply-To: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
References: <1532004727-13778-1-git-send-email-stefan.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v6 08/11] elf: Remove duplicate preprocessor
 constant definition
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

Remove duplicate preprocessor constant definition for EF_MIPS_ARCH.

The duplicate was introduced in commit 45506bdd.

Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 include/elf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/elf.h b/include/elf.h
index 934dbbd..c8aaa2a 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -33,7 +33,6 @@ typedef int64_t  Elf64_Sxword;
 
 /* Flags in the e_flags field of the header */
 /* MIPS architecture level. */
-#define EF_MIPS_ARCH            0xf0000000
 
 /* Legal values for MIPS architecture level.  */
 #define EF_MIPS_ARCH_1		0x00000000	/* -mips1 code.  */
-- 
2.7.4
