Received: from eggs.gnu.org ([209.51.188.92]:35995)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AU-0001ub-2F
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:06:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gr4AR-0000Zf-Vd
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:53 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:42883)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gr4AR-0000U6-N7
	for qemu-devel@nongnu.org; Tue, 05 Feb 2019 12:05:51 -0500
Received: by mail-wr1-x42c.google.com with SMTP id q18so4437705wrx.9
	for <qemu-devel@nongnu.org>; Tue, 05 Feb 2019 09:05:43 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id w13sm5583164wmf.5.2019.02.05.09.05.41
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 05 Feb 2019 09:05:41 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue,  5 Feb 2019 17:05:08 +0000
Message-Id: <20190205170510.21984-21-peter.maydell@linaro.org>
In-Reply-To: <20190205170510.21984-1-peter.maydell@linaro.org>
References: <20190205170510.21984-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 20/22] hw/arm/boot: Clarify why
 arm_setup_firmware_boot() doesn't set env->boot_info
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

The code path for booting firmware doesn't set env->boot_info. At
first sight this looks odd, so add a comment saying why we don't.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Reviewed-by: Igor Mammedov <imammedo@redhat.com>
Message-id: 20190131112240.8395-5-peter.maydell@linaro.org
---
 hw/arm/boot.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/boot.c b/hw/arm/boot.c
index 2d4f710395f..328cc6bd245 100644
--- a/hw/arm/boot.c
+++ b/hw/arm/boot.c
@@ -1182,7 +1182,8 @@ static void arm_setup_firmware_boot(ARMCPU *cpu, struct arm_boot_info *info)
 
     /*
      * We will start from address 0 (typically a boot ROM image) in the
-     * same way as hardware.
+     * same way as hardware. Leave env->boot_info NULL, so that
+     * do_cpu_reset() knows it does not need to alter the PC on reset.
      */
 }
 
-- 
2.20.1
