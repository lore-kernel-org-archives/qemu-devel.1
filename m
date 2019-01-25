Received: from eggs.gnu.org ([209.51.188.92]:36634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnAe7-0004qA-SL
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 18:12:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gnAPc-0005NG-IS
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:57:25 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:47007)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gnAPc-0005LI-6e
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 17:57:24 -0500
Received: by mail-pl1-x644.google.com with SMTP id t13so5179947ply.13
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 14:57:23 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Fri, 25 Jan 2019 14:57:11 -0800
Message-Id: <20190125225714.10234-5-richard.henderson@linaro.org>
In-Reply-To: <20190125225714.10234-1-richard.henderson@linaro.org>
References: <20190125225714.10234-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH 3/6] aarch64-linux-user: Enable HWCAP bits for
 PAuth
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
 linux-user/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3c7a7c2836..775a36ccdd 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -600,6 +600,7 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_dp, ARM_HWCAP_A64_ASIMDDP);
     GET_FEATURE_ID(aa64_fcma, ARM_HWCAP_A64_FCMA);
     GET_FEATURE_ID(aa64_sve, ARM_HWCAP_A64_SVE);
+    GET_FEATURE_ID(aa64_pauth, ARM_HWCAP_A64_PACA | ARM_HWCAP_A64_PACG);
 
 #undef GET_FEATURE_ID
 
-- 
2.17.2
