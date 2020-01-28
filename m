Return-Path: <SRS0=Nty2=3R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 327D0C2D0DB
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:24:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D9CA224681
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jan 2020 19:24:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uLxacSMc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D9CA224681
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwWTm-0005wp-UC
	for qemu-devel@archiver.kernel.org; Tue, 28 Jan 2020 14:24:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36840)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7v-0003xQ-KC
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:20 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iwV7r-0008DJ-I0
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:15 -0500
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331]:40201)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iwV7r-0008B6-4i
 for qemu-devel@nongnu.org; Tue, 28 Jan 2020 12:58:11 -0500
Received: by mail-wm1-x331.google.com with SMTP id t14so3551361wmi.5
 for <qemu-devel@nongnu.org>; Tue, 28 Jan 2020 09:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=IzZJtSsh+xbI6vbXJ8yrybHvyWpVZezOavCZ41u0hbQ=;
 b=uLxacSMc9YrZESGx+KKbyBglwxTTJHhTCphmm0W0+IOHsnmyAD/ungxdkfjzw6M4wQ
 G7B6kQsaX9YMC9EMWnDf/9NiT8e2IvOBA9NnSjFRgCutn27Dz32kaHPyTpoe61nsYs5o
 lkioBl8yVNfO245enJeBoJhyiTGk+y3tcFEJc7hb5LMc1FmvgG0CkHAdM+a3txs+qYag
 +v5im2H/uQhbPY5HxiNAgmdkjnYF4NMs9uKZ7NIeoK9dAbRgSniRu+ScLlsw2Lz+D4Oe
 w2YSCkIBDo3f/+l9BXXxI41vh1swebbDz0Bp5zUiBYXPV3WHb4GyGby4T0s39T+qm3RL
 yKQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
 :in-reply-to:references:mime-version:content-transfer-encoding;
 bh=IzZJtSsh+xbI6vbXJ8yrybHvyWpVZezOavCZ41u0hbQ=;
 b=cLFN6vY5VM5QpwVlwlJGxuXWAucA+53ttoIwdbQgSGvH/BS3qGSFXL6EMUovXIUGN8
 KfNIY7Xneh0b9SuyWLOFFvbVQSWPgfdhs0HvQeVe5e5hDv5LDVqgWzrKmA5LUS/kIUol
 C+iM87bYNTMJ+Lf+PrM23g9MdLkH7MtH9Cb0NDUw7fV8ySnJx72TuPJVtk4zOJsJR7gw
 V8egzRVk5SOU+cOtXywcDcs/XmyCCiH/xiiBP3ZqORp2q9Ujj9bq0cMXHr5j7fPt/306
 XRqH1pS5w7btsRDTVHv9OGTARjJSMvFp7xjJ9asudgJXNzNm4l/WPyYP+lhT1NH9Sltt
 P5QQ==
X-Gm-Message-State: APjAAAXxdlhPdiJf8bGQyjUB1Yqn/D2JQytQuG4So2v+N6jj+dbqDiLr
 Ppygmq9u6M3h5+0BZf5aTQkJQWfL
X-Google-Smtp-Source: APXvYqw1M36+il57kWbikYTrj/nKRgTcrdVagrJS2Z+M6pmHOYG6dpRgUCRjyvJFJ4vSyQLlZ2vUdA==
X-Received: by 2002:a05:600c:108a:: with SMTP id
 e10mr6268992wmd.10.1580234289369; 
 Tue, 28 Jan 2020 09:58:09 -0800 (PST)
Received: from localhost.localdomain (93-36-56-206.ip58.fastwebnet.it.
 [93.36.56.206])
 by smtp.gmail.com with ESMTPSA id o4sm27046968wrx.25.2020.01.28.09.58.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jan 2020 09:58:08 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 111/142] meson: convert hw/arch*
Date: Tue, 28 Jan 2020 18:53:11 +0100
Message-Id: <20200128175342.9066-112-pbonzini@redhat.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20200128175342.9066-1-pbonzini@redhat.com>
References: <20200128175342.9066-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::331
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
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Marc-André Lureau <marcandre.lureau@redhat.com>

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
---
 Makefile.target             |  7 ----
 hw/alpha/Makefile.objs      |  1 -
 hw/alpha/meson.build        |  8 ++++
 hw/arm/Makefile.objs        | 53 ------------------------
 hw/arm/meson.build          | 56 +++++++++++++++++++++++++
 hw/cris/Makefile.objs       |  2 -
 hw/cris/meson.build         |  5 +++
 hw/hppa/Makefile.objs       |  1 -
 hw/hppa/meson.build         |  4 ++
 hw/i386/kvm/Makefile.objs   |  5 ---
 hw/i386/kvm/meson.build     |  8 ++++
 hw/i386/meson.build         | 25 +++++++++++
 hw/i386/xen/Makefile.objs   |  1 -
 hw/i386/xen/meson.build     |  7 ++++
 hw/lm32/Makefile.objs       |  3 --
 hw/lm32/meson.build         |  6 +++
 hw/m68k/meson.build         |  7 ++++
 hw/meson.build              | 23 +++++++++++
 hw/microblaze/Makefile.objs |  4 --
 hw/microblaze/meson.build   |  7 ++++
 hw/mips/Makefile.objs       |  8 ----
 hw/mips/meson.build         | 11 +++++
 hw/moxie/Makefile.objs      |  2 -
 hw/moxie/meson.build        |  4 ++
 hw/nios2/Makefile.objs      |  3 --
 hw/nios2/meson.build        |  6 +++
 hw/openrisc/Makefile.objs   |  2 -
 hw/openrisc/meson.build     |  5 +++
 hw/ppc/Makefile.objs        | 36 ----------------
 hw/ppc/meson.build          | 82 +++++++++++++++++++++++++++++++++++++
 hw/riscv/Makefile.objs      | 15 -------
 hw/riscv/meson.build        | 18 ++++++++
 hw/s390x/Makefile.objs      | 36 ----------------
 hw/s390x/meson.build        | 45 ++++++++++++++++++++
 hw/sh4/Makefile.objs        |  4 --
 hw/sh4/meson.build          | 10 +++++
 hw/sparc/Makefile.objs      |  3 --
 hw/sparc/meson.build        |  6 +++
 hw/sparc64/Makefile.objs    |  4 --
 hw/sparc64/meson.build      |  6 +++
 hw/tricore/Makefile.objs    |  1 -
 hw/tricore/meson.build      |  4 ++
 hw/unicore32/Makefile.objs  |  4 --
 hw/unicore32/meson.build    |  5 +++
 hw/xenpv/Makefile.objs      |  2 -
 hw/xenpv/meson.build        |  1 +
 hw/xtensa/Makefile.objs     |  6 ---
 hw/xtensa/meson.build       | 11 +++++
 meson.build                 |  4 ++
 49 files changed, 374 insertions(+), 203 deletions(-)
 delete mode 100644 hw/alpha/Makefile.objs
 create mode 100644 hw/alpha/meson.build
 delete mode 100644 hw/arm/Makefile.objs
 create mode 100644 hw/arm/meson.build
 delete mode 100644 hw/cris/Makefile.objs
 create mode 100644 hw/cris/meson.build
 delete mode 100644 hw/hppa/Makefile.objs
 create mode 100644 hw/hppa/meson.build
 delete mode 100644 hw/i386/kvm/Makefile.objs
 create mode 100644 hw/i386/kvm/meson.build
 create mode 100644 hw/i386/meson.build
 delete mode 100644 hw/i386/xen/Makefile.objs
 create mode 100644 hw/i386/xen/meson.build
 delete mode 100644 hw/lm32/Makefile.objs
 create mode 100644 hw/lm32/meson.build
 create mode 100644 hw/m68k/meson.build
 delete mode 100644 hw/microblaze/Makefile.objs
 create mode 100644 hw/microblaze/meson.build
 delete mode 100644 hw/mips/Makefile.objs
 create mode 100644 hw/mips/meson.build
 delete mode 100644 hw/moxie/Makefile.objs
 create mode 100644 hw/moxie/meson.build
 delete mode 100644 hw/nios2/Makefile.objs
 create mode 100644 hw/nios2/meson.build
 delete mode 100644 hw/openrisc/Makefile.objs
 create mode 100644 hw/openrisc/meson.build
 delete mode 100644 hw/ppc/Makefile.objs
 create mode 100644 hw/ppc/meson.build
 delete mode 100644 hw/riscv/Makefile.objs
 create mode 100644 hw/riscv/meson.build
 delete mode 100644 hw/s390x/Makefile.objs
 create mode 100644 hw/s390x/meson.build
 delete mode 100644 hw/sh4/Makefile.objs
 create mode 100644 hw/sh4/meson.build
 delete mode 100644 hw/sparc/Makefile.objs
 create mode 100644 hw/sparc/meson.build
 delete mode 100644 hw/sparc64/Makefile.objs
 create mode 100644 hw/sparc64/meson.build
 delete mode 100644 hw/tricore/Makefile.objs
 create mode 100644 hw/tricore/meson.build
 delete mode 100644 hw/unicore32/Makefile.objs
 create mode 100644 hw/unicore32/meson.build
 delete mode 100644 hw/xenpv/Makefile.objs
 create mode 100644 hw/xenpv/meson.build
 delete mode 100644 hw/xtensa/Makefile.objs
 create mode 100644 hw/xtensa/meson.build

