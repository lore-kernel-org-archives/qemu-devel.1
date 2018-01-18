Received: from eggs.gnu.org ([2001:4830:134:3::10]:45097)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecH0M-0000md-0f
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:41:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecH0L-0007hf-1S
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:41:46 -0500
Received: from mail-qt0-x243.google.com ([2607:f8b0:400d:c0d::243]:38035)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ecH0K-0007hV-TD
	for qemu-devel@nongnu.org; Thu, 18 Jan 2018 15:41:44 -0500
Received: by mail-qt0-x243.google.com with SMTP id z10so5493436qti.5
	for <qemu-devel@nongnu.org>; Thu, 18 Jan 2018 12:41:44 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Thu, 18 Jan 2018 17:40:54 -0300
Message-Id: <20180118204058.5768-11-f4bug@amsat.org>
In-Reply-To: <20180118204058.5768-1-f4bug@amsat.org>
References: <20180118204058.5768-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v7 10/14] sdhci: add Spec v4.2 register
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Prasad J Pandit <pjp@fedoraproject.org>, Sai Pavan Boddu <saipava@xilinx.com>, Peter Crosthwaite <crosthwaite.peter@gmail.com>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Alistair Francis <alistair.francis@xilinx.com>
---
 hw/sd/sdhci-internal.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index ac4704eb61..b82e847636 100644
--- a/hw/sd/sdhci-internal.h
+++ b/hw/sd/sdhci-internal.h
@@ -191,6 +191,10 @@ FIELD(SDHC_HOSTCTL2, V18_ENA,          3, 1); /* UHS-I only */
 FIELD(SDHC_HOSTCTL2, DRIVER_STRENGTH,  4, 2); /* UHS-I only */
 FIELD(SDHC_HOSTCTL2, EXECUTE_TUNING,   6, 1); /* UHS-I only */
 FIELD(SDHC_HOSTCTL2, SAMPLING_CLKSEL,  7, 1); /* UHS-I only */
+FIELD(SDHC_HOSTCTL2, UHS_II_ENA,       8, 1); /* since v4 */
+FIELD(SDHC_HOSTCTL2, ADMA2_LENGTH,    10, 1); /* since v4 */
+FIELD(SDHC_HOSTCTL2, CMD23_ENA,       11, 1); /* since v4 */
+FIELD(SDHC_HOSTCTL2, VERSION4,        12, 1); /* since v4 */
 FIELD(SDHC_HOSTCTL2, ASYNC_INT,       14, 1);
 FIELD(SDHC_HOSTCTL2, PRESET_ENA,      15, 1);
 
@@ -219,12 +223,16 @@ FIELD(SDHC_CAPAB, DRIVER_TYPE_C,      37, 1); /* since v3 */
 FIELD(SDHC_CAPAB, DRIVER_TYPE_D,      38, 1); /* since v3 */
 FIELD(SDHC_CAPAB, TIMER_RETUNNING,    40, 4); /* since v3 */
 FIELD(SDHC_CAPAB, SDR50_TUNNING,      45, 1); /* since v3 */
+FIELD(SDHC_CAPAB, CLK_MUL,            48, 8); /* since v4.20 */
+FIELD(SDHC_CAPAB, ADMA3,              59, 1); /* since v4.20 */
+FIELD(SDHC_CAPAB, V18_VDD2,           60, 1); /* since v4.20 */
 
 /* HWInit Maximum Current Capabilities Register 0x0 */
 #define SDHC_MAXCURR                   0x48
 FIELD(SDHC_MAXCURR, V33_VDD1,          0, 8);
 FIELD(SDHC_MAXCURR, V30_VDD1,          8, 8);
 FIELD(SDHC_MAXCURR, V18_VDD1,         16, 8);
+FIELD(SDHC_MAXCURR, V18_VDD2,         32, 8); /* since v4.20 */
 
 /* W Force Event Auto CMD12 Error Interrupt Register 0x0000 */
 #define SDHC_FEAER                     0x50
-- 
2.15.1
