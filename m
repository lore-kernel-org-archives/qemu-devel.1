Received: from eggs.gnu.org ([2001:4830:134:3::10]:46031)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fspmI-00056N-Qh
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:36:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fspmA-0000En-El
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:35:58 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:41932 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fspm9-0000AZ-Vm
	for qemu-devel@nongnu.org; Thu, 23 Aug 2018 09:35:50 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 23 Aug 2018 15:34:29 +0200
Message-Id: <1535031276-22911-40-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1535031276-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1535031276-22911-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL v4 39/46] elf: Add EM_NANOMIPS value as a valid
 one for e_machine field
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

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Value 249 is registered as valid for usage for nanoMIPS executables.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Aleksandar Markovic <amarkovic@wavecomp.com>
Signed-off-by: Stefan Markovic <smarkovic@wavecomp.com>
---
 include/elf.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/elf.h b/include/elf.h
index 28a5a63..312f68a 100644
--- a/include/elf.h
+++ b/include/elf.h
@@ -143,6 +143,8 @@ typedef int64_t  Elf64_Sxword;
 
 #define EM_RISCV        243     /* RISC-V */
 
+#define EM_NANOMIPS     249     /* Wave Computing nanoMIPS */
+
 /*
  * This is an interim value that we will use until the committee comes
  * up with a final number.
-- 
2.7.4
