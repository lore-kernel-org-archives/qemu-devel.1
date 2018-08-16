Received: from eggs.gnu.org ([2001:4830:134:3::10]:56394)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJlS-0005tM-Sq
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.markovic@rt-rk.com>) id 1fqJlA-00016D-MQ
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:33 -0400
Received: from mx2.rt-rk.com ([89.216.37.149]:43763 helo=mail.rt-rk.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <aleksandar.markovic@rt-rk.com>)
	id 1fqJl3-0000hL-Qq
	for qemu-devel@nongnu.org; Thu, 16 Aug 2018 11:00:21 -0400
From: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Date: Thu, 16 Aug 2018 16:57:48 +0200
Message-Id: <1534431497-1385-56-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1534431497-1385-1-git-send-email-aleksandar.markovic@rt-rk.com>
Subject: [Qemu-devel] [PATCH v9 55/84] elf: Add EM_NANOMIPS value as a valid
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
Cc: peter.maydell@linaro.org, laurent@vivier.eu, riku.voipio@iki.fi, philippe.mathieu.daude@gmail.com, aurelien@aurel32.net, richard.henderson@linaro.org, amarkovic@wavecomp.com, smarkovic@wavecomp.com, pjovanovic@wavecomp.com, pburton@wavecomp.com

From: Aleksandar Rikalo <arikalo@wavecomp.com>

Value 249 is registered as valid for usage for nanoMIPS executables.

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
