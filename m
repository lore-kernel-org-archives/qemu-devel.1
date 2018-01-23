Received: from eggs.gnu.org ([2001:4830:134:3::10]:48884)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edo1h-0005ne-9n
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 21:09:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1edo1g-0003kp-C1
	for qemu-devel@nongnu.org; Mon, 22 Jan 2018 21:09:29 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 22 Jan 2018 23:08:19 -0300
Message-Id: <20180123020820.1288-16-f4bug@amsat.org>
In-Reply-To: <20180123020820.1288-1-f4bug@amsat.org>
References: <20180123020820.1288-1-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Subject: [Qemu-devel] [PATCH v9 15/16] hw/arm/exynos4210: add a comment
 about a very similar SDHCI (Spec. v2)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, Alistair Francis <alistair.francis@xilinx.com>, Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <f4bug@amsat.org>, qemu-devel@nongnu.org, Kevin O'Connor <kevin@koconnor.net>, "Edgar E . Iglesias" <edgar.iglesias@xilinx.com>, Andrey Smirnov <andrew.smirnov@gmail.com>, Marcel Apfelbaum <marcel@redhat.com>, Krzysztof Kozlowski <krzk@kernel.org>, Igor Mitsyanko <i.mitsyanko@gmail.com>, "open list:Exynos" <qemu-arm@nongnu.org>

Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
---
 hw/arm/exynos4210.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/hw/arm/exynos4210.c b/hw/arm/exynos4210.c
index d89322c7ea..06f9d1ffa4 100644
--- a/hw/arm/exynos4210.c
+++ b/hw/arm/exynos4210.c
@@ -377,6 +377,18 @@ Exynos4210State *exynos4210_init(MemoryRegion *system_mem)
         BlockBackend *blk;
         DriveInfo *di;
 
+        /* Compatible with:
+         * - SD Host Controller Specification Version 2.0
+         * - SDIO Specification Version 2.0
+         * - MMC Specification Version 4.3
+         * - SDMA
+         * - ADMA2
+         *
+         * As this part of the Exynos4210 is not publically available,
+         * we used the "HS-MMC Controller S3C2416X RISC Microprocessor"
+         * public datasheet which is very similar (implementing
+         * MMC Specification Version 4.0 being the only difference noted)
+         */
         dev = qdev_create(NULL, TYPE_SYSBUS_SDHCI);
         qdev_prop_set_uint64(dev, "capareg", EXYNOS4210_SDHCI_CAPABILITIES);
         qdev_init_nofail(dev);
-- 
2.15.1
