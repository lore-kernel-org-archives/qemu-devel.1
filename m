Return-Path: <SRS0=JPH5=CC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ABCD3C433E1
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:50:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 717812071E
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Aug 2020 09:50:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Lw8I+PcT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 717812071E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kA97m-0001JU-Eh
	for qemu-devel@archiver.kernel.org; Mon, 24 Aug 2020 05:50:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46818)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95e-00056J-1Q
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:34 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:35030)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kA95a-0004nl-Jk
 for qemu-devel@nongnu.org; Mon, 24 Aug 2020 05:48:33 -0400
Received: by mail-wr1-x444.google.com with SMTP id b17so7217696wru.2
 for <qemu-devel@nongnu.org>; Mon, 24 Aug 2020 02:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=nj/jVd48Yy5aWXuxg27tOObzp4JLkxMOKbL7+qjvNT8=;
 b=Lw8I+PcTCJaQxUJUkvIA9teZ8/4b2LgVodn6EnSF8HXKsDIGI/BlCXfbYo1HzdRp1T
 0U6pKr05xyv8gopfs8geB4lty81gkgdJDjwmNo4qeeFtzTiJUuh0kkXaobuu4v/pWtr5
 lkUUtKQ48xn77vLaXqg0fuO2EGZsdsiO6LpncALVq6fKr4hOXBgBAsSXHCXnFnf227wF
 98tyb5kobzT6QhnkiXxTM9avymz+UsH2033PPLymyN4qPC7Eb7s6Is5zknCkaa05yu0k
 8UAjX6v6d8tyVBUPOaW5GzoNEdYwVooP401zYLF1i2tyDBQs0eU/4jJrJQoPuDlulP+w
 fb6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=nj/jVd48Yy5aWXuxg27tOObzp4JLkxMOKbL7+qjvNT8=;
 b=G1s02of+Mk6FHz88fiB3Y/+4uAcYawvyAw1W349Nikhr2pfJCOjRBPl568v2k+hS0U
 XEtPpvbSbimn8EbaLWLjPnvgg3IZ0PluGJTI3rsLFh8KSg2O/nY1g5w9J12tqM5V9hxE
 byuMAaOKX2YKeO2AhtwCjDODBGg1r5REau4/VnII87Mz8/q5/o9FtQoWsUqMhe9dXV5x
 oA81kMsB5R9I5k/Os4X1PjBP3uw8hdbG+md5V143OBIVNZX0x8F5bDzrXVYwHOn2Z5rN
 74TSVwuC49YjMm7EEQzfahGUF1lmcOXM970nWy5JFCz/41sHFLP/rJhWxU1WJedIVMOM
 Oavg==
X-Gm-Message-State: AOAM531qaDBOSU1SguOzi4dex/n3fnrYoZUutFONukbpJBnLuGhLiNtN
 E4QMNXClSvhjjufGuS+mX6tSY7k+YOUw9s/m
