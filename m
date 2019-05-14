Return-Path: <SRS0=VR7F=TO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4109CC04AB4
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 10:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17F9F20879
	for <qemu-devel@archiver.kernel.org>; Tue, 14 May 2019 10:05:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17F9F20879
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44606 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hQUJQ-0001EU-BH
	for qemu-devel@archiver.kernel.org; Tue, 14 May 2019 06:05:32 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49387)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hQUF5-0006vX-SW
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:01:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hQUEw-0004Je-W2
	for qemu-devel@nongnu.org; Tue, 14 May 2019 06:01:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46590)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hQUEu-00045I-1H; Tue, 14 May 2019 06:00:52 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 0957981F0C;
	Tue, 14 May 2019 10:00:48 +0000 (UTC)
Received: from thuth.com (ovpn-116-85.ams2.redhat.com [10.36.116.85])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E49695C207;
	Tue, 14 May 2019 10:00:41 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>,
	qemu-devel@nongnu.org
Date: Tue, 14 May 2019 12:00:19 +0200
Message-Id: <20190514100019.13263-5-thuth@redhat.com>
In-Reply-To: <20190514100019.13263-1-thuth@redhat.com>
References: <20190514100019.13263-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 14 May 2019 10:00:48 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 4/4] hw/misc: Add a config switch for the
 "unimplemented" device
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: qemu-trivial@nongnu.org, qemu-arm@nongnu.org, philmd@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The device is only used by certain Arm boards. Now that we have
fine-grained Kconfig for these machines, too, we can enable the
"unimplemented" devices only for the machines that really need it.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 hw/arm/Kconfig        | 9 +++++++++
 hw/microblaze/Kconfig | 1 +
 hw/misc/Kconfig       | 3 +++
 hw/misc/Makefile.objs | 2 +-
 hw/sparc64/Kconfig    | 1 +
 5 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index ac1e94f63a..7e261f5d73 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -201,6 +201,7 @@ config STELLARIS
     select SSI_SD
     select STELLARIS_INPUT
     select STELLARIS_ENET # ethernet
+    select UNIMP
=20
 config STRONGARM
     bool
@@ -267,6 +268,7 @@ config ALLWINNER_A10
     select ALLWINNER_A10_PIC
     select ALLWINNER_EMAC
     select SERIAL
+    select UNIMP
=20
 config RASPI
     bool
@@ -304,6 +306,7 @@ config XLNX_VERSAL
     select PL011
     select CADENCE
     select VIRTIO_MMIO
+    select UNIMP
=20
 config FSL_IMX25
     bool
@@ -339,6 +342,7 @@ config ASPEED_SOC
     select SSI_M25P80
     select TMP105
     select TMP421
+    select UNIMP
=20
 config MPS2
     bool
@@ -360,6 +364,7 @@ config FSL_IMX7
     select IMX_I2C
     select PCI_EXPRESS_DESIGNWARE
     select SDHCI
+    select UNIMP
=20
 config ARM_SMMUV3
     bool
@@ -371,6 +376,7 @@ config FSL_IMX6UL
     select IMX_FEC
     select IMX_I2C
     select SDHCI
+    select UNIMP
=20
 config MICROBIT
     bool
@@ -380,6 +386,7 @@ config NRF51_SOC
     bool
     select I2C
     select ARM_V7M
+    select UNIMP
=20
 config EMCRAFT_SF2
     bool
@@ -392,6 +399,7 @@ config MSF2
     select PTIMER
     select SERIAL
     select SSI
+    select UNIMP
=20
 config ZAURUS
     bool
@@ -430,6 +438,7 @@ config ARMSSE
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
index c71e07ae35..7a0902c76f 100644
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


