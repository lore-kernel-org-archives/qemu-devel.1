Received: from eggs.gnu.org ([2001:4830:134:3::10]:47167)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE37-0000mY-2i
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:08:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE35-0004NA-9b
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:08:09 -0500
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:43289)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eaE35-0004Mu-4s
	for qemu-devel@nongnu.org; Sat, 13 Jan 2018 00:08:07 -0500
Received: by mail-qt0-x242.google.com with SMTP id s3so8546425qtb.10
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 21:08:07 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Sat, 13 Jan 2018 02:07:13 -0300
Message-Id: <20180113050717.22969-11-f4bug@amsat.org>
In-Reply-To: <20180113050717.22969-1-f4bug@amsat.org>
References: <20180113050717.22969-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 10/14] sdhci: rename the SDHC_CAPAB register
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
 hw/sd/sdhci-internal.h | 2 +-
 hw/sd/sdhci.c          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index e941bc2386..fc807f08f3 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -174,7 +174,7 @@
 #define SDHC_ACMD12ERRSTS              0x3C
 
 /* HWInit Capabilities Register 0x05E80080 */
-#define SDHC_CAPAREG                   0x40
+#define SDHC_CAPAB                     0x40
 #define SDHC_CAN_DO_DMA                0x00400000
 #define SDHC_CAN_DO_ADMA2              0x00080000
 #define SDHC_CAN_DO_ADMA1              0x00100000
diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index e8f4a3478a..3df33f5e93 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -898,7 +898,7 @@ static uint64_t sdhci_read(void *opaque, hwaddr offset, unsigned size)
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