X-Google-Smtp-Source: ABdhPJzAEFMZBW5DdSBcAaK3tYEUt88dsoORNFgCz6cajvAYK2J9c8p16vCsTk9//YUZxay2vU+3Mg==
X-Received: by 2002:adf:f007:: with SMTP id j7mr4745958wro.195.1598262508816; 
 Mon, 24 Aug 2020 02:48:28 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id q6sm24877057wma.22.2020.08.24.02.48.27
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 24 Aug 2020 02:48:28 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 13/27] docs/system/arm: Document the Xilinx Versal Virt board
Date: Mon, 24 Aug 2020 10:47:57 +0100
Message-Id: <20200824094811.15439-14-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200824094811.15439-1-peter.maydell@linaro.org>
References: <20200824094811.15439-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=peter.maydell@linaro.org; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 WEIRD_QUOTING=0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Document the Xilinx Versal Virt board.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Message-id: 20200803164749.301971-2-edgar.iglesias@gmail.com
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 docs/system/arm/xlnx-versal-virt.rst | 176 +++++++++++++++++++++++++++
 docs/system/target-arm.rst           |   1 +
 MAINTAINERS                          |   3 +-
 3 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/arm/xlnx-versal-virt.rst

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
new file mode 100644
index 00000000000..2602d0f9953
--- /dev/null
+++ b/docs/system/arm/xlnx-versal-virt.rst
@@ -0,0 +1,176 @@
+Xilinx Versal Virt (``xlnx-versal-virt``)
+=========================================
+
+Xilinx Versal is a family of heterogeneous multi-core SoCs
+(System on Chip) that combine traditional hardened CPUs and I/O
+peripherals in a Processing System (PS) with runtime programmable
+FPGA logic (PL) and an Artificial Intelligence Engine (AIE).
+
+More details here:
+https://www.xilinx.com/products/silicon-devices/acap/versal.html
+
+The family of Versal SoCs share a single architecture but come in
+different parts with different speed grades, amounts of PL and
+other differences.
+
+The Xilinx Versal Virt board in QEMU is a model of a virtual board
+(does not exist in reality) with a virtual Versal SoC without I/O
+limitations. Currently, we support the following cores and devices:
+
+Implemented CPU cores:
+
+- 2 ACPUs (ARM Cortex-A72)
+
+Implemented devices:
+
+- Interrupt controller (ARM GICv3)
+- 2 UARTs (ARM PL011)
+- An RTC (Versal built-in)
+- 2 GEMs (Cadence MACB Ethernet MACs)
+- 8 ADMA (Xilinx zDMA) channels
+- 2 SD Controllers
+- OCM (256KB of On Chip Memory)
+- DDR memory
+
+QEMU does not yet model any other devices, including the PL and the AI Engine.
+
+Other differences between the hardware and the QEMU model:
+
+- QEMU allows the amount of DDR memory provided to be specified with the
+  ``-m`` argument. If a DTB is provided on the command line then QEMU will
+  edit it to include suitable entries describing the Versal DDR memory ranges.
+
+- QEMU provides 8 virtio-mmio virtio transports; these start at
+  address ``0xa0000000`` and have IRQs from 111 and upwards.
+
+Running
+"""""""
+If the user provides an Operating System to be loaded, we expect users
+to use the ``-kernel`` command line option.
+
+Users can load firmware or boot-loaders with the ``-device loader`` options.
+
+When loading an OS, QEMU generates a DTB and selects an appropriate address
+where it gets loaded. This DTB will be passed to the kernel in register x0.
+
+If there's no ``-kernel`` option, we generate a DTB and place it at 0x1000
+for boot-loaders or firmware to pick it up.
+
+If users want to provide their own DTB, they can use the ``-dtb`` option.
+These DTBs will have their memory nodes modified to match QEMU's
+selected ram_size option before they get passed to the kernel or FW.
+
+When loading an OS, we turn on QEMU's PSCI implementation with SMC
+as the PSCI conduit. When there's no ``-kernel`` option, we assume the user
+provides EL3 firmware to handle PSCI.
+
+A few examples:
+
+Direct Linux boot of a generic ARM64 upstream Linux kernel:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M xlnx-versal-virt -m 2G \
+      -serial mon:stdio -display none \
+      -kernel arch/arm64/boot/Image \
+      -nic user -nic user \
+      -device virtio-rng-device,bus=virtio-mmio-bus.0 \
+      -drive if=none,index=0,file=hd0.qcow2,id=hd0,snapshot \
+      -drive file=qemu_sd.qcow2,if=sd,index=0,snapshot \
+      -device virtio-blk-device,drive=hd0 -append root=/dev/vda
+
+Direct Linux boot of PetaLinux 2019.2:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64  -M xlnx-versal-virt -m 2G \
+      -serial mon:stdio -display none \
+      -kernel petalinux-v2019.2/Image \
+      -append "rdinit=/sbin/init console=ttyAMA0,115200n8 earlycon=pl011,mmio,0xFF000000,115200n8" \
+      -net nic,model=cadence_gem,netdev=net0 -netdev user,id=net0 \
+      -device virtio-rng-device,bus=virtio-mmio-bus.0,rng=rng0 \
+      -object rng-random,filename=/dev/urandom,id=rng0
+
+Boot PetaLinux 2019.2 via ARM Trusted Firmware (2018.3 because the 2019.2
+version of ATF tries to configure the CCI which we don't model) and U-boot:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M xlnx-versal-virt -m 2G \
+      -serial stdio -display none \
+      -device loader,file=petalinux-v2018.3/bl31.elf,cpu-num=0 \
+      -device loader,file=petalinux-v2019.2/u-boot.elf \
+      -device loader,addr=0x20000000,file=petalinux-v2019.2/Image \
+      -nic user -nic user \
+      -device virtio-rng-device,bus=virtio-mmio-bus.0,rng=rng0 \
+      -object rng-random,filename=/dev/urandom,id=rng0
+
+Run the following at the U-Boot prompt:
+
+.. code-block:: bash
+
+  Versal>
+  fdt addr $fdtcontroladdr
+  fdt move $fdtcontroladdr 0x40000000
+  fdt set /timer clock-frequency <0x3dfd240>
+  setenv bootargs "rdinit=/sbin/init maxcpus=1 console=ttyAMA0,115200n8 earlycon=pl011,mmio,0xFF000000,115200n8"
+  booti 20000000 - 40000000
+  fdt addr $fdtcontroladdr
+
+Boot Linux as DOM0 on Xen via U-Boot:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M xlnx-versal-virt -m 4G \
+      -serial stdio -display none \
+      -device loader,file=petalinux-v2019.2/u-boot.elf,cpu-num=0 \
+      -device loader,addr=0x30000000,file=linux/2018-04-24/xen \
+      -device loader,addr=0x40000000,file=petalinux-v2019.2/Image \
+      -nic user -nic user \
+      -device virtio-rng-device,bus=virtio-mmio-bus.0,rng=rng0 \
+      -object rng-random,filename=/dev/urandom,id=rng0
+
+Run the following at the U-Boot prompt:
+
+.. code-block:: bash
+
+  Versal>
+  fdt addr $fdtcontroladdr
+  fdt move $fdtcontroladdr 0x20000000
+  fdt set /timer clock-frequency <0x3dfd240>
+  fdt set /chosen xen,xen-bootargs "console=dtuart dtuart=/uart@ff000000 dom0_mem=640M bootscrub=0 maxcpus=1 timer_slop=0"
+  fdt set /chosen xen,dom0-bootargs "rdinit=/sbin/init clk_ignore_unused console=hvc0 maxcpus=1"
+  fdt mknode /chosen dom0
+  fdt set /chosen/dom0 compatible "xen,multiboot-module"
+  fdt set /chosen/dom0 reg <0x00000000 0x40000000 0x0 0x03100000>
+  booti 30000000 - 20000000
+
+Boot Linux as Dom0 on Xen via ARM Trusted Firmware and U-Boot:
+
+.. code-block:: bash
+
+  $ qemu-system-aarch64 -M xlnx-versal-virt -m 4G \
+      -serial stdio -display none \
+      -device loader,file=petalinux-v2018.3/bl31.elf,cpu-num=0 \
+      -device loader,file=petalinux-v2019.2/u-boot.elf \
+      -device loader,addr=0x30000000,file=linux/2018-04-24/xen \
+      -device loader,addr=0x40000000,file=petalinux-v2019.2/Image \
+      -nic user -nic user \
+      -device virtio-rng-device,bus=virtio-mmio-bus.0,rng=rng0 \
+      -object rng-random,filename=/dev/urandom,id=rng0
+
+Run the following at the U-Boot prompt:
+
+.. code-block:: bash
+
+  Versal>
+  fdt addr $fdtcontroladdr
+  fdt move $fdtcontroladdr 0x20000000
+  fdt set /timer clock-frequency <0x3dfd240>
+  fdt set /chosen xen,xen-bootargs "console=dtuart dtuart=/uart@ff000000 dom0_mem=640M bootscrub=0 maxcpus=1 timer_slop=0"
+  fdt set /chosen xen,dom0-bootargs "rdinit=/sbin/init clk_ignore_unused console=hvc0 maxcpus=1"
+  fdt mknode /chosen dom0
+  fdt set /chosen/dom0 compatible "xen,multiboot-module"
+  fdt set /chosen/dom0 reg <0x00000000 0x40000000 0x0 0x03100000>
+  booti 30000000 - 20000000
+
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 4c5b0e4aab8..afdb37e7384 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -93,6 +93,7 @@ undocumented; you can get a complete list by running
    arm/sx1
    arm/stellaris
    arm/virt
+   arm/xlnx-versal-virt
 
 Arm CPU features
 ================
diff --git a/MAINTAINERS b/MAINTAINERS
index 0886eb3d2b5..5a22c8be429 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -894,7 +894,7 @@ F: hw/misc/zynq*
 F: include/hw/misc/zynq*
 X: hw/ssi/xilinx_*
 
-Xilinx ZynqMP
+Xilinx ZynqMP and Versal
 M: Alistair Francis <alistair@alistair23.me>
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
 M: Peter Maydell <peter.maydell@linaro.org>
@@ -905,6 +905,7 @@ F: include/hw/*/xlnx*.h
 F: include/hw/ssi/xilinx_spips.h
 F: hw/display/dpcd.c
 F: include/hw/display/dpcd.h
+F: docs/system/arm/xlnx-versal-virt.rst
 
 ARM ACPI Subsystem
 M: Shannon Zhao <shannon.zhaosl@gmail.com>
-- 
2.20.1


