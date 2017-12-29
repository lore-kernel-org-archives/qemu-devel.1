Received: from eggs.gnu.org ([2001:4830:134:3::10]:56861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynP-00033q-Cp
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynO-00061f-JS
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:15 -0500
Received: from mail-qk0-x244.google.com ([2607:f8b0:400d:c09::244]:42460)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUynO-00060e-Eu
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:14 -0500
Received: by mail-qk0-x244.google.com with SMTP id d202so29033624qkc.9
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 09:50:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 29 Dec 2017 14:48:59 -0300
Message-Id: <20171229174933.1781-9-f4bug@amsat.org>
In-Reply-To: <20171229174933.1781-1-f4bug@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 08/42] sdhci: use qemu_log_mask(UNIMP)
 instead of fprintf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 06a1ec6f91..afb3a794ec 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -946,7 +946,8 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
         ret = (SD_HOST_SPECv2_VERS << 16) | sdhci_slotint(s);
         break;
     default:
-        ERRPRINT("bad %ub read: addr[0x%04x]\n", size, (int)offset);
+        qemu_log_mask(LOG_UNIMP, "SDHC rd_%ub @0x%02" HWADDR_PRIx " "
+                      "not implemented\n", size, offset);
         break;
     }
 
@@ -1152,8 +1153,8 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
         sdhci_update_irq(s);
         break;
     default:
-        ERRPRINT("bad %ub write offset: addr[0x%04x] <- %u(0x%x)\n",
-                 size, (int)offset, value >> shift, value >> shift);
+        qemu_log_mask(LOG_UNIMP, "SDHC wr_%ub @0x%02" HWADDR_PRIx " <- 0x%08x "
+                      "not implemented\n", size, offset, value >> shift);
         break;
     }
     DPRINT_L2("write %ub: addr[0x%04x] <- %u(0x%x)\n",
-- 
2.15.1