diff --git a/Makefile.target b/Makefile.target
index e269300203..584cfb58c4 100644
--- a/Makefile.target
+++ b/Makefile.target
@@ -171,13 +171,6 @@ LIBS := $(LIBS) $(VDE_LIBS) $(SLIRP_LIBS)
 LIBS := $(LIBS) $(LIBUSB_LIBS) $(SMARTCARD_LIBS) $(USB_REDIR_LIBS)
 LIBS := $(LIBS) $(VIRGL_LIBS)
 
-# Hardware support
-ifeq ($(TARGET_NAME), sparc64)
-obj-y += hw/sparc64/
-else
-obj-y += hw/$(TARGET_BASE_ARCH)/
-endif
-
 generated-files-y += hmp-commands.h hmp-commands-info.h
 
 endif # CONFIG_SOFTMMU
diff --git a/hw/alpha/Makefile.objs b/hw/alpha/Makefile.objs
deleted file mode 100644
index 62fdf3edec..0000000000
--- a/hw/alpha/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_DP264) += dp264.o pci.o typhoon.o
diff --git a/hw/alpha/meson.build b/hw/alpha/meson.build
new file mode 100644
index 0000000000..81ca215777
--- /dev/null
+++ b/hw/alpha/meson.build
@@ -0,0 +1,8 @@
+alpha_ss = ss.source_set()
+alpha_ss.add(when: 'CONFIG_DP264', if_true: files(
+  'dp264.c',
+  'pci.c',
+  'typhoon.c',
+))
+
+hw_arch += {'alpha': alpha_ss}
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
deleted file mode 100644
index fe749f65fd..0000000000
--- a/hw/arm/Makefile.objs
+++ /dev/null
@@ -1,53 +0,0 @@
-obj-y += boot.o
-obj-$(CONFIG_PLATFORM_BUS) += sysbus-fdt.o
-obj-$(CONFIG_ARM_VIRT) += virt.o
-obj-$(CONFIG_ACPI) += virt-acpi-build.o
-obj-$(CONFIG_DIGIC) += digic_boards.o
-obj-$(CONFIG_EXYNOS4) += exynos4_boards.o
-obj-$(CONFIG_EMCRAFT_SF2) += msf2-som.o
-obj-$(CONFIG_HIGHBANK) += highbank.o
-obj-$(CONFIG_INTEGRATOR) += integratorcp.o
-obj-$(CONFIG_MAINSTONE) += mainstone.o
-obj-$(CONFIG_MICROBIT) += microbit.o
-obj-$(CONFIG_MUSICPAL) += musicpal.o
-obj-$(CONFIG_NETDUINO2) += netduino2.o
-obj-$(CONFIG_NSERIES) += nseries.o
-obj-$(CONFIG_SX1) += omap_sx1.o
-obj-$(CONFIG_CHEETAH) += palm.o
-obj-$(CONFIG_GUMSTIX) += gumstix.o
-obj-$(CONFIG_SPITZ) += spitz.o
-obj-$(CONFIG_TOSA) += tosa.o
-obj-$(CONFIG_Z2) += z2.o
-obj-$(CONFIG_REALVIEW) += realview.o
-obj-$(CONFIG_SBSA_REF) += sbsa-ref.o
-obj-$(CONFIG_STELLARIS) += stellaris.o
-obj-$(CONFIG_COLLIE) += collie.o
-obj-$(CONFIG_VERSATILE) += versatilepb.o
-obj-$(CONFIG_VEXPRESS) += vexpress.o
-obj-$(CONFIG_ZYNQ) += xilinx_zynq.o
-obj-$(CONFIG_SABRELITE) += sabrelite.o
-
-obj-$(CONFIG_ARM_V7M) += armv7m.o
-obj-$(CONFIG_EXYNOS4) += exynos4210.o
-obj-$(CONFIG_PXA2XX) += pxa2xx.o pxa2xx_gpio.o pxa2xx_pic.o
-obj-$(CONFIG_DIGIC) += digic.o
-obj-$(CONFIG_OMAP) += omap1.o omap2.o
-obj-$(CONFIG_STRONGARM) += strongarm.o
-obj-$(CONFIG_ALLWINNER_A10) += allwinner-a10.o cubieboard.o
-obj-$(CONFIG_RASPI) += bcm2835_peripherals.o bcm2836.o raspi.o
-obj-$(CONFIG_STM32F205_SOC) += stm32f205_soc.o
-obj-$(CONFIG_XLNX_ZYNQMP_ARM) += xlnx-zynqmp.o xlnx-zcu102.o
-obj-$(CONFIG_XLNX_VERSAL) += xlnx-versal.o xlnx-versal-virt.o
-obj-$(CONFIG_FSL_IMX25) += fsl-imx25.o imx25_pdk.o
-obj-$(CONFIG_FSL_IMX31) += fsl-imx31.o kzm.o
-obj-$(CONFIG_FSL_IMX6) += fsl-imx6.o
-obj-$(CONFIG_ASPEED_SOC) += aspeed_soc.o aspeed.o aspeed_ast2600.o
-obj-$(CONFIG_MPS2) += mps2.o
-obj-$(CONFIG_MPS2) += mps2-tz.o
-obj-$(CONFIG_MSF2) += msf2-soc.o
-obj-$(CONFIG_MUSCA) += musca.o
-obj-$(CONFIG_ARMSSE) += armsse.o
-obj-$(CONFIG_FSL_IMX7) += fsl-imx7.o mcimx7d-sabre.o
-obj-$(CONFIG_ARM_SMMUV3) += smmu-common.o smmuv3.o
-obj-$(CONFIG_FSL_IMX6UL) += fsl-imx6ul.o mcimx6ul-evk.o
-obj-$(CONFIG_NRF51_SOC) += nrf51_soc.o
diff --git a/hw/arm/meson.build b/hw/arm/meson.build
new file mode 100644
index 0000000000..5b32c48fda
--- /dev/null
+++ b/hw/arm/meson.build
@@ -0,0 +1,56 @@
+arm_ss = ss.source_set()
+arm_ss.add(files('boot.c'))
+arm_ss.add(when: 'CONFIG_PLATFORM_BUS', if_true: files('sysbus-fdt.c'))
+arm_ss.add(when: 'CONFIG_ARM_VIRT', if_true: files('virt.c'))
+arm_ss.add(when: 'CONFIG_ACPI', if_true: files('virt-acpi-build.c'))
+arm_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic_boards.c'))
+arm_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4_boards.c'))
+arm_ss.add(when: 'CONFIG_EMCRAFT_SF2', if_true: files('msf2-som.c'))
+arm_ss.add(when: 'CONFIG_HIGHBANK', if_true: files('highbank.c'))
+arm_ss.add(when: 'CONFIG_INTEGRATOR', if_true: files('integratorcp.c'))
+arm_ss.add(when: 'CONFIG_MAINSTONE', if_true: files('mainstone.c'))
+arm_ss.add(when: 'CONFIG_MICROBIT', if_true: files('microbit.c'))
+arm_ss.add(when: 'CONFIG_MUSICPAL', if_true: files('musicpal.c'))
+arm_ss.add(when: 'CONFIG_NETDUINO2', if_true: files('netduino2.c'))
+arm_ss.add(when: 'CONFIG_NSERIES', if_true: files('nseries.c'))
+arm_ss.add(when: 'CONFIG_SX1', if_true: files('omap_sx1.c'))
+arm_ss.add(when: 'CONFIG_CHEETAH', if_true: files('palm.c'))
+arm_ss.add(when: 'CONFIG_GUMSTIX', if_true: files('gumstix.c'))
+arm_ss.add(when: 'CONFIG_SPITZ', if_true: files('spitz.c'))
+arm_ss.add(when: 'CONFIG_TOSA', if_true: files('tosa.c'))
+arm_ss.add(when: 'CONFIG_Z2', if_true: files('z2.c'))
+arm_ss.add(when: 'CONFIG_REALVIEW', if_true: files('realview.c'))
+arm_ss.add(when: 'CONFIG_SBSA_REF', if_true: files('sbsa-ref.c'))
+arm_ss.add(when: 'CONFIG_STELLARIS', if_true: files('stellaris.c'))
+arm_ss.add(when: 'CONFIG_COLLIE', if_true: files('collie.c'))
+arm_ss.add(when: 'CONFIG_VERSATILE', if_true: files('versatilepb.c'))
+arm_ss.add(when: 'CONFIG_VEXPRESS', if_true: files('vexpress.c'))
+arm_ss.add(when: 'CONFIG_ZYNQ', if_true: files('xilinx_zynq.c'))
+arm_ss.add(when: 'CONFIG_SABRELITE', if_true: files('sabrelite.c'))
+
+arm_ss.add(when: 'CONFIG_ARM_V7M', if_true: files('armv7m.c'))
+arm_ss.add(when: 'CONFIG_EXYNOS4', if_true: files('exynos4210.c'))
+arm_ss.add(when: 'CONFIG_PXA2XX', if_true: files('pxa2xx.c', 'pxa2xx_gpio.c', 'pxa2xx_pic.c'))
+arm_ss.add(when: 'CONFIG_DIGIC', if_true: files('digic.c'))
+arm_ss.add(when: 'CONFIG_OMAP', if_true: files('omap1.c', 'omap2.c'))
+arm_ss.add(when: 'CONFIG_STRONGARM', if_true: files('strongarm.c'))
+arm_ss.add(when: 'CONFIG_ALLWINNER_A10', if_true: files('allwinner-a10.c', 'cubieboard.c'))
+arm_ss.add(when: 'CONFIG_RASPI', if_true: files('bcm2835_peripherals.c', 'bcm2836.c', 'raspi.c'))
+arm_ss.add(when: 'CONFIG_STM32F205_SOC', if_true: files('stm32f205_soc.c'))
+arm_ss.add(when: 'CONFIG_XLNX_ZYNQMP_ARM', if_true: files('xlnx-zynqmp.c', 'xlnx-zcu102.c'))
+arm_ss.add(when: 'CONFIG_XLNX_VERSAL', if_true: files('xlnx-versal.c', 'xlnx-versal-virt.c'))
+arm_ss.add(when: 'CONFIG_FSL_IMX25', if_true: files('fsl-imx25.c', 'imx25_pdk.c'))
+arm_ss.add(when: 'CONFIG_FSL_IMX31', if_true: files('fsl-imx31.c', 'kzm.c'))
+arm_ss.add(when: 'CONFIG_FSL_IMX6', if_true: files('fsl-imx6.c'))
+arm_ss.add(when: 'CONFIG_ASPEED_SOC', if_true: files('aspeed_soc.c', 'aspeed.c', 'aspeed_ast2600.c'))
+arm_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2.c'))
+arm_ss.add(when: 'CONFIG_MPS2', if_true: files('mps2-tz.c'))
+arm_ss.add(when: 'CONFIG_MSF2', if_true: files('msf2-soc.c'))
+arm_ss.add(when: 'CONFIG_MUSCA', if_true: files('musca.c'))
+arm_ss.add(when: 'CONFIG_ARMSSE', if_true: files('armsse.c'))
+arm_ss.add(when: 'CONFIG_FSL_IMX7', if_true: files('fsl-imx7.c', 'mcimx7d-sabre.c'))
+arm_ss.add(when: 'CONFIG_ARM_SMMUV3', if_true: files('smmu-common.c', 'smmuv3.c'))
+arm_ss.add(when: 'CONFIG_FSL_IMX6UL', if_true: files('fsl-imx6ul.c', 'mcimx6ul-evk.c'))
+arm_ss.add(when: 'CONFIG_NRF51_SOC', if_true: files('nrf51_soc.c'))
+
+hw_arch += {'arm': arm_ss}
diff --git a/hw/cris/Makefile.objs b/hw/cris/Makefile.objs
deleted file mode 100644
index a4a27b3a13..0000000000
--- a/hw/cris/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y += boot.o
-obj-$(CONFIG_AXIS) += axis_dev88.o
diff --git a/hw/cris/meson.build b/hw/cris/meson.build
new file mode 100644
index 0000000000..dc808a4e0f
--- /dev/null
+++ b/hw/cris/meson.build
@@ -0,0 +1,5 @@
+cris_ss = ss.source_set()
+cris_ss.add(files('boot.c'))
+cris_ss.add(when: 'CONFIG_AXIS', if_true: files('axis_dev88.c'))
+
+hw_arch += {'cris': cris_ss}
diff --git a/hw/hppa/Makefile.objs b/hw/hppa/Makefile.objs
deleted file mode 100644
index 67838f50a3..0000000000
--- a/hw/hppa/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_DINO) += pci.o machine.o dino.o
diff --git a/hw/hppa/meson.build b/hw/hppa/meson.build
new file mode 100644
index 0000000000..392cf9952b
--- /dev/null
+++ b/hw/hppa/meson.build
@@ -0,0 +1,4 @@
+hppa_ss = ss.source_set()
+hppa_ss.add(when: 'CONFIG_DINO', if_true: files('pci.c', 'machine.c', 'dino.c'))
+
+hw_arch += {'hppa': hppa_ss}
diff --git a/hw/i386/kvm/Makefile.objs b/hw/i386/kvm/Makefile.objs
deleted file mode 100644
index 0c8d5f2dee..0000000000
--- a/hw/i386/kvm/Makefile.objs
+++ /dev/null
@@ -1,5 +0,0 @@
-obj-y += clock.o
-obj-$(CONFIG_APIC) += apic.o
-obj-$(CONFIG_IOAPIC) += ioapic.o
-obj-$(CONFIG_I8254) += i8254.o
-obj-$(CONFIG_I8259) += i8259.o
diff --git a/hw/i386/kvm/meson.build b/hw/i386/kvm/meson.build
new file mode 100644
index 0000000000..95467f1ded
--- /dev/null
+++ b/hw/i386/kvm/meson.build
@@ -0,0 +1,8 @@
+i386_kvm_ss = ss.source_set()
+i386_kvm_ss.add(files('clock.c'))
+i386_kvm_ss.add(when: 'CONFIG_APIC', if_true: files('apic.c'))
+i386_kvm_ss.add(when: 'CONFIG_I8254', if_true: files('i8254.c'))
+i386_kvm_ss.add(when: 'CONFIG_I8259', if_true: files('i8259.c'))
+i386_kvm_ss.add(when: 'CONFIG_IOAPIC', if_true: files('ioapic.c'))
+
+i386_ss.add_all(when: 'CONFIG_KVM', if_true: i386_kvm_ss)
diff --git a/hw/i386/meson.build b/hw/i386/meson.build
new file mode 100644
index 0000000000..71d3827a5d
--- /dev/null
+++ b/hw/i386/meson.build
@@ -0,0 +1,25 @@
+i386_ss = ss.source_set()
+i386_ss.add(files(
+  'acpi-build.c',
+  'fw_cfg.c',
+  'kvmvapic.c',
+  'e820_memory_layout.c',
+  'multiboot.c',
+  'pc.c',
+  'pc_sysfw.c',
+  'x86.c',
+  'x86-iommu.c',
+))
+
+i386_ss.add(when: 'CONFIG_AMD_IOMMU', if_true: files('amd_iommu.c'))
+i386_ss.add(when: 'CONFIG_I440FX', if_true: files('pc_piix.c'))
+i386_ss.add(when: 'CONFIG_MICROVM', if_true: files('microvm.c'))
+i386_ss.add(when: 'CONFIG_Q35', if_true: files('pc_q35.c'))
+i386_ss.add(when: 'CONFIG_VMMOUSE', if_true: files('vmmouse.c'))
+i386_ss.add(when: 'CONFIG_VMPORT', if_true: files('vmport.c'))
+i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel_iommu.c'))
+
+subdir('kvm')
+subdir('xen')
+
+hw_arch += {'i386': i386_ss}
diff --git a/hw/i386/xen/Makefile.objs b/hw/i386/xen/Makefile.objs
deleted file mode 100644
index be9d10cf2a..0000000000
--- a/hw/i386/xen/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-obj-y += xen_platform.o xen_apic.o xen_pvdevice.o xen-hvm.o xen-mapcache.o
diff --git a/hw/i386/xen/meson.build b/hw/i386/xen/meson.build
new file mode 100644
index 0000000000..be84130300
--- /dev/null
+++ b/hw/i386/xen/meson.build
@@ -0,0 +1,7 @@
+i386_ss.add(when: 'CONFIG_XEN', if_true: files(
+  'xen-hvm.c',
+  'xen-mapcache.c',
+  'xen_apic.c',
+  'xen_platform.c',
+  'xen_pvdevice.c',
+))
diff --git a/hw/lm32/Makefile.objs b/hw/lm32/Makefile.objs
deleted file mode 100644
index c3941866c7..0000000000
--- a/hw/lm32/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-# LM32 boards
-obj-$(CONFIG_LM32) += lm32_boards.o
-obj-$(CONFIG_MILKYMIST) += milkymist.o
diff --git a/hw/lm32/meson.build b/hw/lm32/meson.build
new file mode 100644
index 0000000000..8caf0a727f
--- /dev/null
+++ b/hw/lm32/meson.build
@@ -0,0 +1,6 @@
+lm32_ss = ss.source_set()
+# LM32 boards
+lm32_ss.add(when: 'CONFIG_LM32', if_true: files('lm32_boards.c'))
+lm32_ss.add(when: 'CONFIG_MILKYMIST', if_true: files('milkymist.c'))
+
+hw_arch += {'lm32': lm32_ss}
diff --git a/hw/m68k/meson.build b/hw/m68k/meson.build
new file mode 100644
index 0000000000..ca0044c652
--- /dev/null
+++ b/hw/m68k/meson.build
@@ -0,0 +1,7 @@
+m68k_ss = ss.source_set()
+m68k_ss.add(when: 'CONFIG_AN5206', if_true: files('an5206.c', 'mcf5206.c'))
+m68k_ss.add(when: 'CONFIG_MCF5208', if_true: files('mcf5208.c', 'mcf_intc.c'))
+m68k_ss.add(when: 'CONFIG_NEXTCUBE', if_true: files('next-kbd.c', 'next-cube.c'))
+m68k_ss.add(when: 'CONFIG_Q800', if_true: files('q800.c'))
+
+hw_arch += {'m68k': m68k_ss}
diff --git a/hw/meson.build b/hw/meson.build
index ba8763cad8..6ca4c598b4 100644
--- a/hw/meson.build
+++ b/hw/meson.build
@@ -40,3 +40,26 @@ subdir('vfio')
 subdir('virtio')
 subdir('watchdog')
 subdir('xen')
