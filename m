Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E265C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:23:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E8A072064A
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:23:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E8A072064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45424 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHBhV-0003sw-4O
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 14:23:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46416)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBNt-0004Di-SO
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:03:42 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBNs-0002cf-Qj
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:03:41 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52404)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hHBNk-0002ZB-BQ; Thu, 18 Apr 2019 14:03:33 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 7DCB9300414E;
	Thu, 18 Apr 2019 18:03:30 +0000 (UTC)
Received: from thuth.com (ovpn-116-56.ams2.redhat.com [10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 867561001DEF;
	Thu, 18 Apr 2019 18:03:24 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, pbonzini@redhat.com
Date: Thu, 18 Apr 2019 20:00:44 +0200
Message-Id: <20190418180057.3593-17-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-1-thuth@redhat.com>
References: <20190418180057.3593-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.46]);
	Thu, 18 Apr 2019 18:03:30 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-QEMU-4.1 v5 16/29] hw/arm: Express
 dependencies of the virt machine with Kconfig
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
	"Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Rob Herring <robh@kernel.org>, qemu-block@nongnu.org,
	Andrey Smirnov <andrew.smirnov@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Antony Pavlov <antonynpavlov@gmail.com>,
	Alistair Francis <alistair@alistair23.me>,
	Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
	Peter Chubb <peter.chubb@nicta.com.au>,
	Cedric Le Goater <clg@kaod.org>, John Snow <jsnow@redhat.com>,
	Andrew Jeffery <andrew@aj.id.au>, Philippe Mathieu-Daude <f4bug@amsat.org>,
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	Igor Mitsyanko <i.mitsyanko@gmail.com>, Jan Kiszka <jan.kiszka@web.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <20190418180044.pA23Ij78v2YC3tbMosMjzupzrshRKIX9JtI8qWf6rAM@z>

Dependencies have been determined by looking at hw/arm/virt.c

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 11 +----------
 hw/arm/Kconfig                  | 19 +++++++++++++++++++
 hw/arm/Makefile.objs            |  3 ++-
 3 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 2580584281..f440a2b1cd 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -6,6 +6,7 @@ CONFIG_ARM_V7M=3Dy
 # CONFIG_PCI_DEVICES=3Dn
 # CONFIG_TEST_DEVICES=3Dn
=20
+CONFIG_ARM_VIRT=3Dy
 CONFIG_EXYNOS4=3Dy
 CONFIG_HIGHBANK=3Dy
 CONFIG_INTEGRATOR=3Dy
@@ -32,8 +33,6 @@ CONFIG_VGA=3Dy
 CONFIG_SSI_M25P80=3Dy
 CONFIG_ALLWINNER_EMAC=3Dy
 CONFIG_IMX_FEC=3Dy
-CONFIG_PLATFORM_BUS=3Dy
-CONFIG_VIRTIO_MMIO=3Dy
=20
 CONFIG_NETDUINO2=3Dy
=20
@@ -68,9 +67,6 @@ CONFIG_IOTKIT_SYSINFO=3Dy
 CONFIG_ARMSSE_CPUID=3Dy
 CONFIG_ARMSSE_MHU=3Dy
=20
-CONFIG_PCI_EXPRESS=3Dy
-CONFIG_PCI_EXPRESS_GENERIC_BRIDGE=3Dy
-
 CONFIG_ALLWINNER_A10_PIT=3Dy
 CONFIG_ALLWINNER_A10_PIC=3Dy
 CONFIG_ALLWINNER_A10=3Dy
@@ -86,10 +82,5 @@ CONFIG_PCIE_PORT=3Dy
 CONFIG_XIO3130=3Dy
 CONFIG_IOH3420=3Dy
 CONFIG_I82801B11=3Dy
-CONFIG_ACPI=3Dy
-CONFIG_ARM_VIRT=3Dy
-CONFIG_SMBIOS=3Dy
-CONFIG_GPIO_KEY=3Dy
 CONFIG_MSF2=3Dy
-CONFIG_FW_CFG_DMA=3Dy
 CONFIG_PCI_EXPRESS_DESIGNWARE=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index abeaa54d88..4d0febf644 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -1,6 +1,24 @@
 config ARM_VIRT
     bool
+    imply PCI_DEVICES
+    imply TEST_DEVICES
+    imply VFIO_AMD_XGBE
     imply VFIO_PLATFORM
+    imply VFIO_XGMAC
+    select A15MPCORE
+    select ACPI
+    select ARM_SMMUV3
+    select GPIO_KEY
+    select FW_CFG_DMA
+    select PCI_EXPRESS
+    select PCI_EXPRESS_GENERIC_BRIDGE
+    select PFLASH_CFI01
+    select PL011 # UART
+    select PL031 # RTC
+    select PL061 # GPIO
+    select PLATFORM_BUS
+    select SMBIOS
+    select VIRTIO_MMIO
=20
 config CHEETAH
     bool
@@ -298,6 +316,7 @@ config A9MPCORE
=20
 config A15MPCORE
     bool
+    select ARM_GIC
=20
 config ARM11MPCORE
     bool
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index 729e711b87..4f591ca487 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -1,4 +1,5 @@
-obj-y +=3D boot.o sysbus-fdt.o
+obj-y +=3D boot.o
+obj-$(CONFIG_PLATFORM_BUS) +=3D sysbus-fdt.o
 obj-$(CONFIG_ARM_VIRT) +=3D virt.o
 obj-$(CONFIG_ACPI) +=3D virt-acpi-build.o
 obj-$(CONFIG_DIGIC) +=3D digic_boards.o
--=20
2.21.0


