Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06E8EC433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B35452071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 10:04:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oGPNDpsP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B35452071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49654 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA9LR-00031M-W9
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 06:04:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50216)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kA9Hc-0004JT-Mb
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:00:56 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:38871)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1kA9HZ-0006Vp-M6
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 06:00:56 -0400
Received: by mail-lj1-x243.google.com with SMTP id m22so8911913ljj.5
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 03:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IWN4qU12HS0woZTjIAIO7apv40KJIOmkEvFwnL+ngmU=;
 b=oGPNDpsPrJaYV8GziCVj79wvgMmdA9iZ4D1IsrjYO/Yel1ztGYUbCpJS6K7LJlTSsB
 Gyh7/8ONBB9O/e7N0rfCNI5lQKHeB9tPLfYXPNR8/FSXQeYxDdFF7X+nukKxocOn/lsr
 z7ejgtPMACqHwqCcm6KZVSBLqxUss5+2HgEspYRJ0U0wqQUr9O8KxHlU8aX/RNlBNAMM
 j0zmHZ6kD9kMZdBjk0k7niVJcqR8oV7depTvhTzoO40/3AUf3NgeE0MTYm7sjIVLusWV
 RiHIiUe1YnBBfOgjbXHMr2s3xd6XnO+am/mivES+jWljLgPveTwUK/6+8afRd/CNwIl1
 kNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=IWN4qU12HS0woZTjIAIO7apv40KJIOmkEvFwnL+ngmU=;
 b=Wz56StEIDIY/Jr0FMu1eYLc2gQjop7bPcFEMT0hTcjdGMs0wCtqZ7cmtZNFU2n/5xg
 V9BwjyaPj5gdgmYOKy6TqgTdIJlXiOgMSEgBO9l0OHtTL1JtdGrBjEOzjRD7LPWw5tRY
 cjSeldqt+8+Hgu24nhxsyOF8mElGBHQ7/kPMEPD7GK4WJKlJIFaXC/JetE3XBEoS5FEn
 QGcsV9+k2mhZs7cEtM90hOmGIvWt5HwLJtRJ2oIpg0JtFp6pdE5NP2rUS893xEjkrw1f
 mUaad4nZDazrRKZKDBDxOnIFLdKy6iCa/tcvQ1/9n63X5tOGOlJZkULpBJofS0yCKwRo
 cpaw==
X-Gm-Message-State: AOAM5319WPX4gvF94Ty1pSi0n/zCExCE9gdHiVqalDJVFxqmdz+JRzSF
 lrqsnCL4igWZRH+NeopLpZ6CGfCAE7Y=
X-Google-Smtp-Source: ABdhPJy31iBxj7am2WGBlVs9pq94D74thzMheDDbSBRgKKJ0utfBjxGfPWZ0HW76WcLs1o9LhZTcYg==
X-Received: by 2002:a05:651c:1069:: with SMTP id
 y9mr2323494ljm.438.1598263251045; 
 Mon, 24 Aug 2020 03:00:51 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id 1sm2087812ljr.6.2020.08.24.03.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 03:00:50 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PULL v1 7/8] microblaze: petalogix-ml605: Add device-tree source
Date: Mon, 24 Aug 2020 12:00:40 +0200
Message-Id: <20200824100041.1864420-8-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200824100041.1864420-1-edgar.iglesias@gmail.com>
References: <20200824100041.1864420-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::243;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x243.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=3.724, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: edgar.iglesias@xilinx.com, peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Add a device-tree source for petalogix-ml605 and recompile
the DTB.

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Acked-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 pc-bios/petalogix-ml605.dtb | Bin 9982 -> 9882 bytes
 pc-bios/petalogix-ml605.dts | 350 ++++++++++++++++++++++++++++++++++++
 2 files changed, 350 insertions(+)
 create mode 100644 pc-bios/petalogix-ml605.dts

