Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C5A5C43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 07:32:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E13AB2080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 07:32:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E13AB2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40618 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLNFS-0004As-4A
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 03:32:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56538)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLN2O-0000pT-VK
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:18:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hLN2N-0005lK-Tq
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 03:18:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:14556)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hLN2J-0005jp-FA; Tue, 30 Apr 2019 03:18:43 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 699163091785;
	Tue, 30 Apr 2019 07:18:42 +0000 (UTC)
Received: from thuth.com (ovpn-116-190.ams2.redhat.com [10.36.116.190])
	by smtp.corp.redhat.com (Postfix) with ESMTP id D9A3C1001DD2;
	Tue, 30 Apr 2019 07:18:29 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, pbonzini@redhat.com
Date: Tue, 30 Apr 2019 09:13:59 +0200
Message-Id: <20190430071405.16714-25-thuth@redhat.com>
In-Reply-To: <20190430071405.16714-1-thuth@redhat.com>
References: <20190430071405.16714-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Tue, 30 Apr 2019 07:18:42 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH v6 24/30] hw/arm: Express dependencies of the
 MSF2 / EMCRAFT_SF2 machine with Kconfig
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
	Subbaraya Sundeep <sundeep.lkml@gmail.com>,
	Rob Herring <robh@kernel.org>, qemu-block@nongnu.org,
	Andrey Smirnov <andrew.smirnov@gmail.com>,
	Antony Pavlov <antonynpavlov@gmail.com>, Joel Stanley <joel@jms.id.au>,
	Alistair Francis <alistair@alistair23.me>,
	Beniamino Galvani <b.galvani@gmail.com>, qemu-arm@nongnu.org,
	Jan Kiszka <jan.kiszka@web.de>, Cedric Le Goater <clg@kaod.org>,
	John Snow <jsnow@redhat.com>, Igor Mitsyanko <i.mitsyanko@gmail.com>,
	Philippe Mathieu-Daude <f4bug@amsat.org>,
	Jean-Christophe Dubois <jcd@tribudubois.net>,
	Andrew Jeffery <andrew@aj.id.au>, Peter Chubb <peter.chubb@nicta.com.au>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430071359.iH-njRpV2htBSzWq4MgOpvkCjmAs9CI84dFGsqmiqEo@z>

Add Kconfig dependencies for the emcraft-sf2 machine - we also
distinguish between the machine (CONFIG_EMCRAFT_SF2) and the SoC
(CONFIG_MSF2) now.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 3 +--
 hw/arm/Kconfig                  | 8 ++++++++
 hw/arm/Makefile.objs            | 3 ++-
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index ef7dd7156a..1455d083d8 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -34,9 +34,9 @@ CONFIG_MPS2=3Dy
 CONFIG_RASPI=3Dy
 CONFIG_DIGIC=3Dy
 CONFIG_SABRELITE=3Dy
+CONFIG_EMCRAFT_SF2=3Dy
=20
 CONFIG_VGA=3Dy
-CONFIG_SSI_M25P80=3Dy
 CONFIG_IMX_FEC=3Dy
=20
 CONFIG_NRF51_SOC=3Dy
@@ -49,5 +49,4 @@ CONFIG_PCIE_PORT=3Dy
 CONFIG_XIO3130=3Dy
 CONFIG_IOH3420=3Dy
 CONFIG_I82801B11=3Dy
-CONFIG_MSF2=3Dy
 CONFIG_PCI_EXPRESS_DESIGNWARE=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 0a1eab568b..7af94a8184 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -334,9 +334,17 @@ config FSL_IMX6UL
 config NRF51_SOC
     bool
=20
+config EMCRAFT_SF2
+    bool
+    select MSF2
+    select SSI_M25P80
+
 config MSF2
     bool
+    select ARM_V7M
     select PTIMER
+    select SERIAL
+    select SSI
=20
 config ZAURUS
     bool
diff --git a/hw/arm/Makefile.objs b/hw/arm/Makefile.objs
index fadd69882c..eae9f6c442 100644
--- a/hw/arm/Makefile.objs
+++ b/hw/arm/Makefile.objs
@@ -4,6 +4,7 @@ obj-$(CONFIG_ARM_VIRT) +=3D virt.o
 obj-$(CONFIG_ACPI) +=3D virt-acpi-build.o
 obj-$(CONFIG_DIGIC) +=3D digic_boards.o
 obj-$(CONFIG_EXYNOS4) +=3D exynos4_boards.o
+obj-$(CONFIG_EMCRAFT_SF2) +=3D msf2-som.o
 obj-$(CONFIG_HIGHBANK) +=3D highbank.o
 obj-$(CONFIG_INTEGRATOR) +=3D integratorcp.o
 obj-$(CONFIG_MAINSTONE) +=3D mainstone.o
@@ -41,7 +42,7 @@ obj-$(CONFIG_FSL_IMX6) +=3D fsl-imx6.o
 obj-$(CONFIG_ASPEED_SOC) +=3D aspeed_soc.o aspeed.o
 obj-$(CONFIG_MPS2) +=3D mps2.o
 obj-$(CONFIG_MPS2) +=3D mps2-tz.o
-obj-$(CONFIG_MSF2) +=3D msf2-soc.o msf2-som.o
+obj-$(CONFIG_MSF2) +=3D msf2-soc.o
 obj-$(CONFIG_MUSCA) +=3D musca.o
 obj-$(CONFIG_ARMSSE) +=3D armsse.o
 obj-$(CONFIG_FSL_IMX7) +=3D fsl-imx7.o mcimx7d-sabre.o
--=20
2.21.0


