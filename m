Return-Path: <SRS0=VgPO=WQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C120C3A589
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 08:04:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD6623A5C
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Aug 2019 08:04:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4FD6623A5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34408 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hzyyN-0008SM-8F
	for qemu-devel@archiver.kernel.org; Tue, 20 Aug 2019 03:54:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49521)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <thuth@redhat.com>) id 1hzysE-00087f-E8
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:48:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hzysD-0004UU-1l
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:48:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49220)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>) id 1hzysC-0004Tx-QI
 for qemu-devel@nongnu.org; Tue, 20 Aug 2019 03:48:08 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1C857102BB36;
 Tue, 20 Aug 2019 07:48:08 +0000 (UTC)
Received: from thuth.com (ovpn-116-232.ams2.redhat.com [10.36.116.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0F542100195C;
 Tue, 20 Aug 2019 07:48:06 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Tue, 20 Aug 2019 09:47:48 +0200
Message-Id: <20190820074749.25208-8-thuth@redhat.com>
In-Reply-To: <20190820074749.25208-1-thuth@redhat.com>
References: <20190820074749.25208-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2
 (mx1.redhat.com [10.5.110.64]); Tue, 20 Aug 2019 07:48:08 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 7/8] hw/misc: Add a config switch for the
 "unimplemented" device
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
Cc: philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The device is only used by some few boards. Let's use a proper Kconfig
switch so that we only compile this code if we really need it.

Message-Id: <20190817101931.28386-8-thuth@redhat.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/Kconfig        | 11 +++++++++++
 hw/microblaze/Kconfig |  1 +
 hw/misc/Kconfig       |  3 +++
 hw/misc/Makefile.objs |  2 +-
 hw/sparc64/Kconfig    |  1 +
 5 files changed, 17 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 6e24c73b54..76a2a6bcbf 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -82,6 +82,7 @@ config MUSCA
     select PL011
     select PL031
     select SPLIT_IRQ
+    select UNIMP
=20
 config MUSICPAL
     bool
@@ -217,6 +218,7 @@ config STELLARIS
     select SSI_SD
     select STELLARIS_INPUT
     select STELLARIS_ENET # ethernet
+    select UNIMP
=20
 config STRONGARM
     bool
@@ -283,6 +285,7 @@ config ALLWINNER_A10
     select ALLWINNER_A10_PIC
     select ALLWINNER_EMAC
     select SERIAL
+    select UNIMP
=20
 config RASPI
     bool
@@ -320,6 +323,7 @@ config XLNX_VERSAL
     select PL011
     select CADENCE
     select VIRTIO_MMIO
+    select UNIMP
=20
 config FSL_IMX25
     bool
@@ -355,6 +359,7 @@ config ASPEED_SOC
     select SSI_M25P80
     select TMP105
     select TMP421
+    select UNIMP
=20
 config MPS2
     bool
@@ -366,6 +371,7 @@ config MPS2
     select PL022    # Serial port
     select PL080    # DMA controller
     select SPLIT_IRQ
+    select UNIMP
=20
 config FSL_IMX7
     bool
@@ -378,6 +384,7 @@ config FSL_IMX7
     select IMX_I2C
     select PCI_EXPRESS_DESIGNWARE
     select SDHCI
+    select UNIMP
=20
 config ARM_SMMUV3
     bool
@@ -389,6 +396,7 @@ config FSL_IMX6UL
     select IMX_FEC
     select IMX_I2C
     select SDHCI
+    select UNIMP
=20
 config MICROBIT
     bool
@@ -398,6 +406,7 @@ config NRF51_SOC
     bool
     select I2C
     select ARM_V7M
+    select UNIMP
=20
 config EMCRAFT_SF2
     bool
@@ -410,6 +419,7 @@ config MSF2
     select PTIMER
     select SERIAL
     select SSI
+    select UNIMP
=20
 config ZAURUS
     bool
@@ -448,6 +458,7 @@ config ARMSSE
     select TZ_MPC
     select TZ_MSC
     select TZ_PPC
+    select UNIMP
=20
 config ARMSSE_CPUID
     bool
diff --git a/hw/microblaze/Kconfig b/hw/microblaze/Kconfig
index c4dc120973..e2697ced9c 100644
--- a/hw/microblaze/Kconfig
+++ b/hw/microblaze/Kconfig
@@ -4,6 +4,7 @@ config PETALOGIX_S3ADSP1800
     select XILINX
     select XILINX_AXI
     select XILINX_ETHLITE
+    select UNIMP
=20
 config PETALOGIX_ML605
     bool
diff --git a/hw/misc/Kconfig b/hw/misc/Kconfig
index 385e1b0cec..51754bb47c 100644
--- a/hw/misc/Kconfig
+++ b/hw/misc/Kconfig
@@ -117,4 +117,7 @@ config AUX
     bool
     select I2C
=20
+config UNIMP
+    bool
+
 source macio/Kconfig
diff --git a/hw/misc/Makefile.objs b/hw/misc/Makefile.objs
index e9aab519a1..e4aad707fb 100644
--- a/hw/misc/Makefile.objs
+++ b/hw/misc/Makefile.objs
@@ -9,7 +9,7 @@ common-obj-$(CONFIG_PCI_TESTDEV) +=3D pci-testdev.o
 common-obj-$(CONFIG_EDU) +=3D edu.o
 common-obj-$(CONFIG_PCA9552) +=3D pca9552.o
=20
-common-obj-y +=3D unimp.o
+common-obj-$(CONFIG_UNIMP) +=3D unimp.o
 common-obj-$(CONFIG_FW_CFG_DMA) +=3D vmcoreinfo.o
=20
 # ARM devices
diff --git a/hw/sparc64/Kconfig b/hw/sparc64/Kconfig
index d4d76a89be..f9f8b0f73a 100644
--- a/hw/sparc64/Kconfig
+++ b/hw/sparc64/Kconfig
@@ -17,3 +17,4 @@ config NIAGARA
     bool
     select EMPTY_SLOT
     select SUN4V_RTC
+    select UNIMP
--=20
2.18.1