diff --git a/pc-bios/petalogix-ml605.dtb b/pc-bios/petalogix-ml605.dtb
index fbbd45fdad06489c6333b6de868f44dfaed405bf..9a05434db7f622d1b598d2cf1415c867cf7f5cc6 100644
GIT binary patch
literal 9882
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
P8Y(N=^pc>DYv+Ffk0I_w

literal 9982
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

diff --git a/pc-bios/petalogix-ml605.dts b/pc-bios/petalogix-ml605.dts
new file mode 100644
index 0000000000..b307a29279
--- /dev/null
+++ b/pc-bios/petalogix-ml605.dts
@@ -0,0 +1,350 @@
+/*
+ * Copyright (c) 2020 Xilinx Inc.
+ * Written by Edgar E. Iglesias <edgar.iglesias@xilinx.com>.
+ *
+ * SPDX-License-Identifier:     GPL-2.0+
+ */
+
+/dts-v1/;
+
+/ {
+	#address-cells = < 0x01 >;
+	#size-cells = < 0x01 >;
+	compatible = "xlnx,microblaze";
+	model = "edk131";
+
+	memory@50000000 {
+		device_type = "memory";
+		reg = < 0x50000000 0x10000000 >;
+	};
+
+	aliases {
+		ethernet0 = "/axi/axi-ethernet@82780000";
+		serial0 = "/axi/serial@83e00000";
+	};
+
+	chosen {
+		bootargs = " console=ttyS0,115200 ";
+		stdout-path = "/axi/serial@83e00000";
+	};
+
+	cpus {
+		#address-cells = < 0x01 >;
+		#cpus = < 0x01 >;
+		#size-cells = < 0x00 >;
+
+		cpu@0 {
+			clock-frequency = < 0xbebc200 >;
+			compatible = "xlnx,microblaze-8.10.a";
+			d-cache-baseaddr = < 0x50000000 >;
+			d-cache-highaddr = < 0x5fffffff >;
+			d-cache-line-size = < 0x20 >;
+			d-cache-size = < 0x800 >;
+			device_type = "cpu";
+			i-cache-baseaddr = < 0x50000000 >;
+			i-cache-highaddr = < 0x5fffffff >;
+			i-cache-line-size = < 0x20 >;
+			i-cache-size = < 0x800 >;
+			model = "microblaze,8.10.a";
+			reg = < 0x00 >;
+			timebase-frequency = < 0xbebc200 >;
+			xlnx,addr-tag-bits = < 0x11 >;
+			xlnx,allow-dcache-wr = < 0x01 >;
+			xlnx,allow-icache-wr = < 0x01 >;
+			xlnx,area-optimized = < 0x00 >;
+			xlnx,branch-target-cache-size = < 0x00 >;
+			xlnx,cache-byte-size = < 0x800 >;
+			xlnx,d-axi = < 0x01 >;
+			xlnx,d-lmb = < 0x01 >;
+			xlnx,d-plb = < 0x00 >;
+			xlnx,data-size = < 0x20 >;
+			xlnx,dcache-addr-tag = < 0x11 >;
+			xlnx,dcache-always-used = < 0x01 >;
+			xlnx,dcache-byte-size = < 0x800 >;
+			xlnx,dcache-data-width = < 0x00 >;
+			xlnx,dcache-force-tag-lutram = < 0x00 >;
+			xlnx,dcache-interface = < 0x01 >;
+			xlnx,dcache-line-len = < 0x08 >;
+			xlnx,dcache-use-fsl = < 0x00 >;
+			xlnx,dcache-use-writeback = < 0x01 >;
+			xlnx,dcache-victims = < 0x00 >;
+			xlnx,debug-enabled = < 0x01 >;
+			xlnx,div-zero-exception = < 0x01 >;
+			xlnx,dynamic-bus-sizing = < 0x01 >;
+			xlnx,ecc-use-ce-exception = < 0x00 >;
+			xlnx,edge-is-positive = < 0x01 >;
+			xlnx,endianness = < 0x01 >;
+			xlnx,family = "virtex6";
+			xlnx,fault-tolerant = < 0x00 >;
+			xlnx,fpu-exception = < 0x01 >;
+			xlnx,freq = < 0xbebc200 >;
+			xlnx,fsl-data-size = < 0x20 >;
+			xlnx,fsl-exception = < 0x00 >;
+			xlnx,fsl-links = < 0x00 >;
+			xlnx,i-axi = < 0x01 >;
+			xlnx,i-lmb = < 0x01 >;
+			xlnx,i-plb = < 0x00 >;
+			xlnx,icache-always-used = < 0x01 >;
+			xlnx,icache-data-width = < 0x00 >;
+			xlnx,icache-force-tag-lutram = < 0x00 >;
+			xlnx,icache-interface = < 0x00 >;
+			xlnx,icache-line-len = < 0x08 >;
+			xlnx,icache-streams = < 0x00 >;
+			xlnx,icache-use-fsl = < 0x00 >;
+			xlnx,icache-victims = < 0x00 >;
+			xlnx,ill-opcode-exception = < 0x01 >;
+			xlnx,instance = "microblaze_0";
+			xlnx,interconnect = < 0x02 >;
+			xlnx,interrupt-is-edge = < 0x00 >;
+			xlnx,mmu-dtlb-size = < 0x04 >;
+			xlnx,mmu-itlb-size = < 0x02 >;
+			xlnx,mmu-privileged-instr = < 0x00 >;
+			xlnx,mmu-tlb-access = < 0x03 >;
+			xlnx,mmu-zones = < 0x02 >;
+			xlnx,number-of-pc-brk = < 0x01 >;
+			xlnx,number-of-rd-addr-brk = < 0x00 >;
+			xlnx,number-of-wr-addr-brk = < 0x00 >;
+			xlnx,opcode-0x0-illegal = < 0x01 >;
+			xlnx,optimization = < 0x00 >;
+			xlnx,pvr = < 0x02 >;
+			xlnx,pvr-user1 = < 0x00 >;
+			xlnx,pvr-user2 = < 0x00 >;
+			xlnx,reset-msr = < 0x00 >;
+			xlnx,sco = < 0x00 >;
+			xlnx,stream-interconnect = < 0x00 >;
+			xlnx,unaligned-exceptions = < 0x01 >;
+			xlnx,use-barrel = < 0x01 >;
+			xlnx,use-branch-target-cache = < 0x00 >;
+			xlnx,use-dcache = < 0x01 >;
+			xlnx,use-div = < 0x01 >;
+			xlnx,use-ext-brk = < 0x01 >;
+			xlnx,use-ext-nm-brk = < 0x01 >;
+			xlnx,use-extended-fsl-instr = < 0x00 >;
+			xlnx,use-fpu = < 0x01 >;
+			xlnx,use-hw-mul = < 0x02 >;
+			xlnx,use-icache = < 0x01 >;
+			xlnx,use-interrupt = < 0x01 >;
+			xlnx,use-mmu = < 0x03 >;
+			xlnx,use-msr-instr = < 0x01 >;
+			xlnx,use-pcmp-instr = < 0x01 >;
+			xlnx,use-stack-protection = < 0x00 >;
+		};
+	};
+
+	axi {
+		#address-cells = < 0x01 >;
+		#size-cells = < 0x01 >;
+		compatible = "xlnx,axi-interconnect-1.02.a\0simple-bus";
+		ranges;
+
+		axi-ethernet@82780000 {
+			axistream-connected = < &axi_dma >;
+			compatible = "xlnx,axi-ethernet-2.01.a\0xlnx,axi-ethernet-1.00.a";
+			device_type = "network";
+			interrupt-parent = < &intc >;
+			interrupts = < 0x03 0x02 >;
+			local-mac-address = [ 00 0a 35 00 22 01 ];
+			phy-handle = < &phy7 >;
+			reg = < 0x82780000 0x40000 >;
+			xlnx,avb = < 0x00 >;
+			xlnx,halfdup = < 0x00 >;
+			xlnx,include-io = < 0x01 >;
+			xlnx,mcast-extend = < 0x00 >;
+			xlnx,phy-type = < 0x01 >;
+			xlnx,phyaddr = "0B00001";
+			xlnx,rxcsum = < 0x00 >;
+			xlnx,rxmem = < 0x1000 >;
+			xlnx,rxvlan-strp = < 0x00 >;
+			xlnx,rxvlan-tag = < 0x00 >;
+			xlnx,rxvlan-tran = < 0x00 >;
+			xlnx,stats = < 0x00 >;
+			xlnx,txcsum = < 0x00 >;
+			xlnx,txmem = < 0x1000 >;
+			xlnx,txvlan-strp = < 0x00 >;
+			xlnx,txvlan-tag = < 0x00 >;
+			xlnx,txvlan-tran = < 0x00 >;
+			xlnx,type = < 0x02 >;
+
+			mdio {
+				#address-cells = < 0x01 >;
+				#size-cells = < 0x00 >;
+
+				phy7: phy@7 {
+					compatible = "marvell,88e1111";
+					device_type = "ethernet-phy";
+					reg = < 0x07 >;
+				};
+			};
+		};
+
+		axi_dma: axi-dma@84600000 {
+			compatible = "xlnx,axi-dma-3.00.a";
+			interrupt-parent = < &intc >;
+			interrupts = < 0x01 0x02 0x00 0x02 >;
+			reg = < 0x84600000 0x10000 >;
+			xlnx,dlytmr-resolution = < 0x4e2 >;
+			xlnx,family = "virtex6";
+			xlnx,include-mm2s = < 0x01 >;
+			xlnx,include-mm2s-dre = < 0x01 >;
+			xlnx,include-s2mm = < 0x01 >;
+			xlnx,include-s2mm-dre = < 0x01 >;
+			xlnx,mm2s-burst-size = < 0x10 >;
+			xlnx,prmry-is-aclk-async = < 0x00 >;
+			xlnx,s2mm-burst-size = < 0x10 >;
+			xlnx,sg-include-desc-queue = < 0x01 >;
+			xlnx,sg-include-stscntrl-strm = < 0x01 >;
+			xlnx,sg-length-width = < 0x10 >;
+			xlnx,sg-use-stsapp-length = < 0x01 >;
+		};
+
+		serial@83e00000 {
+			clock-frequency = < 0x5f5e100 >;
+			compatible = "xlnx,axi-uart16550-1.01.a\0xlnx,xps-uart16550-2.00.a\0ns16550a";
+			current-speed = < 0x2580 >;
+			device_type = "serial";
+			interrupt-parent = < &intc >;
+			interrupts = < 0x05 0x02 >;
+			reg = < 0x83e00000 0x10000 >;
+			reg-offset = < 0x1000 >;
+			reg-shift = < 0x02 >;
+			xlnx,external-xin-clk-hz = < 0x17d7840 >;
+			xlnx,family = "virtex6";
+			xlnx,has-external-rclk = < 0x00 >;
+			xlnx,has-external-xin = < 0x00 >;
+			xlnx,is-a-16550 = < 0x01 >;
+			xlnx,use-modem-ports = < 0x00 >;
+			xlnx,use-user-ports = < 0x00 >;
+		};
+
+		system-timer@83c00000 {
+			clock-frequency = < 0x5f5e100 >;
+			compatible = "xlnx,axi-timer-1.01.a\0xlnx,xps-timer-1.00.a";
+			interrupt-parent = < &intc >;
+			interrupts = < 0x02 0x00 >;
+			reg = < 0x83c00000 0x10000 >;
+			xlnx,count-width = < 0x20 >;
+			xlnx,family = "virtex6";
+			xlnx,gen0-assert = < 0x01 >;
+			xlnx,gen1-assert = < 0x01 >;
+			xlnx,one-timer-only = < 0x00 >;
+			xlnx,trig0-assert = < 0x01 >;
+			xlnx,trig1-assert = < 0x01 >;
+		};
+
+		intc: interrupt-controller@81800000 {
+			#interrupt-cells = < 0x02 >;
+			compatible = "xlnx,axi-intc-1.01.a\0xlnx,xps-intc-1.00.a";
+			interrupt-controller;
+			reg = < 0x81800000 0x10000 >;
+			xlnx,kind-of-intr = < 0x04 >;
+			xlnx,num-intr-inputs = < 0x06 >;
+		};
+
+		flash@86000000 {
+			#address-cells = < 0x01 >;
+			#size-cells = < 0x01 >;
+			bank-width = < 0x02 >;
+			compatible = "xlnx,axi-emc-1.01.a\0cfi-flash";
+			reg = < 0x86000000 0x2000000 >;
+			xlnx,axi-clk-period-ps = < 0x2710 >;
+			xlnx,family = "virtex6";
+			xlnx,include-datawidth-matching-0 = < 0x01 >;
+			xlnx,include-datawidth-matching-1 = < 0x00 >;
+			xlnx,include-datawidth-matching-2 = < 0x00 >;
+			xlnx,include-datawidth-matching-3 = < 0x00 >;
+			xlnx,include-negedge-ioregs = < 0x00 >;
+			xlnx,max-mem-width = < 0x10 >;
+			xlnx,mem0-type = < 0x02 >;
+			xlnx,mem0-width = < 0x10 >;
+			xlnx,mem1-type = < 0x00 >;
+			xlnx,mem1-width = < 0x20 >;
+			xlnx,mem2-type = < 0x00 >;
+			xlnx,mem2-width = < 0x20 >;
+			xlnx,mem3-type = < 0x00 >;
+			xlnx,mem3-width = < 0x20 >;
+			xlnx,num-banks-mem = < 0x01 >;
+			xlnx,parity-type-mem-0 = < 0x00 >;
+			xlnx,parity-type-mem-1 = < 0x00 >;
+			xlnx,parity-type-mem-2 = < 0x00 >;
+			xlnx,parity-type-mem-3 = < 0x00 >;
+			xlnx,s-axi-en-reg = < 0x00 >;
+			xlnx,s-axi-mem-addr-width = < 0x20 >;
+			xlnx,s-axi-mem-data-width = < 0x20 >;
+			xlnx,s-axi-mem-id-width = < 0x01 >;
+			xlnx,s-axi-mem-protocol = "AXI4LITE";
+			xlnx,s-axi-reg-addr-width = < 0x20 >;
+			xlnx,s-axi-reg-data-width = < 0x20 >;
+			xlnx,s-axi-reg-protocol = "axi4";
+			xlnx,synch-pipedelay-0 = < 0x02 >;
+			xlnx,synch-pipedelay-1 = < 0x02 >;
+			xlnx,synch-pipedelay-2 = < 0x02 >;
+			xlnx,synch-pipedelay-3 = < 0x02 >;
+			xlnx,tavdv-ps-mem-0 = < 0x1fbd0 >;
+			xlnx,tavdv-ps-mem-1 = < 0x3a98 >;
+			xlnx,tavdv-ps-mem-2 = < 0x3a98 >;
+			xlnx,tavdv-ps-mem-3 = < 0x3a98 >;
+			xlnx,tcedv-ps-mem-0 = < 0x1fbd0 >;
+			xlnx,tcedv-ps-mem-1 = < 0x3a98 >;
+			xlnx,tcedv-ps-mem-2 = < 0x3a98 >;
+			xlnx,tcedv-ps-mem-3 = < 0x3a98 >;
+			xlnx,thzce-ps-mem-0 = < 0x88b8 >;
+			xlnx,thzce-ps-mem-1 = < 0x1b58 >;
+			xlnx,thzce-ps-mem-2 = < 0x1b58 >;
+			xlnx,thzce-ps-mem-3 = < 0x1b58 >;
+			xlnx,thzoe-ps-mem-0 = < 0x1b58 >;
+			xlnx,thzoe-ps-mem-1 = < 0x1b58 >;
+			xlnx,thzoe-ps-mem-2 = < 0x1b58 >;
+			xlnx,thzoe-ps-mem-3 = < 0x1b58 >;
+			xlnx,tlzwe-ps-mem-0 = < 0x88b8 >;
+			xlnx,tlzwe-ps-mem-1 = < 0x00 >;
+			xlnx,tlzwe-ps-mem-2 = < 0x00 >;
+			xlnx,tlzwe-ps-mem-3 = < 0x00 >;
+			xlnx,tpacc-ps-flash-0 = < 0x61a8 >;
+			xlnx,tpacc-ps-flash-1 = < 0x61a8 >;
+			xlnx,tpacc-ps-flash-2 = < 0x61a8 >;
+			xlnx,tpacc-ps-flash-3 = < 0x61a8 >;
+			xlnx,twc-ps-mem-0 = < 0x32c8 >;
+			xlnx,twc-ps-mem-1 = < 0x3a98 >;
+			xlnx,twc-ps-mem-2 = < 0x3a98 >;
+			xlnx,twc-ps-mem-3 = < 0x3a98 >;
+			xlnx,twp-ps-mem-0 = < 0x11170 >;
+			xlnx,twp-ps-mem-1 = < 0x2ee0 >;
+			xlnx,twp-ps-mem-2 = < 0x2ee0 >;
+			xlnx,twp-ps-mem-3 = < 0x2ee0 >;
+			xlnx,twph-ps-mem-0 = < 0x2ee0 >;
+			xlnx,twph-ps-mem-1 = < 0x2ee0 >;
+			xlnx,twph-ps-mem-2 = < 0x2ee0 >;
+			xlnx,twph-ps-mem-3 = < 0x2ee0 >;
+
+			partition@0 {
+				label = "fpga";
+				reg = < 0x00 0x100000 >;
+			};
+
+			partition@100000 {
+				label = "boot";
+				reg = < 0x100000 0x40000 >;
+			};
+
+			partition@140000 {
+				label = "bootenv";
+				reg = < 0x140000 0x20000 >;
+			};
+
+			partition@160000 {
+				label = "config";
+				reg = < 0x160000 0x20000 >;
+			};
+
+			partition@180000 {
+				label = "image";
+				reg = < 0x180000 0xa00000 >;
+			};
+
+			partition@b80000 {
+				label = "spare";
+				reg = < 0xb80000 0x00 >;
+			};
+		};
+	};
+};
-- 
2.25.1


