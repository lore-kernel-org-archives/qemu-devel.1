Received: from eggs.gnu.org ([209.51.188.92]:52998)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gr5zd-0007sk-Sw
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:02:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gr5zb-0004Ju-Ph
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:02:49 -0500
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:42116)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gr5za-0004BI-G4
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 14:02:46 -0500
Received: by mail-wr1-x443.google.com with SMTP id q18so4848740wrx.9
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 11:02:30 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Tue,  5 Feb 2019 19:02:23 +0000
Message-Id: <20190205190224.2198-6-alex.bennee@linaro.org>
In-Reply-To: <20190205190224.2198-1-alex.bennee@linaro.org>
References: <20190205190224.2198-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v2 5/6] linux-user/elfload: enable HWCAP_CPUID
 for AArch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>

Userspace programs should (in theory) query the ELF HWCAP before
probing these registers. Now we have implemented them all make it
public.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 775a36ccdd..3a50d587ff 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -580,6 +580,7 @@ static uint32_t get_elf_hwcap(void)
 
     hwcaps |= ARM_HWCAP_A64_FP;
     hwcaps |= ARM_HWCAP_A64_ASIMD;
+    hwcaps |= ARM_HWCAP_A64_CPUID;
 
     /* probe for the extra features */
 #define GET_FEATURE_ID(feat, hwcap) \
-- 
2.20.1
