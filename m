Return-Path: <SRS0=Qbil=AU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 592F1C433E0
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:43:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 210E5206DF
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jul 2020 00:43:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VtxO58gz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 210E5206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=reject dis=none) header.from=google.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42442 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jtKev-0007MI-ER
	for qemu-devel@archiver.kernel.org; Wed, 08 Jul 2020 20:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48296)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from
 <3nmYGXwsKCoMozrpuultvlunvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--hskinnemoen.bounces.google.com>)
 id 1jtKYU-0006uG-Tc
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:36:50 -0400
Received: from mail-qv1-xf4a.google.com ([2607:f8b0:4864:20::f4a]:56215)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from
 <3nmYGXwsKCoMozrpuultvlunvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--hskinnemoen.bounces.google.com>)
 id 1jtKYS-000141-GC
 for qemu-devel@nongnu.org; Wed, 08 Jul 2020 20:36:50 -0400
Received: by mail-qv1-xf4a.google.com with SMTP id a12so263550qvt.22
 for <qemu-devel@nongnu.org>; Wed, 08 Jul 2020 17:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=date:in-reply-to:message-id:mime-version:references:subject:from:to
 :cc:content-transfer-encoding;
 bh=4kEgWgHbRpLkO6qJk1qfJXYTlwg9/1nOLKkMOgmQiJc=;
 b=VtxO58gz8PNHQHMZwb1mlisFTYXbvxgG1/iBXGRGmMc0Qtkm2hvC540WlnPYgUjNOY
 VsNgPcL3q7kzfNxP6CAh9VaGaCRmzEoWje+7YJidBUB0jzd9WJ+fogrgz5JisB9zV8ME
 LNSrDLa1Kv270EkDU8tZTqzQjR81d65aHcIcmpzVSwuPUDuK1E7yN27Iy9clnswCWX8K
 ZoAtQzxLCSLZkxyiAfRqcHsyIT3rJR21fPg6W7Hwd7nHaNmgo0OoKhnrs23qMDB7Flee
 zEQWPBxlqWpXnVvtOoEUvULxWdPSVjQebqgCZWmHj8trp8938ROpYHkoN6jt/Y26GmH2
 hGow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:in-reply-to:message-id:mime-version
 :references:subject:from:to:cc:content-transfer-encoding;
 bh=4kEgWgHbRpLkO6qJk1qfJXYTlwg9/1nOLKkMOgmQiJc=;
 b=frSbNIH+aNGihibuhYPmckJY92LK8UA697DiS3X/NIAXDRFj/TikviROXOnapBlmeS
 jvLOCOZkvnELheGbD2AD3lo64utropA/ggJ6OjGr3UM9uTWjpcK1D0y4V1U3/6x9YX+K
 RWPNRNMI9yhBTlsvjOlW3OxHeKBi9tzuQuJHO9xI+zONNx/fptujvML9N45DMgWYivoB
 6Vamo3GRrleV8myYo3oP++wuTMrZMQKuju/ee2MA18PaboRPerdDUzHPc2eKnhhZB+GG
 FPjRFQlR5aXo0a/Yfrda72W0w2gkEZI++YyeiW1RPPvmUNGV3Q7HpWO7xmpAcww6h++B
 yzXw==
X-Gm-Message-State: AOAM530EDqSB1RU1TQZEa8eFxb74I4ZI0J5MeRsGFXYZ7l0kFnv6rvC3
 ciVK10B7deA8n5slH40FEFE+jz+VrFQ6k8Auzg==
X-Google-Smtp-Source: ABdhPJy8ZjBUgvySB4tP65LKCkKFh6zi/gRZZ0dlN3axqfbFSUL0YawLTgA+YJgpDhZXdlVW98bfRyBs2QwH4T4SSA==
X-Received: by 2002:a0c:800e:: with SMTP id 14mr49947224qva.92.1594255006971; 
 Wed, 08 Jul 2020 17:36:46 -0700 (PDT)
Date: Wed,  8 Jul 2020 17:36:08 -0700
In-Reply-To: <20200709003608.3834629-1-hskinnemoen@google.com>
Message-Id: <20200709003608.3834629-12-hskinnemoen@google.com>
Mime-Version: 1.0
References: <20200709003608.3834629-1-hskinnemoen@google.com>
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v5 11/11] docs/system: Add Nuvoton machine documentation
From: Havard Skinnemoen <hskinnemoen@google.com>
To: peter.maydell@linaro.org, f4bug@amsat.org
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, Avi.Fishman@nuvoton.com, 
 kfting@nuvoton.com, Havard Skinnemoen <hskinnemoen@google.com>, 
 "=?UTF-8?q?C=C3=A9dric=20Le=20Goater?=" <clg@kaod.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::f4a;
 envelope-from=3nmYGXwsKCoMozrpuultvlunvvnsl.jvtxlt1-kl2lsuvunu1.vyn@flex--hskinnemoen.bounces.google.com;
 helo=mail-qv1-xf4a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -95
