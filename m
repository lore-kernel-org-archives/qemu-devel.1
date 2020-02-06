Return-Path: <SRS0=rlpO=32=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E91A1C2D0B1
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:57:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BF50421741
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Feb 2020 12:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BF50421741
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38318 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1izgjD-0007vu-0D
	for qemu-devel@archiver.kernel.org; Thu, 06 Feb 2020 07:57:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:56724)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1izgcj-0001TJ-Tf
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1izgci-0006Vc-GF
 for qemu-devel@nongnu.org; Thu, 06 Feb 2020 07:51:13 -0500
Received: from mout.kundenserver.de ([212.227.126.187]:59267)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1izgca-00069v-Ju; Thu, 06 Feb 2020 07:51:05 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1MFbBO-1ijmZl2BLC-00H6yf; Thu, 06 Feb 2020 13:50:39 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PULL 04/12] hw/timer/m48t59: Convert debug printf()s to trace events
Date: Thu,  6 Feb 2020 13:50:19 +0100
Message-Id: <20200206125027.1926263-5-laurent@vivier.eu>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200206125027.1926263-1-laurent@vivier.eu>
References: <20200206125027.1926263-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:T8c6Xi4Oh+lSDqXyVGgojm/O13ryMV6fZe0mJQxr7lgwYwLNDL2
 OPTrCUs1HrLJZXsg8f55CFv8TVazxhfgqjs4k40byvJbQAwisPkRO1CrjyMzDXu+lCX6XU9
 JWWaOBO/h7ATGwQGxxdP3w3+C5hMKQ8gIZj6NFyZDS30A22B3UMJxYYvVc+iaza7O6In5LC
 umB7pmXDBD+pIe7t2J1+A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:Ttucs+vMU28=:aj4RgeUwy8Pl2AoIl83l1R
 o+w4GX+B0ADG5h1GjCpT9XWjLHuB5kuO36Sa5QNV4LdD0DpZ0L3mm3JxSiZWFBps91aV+xnC4
 YdsAQotUdSuwS8iUauvhn0mAg0+Mhfe6lt9h4/7/vtocLF5twX3fKwOP8S91M7wb5YIFOKpG4
 56bEjouLuG3WS3ba3Kz0QH1KdGp1fQIw99Y568CWp7+crG4shypkasoUbT9Es1ue9oRB/NXuo
 XVhhQiWdBZpUmoDIWvkBOPWo/dSGijIy6wkjrz58gSSj+tjjVBLFTkT/4/mukWOQ30LkTlg04
 lJKSTCEI9DOq5sdTPp6HgEWP7Op01nltJWCWxCdRPOwj+8yuBj9rpkw2wgkwFoozR913HHPG4
 ESsEpFUW+AQv8HVOdZWKmtF2eB5IexrQeKaQgy4NI9f7l9Q8G81Iw62A2kd4O7SrcVIqS6hAK
 kG/eg+3c0HUiKy2knnFoxpTIDunBIXbTEPNwk1CKKTeit5ZUA+m4P2T3BKKTTRH03XGA4r7dm
 lkE9PksLUkbYvLKuBU5pr2KH/LwQKtggkcHVvGl9sAMPvWPkCJ7+E70VjNWAZyTKuWsRU4dEg
 YlcZVvj3uN8vyR2bKe0LAsnGco0jo9lbg5ljloLB5sEt6/0QZ+7l5EPPkqeoONmL5iSLl89S8
 Cv+laRz3odlHlv9aboCOi1r+axOUfguz8sP/fuGUI5IL9WWXlR96uFX0sXOIt850vp4nA2SBk
 EmNUJhnBQ+ZGx5ho3A/DrA65LeMvbJ9TcpLAlEYQVXY2aYeC34xaEPPriGNwO68Sp+TulRQ47
 3v9k+HgTpUKqZbEB6tFVDvmt9c+KGnhyVWZPxM8j8UdqzIDdvZBiUemDBTPHoG5J+BhI7+O
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 212.227.126.187
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
Cc: Kevin Wolf <kwolf@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 Eduardo Habkost <ehabkost@redhat.com>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 Markus Armbruster <armbru@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Michael Tokarev <mjt@tls.msk.ru>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-trivial@nongnu.org, =?UTF-8?q?C=C3=A9dric=20Le=20Goater?= <clg@kaod.org>,
 qemu-arm@nongnu.org,
 =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 Joel Stanley <joel@jms.id.au>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Reviewed-by: Hervé Poussineau <hpoussin@reactos.org>
