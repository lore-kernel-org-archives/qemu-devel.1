Received: from eggs.gnu.org ([209.51.188.92]:36814)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnAe7-0004sK-Si
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnAPa-0005Kp-A5
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:57:23 -0500
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:46741)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnAPa-0005JV-3w
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:57:22 -0500
Received: by mail-pf1-x442.google.com with SMTP id c73so5375584pfe.13
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 14:57:22 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 25 Jan 2019 14:57:10 -0800
Message-Id: <20190125225714.10234-4-richard.henderson@linaro.org>
In-Reply-To: <20190125225714.10234-1-richard.henderson@linaro.org>
References: <20190125225714.10234-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 2/6] aarch64-linux-user: Update HWCAP bits from
 linux 5.0-rc1
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

Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4cff9e1a31..3c7a7c2836 100644
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
2.17.2
