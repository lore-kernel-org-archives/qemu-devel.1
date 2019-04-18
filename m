Return-Path: <SRS0=08iY=SU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 06761C10F0E
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:17:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD008206B6
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Apr 2019 18:16:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD008206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:45281 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hHBak-0006Xy-WA
	for qemu-devel@archiver.kernel.org; Thu, 18 Apr 2019 14:16:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBOX-0004kV-OI
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:04:22 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hHBOV-0002xA-9c
	for qemu-devel@nongnu.org; Thu, 18 Apr 2019 14:04:21 -0400
Received: from mx1.redhat.com ([209.132.183.28]:28747)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hHBOK-0002jV-DL; Thu, 18 Apr 2019 14:04:09 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 747083D945;
	Thu, 18 Apr 2019 18:03:59 +0000 (UTC)
Received: from thuth.com (ovpn-116-56.ams2.redhat.com [10.36.116.56])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9CF2110816BC;
	Thu, 18 Apr 2019 18:03:50 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: yang.zhong@intel.com, Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org, pbonzini@redhat.com
Date: Thu, 18 Apr 2019 20:00:47 +0200
Message-Id: <20190418180057.3593-20-thuth@redhat.com>
In-Reply-To: <20190418180057.3593-1-thuth@redhat.com>
References: <20190418180057.3593-1-thuth@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Thu, 18 Apr 2019 18:03:59 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH for-QEMU-4.1 v5 19/29] hw/arm: Express
 dependencies of the MPS2 boards with Kconfig
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
Message-ID: <20190418180047.G9h4MSvQFnrAYLz9825M_ysX62P4oK-ikPirVPkO3XQ@z>

Add Kconfig dependencies for the mps2-an* machines.

Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 20 +-------------------
 hw/arm/Kconfig                  | 18 ++++++++++++++++++
 2 files changed, 19 insertions(+), 19 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index a0b9016e3a..31d31d3f4a 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -30,6 +30,7 @@ CONFIG_Z2=3Dy
 CONFIG_COLLIE=3Dy
 CONFIG_ASPEED_SOC=3Dy
 CONFIG_NETDUINO2=3Dy
+CONFIG_MPS2=3Dy
=20
 CONFIG_VGA=3Dy
 CONFIG_SSI_M25P80=3Dy
@@ -38,28 +39,9 @@ CONFIG_IMX_FEC=3Dy
 CONFIG_FRAMEBUFFER=3Dy
=20
 CONFIG_DIGIC=3Dy
-CONFIG_MPS2=3Dy
 CONFIG_RASPI=3Dy
 CONFIG_NRF51_SOC=3Dy
=20
-CONFIG_CMSDK_APB_TIMER=3Dy
-CONFIG_CMSDK_APB_DUALTIMER=3Dy
-CONFIG_CMSDK_APB_UART=3Dy
-CONFIG_CMSDK_APB_WATCHDOG=3Dy
-
-CONFIG_MPS2_FPGAIO=3Dy
-CONFIG_MPS2_SCC=3Dy
-
-CONFIG_TZ_MPC=3Dy
-CONFIG_TZ_MSC=3Dy
-CONFIG_TZ_PPC=3Dy
-CONFIG_ARMSSE=3Dy
-CONFIG_IOTKIT_SECCTL=3Dy
-CONFIG_IOTKIT_SYSCTL=3Dy
-CONFIG_IOTKIT_SYSINFO=3Dy
-CONFIG_ARMSSE_CPUID=3Dy
-CONFIG_ARMSSE_MHU=3Dy
-
 CONFIG_FSL_IMX6=3Dy
 CONFIG_FSL_IMX25=3Dy
 CONFIG_FSL_IMX7=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2ef5696900..466b143fdf 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -301,6 +301,12 @@ config ASPEED_SOC
=20
 config MPS2
     bool
+    select ARMSSE
+    select LAN9118
+    select MPS2_FPGAIO
+    select MPS2_SCC
+    select PL022    # Serial port
+    select PL080    # DMA controller
=20
 config FSL_IMX7
     bool
@@ -340,6 +346,18 @@ config ARM11MPCORE
=20
 config ARMSSE
     bool
+    select ARMSSE_CPUID
+    select ARMSSE_MHU
+    select CMSDK_APB_TIMER
+    select CMSDK_APB_DUALTIMER
+    select CMSDK_APB_UART
+    select CMSDK_APB_WATCHDOG
+    select IOTKIT_SECCTL
+    select IOTKIT_SYSCTL
+    select IOTKIT_SYSINFO
+    select TZ_MPC
+    select TZ_MSC
+    select TZ_PPC
=20
 config ARMSSE_CPUID
     bool
--=20
2.21.0