+
+subdir('alpha')
+subdir('arm')
+subdir('cris')
+subdir('hppa')
+subdir('i386')
+subdir('lm32')
+subdir('m68k')
+subdir('microblaze')
+subdir('mips')
+subdir('moxie')
+subdir('nios2')
+subdir('openrisc')
+subdir('ppc')
+subdir('riscv')
+subdir('s390x')
+subdir('sh4')
+subdir('sparc')
+subdir('sparc64')
+subdir('tricore')
+subdir('unicore32')
+subdir('xenpv')
+subdir('xtensa')
diff --git a/hw/microblaze/Makefile.objs b/hw/microblaze/Makefile.objs
deleted file mode 100644
index 8595a62f6c..0000000000
--- a/hw/microblaze/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-$(CONFIG_PETALOGIX_S3ADSP1800) += petalogix_s3adsp1800_mmu.o
-obj-$(CONFIG_PETALOGIX_ML605) += petalogix_ml605_mmu.o
-obj-$(CONFIG_XLNX_ZYNQMP_PMU) += xlnx-zynqmp-pmu.o
-obj-y += boot.o
diff --git a/hw/microblaze/meson.build b/hw/microblaze/meson.build
new file mode 100644
index 0000000000..bb9e4eb8f4
--- /dev/null
+++ b/hw/microblaze/meson.build
@@ -0,0 +1,7 @@
+microblaze_ss = ss.source_set()
+microblaze_ss.add(files('boot.c'))
+microblaze_ss.add(when: 'CONFIG_PETALOGIX_S3ADSP1800', if_true: files('petalogix_s3adsp1800_mmu.c'))
+microblaze_ss.add(when: 'CONFIG_PETALOGIX_ML605', if_true: files('petalogix_ml605_mmu.c'))
+microblaze_ss.add(when: 'CONFIG_XLNX_ZYNQMP_PMU', if_true: files('xlnx-zynqmp-pmu.c'))
+
+hw_arch += {'microblaze': microblaze_ss}
diff --git a/hw/mips/Makefile.objs b/hw/mips/Makefile.objs
deleted file mode 100644
index 525809af07..0000000000
--- a/hw/mips/Makefile.objs
+++ /dev/null
@@ -1,8 +0,0 @@
-obj-y += addr.o mips_int.o
-obj-$(CONFIG_R4K) += mips_r4k.o
-obj-$(CONFIG_MALTA) += gt64xxx_pci.o mips_malta.o
-obj-$(CONFIG_MIPSSIM) += mips_mipssim.o
-obj-$(CONFIG_JAZZ) += mips_jazz.o
-obj-$(CONFIG_FULONG) += mips_fulong2e.o
-obj-$(CONFIG_MIPS_CPS) += cps.o
-obj-$(CONFIG_MIPS_BOSTON) += boston.o
diff --git a/hw/mips/meson.build b/hw/mips/meson.build
new file mode 100644
index 0000000000..06adda2d82
--- /dev/null
+++ b/hw/mips/meson.build
@@ -0,0 +1,11 @@
+mips_ss = ss.source_set()
+mips_ss.add(files('addr.c', 'mips_int.c'))
+mips_ss.add(when: 'CONFIG_FULONG', if_true: files('mips_fulong2e.c'))
+mips_ss.add(when: 'CONFIG_JAZZ', if_true: files('mips_jazz.c'))
+mips_ss.add(when: 'CONFIG_MALTA', if_true: files('gt64xxx_pci.c', 'mips_malta.c'))
+mips_ss.add(when: 'CONFIG_MIPSSIM', if_true: files('mips_mipssim.c'))
+mips_ss.add(when: 'CONFIG_MIPS_BOSTON', if_true: files('boston.c'))
+mips_ss.add(when: 'CONFIG_MIPS_CPS', if_true: files('cps.c'))
+mips_ss.add(when: 'CONFIG_R4K', if_true: files('mips_r4k.c'))
+
+hw_arch += {'mips': mips_ss}
diff --git a/hw/moxie/Makefile.objs b/hw/moxie/Makefile.objs
deleted file mode 100644
index ddbf300f54..0000000000
--- a/hw/moxie/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-# moxie boards
-obj-$(CONFIG_MOXIESIM) += moxiesim.o
diff --git a/hw/moxie/meson.build b/hw/moxie/meson.build
new file mode 100644
index 0000000000..05a7c2e00f
--- /dev/null
+++ b/hw/moxie/meson.build
@@ -0,0 +1,4 @@
+moxie_ss = ss.source_set()
+moxie_ss.add(when: 'CONFIG_MOXIESIM', if_true: files('moxiesim.c'))
+
+hw_arch += {'moxie': moxie_ss}
diff --git a/hw/nios2/Makefile.objs b/hw/nios2/Makefile.objs
deleted file mode 100644
index 3e017981ba..0000000000
--- a/hw/nios2/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-y = boot.o cpu_pic.o
-obj-$(CONFIG_NIOS2_10M50) += 10m50_devboard.o
-obj-$(CONFIG_NIOS2_GENERIC_NOMMU) += generic_nommu.o
diff --git a/hw/nios2/meson.build b/hw/nios2/meson.build
new file mode 100644
index 0000000000..dd66ebb32f
--- /dev/null
+++ b/hw/nios2/meson.build
@@ -0,0 +1,6 @@
+nios2_ss = ss.source_set()
+nios2_ss.add(files('boot.c', 'cpu_pic.c'))
+nios2_ss.add(when: 'CONFIG_NIOS2_10M50', if_true: files('10m50_devboard.c'))
+nios2_ss.add(when: 'CONFIG_NIOS2_GENERIC_NOMMU', if_true: files('generic_nommu.c'))
+
+hw_arch += {'nios2': nios2_ss}
diff --git a/hw/openrisc/Makefile.objs b/hw/openrisc/Makefile.objs
deleted file mode 100644
index aa04de7f5a..0000000000
--- a/hw/openrisc/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-obj-y = pic_cpu.o cputimer.o
-obj-$(CONFIG_OR1K_SIM) += openrisc_sim.o
diff --git a/hw/openrisc/meson.build b/hw/openrisc/meson.build
new file mode 100644
index 0000000000..57c42558e1
--- /dev/null
+++ b/hw/openrisc/meson.build
@@ -0,0 +1,5 @@
+openrisc_ss = ss.source_set()
+openrisc_ss.add(files('pic_cpu.c', 'cputimer.c'))
+openrisc_ss.add(when: 'CONFIG_OR1K_SIM', if_true: files('openrisc_sim.c'))
+
+hw_arch += {'openrisc': openrisc_ss}
diff --git a/hw/ppc/Makefile.objs b/hw/ppc/Makefile.objs
deleted file mode 100644
index 101e9fc591..0000000000
--- a/hw/ppc/Makefile.objs
+++ /dev/null
@@ -1,36 +0,0 @@
-# shared objects
-obj-y += ppc.o ppc_booke.o fdt.o fw_cfg.o
-# IBM pSeries (sPAPR)
-obj-$(CONFIG_PSERIES) += spapr.o spapr_caps.o spapr_vio.o spapr_events.o
-obj-$(CONFIG_PSERIES) += spapr_hcall.o spapr_iommu.o spapr_rtas.o
-obj-$(CONFIG_PSERIES) += spapr_pci.o spapr_rtc.o spapr_drc.o
-obj-$(CONFIG_PSERIES) += spapr_cpu_core.o spapr_ovec.o spapr_irq.o
-obj-$(CONFIG_PSERIES) += spapr_tpm_proxy.o
-obj-$(CONFIG_SPAPR_RNG) +=  spapr_rng.o
-# IBM PowerNV
-obj-$(CONFIG_POWERNV) += pnv.o pnv_xscom.o pnv_core.o pnv_lpc.o pnv_psi.o pnv_occ.o pnv_bmc.o
-obj-$(CONFIG_POWERNV) += pnv_homer.o pnv_pnor.o
-
-
-ifeq ($(CONFIG_PCI)$(CONFIG_PSERIES)$(CONFIG_LINUX), yyy)
-obj-y += spapr_pci_vfio.o spapr_pci_nvlink2.o
-endif
-obj-$(CONFIG_PSERIES) += spapr_rtas_ddw.o
-# PowerPC 4xx boards
-obj-$(CONFIG_PPC405) += ppc405_boards.o ppc405_uc.o
-obj-$(CONFIG_PPC440) += ppc440_bamboo.o ppc440_pcix.o ppc440_uc.o
-obj-$(CONFIG_PPC4XX) += ppc4xx_pci.o ppc4xx_devs.o
-obj-$(CONFIG_SAM460EX) += sam460ex.o
-# PReP
-obj-$(CONFIG_PREP) += prep.o
-obj-$(CONFIG_PREP) += prep_systemio.o
-obj-${CONFIG_RS6000_MC} += rs6000_mc.o
-# OldWorld PowerMac
-obj-$(CONFIG_MAC_OLDWORLD) += mac_oldworld.o
-# NewWorld PowerMac
-obj-$(CONFIG_MAC_NEWWORLD) += mac_newworld.o
-# e500
-obj-$(CONFIG_E500) += e500.o mpc8544ds.o e500plat.o
-obj-$(CONFIG_E500) += mpc8544_guts.o ppce500_spin.o
-# PowerPC 440 Xilinx ML507 reference board.
-obj-$(CONFIG_VIRTEX) += virtex_ml507.o
diff --git a/hw/ppc/meson.build b/hw/ppc/meson.build
new file mode 100644
index 0000000000..aae2a2cd65
--- /dev/null
+++ b/hw/ppc/meson.build
@@ -0,0 +1,82 @@
+ppc_ss = ss.source_set()
+ppc_ss.add(files(
+  'fdt.c',
+  'fw_cfg.c',
+  'ppc.c',
+  'ppc_booke.c',
+), fdt)
+
+# IBM pSeries (sPAPR)
+ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
+  'spapr.c',
+  'spapr_caps.c',
+  'spapr_vio.c',
+  'spapr_events.c'
+))
+ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
+  'spapr_hcall.c',
+  'spapr_iommu.c',
+  'spapr_rtas.c'))
+ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
+  'spapr_pci.c',
+  'spapr_rtc.c',
+  'spapr_drc.c'
+))
+ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files(
+  'spapr_cpu_core.c',
+  'spapr_ovec.c',
+  'spapr_irq.c',
+  'spapr_tpm_proxy.c'
+))
+ppc_ss.add(when: 'CONFIG_SPAPR_RNG', if_true: files('spapr_rng.c'))
+
+# IBM PowerNV
+ppc_ss.add(when: 'CONFIG_POWERNV', if_true: files(
+  'pnv.c',
+  'pnv_xscom.c',
+  'pnv_core.c',
+  'pnv_lpc.c',
+  'pnv_psi.c',
+  'pnv_occ.c',
+  'pnv_bmc.c',
+  'pnv_homer.c',
+  'pnv_pnor.c',
+))
+ppc_ss.add(when: ['CONFIG_PCI', 'CONFIG_PSERIES', 'CONFIG_LINUX'], if_true: files(
+  'spapr_pci_vfio.c',
+  'spapr_pci_nvlink2.c'
+))
+ppc_ss.add(when: 'CONFIG_PSERIES', if_true: files('spapr_rtas_ddw.c'))
+# PowerPC 4xx boards
+ppc_ss.add(when: 'CONFIG_PPC405', if_true: files(
+  'ppc405_boards.c',
+  'ppc405_uc.c'))
+ppc_ss.add(when: 'CONFIG_PPC440', if_true: files(
+  'ppc440_bamboo.c',
+  'ppc440_pcix.c', 'ppc440_uc.c'))
+ppc_ss.add(when: 'CONFIG_PPC4XX', if_true: files(
+  'ppc4xx_pci.c',
+  'ppc4xx_devs.c'))
+ppc_ss.add(when: 'CONFIG_SAM460EX', if_true: files('sam460ex.c'))
+# PReP
+ppc_ss.add(when: 'CONFIG_PREP', if_true: files('prep.c'))
+ppc_ss.add(when: 'CONFIG_PREP', if_true: files('prep_systemio.c'))
+ppc_ss.add(when: 'CONFIG_RS6000_MC', if_true: files('rs6000_mc.c'))
+# OldWorld PowerMac
+ppc_ss.add(when: 'CONFIG_MAC_OLDWORLD', if_true: files('mac_oldworld.c'))
+# NewWorld PowerMac
+ppc_ss.add(when: 'CONFIG_MAC_NEWWORLD', if_true: files('mac_newworld.c'))
+# e500
+ppc_ss.add(when: 'CONFIG_E500', if_true: files(
+  'e500.c',
+  'mpc8544ds.c',
+  'e500plat.c'
+))
+ppc_ss.add(when: 'CONFIG_E500', if_true: files(
+  'mpc8544_guts.c',
+  'ppce500_spin.c'
+))
+# PowerPC 440 Xilinx ML507 reference board.
+ppc_ss.add(when: 'CONFIG_VIRTEX', if_true: files('virtex_ml507.c'))
+
+hw_arch += {'ppc': ppc_ss}
diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
deleted file mode 100644
index fc3c6dd7c8..0000000000
--- a/hw/riscv/Makefile.objs
+++ /dev/null
@@ -1,15 +0,0 @@
-obj-y += boot.o
-obj-$(CONFIG_SPIKE) += riscv_htif.o
-obj-$(CONFIG_HART) += riscv_hart.o
-obj-$(CONFIG_SIFIVE_E) += sifive_e.o
-obj-$(CONFIG_SIFIVE_E) += sifive_e_prci.o
-obj-$(CONFIG_SIFIVE) += sifive_clint.o
-obj-$(CONFIG_SIFIVE) += sifive_gpio.o
-obj-$(CONFIG_SIFIVE) += sifive_plic.o
-obj-$(CONFIG_SIFIVE) += sifive_test.o
-obj-$(CONFIG_SIFIVE_U) += sifive_u.o
-obj-$(CONFIG_SIFIVE_U) += sifive_u_otp.o
-obj-$(CONFIG_SIFIVE_U) += sifive_u_prci.o
-obj-$(CONFIG_SIFIVE) += sifive_uart.o
-obj-$(CONFIG_SPIKE) += spike.o
-obj-$(CONFIG_RISCV_VIRT) += virt.o
diff --git a/hw/riscv/meson.build b/hw/riscv/meson.build
new file mode 100644
index 0000000000..5d17557ed0
--- /dev/null
+++ b/hw/riscv/meson.build
@@ -0,0 +1,18 @@
+riscv_ss = ss.source_set()
+riscv_ss.add(files('boot.c'))
+riscv_ss.add(when: 'CONFIG_HART', if_true: files('riscv_hart.c'))
+riscv_ss.add(when: 'CONFIG_RISCV_VIRT', if_true: files('virt.c'))
+riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_clint.c'))
+riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_gpio.c'))
+riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_plic.c'))
+riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_test.c'))
+riscv_ss.add(when: 'CONFIG_SIFIVE', if_true: files('sifive_uart.c'))
+riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e.c'))
+riscv_ss.add(when: 'CONFIG_SIFIVE_E', if_true: files('sifive_e_prci.c'))
+riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u.c'))
+riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u_otp.c'))
+riscv_ss.add(when: 'CONFIG_SIFIVE_U', if_true: files('sifive_u_prci.c'))
+riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('riscv_htif.c'))
+riscv_ss.add(when: 'CONFIG_SPIKE', if_true: files('spike.c'))
+
+hw_arch += {'riscv': riscv_ss}
diff --git a/hw/s390x/Makefile.objs b/hw/s390x/Makefile.objs
deleted file mode 100644
index e02ed80b68..0000000000
--- a/hw/s390x/Makefile.objs
+++ /dev/null
@@ -1,36 +0,0 @@
-obj-y += s390-virtio-hcall.o
-obj-y += sclp.o
-obj-y += event-facility.o
-obj-y += sclpquiesce.o
-obj-y += sclpcpu.o
-obj-y += ipl.o
-obj-y += css.o
-obj-$(CONFIG_S390_CCW_VIRTIO) += s390-virtio-ccw.o
-obj-$(CONFIG_TERMINAL3270) += 3270-ccw.o
-ifeq ($(CONFIG_VIRTIO_CCW),y)
-obj-y += virtio-ccw.o
-obj-$(CONFIG_VIRTIO_SERIAL) += virtio-ccw-serial.o
-obj-$(CONFIG_VIRTIO_BALLOON) += virtio-ccw-balloon.o
-obj-$(CONFIG_VIRTIO_SCSI) += virtio-ccw-scsi.o
-obj-$(CONFIG_VIRTIO_RNG) += virtio-ccw-rng.o
-obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-ccw-crypto.o
-obj-$(CONFIG_VIRTIO_GPU) += virtio-ccw-gpu.o
-obj-$(CONFIG_VIRTIO_INPUT) += virtio-ccw-input.o
-obj-$(CONFIG_VIRTIO_NET) += virtio-ccw-net.o
-obj-$(CONFIG_VIRTIO_BLK) += virtio-ccw-blk.o
-obj-$(call land,$(CONFIG_VIRTIO_9P),$(CONFIG_VIRTFS)) += virtio-ccw-9p.o
-obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock-ccw.o
-endif
-obj-y += css-bridge.o
-obj-y += ccw-device.o
-obj-y += s390-pci-bus.o s390-pci-inst.o
-obj-y += s390-skeys.o
-obj-y += s390-stattrib.o
-obj-y += tod.o
-obj-y += tod-qemu.o
-obj-$(CONFIG_KVM) += tod-kvm.o
-obj-$(CONFIG_KVM) += s390-skeys-kvm.o
-obj-$(CONFIG_KVM) += s390-stattrib-kvm.o
-obj-y += s390-ccw.o
-obj-y += ap-device.o
-obj-y += ap-bridge.o
diff --git a/hw/s390x/meson.build b/hw/s390x/meson.build
new file mode 100644
index 0000000000..f9a0bf8812
--- /dev/null
+++ b/hw/s390x/meson.build
@@ -0,0 +1,45 @@
+s390x_ss = ss.source_set()
+s390x_ss.add(files(
+  'ap-bridge.c',
+  'ap-device.c',
+  'ccw-device.c',
+  'css-bridge.c',
+  'css.c',
+  'event-facility.c',
+  'ipl.c',
+  's390-ccw.c',
+  's390-pci-bus.c',
+  's390-pci-inst.c',
+  's390-skeys.c',
+  's390-stattrib.c',
+  's390-virtio-hcall.c',
+  'sclp.c',
+  'sclpcpu.c',
+  'sclpquiesce.c',
+  'tod-qemu.c',
+  'tod.c',
+))
+s390x_ss.add(when: 'CONFIG_KVM', if_true: files(
+  'tod-kvm.c',
+  's390-skeys-kvm.c',
+  's390-stattrib-kvm.c',
+))
+s390x_ss.add(when: 'CONFIG_S390_CCW_VIRTIO', if_true: files('s390-virtio-ccw.c'))
+s390x_ss.add(when: 'CONFIG_TERMINAL3270', if_true: files('3270-ccw.c'))
+
+virtio_ss = ss.source_set()
+virtio_ss.add(files('virtio-ccw.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_BALLOON', if_true: files('virtio-ccw-balloon.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_BLK', if_true: files('virtio-ccw-blk.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_CRYPTO', if_true: files('virtio-ccw-crypto.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_GPU', if_true: files('virtio-ccw-gpu.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_INPUT', if_true: files('virtio-ccw-input.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_NET', if_true: files('virtio-ccw-net.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_RNG', if_true: files('virtio-ccw-rng.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_SCSI', if_true: files('virtio-ccw-scsi.c'))
+virtio_ss.add(when: 'CONFIG_VIRTIO_SERIAL', if_true: files('virtio-ccw-serial.c'))
+virtio_ss.add(when: ['CONFIG_VIRTIO_9P', 'CONFIG_VIRTFS'], if_true: files('virtio-ccw-blk.c'))
+virtio_ss.add(when: 'CONFIG_VHOST_VSOCK', if_true: files('vhost-vsock-ccw.c'))
+s390x_ss.add_all(when: 'CONFIG_VIRTIO_CCW', if_true: virtio_ss)
+
+hw_arch += {'s390x': s390x_ss}
diff --git a/hw/sh4/Makefile.objs b/hw/sh4/Makefile.objs
deleted file mode 100644
index 2a707f9473..0000000000
--- a/hw/sh4/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-y += sh7750.o sh7750_regnames.o
-obj-y += sh_pci.o
-obj-$(CONFIG_R2D) +=  r2d.o
-obj-$(CONFIG_SHIX) += shix.o
diff --git a/hw/sh4/meson.build b/hw/sh4/meson.build
new file mode 100644
index 0000000000..303c0f4287
--- /dev/null
+++ b/hw/sh4/meson.build
@@ -0,0 +1,10 @@
+sh4_ss = ss.source_set()
+sh4_ss.add(files(
+  'sh7750.c',
+  'sh7750_regnames.c',
+  'sh_pci.c'
+))
+sh4_ss.add(when: 'CONFIG_R2D', if_true: files('r2d.c'))
+sh4_ss.add(when: 'CONFIG_SHIX', if_true: files('shix.c'))
+
+hw_arch += {'sh4': sh4_ss}
diff --git a/hw/sparc/Makefile.objs b/hw/sparc/Makefile.objs
deleted file mode 100644
index d57e33f83e..0000000000
--- a/hw/sparc/Makefile.objs
+++ /dev/null
@@ -1,3 +0,0 @@
-obj-$(CONFIG_SUN4M) += sun4m_iommu.o
-obj-$(CONFIG_SUN4M) += sun4m.o
-obj-$(CONFIG_LEON3) += leon3.o
diff --git a/hw/sparc/meson.build b/hw/sparc/meson.build
new file mode 100644
index 0000000000..19c442c90d
--- /dev/null
+++ b/hw/sparc/meson.build
@@ -0,0 +1,6 @@
+sparc_ss = ss.source_set()
+sparc_ss.add(when: 'CONFIG_LEON3', if_true: files('leon3.c'))
+sparc_ss.add(when: 'CONFIG_SUN4M', if_true: files('sun4m.c'))
+sparc_ss.add(when: 'CONFIG_SUN4M', if_true: files('sun4m_iommu.c'))
+
+hw_arch += {'sparc': sparc_ss}
diff --git a/hw/sparc64/Makefile.objs b/hw/sparc64/Makefile.objs
deleted file mode 100644
index af0525c1a2..0000000000
--- a/hw/sparc64/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-obj-y += sparc64.o
-obj-$(CONFIG_SUN4U) += sun4u_iommu.o
-obj-$(CONFIG_SUN4U) += sun4u.o
-obj-$(CONFIG_NIAGARA) += niagara.o
diff --git a/hw/sparc64/meson.build b/hw/sparc64/meson.build
new file mode 100644
index 0000000000..58b5504651
--- /dev/null
+++ b/hw/sparc64/meson.build
@@ -0,0 +1,6 @@
+sparc64_ss = ss.source_set()
+sparc64_ss.add(files('sparc64.c'))
+sparc64_ss.add(when: 'CONFIG_NIAGARA', if_true: files('niagara.c'))
+sparc64_ss.add(when: 'CONFIG_SUN4U', if_true: files('sun4u.c', 'sun4u_iommu.c'))
+
+hw_arch += {'sparc64': sparc64_ss}
diff --git a/hw/tricore/Makefile.objs b/hw/tricore/Makefile.objs
deleted file mode 100644
index 5501f6c1a8..0000000000
--- a/hw/tricore/Makefile.objs
+++ /dev/null
@@ -1 +0,0 @@
-obj-$(CONFIG_TRICORE) += tricore_testboard.o
diff --git a/hw/tricore/meson.build b/hw/tricore/meson.build
new file mode 100644
index 0000000000..579aa13c78
--- /dev/null
+++ b/hw/tricore/meson.build
@@ -0,0 +1,4 @@
+tricore_ss = ss.source_set()
+tricore_ss.add(when: 'CONFIG_TRICORE', if_true: files('tricore_testboard.c'))
+
+hw_arch += {'tricore': tricore_ss}
diff --git a/hw/unicore32/Makefile.objs b/hw/unicore32/Makefile.objs
deleted file mode 100644
index e0fd628523..0000000000
--- a/hw/unicore32/Makefile.objs
+++ /dev/null
@@ -1,4 +0,0 @@
-# For UniCore32 machines and boards
-
-# PKUnity-v3 SoC and board information
-obj-${CONFIG_PUV3} += puv3.o
diff --git a/hw/unicore32/meson.build b/hw/unicore32/meson.build
new file mode 100644
index 0000000000..fc26d6bcab
--- /dev/null
+++ b/hw/unicore32/meson.build
@@ -0,0 +1,5 @@
+unicore32_ss = ss.source_set()
+# PKUnity-v3 SoC and board information
+unicore32_ss.add(when: 'CONFIG_PUV3', if_true: files('puv3.c'))
+
+hw_arch += {'unicore32': unicore32_ss}
diff --git a/hw/xenpv/Makefile.objs b/hw/xenpv/Makefile.objs
deleted file mode 100644
index 8bfa4586ab..0000000000
--- a/hw/xenpv/Makefile.objs
+++ /dev/null
@@ -1,2 +0,0 @@
-# Xen PV machine support
-obj-$(CONFIG_XEN) += xen_machine_pv.o
diff --git a/hw/xenpv/meson.build b/hw/xenpv/meson.build
new file mode 100644
index 0000000000..d269a8308e
--- /dev/null
+++ b/hw/xenpv/meson.build
@@ -0,0 +1 @@
+i386_ss.add(when: 'CONFIG_XEN', if_true: files('xen_machine_pv.c'))
diff --git a/hw/xtensa/Makefile.objs b/hw/xtensa/Makefile.objs
deleted file mode 100644
index 2b40e1b60a..0000000000
--- a/hw/xtensa/Makefile.objs
+++ /dev/null
@@ -1,6 +0,0 @@
-obj-y += mx_pic.o
-obj-y += pic_cpu.o
-obj-y += xtensa_memory.o
-obj-$(CONFIG_XTENSA_SIM) += sim.o
-obj-$(CONFIG_XTENSA_VIRT) += virt.o
-obj-$(CONFIG_XTENSA_XTFPGA) += xtfpga.o
diff --git a/hw/xtensa/meson.build b/hw/xtensa/meson.build
new file mode 100644
index 0000000000..1d5835df4b
--- /dev/null
+++ b/hw/xtensa/meson.build
@@ -0,0 +1,11 @@
+xtensa_ss = ss.source_set()
+xtensa_ss.add(files(
+  'mx_pic.c',
+  'pic_cpu.c',
+  'xtensa_memory.c',
+))
+xtensa_ss.add(when: 'CONFIG_XTENSA_SIM', if_true: files('sim.c'))
+xtensa_ss.add(when: 'CONFIG_XTENSA_VIRT', if_true: files('virt.c'))
+xtensa_ss.add(when: 'CONFIG_XTENSA_XTFPGA', if_true: files('xtfpga.c'))
+
+hw_arch += {'xtensa': xtensa_ss}
diff --git a/meson.build b/meson.build
index 0c61aa5cd4..26ae726779 100644
--- a/meson.build
+++ b/meson.build
@@ -724,6 +724,10 @@ foreach target : target_dirs
   if target.endswith('-softmmu')
     qemu_target_name = 'qemu-system-' + target_name
     target_type='system'
+    hw_dir = target_name == 'sparc64' ? 'sparc64' : arch
+    hw = hw_arch[hw_dir].apply(config_target, strict: false)
+    arch_srcs += hw.sources()
+
     arch_srcs += target_devices_h[target]
   else
     target_type='user'
-- 
2.21.0



