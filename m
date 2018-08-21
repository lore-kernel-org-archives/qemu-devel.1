Received: from eggs.gnu.org ([2001:4830:134:3::10]:41682)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs5tQ-00029k-HS
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fs5tK-0007RU-6L
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:36:16 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:34928 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fs5tJ-0007Mv-8u
	for qemu-devel@nongnu.org; Tue, 21 Aug 2018 08:36:09 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Tue, 21 Aug 2018 14:35:44 +0200
Message-Id: <1534854951-6321-40-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534854951-6321-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534854951-6321-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PULL 39/46] elf: Add EM_NANOMIPS value as a valid one
 for e_machine field
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