Message-Id: <20200117165809.31067-3-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/rtc/m48t59-internal.h |  5 -----
 hw/rtc/m48t59.c          | 11 +++++------
 hw/rtc/trace-events      |  6 ++++++
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/rtc/m48t59-internal.h b/hw/rtc/m48t59-internal.h
index 4d4f2a6fed94..cd648241e989 100644
--- a/hw/rtc/m48t59-internal.h
+++ b/hw/rtc/m48t59-internal.h
@@ -26,11 +26,6 @@
 #ifndef HW_M48T59_INTERNAL_H
 #define HW_M48T59_INTERNAL_H
 
-#define M48T59_DEBUG 0
-
-#define NVRAM_PRINTF(fmt, ...) do { \
-    if (M48T59_DEBUG) { printf(fmt , ## __VA_ARGS__); } } while (0)
-
 /*
  * The M48T02, M48T08 and M48T59 chips are very similar. The newer '59 has
  * alarm and a watchdog timer and related control registers. In the
diff --git a/hw/rtc/m48t59.c b/hw/rtc/m48t59.c
index 1269134bcbef..47d48054fdc1 100644
--- a/hw/rtc/m48t59.c
+++ b/hw/rtc/m48t59.c
@@ -35,6 +35,7 @@
 #include "exec/address-spaces.h"
 #include "qemu/bcd.h"
 #include "qemu/module.h"
+#include "trace.h"
 
 #include "m48t59-internal.h"
 #include "migration/vmstate.h"
@@ -192,8 +193,7 @@ void m48t59_write(M48t59State *NVRAM, uint32_t addr, uint32_t val)
     struct tm tm;
     int tmp;
 
-    if (addr > 0x1FF8 && addr < 0x2000)
-	NVRAM_PRINTF("%s: 0x%08x => 0x%08x\n", __func__, addr, val);
+    trace_m48txx_nvram_mem_write(addr, val);
 
     /* check for NVRAM access */
     if ((NVRAM->model == 2 && addr < 0x7f8) ||
@@ -450,8 +450,7 @@ uint32_t m48t59_read(M48t59State *NVRAM, uint32_t addr)
 	}
         break;
     }
-    if (addr > 0x1FF9 && addr < 0x2000)
-       NVRAM_PRINTF("%s: 0x%08x <= 0x%08x\n", __func__, addr, retval);
+    trace_m48txx_nvram_mem_read(addr, retval);
 
     return retval;
 }
@@ -462,7 +461,7 @@ static void NVRAM_writeb(void *opaque, hwaddr addr, uint64_t val,
 {
     M48t59State *NVRAM = opaque;
 
-    NVRAM_PRINTF("%s: 0x%"HWADDR_PRIx" => 0x%"PRIx64"\n", __func__, addr, val);
+    trace_m48txx_nvram_io_write(addr, val);
     switch (addr) {
     case 0:
         NVRAM->addr &= ~0x00FF;
@@ -494,7 +493,7 @@ static uint64_t NVRAM_readb(void *opaque, hwaddr addr, unsigned size)
         retval = -1;
         break;
     }
-    NVRAM_PRINTF("%s: 0x%"HWADDR_PRIx" <= 0x%08x\n", __func__, addr, retval);
+    trace_m48txx_nvram_io_read(addr, retval);
 
     return retval;
 }
diff --git a/hw/rtc/trace-events b/hw/rtc/trace-events
index d6749f4616a0..52c1566198e8 100644
--- a/hw/rtc/trace-events
+++ b/hw/rtc/trace-events
@@ -17,3 +17,9 @@ pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
 # aspeed-rtc.c
 aspeed_rtc_read(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
 aspeed_rtc_write(uint64_t addr, uint64_t value) "addr 0x%02" PRIx64 " value 0x%08" PRIx64
+
+# m48t59.c
+m48txx_nvram_io_read(uint64_t addr, uint64_t value) "io read addr:0x%04" PRIx64 " value:0x%02" PRIx64
+m48txx_nvram_io_write(uint64_t addr, uint64_t value) "io write addr:0x%04" PRIx64 " value:0x%02" PRIx64
+m48txx_nvram_mem_read(uint32_t addr, uint32_t value) "mem read addr:0x%04x value:0x%02x"
+m48txx_nvram_mem_write(uint32_t addr, uint32_t value) "mem write addr:0x%04x value:0x%02x"
-- 
2.24.1


