Return-Path: <SRS0=wZWj=WT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C843C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:43:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4F5821848
	for <qemu-devel@archiver.kernel.org>; Fri, 23 Aug 2019 19:43:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4F5821848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bt.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1FTL-0002au-WE
	for qemu-devel@archiver.kernel.org; Fri, 23 Aug 2019 15:43:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50495)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <tony.nguyen@bt.com>) id 1i1FPo-0007ml-R7
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:40:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <tony.nguyen@bt.com>) id 1i1FPj-0002H9-6y
 for qemu-devel@nongnu.org; Fri, 23 Aug 2019 15:40:04 -0400
Received: from nsstlmta31p.bpe.bigpond.com ([203.38.21.31]:53430)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <tony.nguyen@bt.com>)
 id 1i1FPi-0002EW-1r; Fri, 23 Aug 2019 15:39:59 -0400
Received: from smtp.telstra.com ([10.10.24.4])
 by nsstlfep31p-svc.bpe.nexus.telstra.com.au with ESMTP id
 <20190823193953.EIFU30018.nsstlfep31p-svc.bpe.nexus.telstra.com.au@smtp.telstra.com>;
 Sat, 24 Aug 2019 05:39:53 +1000
X-RG-Spam: Unknown
X-RazorGate-Vade: gggruggvucftvghtrhhoucdtuddrgeduvddrudegkedgudefjecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfupfevtfgpvffgnffuvffttedpqfgfvfenuceurghilhhouhhtmecugedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhephffvufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefvohhnhicupfhguhihvghnuceothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucfkphepheekrddujeefrdelkedrieeknecurfgrrhgrmhephhgvlhhopegusgiirdhtvghlshhtrhgrrdgtohhmrdgruhdpihhnvghtpeehkedrudejfedrleekrdeikedpmhgrihhlfhhrohhmpeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqedprhgtphhtthhopeeorghtrghrgehqvghmuhesghhmrghilhdrtghomheqpdhrtghpthhtohepoegsrghlrghtohhnsegvihhkrdgsmhgvrdhhuheqpdhrtghpthhtohepoegthhhouhhtvggruhesrggurggtohhrvgdrtghomheqpdhrtghpthhtohepoegtlhhgsehkrghougdrohhrgheqpdhrtghpthhtohepoegurghvihgusehgihgsshhonhdrughrohhpsggvrghrrdhiugdrrghuqedprhgtphhtthhopeeouggvlhhlvghrsehgmhigrdguvgeqpdhrtghpthhtohepoehfrhgvuggvrhhitgdrkhhonhhrrggusegruggrtghorhgvrdgtohhmqedprhgtphhtthhopeeojhgrshhofigrnhhgsehrvgguhhgrthdrtgho
 mheqpdhrtghpthhtohepoehkrhgrgigvlhesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeolhgvrhhsvghksehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehmrghrtggrnhgurhgvrdhluhhrvggruhesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeomhgrrhgtvghlrdgrphhfvghlsggruhhmsehgmhgrihhlrdgtohhmqedprhgtphhtthhopeeomhgrrhhkrdgtrghvvgdqrgihlhgrnhgusehilhgrnhguvgdrtghordhukheqpdhrtghpthhtohepoehmihgthhgrvghlseifrghllhgvrdgttgeqpdhrtghpthhtohepoehmshhtsehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehpsghonhiiihhnihesrhgvughhrghtrdgtohhmqedprhgtphhtthhopeeophhhihhlmhgusehrvgguhhgrthdrtghomheqpdhrtghpthhtohepoehqvghmuhdquggvvhgvlhesnhhonhhgnhhurdhorhhgqedprhgtphhtthhopeeoqhgvmhhuqdhpphgtsehnohhnghhnuhdrohhrgheqpdhrtghpthhtohepoehrihgthhgrrhgurdhhvghnuggvrhhsohhnsehlihhnrghrohdrohhrgheqpdhrtghpthhtohepoehrthhhsehtfihiuggulhgvrdhnvghtqedprhgtphhtthhopeeothhonhihrdhnghhuhigvnhessghtrdgtohhmqeenucevlhhushhtvghrufhiiigvpedv
X-RazorGate-Vade-Verdict: clean 0
X-RazorGate-Vade-Classification: clean
X-RG-VS-CLASS: clean
X-Authentication-Info: Submitted using ID tony.nguyen.git@bigpond.com
Received: from dbz.telstra.com.au (58.173.98.68) by smtp.telstra.com (5.8.335)
 (authenticated as tony.nguyen.git@bigpond.com)
 id 5D3692920C8EC2C7; Sat, 24 Aug 2019 05:39:52 +1000
From: Tony Nguyen <tony.nguyen@bt.com>
To: qemu-devel@nongnu.org
Date: Sat, 24 Aug 2019 05:42:43 +1000
Message-Id: <88a8340441fa6e23fc3d1960a71fc2ce7a762506.1566588034.git.tony.nguyen@bt.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <cover.1566588033.git.tony.nguyen@bt.com>
References: <cover.1566588033.git.tony.nguyen@bt.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x
X-Received-From: 203.38.21.31
Subject: [Qemu-devel] [PATCH 4/9] exec: Replace DEVICE_BIG_ENDIAN with MO_BE
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Tony Nguyen <tony.nguyen@bt.com>,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Helge Deller <deller@gmx.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 KONRAD Frederic <frederic.konrad@adacore.com>,
 Fabien Chouteau <chouteau@adacore.com>, Laszlo Ersek <lersek@redhat.com>,
 Michael Walle <michael@walle.cc>, qemu-ppc@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Richard Henderson <rth@twiddle.net>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Simplify endianness comparisons with consistent use of the more
expressive MemOp.