X-Spam_score: -9.6
X-Spam_bar: ---------
X-Spam_report: (-9.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_MED=-1,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 PDS_OTHER_BAD_TLD=1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, URIBL_BLOCKED=0.001,
 USER_IN_DEF_DKIM_WL=-7.5 autolearn=ham autolearn_force=no
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

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Signed-off-by: Havard Skinnemoen <hskinnemoen@google.com>
---
 docs/system/arm/nuvoton.rst | 92 +++++++++++++++++++++++++++++++++++++
 docs/system/target-arm.rst  |  1 +
 2 files changed, 93 insertions(+)
 create mode 100644 docs/system/arm/nuvoton.rst

diff --git a/docs/system/arm/nuvoton.rst b/docs/system/arm/nuvoton.rst
new file mode 100644
index 0000000000..7384662d58
--- /dev/null
+++ b/docs/system/arm/nuvoton.rst
@@ -0,0 +1,92 @@
+Nuvoton iBMC boards (``npcm750-evb``, ``quanta-gsj``)
+=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D
+
+The `Nuvoton iBMC`_ chips (NPCM7xx) are a family of ARM-based SoCs that ar=
e
+designed to be used as Baseboard Management Controllers (BMCs) in various
+servers. They all feature one or two ARM Cortex A9 CPU cores, as well as a=
n
+assortment of peripherals targeted for either Enterprise or Data Center /
+Hyperscale applications. The former is a superset of the latter, so NPCM75=
0 has
+all the peripherals of NPCM730 and more.
+
+.. _Nuvoton iBMC: https://www.nuvoton.com/products/cloud-computing/ibmc/
+
+The NPCM750 SoC has two Cortex A9 cores and is targeted for the Enterprise
+segment. The following machines are based on this chip :
+
+- ``npcm750-evb``       Nuvoton NPCM750 Evaluation board
+
+The NPCM730 SoC has two Cortex A9 cores and is targeted for Data Center an=
d
+Hyperscale applications. The following machines are based on this chip :
+
+- ``quanta-gsj``        Quanta GSJ server BMC
+
+There are also two more SoCs, NPCM710 and NPCM705, which are single-core
+variants of NPCM750 and NPCM730, respectively. These are currently not
+supported by QEMU.
+
+Supported devices
+-----------------
+
+ * SMP (Dual Core Cortex-A9)
+ * Cortex-A9MPCore built-in peripherals: SCU, GIC, Global Timer, Private T=
imer
+   and Watchdog.
+ * SRAM, ROM and DRAM mappings
+ * System Global Control Registers (GCR)
+ * Clock and reset controller (CLK)
+ * Timer controller (TIM)
+ * Serial ports (16550-based)
+ * DDR4 memory controller (dummy interface indicating memory training is d=
one)
+ * OTP controllers (no protection features)
+ * Flash Interface Unit (FIU; no protection features)
+
+Missing devices
+---------------
+
+ * GPIO controller
+ * LPC/eSPI host-to-BMC interface, including
+
+   * Keyboard and mouse controller interface (KBCI)
+   * Keyboard Controller Style (KCS) channels
+   * BIOS POST code FIFO
+   * System Wake-up Control (SWC)
+   * Shared memory (SHM)
+   * eSPI slave interface
+
+ * Ethernet controllers (GMAC and EMC)
+ * USB host (USBH)
+ * USB device (USBD)
+ * SMBus controller (SMBF)
+ * Peripheral SPI controller (PSPI)
+ * Analog to Digital Converter (ADC)
+ * SD/MMC host
+ * Random Number Generator (RNG)
+ * PECI interface
+ * Pulse Width Modulation (PWM)
+ * Tachometer
+ * PCI and PCIe root complex and bridges
+ * VDM and MCTP support
+ * Serial I/O expansion
+ * LPC/eSPI host
+ * Coprocessor
+ * Graphics
+ * Video capture
+ * Encoding compression engine
+ * Security features
+
+Boot options
+------------
+
+The Nuvoton machines can boot from an OpenBMC firmware image, or directly =
into
+a kernel using the ``-kernel`` option. OpenBMC images for `quanta-gsj` and
+possibly others can be downloaded from the OpenPOWER jenkins :
+
+   https://openpower.xyz/
+
+Booting a full firmware image requires a Boot ROM specified via the ``-bio=
s``
+option to QEMU. The firmware image should be attached as an MTD drive. Exa=
mple :
+
+.. code-block:: bash
+
+  $ qemu-system-arm -machine quanta-gsj -nographic \
+      -bios npcm7xx_bootrom.bin \
+      -drive file=3Dimage-bmc,if=3Dmtd,bus=3D0,unit=3D0,format=3Draw
diff --git a/docs/system/target-arm.rst b/docs/system/target-arm.rst
index 1bd477a293..38a9daa9b9 100644
--- a/docs/system/target-arm.rst
+++ b/docs/system/target-arm.rst
@@ -84,6 +84,7 @@ undocumented; you can get a complete list by running
    arm/aspeed
    arm/musicpal
    arm/nseries
+   arm/nuvoton
    arm/orangepi
    arm/palm
    arm/xscale
--=20
2.27.0.383.g050319c2ae-goog


