Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BC0CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:48:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC5FE21D71
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:48:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC5FE21D71
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57672 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNvHA-0003wv-6f
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 04:48:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50207)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNv5H-0001GE-4s
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNv5F-000873-OT
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:34 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:41697)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNv5F-00086K-F9; Fri, 25 Oct 2019 04:36:33 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MD9nd-1iFMLi0Lmj-0099T3; Fri, 25 Oct 2019 10:35:47 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 12/19] hw: Move TWL92230 device from hw/timer/ to hw/rtc/
 subdirectory
Date: Fri, 25 Oct 2019 10:35:04 +0200
Message-Id: <20191025083511.11463-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025083511.11463-1-laurent@vivier.eu>
References: <20191025083511.11463-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:3NgaTQHiZJEuDv6c0dQXCgZoa6BvOnPgHLkhbho/31gjj5l8zsW
 WkeHtXVBDvGfypuno4cKy64/p67eBVjB9Djay1sckjewkgN0u++Cg1gp3Q5iLHUZc6hOp6o
 QJBkYofhhF28uO0DUwDanSge14Bs2da9gAQN4rFeY/0TDz51uzi0x26NmDOh7YzGD+Fk+xL
 jnyVJ/tycrlKjcQBclCxg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:HCo+icgs6qs=:PQSOcCS/4zlWKgipYVMMbF
 mwvkQB/fYY9tHUUcPGbn1Q/2v0mBjnUFMijT5SrWI1gw5w1kwLl2/+OdrMDSKrS/z1EBKcQYJ
 hir/pPZYJZgxRBz5I6V4e0yHcuUFehnwyZ8IBlruhDqB5PoBiSMzLI+4CE8qG8G+BGnuDMzLw
 jtwINX7jQkCxXCmifh8vVXhGbMoXH+Vlod11HJweJxUuX60yFPvCHSL5LjavneuSOqImn9TYT
 zDLvGj7fHmDuqAts73z3Tm9GcY9TAT0Cv4yxfYfAdxu42Gd+b7tMH3w7XtE7WeldY8o8Jbae/
 dDvBh8SsZYXLt9I9hAcq9GRbumwOyscCrctDVe46RwHdPkoLb4sSzq+jN7t+oIegtFPFkilGN
 JoQ/ShpNd77Q+DGhO87+Ypopnm4fLH+7UUUb7VmQxoaMtanNdDY1oKM75YjfnN2aPOt9ID8N6
 iNOkJlVkiyCzX9BPs9qRAI8LXxXWxdsGEVXX/oIAw7daNHxKT3fwefhdFSOIdUTK2DltqrPRL
 i7GVN3wzxnm4baJzKiYCUKjwDUT5cKh8XTVU/WP7+yZr1I82AWMXt90yMm5DSNPdWnN+5xfeN
 60ouLhaGSNiafWnPxGHfvKfOy7fweCr/I3/uD9K5/DblLB0U67OXLUMLtAP1J/1goTqO1MN5/
 i2jrydX4HEK7zsjMAP77z6QKC+79kQJWw3WNUA5XGmyigSWgAtPZR/eYFWi4xajkrGQadGoGb
 19mukk/C+00+gILHvqEZD79paOOQj5H+QsycP3QQ/9lFdEhdNWaziRnBWQW+dV8MWjdENoQFC
 wbx4qpoy1YJK4SKfwD6Y9MjM9iG26fDf16O2PTcc1TYwsDJVFmCpsIH5C+ZUL6oogd4IPmxWd
 oUrTrKK0YKnqyTAzY84E9ribsdW/Rm1B7inZ/Xwkk=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.227.126.131
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

The TWL92230 is an "energy management device" companion with
a RTC. Since we mostly model the RTC, move it under the hw/rtc/
subdirectory.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: Peter Maydell <peter.maydell@linaro.org>
Message-Id: <20191003230404.19384-8-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS                  | 2 +-
 hw/rtc/Kconfig               | 4 ++++
 hw/rtc/Makefile.objs         | 1 +
 hw/{timer => rtc}/twl92230.c | 0
 hw/timer/Kconfig             | 4 ----
 hw/timer/Makefile.objs       | 1 -
 6 files changed, 6 insertions(+), 6 deletions(-)
 rename hw/{timer => rtc}/twl92230.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7de5e2d1253..0dc72d37bdc8 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -663,7 +663,7 @@ F: hw/display/blizzard.c
 F: hw/input/lm832x.c
 F: hw/input/tsc2005.c
 F: hw/misc/cbus.c
-F: hw/timer/twl92230.c
+F: hw/rtc/twl92230.c
 F: include/hw/display/blizzard.h
 F: include/hw/input/tsc2xxx.h
 F: include/hw/misc/cbus.h
diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index cc7fead764f4..dff9d60946af 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -8,6 +8,10 @@ config M48T59
 config PL031
     bool
 
+config TWL92230
+    bool
+    depends on I2C
+
 config MC146818RTC
     bool
 
diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
index 4621b37bc2f6..810a38ee7b3d 100644
--- a/hw/rtc/Makefile.objs
+++ b/hw/rtc/Makefile.objs
@@ -4,5 +4,6 @@ ifeq ($(CONFIG_ISA_BUS),y)
 common-obj-$(CONFIG_M48T59) += m48t59-isa.o
 endif
 common-obj-$(CONFIG_PL031) += pl031.o
+common-obj-$(CONFIG_TWL92230) += twl92230.o
 obj-$(CONFIG_MC146818RTC) += mc146818rtc.o
 common-obj-$(CONFIG_SUN4V_RTC) += sun4v-rtc.o
diff --git a/hw/timer/twl92230.c b/hw/rtc/twl92230.c
similarity index 100%
rename from hw/timer/twl92230.c
rename to hw/rtc/twl92230.c
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index b04c928136c2..9357875f285d 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -20,10 +20,6 @@ config HPET
 config I8254
     bool
 
-config TWL92230
-    bool
-    depends on I2C
-
 config ALTERA_TIMER
     bool
     select PTIMER
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index 034bd30255c0..23be70b71d32 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -7,7 +7,6 @@ common-obj-$(CONFIG_DS1338) += ds1338.o
 common-obj-$(CONFIG_HPET) += hpet.o
 common-obj-$(CONFIG_I8254) += i8254_common.o i8254.o
 common-obj-$(CONFIG_PUV3) += puv3_ost.o
-common-obj-$(CONFIG_TWL92230) += twl92230.o
 common-obj-$(CONFIG_XILINX) += xilinx_timer.o
 common-obj-$(CONFIG_SLAVIO) += slavio_timer.o
 common-obj-$(CONFIG_ETRAXFS) += etraxfs_timer.o
-- 
2.21.0


