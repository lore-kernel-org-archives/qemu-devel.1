Received: from eggs.gnu.org ([2001:4830:134:3::10]:60205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb9Rj-0000Bh-IO
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:25:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb9Ri-0003Fa-OV
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:25:23 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:36753)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eb9Ri-0003FK-Jm
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 13:25:22 -0500
Received: by mail-qk0-x242.google.com with SMTP id d21so17925746qkj.3
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 10:25:22 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 15 Jan 2018 15:24:32 -0300
Message-Id: <20180115182436.2066-11-f4bug@amsat.org>
In-Reply-To: <20180115182436.2066-1-f4bug@amsat.org>
References: <20180115182436.2066-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v8 10/14] sdhci: rename the SDHC_CAPAB register
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>

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
index 4265b6a20e..c4e486e2ff 100644
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
