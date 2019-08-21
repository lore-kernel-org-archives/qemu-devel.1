Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 079A5C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:31:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D087122CE3
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 11:31:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D087122CE3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=vivier.eu
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47164 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0OpT-0000t0-Fi
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 07:31:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53750)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <laurent@vivier.eu>) id 1i0OfX-0005EZ-EV
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <laurent@vivier.eu>) id 1i0OfW-0006ib-6V
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 07:20:47 -0400
Received: from mout.kundenserver.de ([217.72.192.73]:41083)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <laurent@vivier.eu>)
 id 1i0OfK-0006Yo-Tc; Wed, 21 Aug 2019 07:20:35 -0400
Received: from localhost.localdomain ([78.238.229.36]) by
 mrelayeu.kundenserver.de (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis)
 id 1MBV2f-1i68Tj3duR-00D2Vp; Wed, 21 Aug 2019 13:20:13 +0200
From: Laurent Vivier <laurent@vivier.eu>
To: qemu-devel@nongnu.org
Date: Wed, 21 Aug 2019 13:19:45 +0200
Message-Id: <20190821111947.26580-13-laurent@vivier.eu>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20190821111947.26580-1-laurent@vivier.eu>
References: <20190821111947.26580-1-laurent@vivier.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:6ipEDEcf1Ck2g1S/2T5QDfUmWvcuh7rLUy0thWBMmKgkr/N+jy1
 Ybak3/nPxJmyHlHnCx5c6BXVpxx1374Z3SOvYs+KdQAz07Doe2mtfJyevTsKCgJ5QzPKf/X
 IwPYYqfooIabtrLUTh6pxtFN7EQhvYZvly+ByKaYneUXipiJzhv0vA8FtAdK85bKnmtRgvN
 vntQWrHDpJeHtE9O0vV4w==
X-UI-Out-Filterresults: notjunk:1;V03:K0:DwWjJYGGRN4=:0isE0L0d1QA40v1eJkR/lK
 sVjek+lCcppBL/cb0uvibM1wjQZffouxlGFFgJl64PnWdAjWdRGy7IQtfH8zmh2uXv1QM3v5t
 5LEsKGaGM9LrFqFXttszEOS6/KZF03P3gQaDpfk3l3EA/xy4qk1obGFZgBJFIzLgYkZ0EKAIP
 Iw+rEbTo1aN5kSqgSJL6uN7ABRba3WjkSel/5UtVOfHfVo2y94S0eItGI/YlPFBlwO+BnyyFw
 saaXtgMPf2wyJB1TBbagLLX4a8Q6Kz4uFuzCdJfp/4o58EYBC8tmq/QF4KlE946WmK7Fy+sRO
 fwlFDUhPZJGFECUKHJTo+CrPKkC5Mq561UlUif2qv5U+wby1Z+oBt07Yp/OhPNqBq2+SvSOK9
 koD0lS4ArB/FlzHmx5SKJ8VwEPuiM4N6FOHIeXlb8QYPnKWnp+/nY/AVBTXJmjttZExROM25C
 7SFVXg+0BZ9fLmaZLbaocUfvS1AYVwqFAsn5jnyXA9X0loe6fmD4UDYgfA7SnXldp/ttrXcGy
 Q8NbmGf2umfEUK3MFv5t3KytZq6xgeGGP+BCrt0spAGYM2kYaq7Kk2J/fpTxu77AXLFg83JXp
 wfuxysMMvb6Dd1Nf3Idi+DSth38ffeH/NUlceIDSyKQY9aXtYpecIaNy2hXPzdrY2XRiBx0hY
 4RqRRptC4wYZTbzoJOC5+FhHkk8IOSs+la/Gc2VcuHh86kwevlFdhj0z0ThI65UumfEncdYh/
 SFe3b+SO/kq+R2u/yiIgABY264zhWutoJ6nLHjKMC4MyZAyjcW/PTY0jaF4=
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 217.72.192.73
Subject: [Qemu-devel] [PULL 12/14] spapr_events: Rewrite a fall through
 comment
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>, Corey Minyard <minyard@acm.org>,
 Juan Quintela <quintela@redhat.com>, qemu-trivial@nongnu.org,
 Stefan Weil <sw@weilnetz.de>, Jason Wang <jasowang@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Markus Armbruster <armbru@redhat.com>, Laurent Vivier <laurent@vivier.eu>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@redhat.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

From: Philippe Mathieu-Daudé <philmd@redhat.com>

GCC9 is confused by this comment when building with CFLAG
-Wimplicit-fallthrough=2:

    CC      ppc64-softmmu/hw/ppc/spapr_rtc.o
  hw/ppc/spapr_events.c: In function ‘rtas_event_log_to_source’:
  hw/ppc/spapr_events.c:312:12: error: this statement may fall through [-Werror=implicit-fallthrough=]
    312 |         if (spapr_ovec_test(spapr->ov5_cas, OV5_HP_EVT)) {
        |            ^
  hw/ppc/spapr_events.c:317:5: note: here
    317 |     case RTAS_LOG_TYPE_EPOW:
        |     ^~~~
  cc1: all warnings being treated as errors

Rewrite the comment using 'fall through' which is recognized by
GCC and static analyzers.

Reported-by: Stefan Weil <sw@weilnetz.de>
Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
Acked-by: David Gibson <david@gibson.dropbear.id.au>
Message-Id: <20190719131425.10835-8-philmd@redhat.com>
Signed-off-by: Laurent Vivier <laurent@vivier.eu>
---
 hw/ppc/spapr_events.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_events.c b/hw/ppc/spapr_events.c
index 163a6cd25b45..0e4c19523aea 100644
--- a/hw/ppc/spapr_events.c
+++ b/hw/ppc/spapr_events.c
@@ -314,7 +314,7 @@ rtas_event_log_to_source(SpaprMachineState *spapr, int log_type)
             g_assert(source->enabled);
             break;
         }
-        /* fall back to epow for legacy hotplug interrupt source */
+        /* fall through back to epow for legacy hotplug interrupt source */
     case RTAS_LOG_TYPE_EPOW:
         source = spapr_event_sources_get_source(spapr->event_sources,
                                                 EVENT_CLASS_EPOW);
-- 
2.21.0


