Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	WEIRD_QUOTING autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC62AC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 770E120729
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 13:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bDBzZS35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 770E120729
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43558 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxVUf-0007aE-QG
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 09:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55880)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLW-0002h8-6t
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:42 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:52698)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxVLU-0007KE-3q
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 08:56:41 -0400
Received: by mail-wm1-x344.google.com with SMTP id q15so22181836wmj.2
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 05:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:subject:date:message-id:in-reply-to:references:mime-version
 :content-transfer-encoding;
 bh=rJ7cE2x8DPLfwJ7CxRfCKU0ZON3qasEBbPNKnMHWUS8=;
 b=bDBzZS35WqZvQQb9wMjGd4SYzHfl8UTOJxG11qsZgRkzuehrG8HKYhNOt81g3/v/tS
 R9zaRFoEQSfzdlarb4+gymkB8FtOf7yep6pqxRr1Vadz16eQeaHfB/rh/FxUWa7iOv8Z
 DwleBfkckoTRF50CTA29qmBWRWPsb9VIsUtJjmtwu7wIRGZNwbWdhfmTTgsNOuQWI2bz
 lUbl8Hd0D0raTocASvZMAug4CZ/Zo3Y/Uka7U7CfNRiPLY/F+YG6b72euI3UHdirTCzu
 GmxEC2n2I+Yq03VgRk7ONyFczzoffBKW8crnC7gbkD8bvA+rgq1ORdk0I5sXDJsmgIZ/
 d10A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=rJ7cE2x8DPLfwJ7CxRfCKU0ZON3qasEBbPNKnMHWUS8=;
 b=BhQM52niDuo8JI88EnGgV0zODLl1wjgai6wM3OSEdL3EZGYBDga8KMR99RjHdsNdf9
 9WM9Ah077HlVQ3GJTd/hsYmh83jfqRZc6BPQiW/Bj86bTVFfGQgXhtoWV6e8xpS/pyu5
 4PUWZEckMPh2aIyMFPpF5mxNRMjsf01HFqMP2UFrl+TzRoZPiEdlAfif1wnH2iIP9Jr9
 cvf3dLLIQHFdpvj2z7L3tL3i4IWmQc6TwPOmu5Db4QBkZs6QvXiyw9hydjkF8d7Skdkt
 HDaK8kZvtARBeYfUaXoQksdPq2FSGLfAHirIP+XH8lLKIi8TgJkVa2+6IkTKabyMQfo+
 NWaw==
X-Gm-Message-State: AOAM5320C3KIYXnZh31G7OttveRaKDUHYeJwJV+nn0+Fb1/wVPmeVHQa
 puYab9msI/wFRRvngj2LgAqJCmC9SMn1Pw==
X-Google-Smtp-Source: ABdhPJwtK7z2ZKH0hU1aQbijeIY7lZ8vuNY1ReDU9cWVewUwHWU0Fls/erDhm5uLsn3CO1YMVTcuGA==
X-Received: by 2002:a05:600c:2949:: with SMTP id
 n9mr20589095wmd.69.1595249798244; 
 Mon, 20 Jul 2020 05:56:38 -0700 (PDT)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [81.2.115.148])
 by smtp.gmail.com with ESMTPSA id p29sm34025403wmi.43.2020.07.20.05.56.37
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jul 2020 05:56:37 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Subject: [PULL 12/12] docs/system: Document the arm virt board
Date: Mon, 20 Jul 2020 13:56:21 +0100
Message-Id: <20200720125621.13460-13-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200720125621.13460-1-peter.maydell@linaro.org>
References: <20200720125621.13460-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::344;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x344.google.com
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

Document the arm 'virt' board, which has been undocumented
for far too long given that it is the main recommended board
type for arm guests.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
Message-id: 20200713175746.5936-5-peter.maydell@linaro.org
---
 docs/system/arm/virt.rst   | 161 +++++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst |   1 +
 MAINTAINERS                |   1 +
 3 files changed, 163 insertions(+)
 create mode 100644 docs/system/arm/virt.rst

