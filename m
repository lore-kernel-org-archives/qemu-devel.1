Received: from eggs.gnu.org ([209.51.188.92]:45914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwDtx-0000Ks-Cw
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:30:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1gwDts-0002VZ-Tp
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:30:08 -0500
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:39571)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1gwDts-0002TO-Jo
	for qemu-devel@nongnu.org; Tue, 19 Feb 2019 17:30:04 -0500
Received: by mail-pf1-x443.google.com with SMTP id i20so458892pfo.6
	for <qemu-devel@nongnu.org>; Tue, 19 Feb 2019 14:30:02 -0800 (PST)
From: Richard Henderson <richard.henderson@linaro.org>
Date: Tue, 19 Feb 2019 14:29:52 -0800
Message-Id: <20190219222952.22183-6-richard.henderson@linaro.org>
In-Reply-To: <20190219222952.22183-1-richard.henderson@linaro.org>
References: <20190219222952.22183-1-richard.henderson@linaro.org>
Subject: [Qemu-devel] [PATCH v5 5/5] linux-user: Enable HWCAP_ASIMDFHM,
 HWCAP_JSCVT
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
 linux-user/elfload.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 3a50d587ff..b9f7cbbdc1 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -602,6 +602,8 @@ static uint32_t get_elf_hwcap(void)
     GET_FEATURE_ID(aa64_fcma, ARM_HWCAP_A64_FCMA);
     GET_FEATURE_ID(aa64_sve, ARM_HWCAP_A64_SVE);
     GET_FEATURE_ID(aa64_pauth, ARM_HWCAP_A64_PACA | ARM_HWCAP_A64_PACG);
+    GET_FEATURE_ID(aa64_fhm, ARM_HWCAP_A64_ASIMDFHM);
+    GET_FEATURE_ID(aa64_jscvt, ARM_HWCAP_A64_JSCVT);
 
 #undef GET_FEATURE_ID
 
-- 
2.17.2
