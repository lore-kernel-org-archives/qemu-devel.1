Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E0D7CA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 765222070B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 08:42:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 765222070B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iNvBJ-0001h5-UJ
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 04:42:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50096)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iNv5A-00012e-58
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iNv58-000826-U3
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 04:36:28 -0400
Received: from mout.kundenserver.de ([212.227.126.131]:38597)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iNv58-000812-Kh; Fri, 25 Oct 2019 04:36:26 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1Mtf7H-1i9HlJ04mV-00v6BH; Fri, 25 Oct 2019 10:35:42 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 10/19] hw: Move M41T80 device from hw/timer/ to hw/rtc/
 subdirectory
Date: Fri, 25 Oct 2019 10:35:02 +0200
Message-Id: <20191025083511.11463-11-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20191025083511.11463-1-laurent@vivier.eu>
References: <20191025083511.11463-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:K108If5qegdxqtLY28ckEaAROz9TzMIgHjuzWirAeKvjB1s//jF
 yI7eGDdb1l2U7+8j4xKDz8Vk+KBqwDQgdZ+9r8rUf8cPOHjgIxh1faZu0zjHf5MtOFKT9E7
 yhHmhOJsqYLvyIS0Z2jfCLO5ZZo7ShImbP8OCjmlj1FR7ndiR3VCS6g7aOdDbFwKiniZkA1
 sP9kSmYGvXlxqISjEbmeA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:RUpsU3/Gu3s=:X+VJFz7P7jUzGq6x5bPpw0
 oDtLaEReji5sO7r99qRzygZ2YuDR4yDQWl9ctIEqBZqnCas5oiaQp2imr521WmJ73CrQl7DZH
 3E45cxLjP3fEjriwjwXkcCiaPByxutU/8+QNt5gdqRWWE04ZYWc9+OgaOcpqDAODz7CBkpa6F
 UbmZzMw9qsSKyADjrfloDXfyp6o7fpnPFNqEzSjSXODTsxtIklZMHU1+ys0TGBnEQ7eCefYjZ
 vPND0og2eG2mXclG31IOgMDauaumk+5cZz7DWSNBYCDjY2t9xv+wLGqOL9DTyamoXdz6vdyHE
 MdEB+/gRTnboZHgh5xQSbKCns1VJwfic+3Dy4W/pN3XQyc9/4MNpYoe1DcKbdvTE09xpQbc4L
 rfvnkrlUhEk1hq3H+s8wko9kDiPe3rUsucVx44j3xyFk8wfjlMqG/cJ3xEncRiKBKJitFM267
 iPYBv2H4+tIGbWoLimCRO5pZlZJfCVLZMTV82ks7OHeDyHsTKqwXdyWVlb9ZpbzayiYsOQPs1
 imeTOw48PboqcKdJF2Oddx9d3LPATHw6kdsYBGwcCaDjnTfMxfVw9LZSIf/M3mXHUa9EpKrvQ
 CzN6lpOBVpBIjGuGfv9oa2ASZenmoO7qtnmv8ZdaEAWMIkF1uRwnq367sxqRCGd3nEpQ/fbwI
 vCjIJWsKj1Q/kjRLkusccN6V6O7pxpISBpO8Id8GWKJB9K/q2jWALnRS291aC9GdAUMMlW7JO
 llhnwRWgdF40A383fwZ1jHWuf060/q8aeqzc1mT+gRr9OPShAN4LyKPfslWxJVKoyl+JAeKQT
 oZAn0yPH5fL79YeQlWXOT1oe5J4MyBtah077jxAoDqGdHH3/4SzeompNgTgVY/a22AFyG0RNu
 hMdGtPMx3JX+ZqLmfSbbSRqLM2S7kER2WvmI6lW1g=
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

The M41T80 is a Real Time Clock, not a timer.
Move it under the hw/rtc/ subdirectory.

Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Message-Id: <20191003230404.19384-6-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 MAINTAINERS                | 2 +-
 hw/rtc/Kconfig             | 4 ++++
 hw/rtc/Makefile.objs       | 1 +
 hw/{timer => rtc}/m41t80.c | 0
 hw/timer/Kconfig           | 4 ----
 hw/timer/Makefile.objs     | 1 -
 6 files changed, 6 insertions(+), 6 deletions(-)
 rename hw/{timer => rtc}/m41t80.c (100%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4e65f062f29c..ba0d1906aae9 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -1111,7 +1111,7 @@ F: hw/ppc/sam460ex.c
 F: hw/ppc/ppc440_pcix.c
 F: hw/display/sm501*
 F: hw/ide/sii3112.c
-F: hw/timer/m41t80.c
+F: hw/rtc/m41t80.c
 F: pc-bios/canyonlands.dt[sb]
 F: pc-bios/u-boot-sam460ex-20100605.bin
 F: roms/u-boot-sam460ex
diff --git a/hw/rtc/Kconfig b/hw/rtc/Kconfig
index 159c2335171a..434b20b2b1bd 100644
--- a/hw/rtc/Kconfig
+++ b/hw/rtc/Kconfig
@@ -1,3 +1,7 @@
+config M41T80
+    bool
+    depends on I2C
+
 config M48T59
     bool
 
diff --git a/hw/rtc/Makefile.objs b/hw/rtc/Makefile.objs
index c87f81405e9d..89e8e48c6409 100644
--- a/hw/rtc/Makefile.objs
+++ b/hw/rtc/Makefile.objs
@@ -1,3 +1,4 @@
+common-obj-$(CONFIG_M41T80) += m41t80.o
 common-obj-$(CONFIG_M48T59) += m48t59.o
 ifeq ($(CONFIG_ISA_BUS),y)
 common-obj-$(CONFIG_M48T59) += m48t59-isa.o
diff --git a/hw/timer/m41t80.c b/hw/rtc/m41t80.c
similarity index 100%
rename from hw/timer/m41t80.c
rename to hw/rtc/m41t80.c
diff --git a/hw/timer/Kconfig b/hw/timer/Kconfig
index a57e9b59fca8..a6b668b2559b 100644
--- a/hw/timer/Kconfig
+++ b/hw/timer/Kconfig
@@ -20,10 +20,6 @@ config HPET
 config I8254
     bool
 
-config M41T80
-    bool
-    depends on I2C
-
 config TWL92230
     bool
     depends on I2C
diff --git a/hw/timer/Makefile.objs b/hw/timer/Makefile.objs
index fe2d1fbc4040..2fb12162a623 100644
--- a/hw/timer/Makefile.objs
+++ b/hw/timer/Makefile.objs
@@ -6,7 +6,6 @@ common-obj-$(CONFIG_CADENCE) += cadence_ttc.o
 common-obj-$(CONFIG_DS1338) += ds1338.o
 common-obj-$(CONFIG_HPET) += hpet.o
 common-obj-$(CONFIG_I8254) += i8254_common.o i8254.o
-common-obj-$(CONFIG_M41T80) += m41t80.o
 common-obj-$(CONFIG_PUV3) += puv3_ost.o
 common-obj-$(CONFIG_TWL92230) += twl92230.o
 common-obj-$(CONFIG_XILINX) += xilinx_timer.o
-- 
2.21.0


