Return-Path: <SRS0=TdIk=BN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT,
	WEIRD_QUOTING autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85C6DC433DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:49:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4EDC0207DF
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2020 16:49:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aD6uXced"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4EDC0207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40616 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2deu-0003Q2-KV
	for qemu-devel@archiver.kernel.org; Mon, 03 Aug 2020 12:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51826)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k2dd1-0001AN-3Z; Mon, 03 Aug 2020 12:47:59 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:33570)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <edgar.iglesias@gmail.com>)
 id 1k2dcz-00081G-7N; Mon, 03 Aug 2020 12:47:58 -0400
Received: by mail-lj1-x241.google.com with SMTP id v4so30716307ljd.0;
 Mon, 03 Aug 2020 09:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=+GaW+fNRmBSUhIsokeJX0HIcwVIfHoIyE+CQVdEFwtM=;
 b=aD6uXced+4juhks4ZArh8hyZ4kUsvka8Dhn8zWxwqWrSeXKNJX9HDAm1m+MpsYWInF
 WfUyYIq5qGM7telEuY0PHJdNuQ/HcYTwGKYTHOkXjqNV+nuhlqJqR2f+PITQB/N7WxMM
 fDH2G+m935gesecYL5GcSw90kqTUSa4OPfHVCxZhOZFeAW22JFh9Nnx6YyEAWl7lA8g0
 0icfh1RzfXFhPF/FZ9evNjdXxqBYYknmYLDpYKJfiktY22S96Kl5XrR75c4paqMvSbjW
 y9ThEFDjo73fgazId0GuXG9GVdDJJYlnUaxZr/f0z9EJRUMl+HZbdtO9rHtN8vfbiSYY
 Hqyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=+GaW+fNRmBSUhIsokeJX0HIcwVIfHoIyE+CQVdEFwtM=;
 b=MYS3DbHdcls+Q/AiJpDMQvEeTmUjJglGe0M5THiP312ENygGn9hhHC6EDXzMRiQWZ2
 D7ptRVUR1gmFe9hLW2PPaaKutT9eoGEPicm/yDzlLlcnaKjcXCEpgBFn8ZH4MhIRMeLf
 PAfo83ZGIGdgCx38ab/CTGhBDh86UTZ9BDuScTp5NIw0aS6rvy3qoxf9/DxvO90FOxmk
 G71PYAD36HEEijwGKCnWkVjAdrhfzwFcZvFk6b0IKnXf7Nriz1oAk7Nzz2XZiqaRNP4x
 oX+D8kDLkBlLmUU7bObQXZouyNXE346c9Yq8rywuUdI18QI5eakiF2ghCA5DyRGTVYm1
 5NLQ==
X-Gm-Message-State: AOAM533jenrgiVv6Sgf5+B0PkgOuX5ZMjWez520pWTuGEyCsPhzXS8aa
 Oaq4C2Ec5jp9d37F7OPBMijNGmqX
X-Google-Smtp-Source: ABdhPJxgfYnjJ4VUcfG/CnG7wrIZsBRn4xWDc0cs8ZIBtTq4aP2qCsbhS5aVAvX2/4ugNJ4vkewkwQ==
X-Received: by 2002:a05:651c:88:: with SMTP id 8mr4799339ljq.277.1596473272315; 
 Mon, 03 Aug 2020 09:47:52 -0700 (PDT)
Received: from gmail.com (81-231-232-130-no39.tbcn.telia.com. [81.231.232.130])
 by smtp.gmail.com with ESMTPSA id n3sm4393482ljc.114.2020.08.03.09.47.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 09:47:51 -0700 (PDT)
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
To: qemu-devel@nongnu.org
Subject: [PATCH v1 1/1] docs/system/arm: Document the Xilinx Versal Virt board
Date: Mon,  3 Aug 2020 18:47:49 +0200
Message-Id: <20200803164749.301971-2-edgar.iglesias@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803164749.301971-1-edgar.iglesias@gmail.com>
References: <20200803164749.301971-1-edgar.iglesias@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::241;
 envelope-from=edgar.iglesias@gmail.com; helo=mail-lj1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 FSL_HELO_FAKE=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 WEIRD_QUOTING=0.001 autolearn=no autolearn_force=no
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
Cc: figlesia@xilinx.com, peter.maydell@linaro.org, sstabellini@kernel.org,
 edgar.iglesias@xilinx.com, sai.pavan.boddu@xilinx.com,
 frasse.iglesias@gmail.com, alistair@alistair23.me, frederic.konrad@adacore.com,
 qemu-arm@nongnu.org, philmd@redhat.com, luc.michel@greensocs.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>

Document the Xilinx Versal Virt board.

Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
---
 docs/system/arm/xlnx-versal-virt.rst | 176 +++++++++++++++++++++++++++
 docs/system/target-arm.rst           |   1 +
 MAINTAINERS                          |   3 +-
 3 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 docs/system/arm/xlnx-versal-virt.rst

diff --git a/docs/system/arm/xlnx-versal-virt.rst b/docs/system/arm/xlnx-versal-virt.rst
new file mode 100644
index 0000000000..2602d0f995
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
index 4c5b0e4aab..afdb37e738 100644
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
index 0886eb3d2b..5a22c8be42 100644
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
2.25.1