diff --git a/docs/system/arm/virt.rst b/docs/system/arm/virt.rst
new file mode 100644
index 00000000000..6621ab7205d
--- /dev/null
+++ b/docs/system/arm/virt.rst
@@ -0,0 +1,161 @@
+'virt' generic virtual platform (``virt``)
+==========================================
+
+The `virt` board is a platform which does not correspond to any
+real hardware; it is designed for use in virtual machines.
+It is the recommended board type if you simply want to run
+a guest such as Linux and do not care about reproducing the
+idiosyncrasies and limitations of a particular bit of real-world
+hardware.
+
+This is a "versioned" board model, so as well as the ``virt`` machine
+type itself (which may have improvements, bugfixes and other minor
+changes between QEMU versions) a version is provided that guarantees
+to have the same behaviour as that of previous QEMU releases, so
+that VM migration will work between QEMU versions. For instance the
+``virt-5.0`` machine type will behave like the ``virt`` machine from
+the QEMU 5.0 release, and migration should work between ``virt-5.0``
+of the 5.0 release and ``virt-5.0`` of the 5.1 release. Migration
+is not guaranteed to work between different QEMU releases for
+the non-versioned ``virt`` machine type.
+
+Supported devices
+"""""""""""""""""
+
+The virt board supports:
+
+- PCI/PCIe devices
+- Flash memory
+- One PL011 UART
+- An RTC
+- The fw_cfg device that allows a guest to obtain data from QEMU
+- A PL061 GPIO controller
+- An optional SMMUv3 IOMMU
+- hotpluggable DIMMs
+- hotpluggable NVDIMMs
+- An MSI controller (GICv2M or ITS). GICv2M is selected by default along
+  with GICv2. ITS is selected by default with GICv3 (>= virt-2.7). Note
+  that ITS is not modeled in TCG mode.
+- 32 virtio-mmio transport devices
+- running guests using the KVM accelerator on aarch64 hardware
+- large amounts of RAM (at least 255GB, and more if using highmem)
+- many CPUs (up to 512 if using a GICv3 and highmem)
+- Secure-World-only devices if the CPU has TrustZone:
+
+  - A second PL011 UART
+  - A secure flash memory
+  - 16MB of secure RAM
+
+Supported guest CPU types:
+
+- ``cortex-a7`` (32-bit)
+- ``cortex-a15`` (32-bit; the default)
+- ``cortex-a53`` (64-bit)
+- ``cortex-a57`` (64-bit)
+- ``cortex-a72`` (64-bit)
+- ``host`` (with KVM only)
+- ``max`` (same as ``host`` for KVM; best possible emulation with TCG)
+
+Note that the default is ``cortex-a15``, so for an AArch64 guest you must
+specify a CPU type.
+
+Graphics output is available, but unlike the x86 PC machine types
+there is no default display device enabled: you should select one from
+the Display devices section of "-device help". The recommended option
+is ``virtio-gpu-pci``; this is the only one which will work correctly
+with KVM. You may also need to ensure your guest kernel is configured
+with support for this; see below.
+
+Machine-specific options
+""""""""""""""""""""""""
+
+The following machine-specific options are supported:
+
+secure
+  Set ``on``/``off`` to enable/disable emulating a guest CPU which implements the
+  Arm Security Extensions (TrustZone). The default is ``off``.
+
+virtualization
+  Set ``on``/``off`` to enable/disable emulating a guest CPU which implements the
+  Arm Virtualization Extensions. The default is ``off``.
+
+highmem
+  Set ``on``/``off`` to enable/disable placing devices and RAM in physical
+  address space above 32 bits. The default is ``on`` for machine types
+  later than ``virt-2.12``.
+
+gic-version
+  Specify the version of the Generic Interrupt Controller (GIC) to provide.
+  Valid values are:
+
+  ``2``
+    GICv2
+  ``3``
+    GICv3
+  ``host``
+    Use the same GIC version the host provides, when using KVM
+  ``max``
+    Use the best GIC version possible (same as host when using KVM;
+    currently same as ``3``` for TCG, but this may change in future)
+
+its
+  Set ``on``/``off`` to enable/disable ITS instantiation. The default is ``on``
+  for machine types later than ``virt-2.7``.
+
+iommu
+  Set the IOMMU type to create for the guest. Valid values are:
+
+  ``none``
+    Don't create an IOMMU (the default)
+  ``smmuv3``
+    Create an SMMUv3
+
+ras
+  Set ``on``/``off`` to enable/disable reporting host memory errors to a guest
+  using ACPI and guest external abort exceptions. The default is off.
+
+Linux guest kernel configuration
+""""""""""""""""""""""""""""""""
+
+The 'defconfig' for Linux arm and arm64 kernels should include the
+right device drivers for virtio and the PCI controller; however some older
+kernel versions, especially for 32-bit Arm, did not have everything
+enabled by default. If you're not seeing PCI devices that you expect,
+then check that your guest config has::
+
+  CONFIG_PCI=y
+  CONFIG_VIRTIO_PCI=y
+  CONFIG_PCI_HOST_GENERIC=y
+
+If you want to use the ``virtio-gpu-pci`` graphics device you will also
+need::
+
+  CONFIG_DRM=y
+  CONFIG_DRM_VIRTIO_GPU=y
+
+Hardware configuration information for bare-metal programming
+"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
+
+The ``virt`` board automatically generates a device tree blob ("dtb")
+which it passes to the guest. This provides information about the
+addresses, interrupt lines and other configuration of the various devices
+in the system. Guest code can rely on and hard-code the following
+addresses:
+
+- Flash memory starts at address 0x0000_0000
+
+- RAM starts at 0x4000_0000
+
+All other information about device locations may change between
+QEMU versions, so guest code must look in the DTB.
+
+QEMU supports two types of guest image boot for ``virt``, and
+the way for the guest code to locate the dtb binary differs:
+
+- For guests using the Linux kernel boot protocol (this means any
+  non-ELF file passed to the QEMU ``-kernel`` option) the address
+  of the DTB is passed in a register (``r2`` for 32-bit guests,
+  or ``x0`` for 64-bit guests)
+
+- For guests booting as "bare-metal" (any other kind of boot),
+  the DTB is at the start of RAM (0x4000_0000)
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 163ab915592..4c5b0e4aab8 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -92,6 +92,7 @@ undocumented; you can get a complete list by running
    arm/collie
    arm/sx1
    arm/stellaris
+   arm/virt
 
 Arm CPU features
 ================
diff --git a/MAINTAINERS b/MAINTAINERS
index 935ccb3ab31..5e8616821a5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -880,6 +880,7 @@ L: qemu-arm@nongnu.org
 S: Maintained
 F: hw/arm/virt*
 F: include/hw/arm/virt.h
+F: docs/system/arm/virt.rst
 
 Xilinx Zynq
 M: Edgar E. Iglesias <edgar.iglesias@gmail.com>
-- 
2.20.1


