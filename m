Return-Path: <SRS0=/cID=ZR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A283C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:25:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6AA692084D
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2019 14:25:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6AA692084D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44550 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iZFIT-000640-C7
	for qemu-devel@archiver.kernel.org; Mon, 25 Nov 2019 09:25:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:49612)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1iZFG3-0002wW-7E
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:22:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1iZF8B-0003GQ-No
 for qemu-devel@nongnu.org; Mon, 25 Nov 2019 09:14:28 -0500
Received: from mout.kundenserver.de ([212.227.126.135]:41151)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1iZF8A-0003Fn-DQ; Mon, 25 Nov 2019 09:14:22 -0500
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.167]) with ESMTPSA (Nemesis)
 id 1M2xjg-1iY9jS2T6q-003LmH; Mon, 25 Nov 2019 15:14:18 +0100
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Subject: [PATCH] mos6522: update counters when timer interrupts are off
Date: Mon, 25 Nov 2019 15:14:14 +0100
Message-Id: <20191125141414.5015-1-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:VYEDlcsKVP3/7B9l90kM2a/1axH/kJjvkaolrdibdEdyf6qLXhp
 xFGO/fYmvFmmK0i7EqDwOuySNM8Xv8OiVyzrxsno8Cph3Pe9ryfTMnDNW1cIP0GkkAKnDFM
 r/5Ny0yjIIO2m6dN/pArfyGIUyTplJa/M9qPn22q/XmG694/nIkKUZvuG7+95hqBfViBpDN
 r12W5PDpXonyt1p1SsouQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:98vT1MKA7Rw=:G/CeE9NP3nfR9OA25WhckZ
 l5bM7SSZtHKETuKqaklGHOA2+QYC4kTCgYGb9b4w6mumjv6RDTmKv4QwmVOS+usxp8MCHbjmj
 +NYYGjq1T4kfp+oH0NvH5H5ZNtK8Armu1Su2Y5nUb58P3uSgWvGz2WC1Q7UJCcBThNq4BXfMA
 4WDp9Ltc2wOMejeOnWKqflFLK/ymbHZNOEZuDm9GaLflPO75Zop93dnu6PlVCrob5ntUmSkba
 HCZJ7cA3rgkuIwhikFo/71QGDmNqkjZ0zG7NThVGwtTqiLrWGzcEcAJtTdbSWYLWk9mJUvnl+
 p83h4Z8il813A5j9ANuGYoOqhVQv1ZkB47FjGx2AP84EdPIn48W00Gf1gCYWCViePG0zn1iat
 1f+InBJK2OIPOpzDwIl1XOgKG0f00URhjcyoH35nZeRVAnvPsBee7uTivueFRjbv9wY4WOJy1
 AjXhqZApz8UqVisdrftpxX7Nn9Gpd+8SaPSQ+QuZvDxxf8a/TdUOSna/SdsJqweCaakOQDv8m
 CpZoFGbKvyDdeA6P19j7/te7VfC8MAzhkUAKctCO8lMsq3FmPiOzTPzYGBn4y3o4q5lNvetgR
 ya+GdWBg+DYHIqUJ97QXIoXWXtCCoREiN34e1VCcv0L7vqnR3XkV0X8hNttY/jn1Y2aCTrsKn
 DhvupmQAUvU55vppaOMkdjqmw1AcdjhPtIA5wABsFKlsroUZt7J1z4t1pptPMjjM80/KkHnvR
 tCyBHAb6z90oapWvcxSpBCU+IWn/JR2L8/WbClIUGu8jt20bm3Cl+uOAqTqQtFnz3A4titpM5
 2fNWodtf2n3hhOi1HbzbdHYUBVebL4wgGzpjBPxfzJgTM9yZ84HVLHjC3rxGqsM8AXihmhM7H
 BtcT3oTxXOUYwuKfV+jQ==
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
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>, qemu-ppc@nongnu.org,
 Andrew Randrianasulu <randrianasulu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Even if the interrupts are off, counters must be updated because
they are running anyway and kernel can try to read them
(it's the case with g3beige kernel).

Reported-by: Andrew Randrianasulu <randrianasulu@gmail.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/misc/mos6522.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/hw/misc/mos6522.c b/hw/misc/mos6522.c
index aa3bfe1afd..cecf0be59e 100644
--- a/hw/misc/mos6522.c
+++ b/hw/misc/mos6522.c
@@ -113,6 +113,10 @@ static int64_t get_next_irq_time(MOS6522State *s, MOS6522Timer *ti,
     int64_t d, next_time;
     unsigned int counter;
 
+    if (ti->frequency == 0) {
+        return INT64_MAX;
+    }
+
     /* current counter value */
     d = muldiv64(qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL) - ti->load_time,
                  ti->frequency, NANOSECONDS_PER_SECOND);
@@ -149,10 +153,10 @@ static void mos6522_timer1_update(MOS6522State *s, MOS6522Timer *ti,
     if (!ti->timer) {
         return;
     }
+    ti->next_irq_time = get_next_irq_time(s, ti, current_time);
     if ((s->ier & T1_INT) == 0 || (s->acr & T1MODE) != T1MODE_CONT) {
         timer_del(ti->timer);
     } else {
-        ti->next_irq_time = get_next_irq_time(s, ti, current_time);
         timer_mod(ti->timer, ti->next_irq_time);
     }
 }
@@ -163,10 +167,10 @@ static void mos6522_timer2_update(MOS6522State *s, MOS6522Timer *ti,
     if (!ti->timer) {
         return;
     }
+    ti->next_irq_time = get_next_irq_time(s, ti, current_time);
     if ((s->ier & T2_INT) == 0) {
         timer_del(ti->timer);
     } else {
-        ti->next_irq_time = get_next_irq_time(s, ti, current_time);
         timer_mod(ti->timer, ti->next_irq_time);
     }
 }
-- 
2.21.0


