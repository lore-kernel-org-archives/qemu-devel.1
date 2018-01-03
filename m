Received: from eggs.gnu.org ([2001:4830:134:3::10]:47905)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnTC-0000h3-Ib
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnT9-00076W-Dz
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:08:54 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:41431)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eWnT9-00076J-9a
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 13:08:51 -0500
Received: by mail-qk0-x241.google.com with SMTP id a8so2565144qkb.8
	for <qemu-devel@nongnu.org>; Wed, 03 Jan 2018 10:08:51 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Wed,  3 Jan 2018 15:08:01 -0300
Message-Id: <20180103180805.18140-14-f4bug@amsat.org>
In-Reply-To: <20180103180805.18140-1-f4bug@amsat.org>
References: <20180103180805.18140-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v5 13/17] sdhci: rename the SDHC_CAPAB register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Fam Zheng <famz@redhat.com>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Andrey Smirnov <andrew.smirnov@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Reviewed-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci-internal.h | 2 +-
 hw/sd/sdhci.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index df240ea046..b7475a1b7b 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -176,7 +176,7 @@ FIELD(SDHC_PRNSTS, WRITE_PROTECT,      19, 1);
 #define SDHC_ACMD12ERRSTS              0x3C
 
 /* HWInit Capabilities Register 0x05E80080 */
-#define SDHC_CAPAREG                   0x40
+#define SDHC_CAPAB                     0x40
 #define SDHC_CAN_DO_DMA                0x00400000
 #define SDHC_CAN_DO_ADMA2              0x00080000
 #define SDHC_CAN_DO_ADMA1              0x00100000
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index 2c8dc66e7a..5d1c6b518d 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -903,7 +903,7 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
     case SDHC_ACMD12ERRSTS:
         ret = s->acmd12errsts;
         break;
-    case SDHC_CAPAREG:
+    case SDHC_CAPAB:
         ret = s->capareg;
         break;
     case SDHC_MAXCURR:
-- 
2.15.1
