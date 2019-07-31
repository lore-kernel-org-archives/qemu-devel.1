Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06553C32751
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 08:00:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDA86206A2
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 08:00:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDA86206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsjXd-0001cN-1W
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 04:00:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58783)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <thuth@redhat.com>) id 1hsjUD-0002de-SE
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 03:57:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <thuth@redhat.com>) id 1hsjUC-0008IS-LG
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 03:57:25 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36722)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <thuth@redhat.com>)
 id 1hsjUA-0008Ck-6N; Wed, 31 Jul 2019 03:57:22 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 78CF7C057F2C;
 Wed, 31 Jul 2019 07:57:21 +0000 (UTC)
Received: from thuth.com (dhcp-200-228.str.redhat.com [10.33.200.228])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C407C5C1B5;
 Wed, 31 Jul 2019 07:57:19 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>, Yang Zhong <yang.zhong@intel.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
Date: Wed, 31 Jul 2019 09:56:51 +0200
Message-Id: <20190731075652.17053-8-thuth@redhat.com>
In-Reply-To: <20190731075652.17053-1-thuth@redhat.com>
References: <20190731075652.17053-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Wed, 31 Jul 2019 07:57:21 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v2 7/8] hw/misc: Add a config switch for the
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
Cc: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-arm@nongnu.org,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The device is only used by some few boards. Let's use a proper Kconfig
switch so that we only compile this code if we really need it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/Kconfig        | 9 +++++++++
 hw/microblaze/Kconfig | 1 +
 hw/misc/Kconfig       | 3 +++
 hw/misc/Makefile.objs | 2 +-
 hw/sparc64/Kconfig    | 1 +
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 6e24c73b54..ab9e592d74 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -217,6 +217,7 @@ config STELLARIS
     select SSI_SD
     select STELLARIS_INPUT
     select STELLARIS_ENET # ethernet
+    select UNIMP
=20
 config STRONGARM
     bool
@@ -283,6 +284,7 @@ config ALLWINNER_A10
     select ALLWINNER_A10_PIC
     select ALLWINNER_EMAC
     select SERIAL
+    select UNIMP
=20
 config RASPI
     bool
@@ -320,6 +322,7 @@ config XLNX_VERSAL
     select PL011
     select CADENCE
     select VIRTIO_MMIO
+    select UNIMP
=20
 config FSL_IMX25
     bool
@@ -355,6 +358,7 @@ config ASPEED_SOC
     select SSI_M25P80
     select TMP105
     select TMP421
+    select UNIMP
=20
 config MPS2
     bool
@@ -378,6 +382,7 @@ config FSL_IMX7
     select IMX_I2C
     select PCI_EXPRESS_DESIGNWARE
     select SDHCI
+    select UNIMP
=20
 config ARM_SMMUV3
     bool
@@ -389,6 +394,7 @@ config FSL_IMX6UL
     select IMX_FEC
     select IMX_I2C
     select SDHCI
+    select UNIMP
=20
 config MICROBIT
     bool
@@ -398,6 +404,7 @@ config NRF51_SOC
     bool
     select I2C
     select ARM_V7M
+    select UNIMP
=20
 config EMCRAFT_SF2
     bool
@@ -410,6 +417,7 @@ config MSF2
     select PTIMER
     select SERIAL
     select SSI
+    select UNIMP
=20
 config ZAURUS
     bool
@@ -448,6 +456,7 @@ config ARMSSE
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
2.21.0


