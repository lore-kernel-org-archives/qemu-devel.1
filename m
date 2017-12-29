Received: from eggs.gnu.org ([2001:4830:134:3::10]:57310)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyo3-0003fk-TB
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyo3-00073V-2K
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:55 -0500
Received: from mail-qk0-x241.google.com ([2607:f8b0:400d:c09::241]:44082)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eUyo2-00072r-Uc
	for qemu-devel@nongnu.org; Fri, 29 Dec 2017 12:50:54 -0500
Received: by mail-qk0-x241.google.com with SMTP id v188so26138019qkh.11
	for <qemu-devel@nongnu.org>; Fri, 29 Dec 2017 09:50:54 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Fri, 29 Dec 2017 14:49:14 -0300
Message-Id: <20171229174933.1781-24-f4bug@amsat.org>
In-Reply-To: <20171229174933.1781-1-f4bug@amsat.org>
References: <20171229174933.1781-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v3 23/42] sdhci: default to Spec v2
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
 hw/sd/sdhci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/sd/sdhci.c b/hw/sd/sdhci.c
index b8749b6f42..dac5c48196 100644
--- a/hw/sd/sdhci.c
+++ b/hw/sd/sdhci.c
@@ -1293,7 +1293,7 @@ const VMStateDescription sdhci_vmstate = {
 /* Capabilities registers provide information on supported features of this
  * specific host controller implementation */
 static Property sdhci_properties[] = {
-    DEFINE_PROP_UINT8("sd-spec-version", SDHCIState, spec_version, 1),
+    DEFINE_PROP_UINT8("sd-spec-version", SDHCIState, spec_version, 2),
 
     /* Timeout clock frequency 1-63, 0 - not defined */
     DEFINE_PROP_UINT8("timeout-freq", SDHCIState, cap.timeout_clk_freq, 0),
-- 
2.15.1
