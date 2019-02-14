Received: from eggs.gnu.org ([209.51.188.92]:53888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMKz-0007oG-MH
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1guMKx-0004jL-Nx
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:21 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:36838)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1guMKw-0004iR-9m
	for qemu-devel@nongnu.org; Thu, 14 Feb 2019 14:06:18 -0500
Received: by mail-wm1-x331.google.com with SMTP id j125so7206816wmj.1
	for <qemu-devel@nongnu.org>; Thu, 14 Feb 2019 11:06:18 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id
	n184sm7798471wmf.5.2019.02.14.11.06.15 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 14 Feb 2019 11:06:16 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 14 Feb 2019 19:05:46 +0000
Message-Id: <20190214190603.25030-11-peter.maydell@linaro.org>
In-Reply-To: <20190214190603.25030-1-peter.maydell@linaro.org>
References: <20190214190603.25030-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 10/27] linux-user/elfload: enable HWCAP_CPUID
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

From: Alex Bennée <alex.bennee@linaro.org>

Userspace programs should (in theory) query the ELF HWCAP before
probing these registers. Now we have implemented them all make it
public.

Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Message-id: 20190205190224.2198-6-alex.bennee@linaro.org
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 linux-user/elfload.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/linux-user/elfload.c b/linux-user/elfload.c
index 775a36ccdda..3a50d587ff0 100644
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
