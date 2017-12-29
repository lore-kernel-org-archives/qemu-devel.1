Received: from eggs.gnu.org ([2001:4830:134:3::10]:57916)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyow-0004Qt-FY
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:51:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyov-0008Dx-Kn
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:51:50 -0500
Received: from mail-qt0-x241.google.com ([2607:f8b0:400d:c0d::241]:35165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyov-0008Dr-Fv
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:51:49 -0500
Received: by mail-qt0-x241.google.com with SMTP id u10so54961457qtg.2
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 09:51:49 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 29 Dec 2017 14:49:33 -0300
Message-Id: <20171229174933.1781-43-f4bug@amsat.org>
In-Reply-To: <20171229174933.1781-1-f4bug@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 42/42] sdhci: add Spec v4.2 register
 definitions
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
---
 hw/sd/sdhci-internal.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/hw/sd/sdhci-internal.h b/hw/sd/sdhci-internal.h
index 1da91a27b4..8193aa1821 100644
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
