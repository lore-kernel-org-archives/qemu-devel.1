Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EB728CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:49:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C00A221D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:49:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C00A221D71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNvHn-0005w8-I8
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 04:49:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49948)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNv51-0000mf-7Y
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNv4z-0007tY-SA
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:19 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:42539)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNv4p-0007i4-NA; Fri, 25 Oct 2019 04:36:07 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MPXta-1iacMQ3LTG-00Mbyg; Fri, 25 Oct 2019 10:35:33 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 06/19] hw/timer: Compile devices not target-dependent as common
 object
Date: Fri, 25 Oct 2019 10:34:58 +0200
Message-Id: <20191025083511.11463-7-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025083511.11463-1-laurent@vivier.eu>
References: <20191025083511.11463-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:fJ4V1AnXTAcItYSV9oR8i35L0OGfAII0+g067o8KOiaQpL/F/Dy
 ZwprbljE8vnKw8Swcki38wOLABSHSdwgvzsbd+ruAOD6OewQ2dfUeIPD3xqRfGXKlWl8MGW
 uN+u7znWyXKIvvd+uqmtszoEu4aaEcKL/AakDVxCLTeOfq8keKigQPyAktuA1038zubP+aE
 R0KAfL6HP8jiXkSihxieg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:2Rpo3xlo6y0=:J14/lgwOwfUNXqY26XKPK6
 /LCbiixh3U/3SOte/ZGRUhk+qolPY5xQqR270PaRTA3v/G2M+NOBR+aLMRmKFJPx4NdV/1ltx
 fv72HigBTOsZPL/BZJ+Et2RcShxvX28bivAsnJ2IlswAaPXI6xKuSVQ8NSB8qc5fBMccYLuEj
 F5qF4fkimZFsbsgoXyYmry9jl0cWgRd2hU4F22Bs49KlwCJuGSCrh5QFTKUmHn3N0ZE+jiB6W
 ZDf1pBmPYrsXfG9DVDbkGzPQJeocDJzxvh5uGm+Mrdgx3udtJ11UJpNWjQ6SKrAHxff413K8P
 xzagBpNEGKT4O2LUZsJ2fECKH60Llus3OwJ30mQyB2/p4JOIm/upvzxyx3cW6xt2EuKOjo+mr
 NcSHPmpzoYPhrzGFrUomDARcEsRLJ58rBbCObt91brilSotJ8rF/o6Vs/Gv0iDiYSI8AXAbGE
 B1W8Ias8YXT+zsuQm5KKja5bjWPWCbN9STEQquRCYj256usZuLNi9ms0n2GsDu4VvKc5ilGz6
 N9KTMkJieMGuT0JQYAUJZXUPw0t7jiqBk9UWsjJir50pZOyB1ncdpY2h3S7+4J/HSanLbYPTt
 Lj4FBn5fktue0bg3uDk0+Io9V6rDCtvvxiy3zKx6yBVjm5cM2PzaQopdc+zdIjKvpcktqw/vy
 HtFm25iYMsF8SRj35bU1kG9q+iIiITv+yAp2wzNkm1JevXaFgUAQl/djX+XMaDQVjoeGk7y8d
 2rJOl/ShR9yxS20Tx5wuxhNJRlFYqxvNLu+qz9YoBdOeEjD6pGeNlhJIPqwtJEUqibuT7wXod
 mVE40dupzFuta57phzfzRSI6J/I4S3cymRmnXEpBe4dwb09KizjrRiofQwws+hKwn6Gq0lZNl
 o5vwYz3el7btGeww7WCqF4c5qSYOgtzRxedd5CLao=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.134
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alistair Francis <alistair.francis@wdc.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-block@nongnu.org,
 qemu-trivial@nongnu.org, Helge Deller <deller@gmx.de>,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Laurent Vivier <lvivier@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Alistair Francis <alistair@alistair23.me>, qemu-arm@nongnu.org,
 =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <rth@twiddle.net>, Andrew Jeffery <andrew@aj.id.au>,
 Laurent Vivier <laurent@vivier.eu>, Aleksandar Rikalo <arikalo@wavecomp.com>,
 qemu-ppc@nongnu.org, Aleksandar Markovic <amarkovic@wavecomp.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

All these devices do not contain any target-specific. While most
of them are arch-specific, they are shared between different
targets of the same arch family (ARM and AArch64, MIPS32/MIPS64,
endianess, ...).
Put them into common-obj-y to compile them once for all targets.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Reviewed-by: Thomas Huth <thuth@redhat.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191003230404.19384-2-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/timer/Makefile.objs | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 123d92c9692c..f407523aa49d 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -25,20 +25,20 @@ common-obj-$(CONFIG_MILKYMIST) += milkymist-sysctl.o
 common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-rtc.o
 common-obj-$(CONFIG_NRF51_SOC) += nrf51_timer.o
 
-obj-$(CONFIG_ALTERA_TIMER) += altera_timer.o
-obj-$(CONFIG_EXYNOS4) += exynos4210_mct.o
-obj-$(CONFIG_EXYNOS4) += exynos4210_pwm.o
-obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
-obj-$(CONFIG_OMAP) += omap_gptimer.o
-obj-$(CONFIG_OMAP) += omap_synctimer.o
-obj-$(CONFIG_PXA2XX) += pxa2xx_timer.o
-obj-$(CONFIG_SH4) += sh_timer.o
-obj-$(CONFIG_DIGIC) += digic-timer.o
-obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
+common-obj-$(CONFIG_ALTERA_TIMER) += altera_timer.o
+common-obj-$(CONFIG_EXYNOS4) += exynos4210_mct.o
+common-obj-$(CONFIG_EXYNOS4) += exynos4210_pwm.o
+common-obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
+common-obj-$(CONFIG_OMAP) += omap_gptimer.o
+common-obj-$(CONFIG_OMAP) += omap_synctimer.o
+common-obj-$(CONFIG_PXA2XX) += pxa2xx_timer.o
+common-obj-$(CONFIG_SH4) += sh_timer.o
+common-obj-$(CONFIG_DIGIC) += digic-timer.o
+common-obj-$(CONFIG_MIPS_CPS) += mips_gictimer.o
 
 obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
 
-obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
+common-obj-$(CONFIG_ALLWINNER_A10_PIT) += allwinner-a10-pit.o
 
 common-obj-$(CONFIG_STM32F2XX_TIMER) += stm32f2xx_timer.o
 common-obj-$(CONFIG_ASPEED_SOC) += aspeed_timer.o aspeed_rtc.o
-- 
2.21.0


