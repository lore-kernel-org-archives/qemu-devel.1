Received: from eggs.gnu.org ([209.51.188.92]:59002)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMD-0008GV-HV
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:08:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbMB-0003jg-1N
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:57 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42443)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbMA-0003eC-Ix
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:54 -0500
Received: by mail-wr1-x42c.google.com with SMTP id q18so7637395wrx.9
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:07:47 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.07.45
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:07:45 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:46 +0000
Message-Id: <20190201160653.13829-41-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 40/47] aarch64-linux-user: Update HWCAP bits
 from linux 5.0-rc1
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: Richard Henderson <richard.henderson@linaro.org>

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Laurent Vivier <laurent@vivier.eu>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4cff9e1a313..3c7a7c2836f 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -560,6 +560,15 @@ enum {
     ARM_HWCAP_A64_ASIMDDP       = 1 << 20,
     ARM_HWCAP_A64_SHA512        = 1 << 21,
     ARM_HWCAP_A64_SVE           = 1 << 22,
+    ARM_HWCAP_A64_ASIMDFHM      = 1 << 23,
+    ARM_HWCAP_A64_DIT           = 1 << 24,
+    ARM_HWCAP_A64_USCAT         = 1 << 25,
+    ARM_HWCAP_A64_ILRCPC        = 1 << 26,
+    ARM_HWCAP_A64_FLAGM         = 1 << 27,
+    ARM_HWCAP_A64_SSBS          = 1 << 28,
+    ARM_HWCAP_A64_SB            = 1 << 29,
+    ARM_HWCAP_A64_PACA          = 1 << 30,
+    ARM_HWCAP_A64_PACG          = 1UL << 31,
 };
 
 #define ELF_HWCAP get_elf_hwcap()
-- 
2.20.1
