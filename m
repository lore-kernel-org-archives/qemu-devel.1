Received: from eggs.gnu.org ([2001:4830:134:3::10]:47128)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE2x-0000f7-3B
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:08:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE2v-0004Aj-13
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:07:59 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:39504)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE2u-0004AM-Rn
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:07:56 -0500
Received: by mail-qt0-x243.google.com with SMTP id k19so8563421qtj.6
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 21:07:56 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Jan 2018 02:07:10 -0300
Message-Id: <20180113050717.22969-8-f4bug@amsat.org>
In-Reply-To: <20180113050717.22969-1-f4bug@amsat.org>
References: <20180113050717.22969-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 07/14] sdhci: use qemu_log_mask(UNIMP)
 instead of fprintf()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Kevin O'Connor <kevin@koconnor.net>, Paolo Bonzini <pbonzini@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index ded4fa4885..d0a91b60d5 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -947,7 +947,8 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
         ret = (SD_HOST_SPECv2_VERS << 16) | sdhci_slotint(s);
         break;
     default:
-        ERRPRINT("bad %ub read: addr[0x%04x]\n", size, (int)offset);
+        qemu_log_mask(LOG_UNIMP, "SDHC rd_%ub @0x%02" HWADDR_PRIx " "
+                      "not implemented\n", size, offset);
         break;
     }
 
@@ -1153,8 +1154,8 @@ sdhci_write(void *opaque, hwaddr offset, uint64_t val, unsigned size)
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
