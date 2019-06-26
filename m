Return-Path: <SRS0=5EQe=UZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92597C48BD3
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:23:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64A8420663
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2019 12:23:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64A8420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hg6xv-0007fz-MD
	for qemu-devel@archiver.kernel.org; Wed, 26 Jun 2019 08:23:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51976)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <philmd@redhat.com>) id 1hg6vD-0005Fw-VH
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:21:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1hg6vC-0005ta-P8
 for qemu-devel@nongnu.org; Wed, 26 Jun 2019 08:21:07 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50507)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>)
 id 1hg6vC-0005rq-Gm; Wed, 26 Jun 2019 08:21:06 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id A9A4A3082140;
 Wed, 26 Jun 2019 12:20:57 +0000 (UTC)
Received: from x1w.redhat.com (ovpn-204-66.brq.redhat.com [10.40.204.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5CC6B10018F9;
 Wed, 26 Jun 2019 12:20:54 +0000 (UTC)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
To: qemu-trivial@nongnu.org,
	qemu-devel@nongnu.org
Date: Wed, 26 Jun 2019 14:20:42 +0200
Message-Id: <20190626122042.7656-3-philmd@redhat.com>
In-Reply-To: <20190626122042.7656-1-philmd@redhat.com>
References: <20190626122042.7656-1-philmd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 26 Jun 2019 12:21:02 +0000 (UTC)
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: [Qemu-devel] [PATCH 2/2] hw/timer/m48t59: Convert debug printf()s
 to trace events
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
Cc: =?UTF-8?q?Herv=C3=A9=20Poussineau?= <hpoussin@reactos.org>,
 qemu-ppc@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
---
 hw/timer/m48t59-internal.h |  5 -----
 hw/timer/m48t59.c          | 11 +++++------
 hw/timer/trace-events      |  6 ++++++
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/hw/timer/m48t59-internal.h b/hw/timer/m48t59-internal.h
index 4d4f2a6fed..cd648241e9 100644
--- a/hw/timer/m48t59-internal.h
+++ b/hw/timer/m48t59-internal.h
@@ -26,11 +26,6 @@
 #ifndef HW_M48T59_INTERNAL_H
 #define HW_M48T59_INTERNAL_H
=20
-#define M48T59_DEBUG 0
-
-#define NVRAM_PRINTF(fmt, ...) do { \
-    if (M48T59_DEBUG) { printf(fmt , ## __VA_ARGS__); } } while (0)
-
 /*
  * The M48T02, M48T08 and M48T59 chips are very similar. The newer '59 h=
as
  * alarm and a watchdog timer and related control registers. In the
diff --git a/hw/timer/m48t59.c b/hw/timer/m48t59.c
index 030c8872a2..d50b4ddea2 100644
--- a/hw/timer/m48t59.c
+++ b/hw/timer/m48t59.c
@@ -33,6 +33,7 @@
 #include "exec/address-spaces.h"
 #include "qemu/bcd.h"
 #include "qemu/module.h"
+#include "trace.h"
=20
 #include "m48t59-internal.h"
=20
@@ -189,8 +190,7 @@ void m48t59_write(M48t59State *NVRAM, uint32_t addr, =
uint32_t val)
     struct tm tm;
     int tmp;
=20
-    if (addr > 0x1FF8 && addr < 0x2000)
-	NVRAM_PRINTF("%s: 0x%08x =3D> 0x%08x\n", __func__, addr, val);
+    trace_m48txx_nvram_mem_write(addr, val);
=20
     /* check for NVRAM access */
     if ((NVRAM->model =3D=3D 2 && addr < 0x7f8) ||
@@ -447,8 +447,7 @@ uint32_t m48t59_read(M48t59State *NVRAM, uint32_t add=
r)
 	}
         break;
     }
-    if (addr > 0x1FF9 && addr < 0x2000)
-       NVRAM_PRINTF("%s: 0x%08x <=3D 0x%08x\n", __func__, addr, retval);
+    trace_m48txx_nvram_mem_read(addr, retval);
=20
     return retval;
 }
@@ -459,7 +458,7 @@ static void NVRAM_writeb(void *opaque, hwaddr addr, u=
int64_t val,
 {
     M48t59State *NVRAM =3D opaque;
=20
-    NVRAM_PRINTF("%s: 0x%"HWADDR_PRIx" =3D> 0x%"PRIx64"\n", __func__, ad=
dr, val);
+    trace_m48txx_nvram_io_write(addr, val);
     switch (addr) {
     case 0:
         NVRAM->addr &=3D ~0x00FF;
@@ -491,7 +490,7 @@ static uint64_t NVRAM_readb(void *opaque, hwaddr addr=
, unsigned size)
         retval =3D -1;
         break;
     }
-    NVRAM_PRINTF("%s: 0x%"HWADDR_PRIx" <=3D 0x%08x\n", __func__, addr, r=
etval);
+    trace_m48txx_nvram_io_read(addr, retval);
=20
     return retval;
 }
diff --git a/hw/timer/trace-events b/hw/timer/trace-events
index dcaf3d6da6..66ccdd0974 100644
--- a/hw/timer/trace-events
+++ b/hw/timer/trace-events
@@ -83,3 +83,9 @@ pl031_read(uint32_t addr, uint32_t value) "addr 0x%08x =
value 0x%08x"
 pl031_write(uint32_t addr, uint32_t value) "addr 0x%08x value 0x%08x"
 pl031_alarm_raised(void) "alarm raised"
 pl031_set_alarm(uint32_t ticks) "alarm set for %u ticks"
+
+# m48t59.c
+m48txx_nvram_io_read(uint64_t addr, uint64_t value) "io read addr:0x%04"=
 PRIx64 " value:0x%02" PRIx64
+m48txx_nvram_io_write(uint64_t addr, uint64_t value) "io write addr:0x%0=
4" PRIx64 " value:0x%02" PRIx64
+m48txx_nvram_mem_read(uint32_t addr, uint32_t value) "mem read addr:0x%0=
4x value:0x%02x"
+m48txx_nvram_mem_write(uint32_t addr, uint32_t value) "mem write addr:0x=
%04x value:0x%02x"
--=20
2.20.1


