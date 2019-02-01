Received: from eggs.gnu.org ([209.51.188.92]:58701)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbLH-0007YC-Mh
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:07:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gpbLH-0003FT-0s
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:06:59 -0500
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334]:55991)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gpbLG-0003F9-RL
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 11:06:58 -0500
Received: by mail-wm1-x334.google.com with SMTP id y139so6604966wmc.5
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 08:06:58 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
	by smtp.gmail.com with ESMTPSA id n6sm2847250wmk.9.2019.02.01.08.06.55
	for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Fri, 01 Feb 2019 08:06:56 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri,  1 Feb 2019 16:06:07 +0000
Message-Id: <20190201160653.13829-2-peter.maydell@linaro.org>
In-Reply-To: <20190201160653.13829-1-peter.maydell@linaro.org>
References: <20190201160653.13829-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PULL 01/47] hw/arm/nrf51_soc: set object owner in
 memory_region_init_ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

From: kumar sourav <sourav.jb1988@gmail.com>

set object owner in memory_region_init_ram() instead
of NULL.

Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Message-id: 20190125155630.17430-1-sourav.jb1988@gmail.com
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 hw/arm/nrf51_soc.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
index 1630c275940..3a1c7e200cc 100644
--- a/hw/arm/nrf51_soc.c
+++ b/hw/arm/nrf51_soc.c
@@ -89,7 +89,8 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
     }
     memory_region_add_subregion(&s->container, NRF51_FLASH_BASE, &s->flash);
 
-    memory_region_init_ram(&s->sram, NULL, "nrf51.sram", s->sram_size, &err);
+    memory_region_init_ram(&s->sram, OBJECT(s), "nrf51.sram", s->sram_size,
+                           &err);
     if (err) {
         error_propagate(errp, err);
         return;
-- 
2.20.1