Suggested-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Tony Nguyen <tony.nguyen@bt.com>
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
---
 hw/audio/cs4231.c           |  2 +-
 hw/audio/milkymist-ac97.c   |  2 +-
 hw/char/escc.c              |  2 +-
 hw/char/grlib_apbuart.c     |  2 +-
 hw/char/lm32_uart.c         |  2 +-
 hw/char/milkymist-uart.c    |  2 +-
 hw/char/serial.c            |  4 ++--
 hw/dma/sparc32_dma.c        |  2 +-
 hw/gpio/mpc8xxx.c           |  2 +-
 hw/hppa/dino.c              |  4 ++--
 hw/hppa/machine.c           |  2 +-
 hw/hppa/pci.c               |  6 +++---
 hw/i2c/mpc_i2c.c            |  2 +-
 hw/intc/openpic.c           | 12 ++++++------
 hw/intc/openpic_kvm.c       |  2 +-
 hw/intc/pnv_xive.c          | 14 +++++++-------
 hw/intc/xics_pnv.c          |  2 +-
 hw/intc/xive.c              |  6 +++---
 hw/misc/grlib_ahb_apb_pnp.c |  4 ++--
 hw/misc/macio/cuda.c        |  2 +-
 hw/misc/macio/pmu.c         |  2 +-
 hw/net/lance.c              |  2 +-
 hw/nvram/fw_cfg.c           |  6 +++---
 hw/nvram/mac_nvram.c        |  2 +-
 hw/pci-host/ppce500.c       |  2 +-
 hw/pci-host/sabre.c         |  2 +-
 hw/pci-host/uninorth.c      |  2 +-
 hw/pci/pci_host.c           |  4 ++--
 hw/ppc/e500.c               |  4 ++--
 hw/ppc/mpc8544_guts.c       |  2 +-
 hw/ppc/pnv_core.c           |  6 +++---
 hw/ppc/pnv_lpc.c            |  8 ++++----
 hw/ppc/pnv_occ.c            |  4 ++--
 hw/ppc/pnv_psi.c            |  8 ++++----
 hw/ppc/pnv_xscom.c          |  2 +-
 hw/ppc/ppc405_boards.c      |  2 +-
 hw/ppc/ppc405_uc.c          | 10 +++++-----
 hw/ppc/ppc440_bamboo.c      |  4 ++--
 hw/ppc/ppce500_spin.c       |  2 +-
 hw/ppc/sam460ex.c           |  4 ++--
 hw/sparc64/niagara.c        |  2 +-
 hw/sparc64/sun4u.c          |  2 +-
 hw/sparc64/sun4u_iommu.c    |  2 +-
 hw/timer/grlib_gptimer.c    |  2 +-
 hw/timer/lm32_timer.c       |  2 +-
 hw/timer/m48t59.c           |  2 +-
 hw/timer/milkymist-sysctl.c |  2 +-
 hw/timer/sun4v-rtc.c        |  2 +-
 include/exec/cpu-common.h   |  2 +-
 memory.c                    |  6 +++---
 memory_ldst.inc.c           | 24 ++++++++++++------------
 51 files changed, 101 insertions(+), 101 deletions(-)

