Received: from eggs.gnu.org ([2001:4830:134:3::10]:52786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXTuZ-0004rb-Qa
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:00:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fXTuY-00053W-Uv
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:00:15 -0400
Received: from mail-wr0-x242.google.com ([2a00:1450:400c:c0c::242]:44879)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fXTuY-00052k-OQ
	for qemu-devel@nongnu.org; Mon, 25 Jun 2018 12:00:14 -0400
Received: by mail-wr0-x242.google.com with SMTP id p12-v6so12598256wrn.11
	for <qemu-devel@nongnu.org>; Mon, 25 Jun 2018 09:00:14 -0700 (PDT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Date: Mon, 25 Jun 2018 17:00:08 +0100
Message-Id: <20180625160009.17437-5-alex.bennee@linaro.org>
In-Reply-To: <20180625160009.17437-1-alex.bennee@linaro.org>
References: <20180625160009.17437-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 4/5] linux-user/elfload: enable HWCAP_CPUID
 for AArch64
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: peter.maydell@linaro.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

Userspace programs should (in theory) query the ELF HWCAP before
probing these registers. Now we have implemented them all make it
public.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
---
 linux-user/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 13bc78d0c8..76d7674649 100644
--- a/linux-user/elfload.c
+++ b/linux-user/elfload.c
@@ -566,6 +566,7 @@ static uint32_t get_elf_hwcap(void)
 
     hwcaps |= ARM_HWCAP_A64_FP;
     hwcaps |= ARM_HWCAP_A64_ASIMD;
+    hwcaps |= ARM_HWCAP_A64_CPUID;
 
     /* probe for the extra features */
 #define GET_FEATURE(feat, hwcap) \
-- 
2.17.1
