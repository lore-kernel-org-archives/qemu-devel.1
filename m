Received: from eggs.gnu.org ([209.51.188.92]:55505)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpAQk-0002G3-MX
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:22:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpAQj-0008F4-Ug
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:22:50 -0500
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:34786)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpAQj-0008E8-NY
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 06:22:49 -0500
Received: by mail-wr1-x444.google.com with SMTP id f7so2898380wrp.1
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 03:22:49 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 31 Jan 2019 11:22:39 +0000
Message-Id: <20190131112240.8395-5-peter.maydell@linaro.org>
In-Reply-To: <20190131112240.8395-1-peter.maydell@linaro.org>
References: <20190131112240.8395-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH 4/5] hw/arm/boot: Clarify why
 arm_setup_firmware_boot() doesn't set env->boot_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Igor Mammedov <imammedo@redhat.com>, Hongbo Zhang <hongbo.zhang@linaro.org>

The code path for booting firmware doesn't set env->boot_info. At
first sight this looks odd, so add a comment saying why we don't.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/boot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index a2e724ac68a..cfcfdf421cf 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1186,7 +1186,8 @@ static void arm_setup_firmware_boot(ARMCPU *cpu, struct arm_boot_info *info)
 
     /*
      * We will start from address 0 (typically a boot ROM image) in the
-     * same way as hardware.
+     * same way as hardware. Leave env->boot_info NULL, so that
+     * do_cpu_reset() knows it does not need to alter the PC on reset.
      */
 }
 
-- 
2.20.1
