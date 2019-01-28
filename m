Received: from eggs.gnu.org ([209.51.188.92]:60234)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1goAsw-00027e-TB
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:39:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1goAst-0003Yy-O5
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:39:49 -0500
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:55781)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1goAst-0003UE-DD
	for qemu-devel@nongnu.org; Mon, 28 Jan 2019 12:39:47 -0500
Received: by mail-wm1-x344.google.com with SMTP id y139so14805505wmc.5
	for <qemu-devel@nongnu.org>; Mon, 28 Jan 2019 09:39:43 -0800 (PST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 28 Jan 2019 17:39:39 +0000
Message-Id: <20190128173940.25813-4-alex.bennee@linaro.org>
In-Reply-To: <20190128173940.25813-1-alex.bennee@linaro.org>
References: <20190128173940.25813-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v1 3/4] linux-user/elfload: enable HWCAP_CPUID
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
Cc: qemu-arm@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Userspace programs should (in theory) query the ELF HWCAP before
probing these registers. Now we have implemented them all make it
public.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
---
 linux-user/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 4cff9e1a31..e95c162097 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -571,6 +571,7 @@ static uint32_t get_elf_hwcap(void)
 
     hwcaps |= ARM_HWCAP_A64_FP;
     hwcaps |= ARM_HWCAP_A64_ASIMD;
+    hwcaps |= ARM_HWCAP_A64_CPUID;
 
     /* probe for the extra features */
 #define GET_FEATURE_ID(feat, hwcap) \
-- 
2.17.1
