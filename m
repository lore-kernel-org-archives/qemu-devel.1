Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF77AC004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 14:12:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92BF82053B
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 14:12:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92BF82053B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41604 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNHsb-0000dE-Rm
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 10:12:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56030)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNHeG-0004Pw-EU
	for qemu-devel@nongnu.org; Sun, 05 May 2019 09:57:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNHeE-0004s7-Fy
	for qemu-devel@nongnu.org; Sun, 05 May 2019 09:57:48 -0400
Received: from mx1.redhat.com ([209.132.183.28]:13114)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hNHeA-0004om-9G; Sun, 05 May 2019 09:57:42 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 92CFE3082231;
	Sun,  5 May 2019 13:57:41 +0000 (UTC)
Received: from thuth.com (ovpn-116-27.ams2.redhat.com [10.36.116.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 87E7C60C18;
	Sun,  5 May 2019 13:57:40 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Sun,  5 May 2019 15:57:02 +0200
Message-Id: <20190505135714.11277-17-thuth@redhat.com>
In-Reply-To: <20190505135714.11277-1-thuth@redhat.com>
References: <20190505135714.11277-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Sun, 05 May 2019 13:57:41 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 16/28] hw/arm: Express dependencies of netduino
 / stm32f2xx with Kconfig
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
Cc: qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505135702.5wOTvTV06U5auTxUFlwQYYoVq-V9wyA7qKwZyTidQg4@z>

Netduino only depends on the stm32f205 SoC which in turn depends on
its components.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak | 9 +--------
 hw/arm/Kconfig                  | 7 +++++++
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index f440a2b1cd..c86a9f5427 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -28,25 +28,18 @@ CONFIG_TOSA=3Dy
 CONFIG_Z2=3Dy
 CONFIG_COLLIE=3Dy
 CONFIG_ASPEED_SOC=3Dy
+CONFIG_NETDUINO2=3Dy
=20
 CONFIG_VGA=3Dy
 CONFIG_SSI_M25P80=3Dy
 CONFIG_ALLWINNER_EMAC=3Dy
 CONFIG_IMX_FEC=3Dy
=20
-CONFIG_NETDUINO2=3Dy
-
 CONFIG_FRAMEBUFFER=3Dy
=20
 CONFIG_DIGIC=3Dy
 CONFIG_MPS2=3Dy
 CONFIG_RASPI=3Dy
-CONFIG_STM32F2XX_TIMER=3Dy
-CONFIG_STM32F2XX_USART=3Dy
-CONFIG_STM32F2XX_SYSCFG=3Dy
-CONFIG_STM32F2XX_ADC=3Dy
-CONFIG_STM32F2XX_SPI=3Dy
-CONFIG_STM32F205_SOC=3Dy
 CONFIG_NRF51_SOC=3Dy
=20
 CONFIG_CMSDK_APB_TIMER=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index 2b63adb667..25ba109773 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -81,6 +81,7 @@ config MUSICPAL
=20
 config NETDUINO2
     bool
+    select STM32F205_SOC
=20
 config NSERIES
     bool
@@ -251,6 +252,12 @@ config RASPI
=20
 config STM32F205_SOC
     bool
+    select ARM_V7M
+    select STM32F2XX_TIMER
+    select STM32F2XX_USART
+    select STM32F2XX_SYSCFG
+    select STM32F2XX_ADC
+    select STM32F2XX_SPI
=20
 config XLNX_ZYNQMP_ARM
     bool
--=20
2.21.0


