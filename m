Received: from eggs.gnu.org ([2001:4830:134:3::10]:44575)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecFGb-0005zf-0X
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:50:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecFGW-0007xm-42
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:50:25 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:33263)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecFGV-0007xA-U7
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 13:50:20 -0500
Received: by mail-qt0-x243.google.com with SMTP id e2so32780462qti.0
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 10:50:19 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 18 Jan 2018 15:50:11 -0300
Message-Id: <20180118185011.19315-1-f4bug@amsat.org>
In-Reply-To: <20180118183108.16009-14-f4bug@amsat.org>
References: <20180118183108.16009-14-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 18/17] !fixup sdhci: add DMA and 64-bit
 capabilities (Spec v2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
missed from patch 14/17 while rebasing :|

 hw/sd/sdhci.c | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index d0d64f0c52..51368e028e 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -41,24 +41,6 @@
 #define TYPE_SDHCI_BUS "sdhci-bus"
 #define SDHCI_BUS(obj) OBJECT_CHECK(SDBus, (obj), TYPE_SDHCI_BUS)
 
-/* Default SD/MMC host controller features information, which will be
- * presented in CAPABILITIES register of generic SD host controller at reset.
- * If not stated otherwise:
- * 0 - not supported, 1 - supported, other - prohibited.
- */
-#define SDHC_CAPAB_64BITBUS       0ul        /* 64-bit System Bus Support */
-#define SDHC_CAPAB_ADMA1          1ul        /* ADMA1 support */
-#define SDHC_CAPAB_ADMA2          1ul        /* ADMA2 support */
-
-/* Now check all parameters and calculate CAPABILITIES REGISTER value */
-#if SDHC_CAPAB_64BITBUS > 1 || SDHC_CAPAB_ADMA2 > 1 || SDHC_CAPAB_ADMA1 > 1
-#error Capabilities features can have value 0 or 1 only!
-#endif
-
-#define SDHC_CAPAB_REG_DEFAULT                                 \
-   ((SDHC_CAPAB_64BITBUS << 28) | (SDHC_CAPAB_ADMA1 << 20) |   \
-    (SDHC_CAPAB_ADMA2 << 19))
-
 #define MASKED_WRITE(reg, mask, val)  (reg = (reg & (mask)) | (val))
 
 static void sdhci_check_capab_freq_range(SDHCIState *s, const char *desc,
-- 
2.15.1
