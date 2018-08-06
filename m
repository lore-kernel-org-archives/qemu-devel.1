Received: from eggs.gnu.org ([2001:4830:134:3::10]:53736)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmiwd-0005Bn-Mu
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:05:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fmiwb-0006db-Tw
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:05:23 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43498 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fmiwb-0006b7-ML
	for qemu-devel@nongnu.org; Mon, 06 Aug 2018 13:05:21 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Mon,  6 Aug 2018 18:59:37 +0200
Message-Id: <1533574847-19294-11-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1533574847-19294-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v7 10/80] elf: Remove duplicate preprocessor
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
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com, arikalo@wavecomp.com, thuth@redhat.com, armbru@redhat.com

From: Aleksandar Markovic <amarkovic@wavecomp.com>

Remove duplicate preprocessor constant definition for EF_MIPS_ARCH.

The duplicate was introduced in commit 45506bdd. It placed the
constant EF_MIPS_ARCH in a better place, however it did not remove
the original. This patch removes the original occurence.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
---
 include/elf.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/elf.h b/include/elf.h
index 934dbbd..60f6cbe 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -61,7 +61,6 @@ typedef int64_t  Elf64_Sxword;
 #define EF_MIPS_ABI		0x0000f000
 #define EF_MIPS_FP64      0x00000200
 #define EF_MIPS_NAN2008   0x00000400
-#define EF_MIPS_ARCH      0xf0000000
 
 /* These constants define the different elf file types */
 #define ET_NONE   0
-- 
2.7.4
