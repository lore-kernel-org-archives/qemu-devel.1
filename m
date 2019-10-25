Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D88CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 09:00:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2705B21929
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 09:00:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2705B21929
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57826 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNvSh-0007Ur-6a
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 05:00:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50631)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNv5V-0001dq-Kv
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNv5U-0008I7-DX
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:49 -0400
Received: from mout.kundenserver.de ([212.227.126.135]:55787)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNv5J-00089O-JD; Fri, 25 Oct 2019 04:36:37 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MNc5b-1id6HK3O8Z-00P4ox; Fri, 25 Oct 2019 10:35:54 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 15/19] hw: Move Exynos4210 RTC from hw/timer/ to hw/rtc/
 subdirectory
Date: Fri, 25 Oct 2019 10:35:07 +0200
Message-Id: <20191025083511.11463-16-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025083511.11463-1-laurent@vivier.eu>
References: <20191025083511.11463-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:vack1BjZXw7zRhCywDDbJMpaQCtjGChZK3BCFTUq7S15JitEFJr
 5p9Ubc07Ugls6WUEmqDhlHC4187umJJJmCfpUAinfcUOUCw8LjqzFpnIdAgAeKrb3aOQtI1
 zjzGjIUoRXr1XGEvQUdQ3StRpC/nTG3m8ycOwOKuzUV4rFfPW+cyW+U+WqtFwc5Lgfws/Fv
 AablbPtdvnzy61crt85hA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:UxPdNoSktyo=:SOk0/YJjK7m8tevZBbEk6o
 rHaygyShR3IXb182XRgQ6Khb2Gu+pU1PUnCDzLpypQBadyzIS7xnNPxdhQxQKNdxaiYhQitoD
 Me6eZeXAPQd3KuhX/ikOfDbWxJQ8kkeb+lKE3VFU5Fl5M0UsykvUJslYA6XxgldablZZylsZo
 XZvsO91pYmL3foc/ZjtFEMOG9DfJxRiUxT5tKiN3CIpYK04igoxaeGgEAw7aEmtCzx8yN9X8u
 n71wQCsXdw38L0oNPdIom6eOIMIblG73jhFbvRJEkMe1A2dzBBhiniRQJobSszTcq568oxG/D
 WIVaGI5ex0PWdCTBWggLzwcj/KLr6Tyt+eT/Sik3mErO42Ex1rY2YTCN8rv/pvw+RKK/+zm/I
 ZcHAPjG4eYl3F9EJWERwTZt6kZy/bdKcS13f6T56HXYm2fImtm9fUwYnCEa3WfmGuveF/92ne
 en8UhO3iVjyYVS4EgmHg/JR9FAUvsJrgNPeyCkbrpybrS0X3jKRs4Qvn44p2vbUI+WAo1/Ec8
 FjcGJlupBZKDou02cHOs9UHiJGYMmoeN/ustEnk/3wEaDEw7fI+MO7x1bYS+QeGwMbC+2dp7j
 B3swZa7gRdkg0okz5LNb9G2N8istKZYzm0FxW435sVuP/AfEAgtXCnEOKvKARTsUuKchS1Lig
 IH38JuHrln+7sKwm4ugwNCPQXNFb8FtNu39SsuGLcxv1Ama/954vrY+Ryk66PSTnH86tlxQZL
 ABtEjukcMyh433wVRIxwk4GpGgv/aaXgWg8Q/rqehnUlZ0BdoRk5T+UNg7ga7zbWmCz7p03Bi
 ewQKIwIx4Ads2yNnuis323kmm6dDZFzew38WjiYDuo5O1uVNybopWPmm2Q/Ld7cndPPvkNAEg
 PJQUlxo6RkdNy3p8jbN3SEASkr0dbbXbvclipTO5Q=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.135
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

Move RTC devices under the hw/rtc/ subdirectory.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20191003230404.19384-11-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/rtc/Makefile.objs               | 1 +
 hw/{timer => rtc}/exynos4210_rtc.c | 0
 hw/timer/Makefile.objs             | 1 -
 3 files changed, 1 insertion(+), 1 deletion(-)
 rename hw/{timer => rtc}/exynos4210_rtc.c (100%)

diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
index 543a550a0f11..3d4763fc269e 100644
--- a/hw/rtc/Makefile.objs
+++ b/hw/rtc/Makefile.objs
@@ -7,5 +7,6 @@ endif
 common-obj-$(CONFIG_PL031) += pl031.o
 common-obj-$(CONFIG_TWL92230) += twl92230.o
 common-obj-$(CONFIG_XLNX_ZYNQMP) += xlnx-zynqmp-rtc.o
+common-obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
 obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
 common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
diff --git a/hw/timer/exynos4210_rtc.c b/hw/rtc/exynos4210_rtc.c
similarity index 100%
rename from hw/timer/exynos4210_rtc.c
rename to hw/rtc/exynos4210_rtc.c
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 294465ef47ad..33191d74cb98 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -19,7 +19,6 @@ common-obj-$(CONFIG_NRF51_SOC) += nrf51_timer.o
 common-obj-$(CONFIG_ALTERA_TIMER) += altera_timer.o
 common-obj-$(CONFIG_EXYNOS4) += exynos4210_mct.o
 common-obj-$(CONFIG_EXYNOS4) += exynos4210_pwm.o
-common-obj-$(CONFIG_EXYNOS4) += exynos4210_rtc.o
 common-obj-$(CONFIG_OMAP) += omap_gptimer.o
 common-obj-$(CONFIG_OMAP) += omap_synctimer.o
 common-obj-$(CONFIG_PXA2XX) += pxa2xx_timer.o
-- 
2.21.0


