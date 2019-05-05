Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5EADC004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 14:08:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8C19D206DF
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 14:08:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8C19D206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:41525 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNHoU-0005E9-Qc
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 10:08:22 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55976)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNHeB-0004JC-79
	for qemu-devel@nongnu.org; Sun, 05 May 2019 09:57:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1hNHe9-0004ou-Sw
	for qemu-devel@nongnu.org; Sun, 05 May 2019 09:57:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60430)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>)
	id 1hNHe7-0004mj-DS; Sun, 05 May 2019 09:57:39 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
	[10.5.11.12])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id B5081307D857;
	Sun,  5 May 2019 13:57:38 +0000 (UTC)
Received: from thuth.com (ovpn-116-27.ams2.redhat.com [10.36.116.27])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A86A260C18;
	Sun,  5 May 2019 13:57:37 +0000 (UTC)
From: Thomas Huth <thuth@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>,
	qemu-devel@nongnu.org
Date: Sun,  5 May 2019 15:57:00 +0200
Message-Id: <20190505135714.11277-15-thuth@redhat.com>
In-Reply-To: <20190505135714.11277-1-thuth@redhat.com>
References: <20190505135714.11277-1-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.48]);
	Sun, 05 May 2019 13:57:38 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PULL 14/28] hw/arm: Express dependencies of the
 aspeed boards with Kconfig
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
Message-ID: <20190505135700.iE9dyn6ONiKj0vsqmPrm80pBoviBWaNTGFcQsAW-Zqc@z>

Dependencies have been determined by looking at hw/arm/aspeed.c

Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>
Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
Signed-off-by: Thomas Huth <thuth@redhat.com>
---
 default-configs/arm-softmmu.mak |  7 +------
 hw/arm/Kconfig                  | 10 ++++++++++
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/default-configs/arm-softmmu.mak b/default-configs/arm-softmm=
u.mak
index 25e8f717ac..2580584281 100644
--- a/default-configs/arm-softmmu.mak
+++ b/default-configs/arm-softmmu.mak
@@ -26,15 +26,12 @@ CONFIG_SPITZ=3Dy
 CONFIG_TOSA=3Dy
 CONFIG_Z2=3Dy
 CONFIG_COLLIE=3Dy
+CONFIG_ASPEED_SOC=3Dy
=20
 CONFIG_VGA=3Dy
-CONFIG_TMP421=3Dy
-CONFIG_PCA9552=3Dy
 CONFIG_SSI_M25P80=3Dy
 CONFIG_ALLWINNER_EMAC=3Dy
 CONFIG_IMX_FEC=3Dy
-CONFIG_FTGMAC100=3Dy
-CONFIG_DS1338=3Dy
 CONFIG_PLATFORM_BUS=3Dy
 CONFIG_VIRTIO_MMIO=3Dy
=20
@@ -92,8 +89,6 @@ CONFIG_I82801B11=3Dy
 CONFIG_ACPI=3Dy
 CONFIG_ARM_VIRT=3Dy
 CONFIG_SMBIOS=3Dy
-CONFIG_ASPEED_SOC=3Dy
-CONFIG_SMBUS_EEPROM=3Dy
 CONFIG_GPIO_KEY=3Dy
 CONFIG_MSF2=3Dy
 CONFIG_FW_CFG_DMA=3Dy
diff --git a/hw/arm/Kconfig b/hw/arm/Kconfig
index a507144d9a..95ac0b540e 100644
--- a/hw/arm/Kconfig
+++ b/hw/arm/Kconfig
@@ -255,6 +255,16 @@ config FSL_IMX6
=20
 config ASPEED_SOC
     bool
+    select DS1338
+    select FTGMAC100
+    select I2C
+    select PCA9552
+    select SERIAL
+    select SMBUS_EEPROM
+    select SSI
+    select SSI_M25P80
+    select TMP105
+    select TMP421
=20
 config MPS2
     bool
--=20
2.21.0