diff --git a/hw/audio/cs4231.c b/hw/audio/cs4231.c
index 1ff9093efa..abfab8c4e3 100644
--- a/hw/audio/cs4231.c
+++ b/hw/audio/cs4231.c
@@ -133,7 +133,7 @@ static void cs_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps cs_mem_ops = {
     .read = cs_mem_read,
     .write = cs_mem_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static const VMStateDescription vmstate_cs4231 = {
diff --git a/hw/audio/milkymist-ac97.c b/hw/audio/milkymist-ac97.c
index 897dfff85a..bde90e4e76 100644
--- a/hw/audio/milkymist-ac97.c
+++ b/hw/audio/milkymist-ac97.c
@@ -177,7 +177,7 @@ static const MemoryRegionOps ac97_mmio_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static void ac97_in_cb(void *opaque, int avail_b)
diff --git a/hw/char/escc.c b/hw/char/escc.c
index e2130e04e5..505364e1f8 100644
--- a/hw/char/escc.c
+++ b/hw/char/escc.c
@@ -576,7 +576,7 @@ static uint64_t escc_mem_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps escc_mem_ops = {
     .read = escc_mem_read,
     .write = escc_mem_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/char/grlib_apbuart.c b/hw/char/grlib_apbuart.c
index 880878ab4d..de21334ace 100644
--- a/hw/char/grlib_apbuart.c
+++ b/hw/char/grlib_apbuart.c
@@ -239,7 +239,7 @@ static void grlib_apbuart_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps grlib_apbuart_ops = {
     .write      = grlib_apbuart_write,
     .read       = grlib_apbuart_read,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static void grlib_apbuart_realize(DeviceState *dev, Error **errp)
diff --git a/hw/char/lm32_uart.c b/hw/char/lm32_uart.c
index 372c7d60d8..533a401fee 100644
--- a/hw/char/lm32_uart.c
+++ b/hw/char/lm32_uart.c
@@ -207,7 +207,7 @@ static void uart_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps uart_ops = {
     .read = uart_read,
     .write = uart_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/char/milkymist-uart.c b/hw/char/milkymist-uart.c
index ed4f02c500..3d008685d1 100644
--- a/hw/char/milkymist-uart.c
+++ b/hw/char/milkymist-uart.c
@@ -158,7 +158,7 @@ static const MemoryRegionOps uart_mmio_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static void uart_rx(void *opaque, const uint8_t *buf, int size)
diff --git a/hw/char/serial.c b/hw/char/serial.c
index b4e2232fc7..cf41203be6 100644
--- a/hw/char/serial.c
+++ b/hw/char/serial.c
@@ -1027,7 +1027,7 @@ static const MemoryRegionOps serial_mm_ops[2] = {
     [1] = {
         .read = serial_mm_read,
         .write = serial_mm_write,
-        .endianness = DEVICE_BIG_ENDIAN,
+        .endianness = MO_BE,
         .valid.max_access_size = 8,
         .impl.max_access_size = 8,
     },
@@ -1051,7 +1051,7 @@ SerialState *serial_mm_init(MemoryRegion *address_space,
     vmstate_register(NULL, base, &vmstate_serial, s);
 
     memory_region_init_io(&s->io, NULL,
-                          &serial_mm_ops[end == DEVICE_BIG_ENDIAN],
+                          &serial_mm_ops[end == MO_BE],
                           s, "serial", 8 << it_shift);
     memory_region_add_subregion(address_space, base, &s->io);
     return s;
diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
index bf76f2e558..df99c25323 100644
--- a/hw/dma/sparc32_dma.c
+++ b/hw/dma/sparc32_dma.c
@@ -226,7 +226,7 @@ static void dma_mem_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps dma_mem_ops = {
     .read = dma_mem_read,
     .write = dma_mem_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/gpio/mpc8xxx.c b/hw/gpio/mpc8xxx.c
index 1d99667094..fe1bb95d33 100644
--- a/hw/gpio/mpc8xxx.c
+++ b/hw/gpio/mpc8xxx.c
@@ -182,7 +182,7 @@ static void mpc8xxx_gpio_set_irq(void * opaque, int irq, int level)
 static const MemoryRegionOps mpc8xxx_gpio_ops = {
     .read = mpc8xxx_gpio_read,
     .write = mpc8xxx_gpio_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static void mpc8xxx_gpio_initfn(Object *obj)
diff --git a/hw/hppa/dino.c b/hw/hppa/dino.c
index 5bc223d9b2..d1d4b52354 100644
--- a/hw/hppa/dino.c
+++ b/hw/hppa/dino.c
@@ -309,7 +309,7 @@ static MemTxResult dino_chip_write_with_attrs(void *opaque, hwaddr addr,
 static const MemoryRegionOps dino_chip_ops = {
     .read_with_attrs = dino_chip_read_with_attrs,
     .write_with_attrs = dino_chip_write_with_attrs,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
@@ -378,7 +378,7 @@ static const MemoryRegionOps dino_config_addr_ops = {
     .write = dino_config_addr_write,
     .valid.min_access_size = 4,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static AddressSpace *dino_pcihost_set_iommu(PCIBus *bus, void *opaque,
diff --git a/hw/hppa/machine.c b/hw/hppa/machine.c
index 2736ce835e..abcd6db2bb 100644
--- a/hw/hppa/machine.c
+++ b/hw/hppa/machine.c
@@ -113,7 +113,7 @@ static void machine_hppa_init(MachineState *machine)
     if (serial_hd(0)) {
         uint32_t addr = DINO_UART_HPA + 0x800;
         serial_mm_init(addr_space, addr, 0, serial_irq,
-                       115200, serial_hd(0), DEVICE_BIG_ENDIAN);
+                       115200, serial_hd(0), MO_BE);
     }
 
     /* SCSI disk setup. */
diff --git a/hw/hppa/pci.c b/hw/hppa/pci.c
index 32609aba63..560726111e 100644
--- a/hw/hppa/pci.c
+++ b/hw/hppa/pci.c
@@ -23,7 +23,7 @@ static void ignore_write(void *opaque, hwaddr addr, uint64_t v, unsigned size)
 const MemoryRegionOps hppa_pci_ignore_ops = {
     .read = ignore_read,
     .write = ignore_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 8,
@@ -53,7 +53,7 @@ static void bw_conf1_write(void *opaque, hwaddr addr,
 const MemoryRegionOps hppa_pci_conf1_ops = {
     .read = bw_conf1_read,
     .write = bw_conf1_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 4,
@@ -76,7 +76,7 @@ static void special_write(void *opaque, hwaddr addr,
 const MemoryRegionOps hppa_pci_iack_ops = {
     .read = iack_read,
     .write = special_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/i2c/mpc_i2c.c b/hw/i2c/mpc_i2c.c
index b71b5ff7d5..50b2844ba7 100644
--- a/hw/i2c/mpc_i2c.c
+++ b/hw/i2c/mpc_i2c.c
@@ -306,7 +306,7 @@ static const MemoryRegionOps i2c_ops = {
     .read =  mpc_i2c_read,
     .write =  mpc_i2c_write,
     .valid.max_access_size = 1,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static const VMStateDescription mpc_i2c_vmstate = {
diff --git a/hw/intc/openpic.c b/hw/intc/openpic.c
index 4e8d5a8050..887926770d 100644
--- a/hw/intc/openpic.c
+++ b/hw/intc/openpic.c
@@ -1160,7 +1160,7 @@ static const MemoryRegionOps openpic_glb_ops_le = {
 static const MemoryRegionOps openpic_glb_ops_be = {
     .write = openpic_gbl_write,
     .read  = openpic_gbl_read,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -1180,7 +1180,7 @@ static const MemoryRegionOps openpic_tmr_ops_le = {
 static const MemoryRegionOps openpic_tmr_ops_be = {
     .write = openpic_tmr_write,
     .read  = openpic_tmr_read,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -1200,7 +1200,7 @@ static const MemoryRegionOps openpic_cpu_ops_le = {
 static const MemoryRegionOps openpic_cpu_ops_be = {
     .write = openpic_cpu_write,
     .read  = openpic_cpu_read,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -1220,7 +1220,7 @@ static const MemoryRegionOps openpic_src_ops_le = {
 static const MemoryRegionOps openpic_src_ops_be = {
     .write = openpic_src_write,
     .read  = openpic_src_read,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -1230,7 +1230,7 @@ static const MemoryRegionOps openpic_src_ops_be = {
 static const MemoryRegionOps openpic_msi_ops_be = {
     .read = openpic_msi_read,
     .write = openpic_msi_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -1240,7 +1240,7 @@ static const MemoryRegionOps openpic_msi_ops_be = {
 static const MemoryRegionOps openpic_summary_ops_be = {
     .read = openpic_summary_read,
     .write = openpic_summary_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/intc/openpic_kvm.c b/hw/intc/openpic_kvm.c
index c09bebedd1..d644caed2b 100644
--- a/hw/intc/openpic_kvm.c
+++ b/hw/intc/openpic_kvm.c
@@ -109,7 +109,7 @@ static uint64_t kvm_openpic_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps kvm_openpic_mem_ops = {
     .write = kvm_openpic_write,
     .read  = kvm_openpic_read,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .impl = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/intc/pnv_xive.c b/hw/intc/pnv_xive.c
index ed6e9d71bb..66b41330a8 100644
--- a/hw/intc/pnv_xive.c
+++ b/hw/intc/pnv_xive.c
@@ -1188,7 +1188,7 @@ static uint64_t pnv_xive_ic_reg_read(void *opaque, hwaddr offset, unsigned size)
 static const MemoryRegionOps pnv_xive_ic_reg_ops = {
     .read = pnv_xive_ic_reg_read,
     .write = pnv_xive_ic_reg_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 8,
         .max_access_size = 8,
@@ -1287,7 +1287,7 @@ static uint64_t pnv_xive_ic_notify_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps pnv_xive_ic_notify_ops = {
     .read = pnv_xive_ic_notify_read,
     .write = pnv_xive_ic_notify_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 8,
         .max_access_size = 8,
@@ -1321,7 +1321,7 @@ static uint64_t pnv_xive_ic_lsi_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps pnv_xive_ic_lsi_ops = {
     .read = pnv_xive_ic_lsi_read,
     .write = pnv_xive_ic_lsi_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 8,
         .max_access_size = 8,
@@ -1386,7 +1386,7 @@ static uint64_t xive_tm_indirect_read(void *opaque, hwaddr offset,
 static const MemoryRegionOps xive_tm_indirect_ops = {
     .read = xive_tm_indirect_read,
     .write = xive_tm_indirect_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 8,
@@ -1420,7 +1420,7 @@ static void pnv_xive_xscom_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps pnv_xive_xscom_ops = {
     .read = pnv_xive_xscom_read,
     .write = pnv_xive_xscom_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 8,
         .max_access_size = 8,
@@ -1516,7 +1516,7 @@ static void pnv_xive_vc_write(void *opaque, hwaddr offset,
 static const MemoryRegionOps pnv_xive_vc_ops = {
     .read = pnv_xive_vc_read,
     .write = pnv_xive_vc_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 8,
         .max_access_size = 8,
@@ -1551,7 +1551,7 @@ static void pnv_xive_pc_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps pnv_xive_pc_ops = {
     .read = pnv_xive_pc_read,
     .write = pnv_xive_pc_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 8,
         .max_access_size = 8,
diff --git a/hw/intc/xics_pnv.c b/hw/intc/xics_pnv.c
index 35f3811264..d25a7863bb 100644
--- a/hw/intc/xics_pnv.c
+++ b/hw/intc/xics_pnv.c
@@ -148,7 +148,7 @@ bad_access:
 static const MemoryRegionOps pnv_icp_ops = {
     .read = pnv_icp_read,
     .write = pnv_icp_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 4,
diff --git a/hw/intc/xive.c b/hw/intc/xive.c
index b7417210d8..1fea2fdb97 100644
--- a/hw/intc/xive.c
+++ b/hw/intc/xive.c
@@ -495,7 +495,7 @@ static uint64_t xive_tm_read(void *opaque, hwaddr offset, unsigned size)
 const MemoryRegionOps xive_tm_ops = {
     .read = xive_tm_read,
     .write = xive_tm_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 8,
@@ -985,7 +985,7 @@ out:
 static const MemoryRegionOps xive_source_esb_ops = {
     .read = xive_source_esb_read,
     .write = xive_source_esb_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 8,
         .max_access_size = 8,
@@ -1785,7 +1785,7 @@ static void xive_end_source_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps xive_end_source_ops = {
     .read = xive_end_source_read,
     .write = xive_end_source_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 8,
         .max_access_size = 8,
diff --git a/hw/misc/grlib_ahb_apb_pnp.c b/hw/misc/grlib_ahb_apb_pnp.c
index 7338461694..a85624ef0d 100644
--- a/hw/misc/grlib_ahb_apb_pnp.c
+++ b/hw/misc/grlib_ahb_apb_pnp.c
@@ -137,7 +137,7 @@ static uint64_t grlib_ahb_pnp_read(void *opaque, hwaddr offset, unsigned size)
 
 static const MemoryRegionOps grlib_ahb_pnp_ops = {
     .read       = grlib_ahb_pnp_read,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static void grlib_ahb_pnp_realize(DeviceState *dev, Error **errp)
@@ -233,7 +233,7 @@ static uint64_t grlib_apb_pnp_read(void *opaque, hwaddr offset, unsigned size)
 
 static const MemoryRegionOps grlib_apb_pnp_ops = {
     .read       = grlib_apb_pnp_read,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static void grlib_apb_pnp_realize(DeviceState *dev, Error **errp)
diff --git a/hw/misc/macio/cuda.c b/hw/misc/macio/cuda.c
index e38becba6a..6faa3969cb 100644
--- a/hw/misc/macio/cuda.c
+++ b/hw/misc/macio/cuda.c
@@ -478,7 +478,7 @@ static void mos6522_cuda_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps mos6522_cuda_ops = {
     .read = mos6522_cuda_read,
     .write = mos6522_cuda_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/misc/macio/pmu.c b/hw/misc/macio/pmu.c
index 769aed8052..d36e1b5157 100644
--- a/hw/misc/macio/pmu.c
+++ b/hw/misc/macio/pmu.c
@@ -666,7 +666,7 @@ static void mos6522_pmu_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps mos6522_pmu_ops = {
     .read = mos6522_pmu_read,
     .write = mos6522_pmu_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .impl = {
         .min_access_size = 1,
         .max_access_size = 1,
diff --git a/hw/net/lance.c b/hw/net/lance.c
index 27dfa3a688..78692100e4 100644
--- a/hw/net/lance.c
+++ b/hw/net/lance.c
@@ -76,7 +76,7 @@ static uint64_t lance_mem_read(void *opaque, hwaddr addr,
 static const MemoryRegionOps lance_mem_ops = {
     .read = lance_mem_read,
     .write = lance_mem_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 2,
         .max_access_size = 2,
diff --git a/hw/nvram/fw_cfg.c b/hw/nvram/fw_cfg.c
index 4c62667afd..b4671c2b4a 100644
--- a/hw/nvram/fw_cfg.c
+++ b/hw/nvram/fw_cfg.c
@@ -526,14 +526,14 @@ static bool fw_cfg_comb_valid(void *opaque, hwaddr addr,
 static const MemoryRegionOps fw_cfg_ctl_mem_ops = {
     .read = fw_cfg_ctl_mem_read,
     .write = fw_cfg_ctl_mem_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid.accepts = fw_cfg_ctl_mem_valid,
 };
 
 static const MemoryRegionOps fw_cfg_data_mem_ops = {
     .read = fw_cfg_data_read,
     .write = fw_cfg_data_mem_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 1,
         .max_access_size = 1,
@@ -551,7 +551,7 @@ static const MemoryRegionOps fw_cfg_comb_mem_ops = {
 static const MemoryRegionOps fw_cfg_dma_mem_ops = {
     .read = fw_cfg_dma_mem_read,
     .write = fw_cfg_dma_mem_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid.accepts = fw_cfg_dma_mem_valid,
     .valid.max_access_size = 8,
     .impl.max_access_size = 8,
diff --git a/hw/nvram/mac_nvram.c b/hw/nvram/mac_nvram.c
index 9a47e35b8e..44fd445192 100644
--- a/hw/nvram/mac_nvram.c
+++ b/hw/nvram/mac_nvram.c
@@ -77,7 +77,7 @@ static const MemoryRegionOps macio_nvram_ops = {
     .valid.max_access_size = 4,
     .impl.min_access_size = 1,
     .impl.max_access_size = 1,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static const VMStateDescription vmstate_macio_nvram = {
diff --git a/hw/pci-host/ppce500.c b/hw/pci-host/ppce500.c
index 8bed8e8941..2d1188089f 100644
--- a/hw/pci-host/ppce500.c
+++ b/hw/pci-host/ppce500.c
@@ -340,7 +340,7 @@ static void pci_reg_write4(void *opaque, hwaddr addr,
 static const MemoryRegionOps e500_pci_reg_ops = {
     .read = pci_reg_read4,
     .write = pci_reg_write4,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static int mpc85xx_pci_map_irq(PCIDevice *pci_dev, int pin)
diff --git a/hw/pci-host/sabre.c b/hw/pci-host/sabre.c
index 7f9520bcc4..aa8bd2c7a6 100644
--- a/hw/pci-host/sabre.c
+++ b/hw/pci-host/sabre.c
@@ -249,7 +249,7 @@ static uint64_t sabre_config_read(void *opaque,
 static const MemoryRegionOps sabre_config_ops = {
     .read = sabre_config_read,
     .write = sabre_config_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static void sabre_pci_config_write(void *opaque, hwaddr addr,
diff --git a/hw/pci-host/uninorth.c b/hw/pci-host/uninorth.c
index c3c2c85192..39ff1ac42c 100644
--- a/hw/pci-host/uninorth.c
+++ b/hw/pci-host/uninorth.c
@@ -565,7 +565,7 @@ static uint64_t unin_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps unin_ops = {
     .read = unin_read,
     .write = unin_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static void unin_init(Object *obj)
diff --git a/hw/pci/pci_host.c b/hw/pci/pci_host.c
index ed407d096d..fc1b837ba2 100644
--- a/hw/pci/pci_host.c
+++ b/hw/pci/pci_host.c
@@ -196,7 +196,7 @@ const MemoryRegionOps pci_host_conf_le_ops = {
 const MemoryRegionOps pci_host_conf_be_ops = {
     .read = pci_host_config_read,
     .write = pci_host_config_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 const MemoryRegionOps pci_host_data_le_ops = {
@@ -208,7 +208,7 @@ const MemoryRegionOps pci_host_data_le_ops = {
 const MemoryRegionOps pci_host_data_be_ops = {
     .read = pci_host_data_read,
     .write = pci_host_data_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static const TypeInfo pci_host_type_info = {
diff --git a/hw/ppc/e500.c b/hw/ppc/e500.c
index 91cd4c26f9..1e10ff0ab5 100644
--- a/hw/ppc/e500.c
+++ b/hw/ppc/e500.c
@@ -930,13 +930,13 @@ void ppce500_init(MachineState *machine)
     if (serial_hd(0)) {
         serial_mm_init(ccsr_addr_space, MPC8544_SERIAL0_REGS_OFFSET,
                        0, qdev_get_gpio_in(mpicdev, 42), 399193,
-                       serial_hd(0), DEVICE_BIG_ENDIAN);
+                       serial_hd(0), MO_BE);
     }
 
     if (serial_hd(1)) {
         serial_mm_init(ccsr_addr_space, MPC8544_SERIAL1_REGS_OFFSET,
                        0, qdev_get_gpio_in(mpicdev, 42), 399193,
-                       serial_hd(1), DEVICE_BIG_ENDIAN);
+                       serial_hd(1), MO_BE);
     }
         /* I2C */
     dev = qdev_create(NULL, "mpc-i2c");
diff --git a/hw/ppc/mpc8544_guts.c b/hw/ppc/mpc8544_guts.c
index b96ea36f98..94c3c94480 100644
--- a/hw/ppc/mpc8544_guts.c
+++ b/hw/ppc/mpc8544_guts.c
@@ -110,7 +110,7 @@ static void mpc8544_guts_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps mpc8544_guts_ops = {
     .read = mpc8544_guts_read,
     .write = mpc8544_guts_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/ppc/pnv_core.c b/hw/ppc/pnv_core.c
index b1a7489e7a..7503c7180a 100644
--- a/hw/ppc/pnv_core.c
+++ b/hw/ppc/pnv_core.c
@@ -99,7 +99,7 @@ static const MemoryRegionOps pnv_core_power8_xscom_ops = {
     .valid.max_access_size = 8,
     .impl.min_access_size = 8,
     .impl.max_access_size = 8,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 
@@ -157,7 +157,7 @@ static const MemoryRegionOps pnv_core_power9_xscom_ops = {
     .valid.max_access_size = 8,
     .impl.min_access_size = 8,
     .impl.max_access_size = 8,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static void pnv_realize_vcpu(PowerPCCPU *cpu, PnvChip *chip, Error **errp)
@@ -378,7 +378,7 @@ static const MemoryRegionOps pnv_quad_xscom_ops = {
     .valid.max_access_size = 8,
     .impl.min_access_size = 8,
     .impl.max_access_size = 8,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static void pnv_quad_realize(DeviceState *dev, Error **errp)
diff --git a/hw/ppc/pnv_lpc.c b/hw/ppc/pnv_lpc.c
index 9466d4a1be..dac8cdffb8 100644
--- a/hw/ppc/pnv_lpc.c
+++ b/hw/ppc/pnv_lpc.c
@@ -336,7 +336,7 @@ static const MemoryRegionOps pnv_lpc_xscom_ops = {
     .valid.max_access_size = 8,
     .impl.min_access_size = 8,
     .impl.max_access_size = 8,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static uint64_t pnv_lpc_mmio_read(void *opaque, hwaddr addr, unsigned size)
@@ -404,7 +404,7 @@ static const MemoryRegionOps pnv_lpc_mmio_ops = {
         .min_access_size = 1,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static void pnv_lpc_eval_irqs(PnvLpcController *lpc)
@@ -507,7 +507,7 @@ static void lpc_hc_write(void *opaque, hwaddr addr, uint64_t val,
 static const MemoryRegionOps lpc_hc_ops = {
     .read = lpc_hc_read,
     .write = lpc_hc_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
@@ -586,7 +586,7 @@ static void opb_master_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps opb_master_ops = {
     .read = opb_master_read,
     .write = opb_master_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 8bead2c930..3945b94a53 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -89,7 +89,7 @@ static const MemoryRegionOps pnv_occ_power8_xscom_ops = {
     .valid.max_access_size = 8,
     .impl.min_access_size = 8,
     .impl.max_access_size = 8,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static void pnv_occ_power8_class_init(ObjectClass *klass, void *data)
@@ -160,7 +160,7 @@ static const MemoryRegionOps pnv_occ_power9_xscom_ops = {
     .valid.max_access_size = 8,
     .impl.min_access_size = 8,
     .impl.max_access_size = 8,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static void pnv_occ_power9_class_init(ObjectClass *klass, void *data)
diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 88ba8e7b9b..a936a85a3c 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -419,7 +419,7 @@ static void pnv_psi_mmio_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps psi_mmio_ops = {
     .read = pnv_psi_mmio_read,
     .write = pnv_psi_mmio_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 8,
         .max_access_size = 8,
@@ -444,7 +444,7 @@ static void pnv_psi_xscom_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps pnv_psi_xscom_ops = {
     .read = pnv_psi_xscom_read,
     .write = pnv_psi_xscom_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 8,
         .max_access_size = 8,
@@ -739,7 +739,7 @@ static void pnv_psi_p9_mmio_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps pnv_psi_p9_mmio_ops = {
     .read = pnv_psi_p9_mmio_read,
     .write = pnv_psi_p9_mmio_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 8,
         .max_access_size = 8,
@@ -776,7 +776,7 @@ static void pnv_psi_p9_xscom_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps pnv_psi_p9_xscom_ops = {
     .read = pnv_psi_p9_xscom_read,
     .write = pnv_psi_p9_xscom_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 8,
         .max_access_size = 8,
diff --git a/hw/ppc/pnv_xscom.c b/hw/ppc/pnv_xscom.c
index 0e31c5786b..1cfd19c515 100644
--- a/hw/ppc/pnv_xscom.c
+++ b/hw/ppc/pnv_xscom.c
@@ -209,7 +209,7 @@ const MemoryRegionOps pnv_xscom_ops = {
     .valid.max_access_size = 8,
     .impl.min_access_size = 8,
     .impl.max_access_size = 8,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 void pnv_xscom_realize(PnvChip *chip, uint64_t size, Error **errp)
diff --git a/hw/ppc/ppc405_boards.c b/hw/ppc/ppc405_boards.c
index e98933fb55..16c65555db 100644
--- a/hw/ppc/ppc405_boards.c
+++ b/hw/ppc/ppc405_boards.c
@@ -111,7 +111,7 @@ static const MemoryRegionOps ref405ep_fpga_ops = {
     .impl.max_access_size = 1,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static void ref405ep_fpga_reset (void *opaque)
diff --git a/hw/ppc/ppc405_uc.c b/hw/ppc/ppc405_uc.c
index 97f0c8687a..bf71144d3d 100644
--- a/hw/ppc/ppc405_uc.c
+++ b/hw/ppc/ppc405_uc.c
@@ -335,7 +335,7 @@ static const MemoryRegionOps opba_ops = {
     .impl.max_access_size = 1,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static void ppc4xx_opba_reset (void *opaque)
@@ -1483,12 +1483,12 @@ CPUPPCState *ppc405cr_init(MemoryRegion *address_space_mem,
     if (serial_hd(0) != NULL) {
         serial_mm_init(address_space_mem, 0xef600300, 0, pic[0],
                        PPC_SERIAL_MM_BAUDBASE, serial_hd(0),
-                       DEVICE_BIG_ENDIAN);
+                       MO_BE);
     }
     if (serial_hd(1) != NULL) {
         serial_mm_init(address_space_mem, 0xef600400, 0, pic[1],
                        PPC_SERIAL_MM_BAUDBASE, serial_hd(1),
-                       DEVICE_BIG_ENDIAN);
+                       MO_BE);
     }
     /* IIC controller */
     sysbus_create_simple(TYPE_PPC4xx_I2C, 0xef600500, pic[2]);
@@ -1846,12 +1846,12 @@ CPUPPCState *ppc405ep_init(MemoryRegion *address_space_mem,
     if (serial_hd(0) != NULL) {
         serial_mm_init(address_space_mem, 0xef600300, 0, pic[0],
                        PPC_SERIAL_MM_BAUDBASE, serial_hd(0),
-                       DEVICE_BIG_ENDIAN);
+                       MO_BE);
     }
     if (serial_hd(1) != NULL) {
         serial_mm_init(address_space_mem, 0xef600400, 0, pic[1],
                        PPC_SERIAL_MM_BAUDBASE, serial_hd(1),
-                       DEVICE_BIG_ENDIAN);
+                       MO_BE);
     }
     /* OCM */
     ppc405_ocm_init(env);
diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
index 4d95c0f8a8..f09269b51b 100644
--- a/hw/ppc/ppc440_bamboo.c
+++ b/hw/ppc/ppc440_bamboo.c
@@ -234,12 +234,12 @@ static void bamboo_init(MachineState *machine)
     if (serial_hd(0) != NULL) {
         serial_mm_init(address_space_mem, 0xef600300, 0, pic[0],
                        PPC_SERIAL_MM_BAUDBASE, serial_hd(0),
-                       DEVICE_BIG_ENDIAN);
+                       MO_BE);
     }
     if (serial_hd(1) != NULL) {
         serial_mm_init(address_space_mem, 0xef600400, 0, pic[1],
                        PPC_SERIAL_MM_BAUDBASE, serial_hd(1),
-                       DEVICE_BIG_ENDIAN);
+                       MO_BE);
     }
 
     if (pcibus) {
diff --git a/hw/ppc/ppce500_spin.c b/hw/ppc/ppce500_spin.c
index 66c1065db2..1e804a6a38 100644
--- a/hw/ppc/ppce500_spin.c
+++ b/hw/ppc/ppce500_spin.c
@@ -172,7 +172,7 @@ static uint64_t spin_read(void *opaque, hwaddr addr, unsigned len)
 static const MemoryRegionOps spin_rw_ops = {
     .read = spin_read,
     .write = spin_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static void ppce500_spin_initfn(Object *obj)
diff --git a/hw/ppc/sam460ex.c b/hw/ppc/sam460ex.c
index 437e214210..4b45c76abe 100644
--- a/hw/ppc/sam460ex.c
+++ b/hw/ppc/sam460ex.c
@@ -413,12 +413,12 @@ static void sam460ex_init(MachineState *machine)
     if (serial_hd(0) != NULL) {
         serial_mm_init(address_space_mem, 0x4ef600300, 0, uic[1][1],
                        PPC_SERIAL_MM_BAUDBASE, serial_hd(0),
-                       DEVICE_BIG_ENDIAN);
+                       MO_BE);
     }
     if (serial_hd(1) != NULL) {
         serial_mm_init(address_space_mem, 0x4ef600400, 0, uic[0][1],
                        PPC_SERIAL_MM_BAUDBASE, serial_hd(1),
-                       DEVICE_BIG_ENDIAN);
+                       MO_BE);
     }
 
     /* Load U-Boot image. */
diff --git a/hw/sparc64/niagara.c b/hw/sparc64/niagara.c
index 167143bffe..e249444298 100644
--- a/hw/sparc64/niagara.c
+++ b/hw/sparc64/niagara.c
@@ -157,7 +157,7 @@ static void niagara_init(MachineState *machine)
     }
     if (serial_hd(0)) {
         serial_mm_init(sysmem, NIAGARA_UART_BASE, 0, NULL, 115200,
-                       serial_hd(0), DEVICE_BIG_ENDIAN);
+                       serial_hd(0), MO_BE);
     }
     create_unimplemented_device("sun4v-iob", NIAGARA_IOBBASE, NIAGARA_IOBSIZE);
     sun4v_rtc_init(NIAGARA_RTC_BASE);
diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
index a5d2ee9ba2..6386d3bfd7 100644
--- a/hw/sparc64/sun4u.c
+++ b/hw/sparc64/sun4u.c
@@ -323,7 +323,7 @@ static void ebus_realize(PCIDevice *pci_dev, Error **errp)
     i = 0;
     if (s->console_serial_base) {
         serial_mm_init(pci_address_space(pci_dev), s->console_serial_base,
-                       0, NULL, 115200, serial_hd(i), DEVICE_BIG_ENDIAN);
+                       0, NULL, 115200, serial_hd(i), MO_BE);
         i++;
     }
     serial_hds_isa_init(s->isa_bus, i, MAX_ISA_SERIAL_PORTS);
diff --git a/hw/sparc64/sun4u_iommu.c b/hw/sparc64/sun4u_iommu.c
index 9178277f82..5073098698 100644
--- a/hw/sparc64/sun4u_iommu.c
+++ b/hw/sparc64/sun4u_iommu.c
@@ -280,7 +280,7 @@ static uint64_t iommu_mem_read(void *opaque, hwaddr addr, unsigned size)
 static const MemoryRegionOps iommu_mem_ops = {
     .read = iommu_mem_read,
     .write = iommu_mem_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static void iommu_reset(DeviceState *d)
diff --git a/hw/timer/grlib_gptimer.c b/hw/timer/grlib_gptimer.c
index df84735197..24dd5ee3f6 100644
--- a/hw/timer/grlib_gptimer.c
+++ b/hw/timer/grlib_gptimer.c
@@ -315,7 +315,7 @@ static void grlib_gptimer_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps grlib_gptimer_ops = {
     .read = grlib_gptimer_read,
     .write = grlib_gptimer_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/timer/lm32_timer.c b/hw/timer/lm32_timer.c
index 4c0d3275e7..b376c815a0 100644
--- a/hw/timer/lm32_timer.c
+++ b/hw/timer/lm32_timer.c
@@ -146,7 +146,7 @@ static void timer_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps timer_ops = {
     .read = timer_read,
     .write = timer_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
     .valid = {
         .min_access_size = 4,
         .max_access_size = 4,
diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index 191b19494b..92204ab0ea 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -521,7 +521,7 @@ static const MemoryRegionOps nvram_ops = {
     .impl.max_access_size = 1,
     .valid.min_access_size = 1,
     .valid.max_access_size = 4,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static const VMStateDescription vmstate_m48t59 = {
diff --git a/hw/timer/milkymist-sysctl.c b/hw/timer/milkymist-sysctl.c
index cb117f944e..eedae27e3a 100644
--- a/hw/timer/milkymist-sysctl.c
+++ b/hw/timer/milkymist-sysctl.c
@@ -223,7 +223,7 @@ static const MemoryRegionOps sysctl_mmio_ops = {
         .min_access_size = 4,
         .max_access_size = 4,
     },
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 static void timer0_hit(void *opaque)
diff --git a/hw/timer/sun4v-rtc.c b/hw/timer/sun4v-rtc.c
index 0e831c91b1..0246e81e47 100644
--- a/hw/timer/sun4v-rtc.c
+++ b/hw/timer/sun4v-rtc.c
@@ -47,7 +47,7 @@ static void sun4v_rtc_write(void *opaque, hwaddr addr,
 static const MemoryRegionOps sun4v_rtc_ops = {
     .read = sun4v_rtc_read,
     .write = sun4v_rtc_write,
-    .endianness = DEVICE_BIG_ENDIAN,
+    .endianness = MO_BE,
 };
 
 void sun4v_rtc_init(hwaddr addr)
diff --git a/include/exec/cpu-common.h b/include/exec/cpu-common.h
index f61f269465..01a29ba571 100644
--- a/include/exec/cpu-common.h
+++ b/include/exec/cpu-common.h
@@ -27,7 +27,7 @@ enum device_endian {
 };
 
 #if defined(HOST_WORDS_BIGENDIAN)
-#define DEVICE_HOST_ENDIAN DEVICE_BIG_ENDIAN
+#define DEVICE_HOST_ENDIAN MO_BE
 #else
 #define DEVICE_HOST_ENDIAN MO_LE
 #endif
diff --git a/memory.c b/memory.c
index 01703988be..52090e18eb 100644
--- a/memory.c
+++ b/memory.c
@@ -348,7 +348,7 @@ static bool memory_region_big_endian(MemoryRegion *mr)
 #ifdef TARGET_WORDS_BIGENDIAN
     return mr->ops->endianness != MO_LE;
 #else
-    return mr->ops->endianness == DEVICE_BIG_ENDIAN;
+    return mr->ops->endianness == MO_BE;
 #endif
 }
 
@@ -3276,13 +3276,13 @@ MemOp devend_memop(enum device_endian end)
 {
     static MemOp conv[] = {
         [MO_LE] = MO_LE,
-        [DEVICE_BIG_ENDIAN] = MO_BE,
+        [MO_BE] = MO_BE,
         [MO_TE] = MO_TE,
         [DEVICE_HOST_ENDIAN] = 0,
     };
     switch (end) {
     case MO_LE:
-    case DEVICE_BIG_ENDIAN:
+    case MO_BE:
         return conv[end];
     default:
         g_assert_not_reached();
diff --git a/memory_ldst.inc.c b/memory_ldst.inc.c
index 8d723cffc2..45bec83a94 100644
--- a/memory_ldst.inc.c
+++ b/memory_ldst.inc.c
@@ -47,7 +47,7 @@ static inline uint32_t glue(address_space_ldl_internal, SUFFIX)(ARG1_DECL,
         case MO_LE:
             val = ldl_le_p(ptr);
             break;
-        case DEVICE_BIG_ENDIAN:
+        case MO_BE:
             val = ldl_be_p(ptr);
             break;
         default:
@@ -84,7 +84,7 @@ uint32_t glue(address_space_ldl_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     return glue(address_space_ldl_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_BIG_ENDIAN);
+                                                    MO_BE);
 }
 
 /* warning: addr must be aligned */
@@ -115,7 +115,7 @@ static inline uint64_t glue(address_space_ldq_internal, SUFFIX)(ARG1_DECL,
         case MO_LE:
             val = ldq_le_p(ptr);
             break;
-        case DEVICE_BIG_ENDIAN:
+        case MO_BE:
             val = ldq_be_p(ptr);
             break;
         default:
@@ -152,7 +152,7 @@ uint64_t glue(address_space_ldq_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     return glue(address_space_ldq_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                                    DEVICE_BIG_ENDIAN);
+                                                    MO_BE);
 }
 
 uint32_t glue(address_space_ldub, SUFFIX)(ARG1_DECL,
@@ -217,7 +217,7 @@ static inline uint32_t glue(address_space_lduw_internal, SUFFIX)(ARG1_DECL,
         case MO_LE:
             val = lduw_le_p(ptr);
             break;
-        case DEVICE_BIG_ENDIAN:
+        case MO_BE:
             val = lduw_be_p(ptr);
             break;
         default:
@@ -254,7 +254,7 @@ uint32_t glue(address_space_lduw_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, MemTxAttrs attrs, MemTxResult *result)
 {
     return glue(address_space_lduw_internal, SUFFIX)(ARG1, addr, attrs, result,
-                                       DEVICE_BIG_ENDIAN);
+                                       MO_BE);
 }
 
 /* warning: addr must be aligned. The ram page is not masked as dirty
@@ -321,7 +321,7 @@ static inline void glue(address_space_stl_internal, SUFFIX)(ARG1_DECL,
         case MO_LE:
             stl_le_p(ptr, val);
             break;
-        case DEVICE_BIG_ENDIAN:
+        case MO_BE:
             stl_be_p(ptr, val);
             break;
         default:
@@ -358,7 +358,7 @@ void glue(address_space_stl_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
 {
     glue(address_space_stl_internal, SUFFIX)(ARG1, addr, val, attrs,
-                                             result, DEVICE_BIG_ENDIAN);
+                                             result, MO_BE);
 }
 
 void glue(address_space_stb, SUFFIX)(ARG1_DECL,
@@ -417,7 +417,7 @@ static inline void glue(address_space_stw_internal, SUFFIX)(ARG1_DECL,
         case MO_LE:
             stw_le_p(ptr, val);
             break;
-        case DEVICE_BIG_ENDIAN:
+        case MO_BE:
             stw_be_p(ptr, val);
             break;
         default:
@@ -454,7 +454,7 @@ void glue(address_space_stw_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint32_t val, MemTxAttrs attrs, MemTxResult *result)
 {
     glue(address_space_stw_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                               DEVICE_BIG_ENDIAN);
+                               MO_BE);
 }
 
 static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
@@ -481,7 +481,7 @@ static void glue(address_space_stq_internal, SUFFIX)(ARG1_DECL,
         case MO_LE:
             stq_le_p(ptr, val);
             break;
-        case DEVICE_BIG_ENDIAN:
+        case MO_BE:
             stq_be_p(ptr, val);
             break;
         default:
@@ -518,7 +518,7 @@ void glue(address_space_stq_be, SUFFIX)(ARG1_DECL,
     hwaddr addr, uint64_t val, MemTxAttrs attrs, MemTxResult *result)
 {
     glue(address_space_stq_internal, SUFFIX)(ARG1, addr, val, attrs, result,
-                                             DEVICE_BIG_ENDIAN);
+                                             MO_BE);
 }
 
 #undef ARG1_DECL
-- 
2.23.0


