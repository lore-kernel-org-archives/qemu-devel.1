Return-Path: <SRS0=aBJE=ZL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BB32C432C0
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:21:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6ADDA22363
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Nov 2019 16:21:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZW7VpqmJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6ADDA22363
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47128 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iX6Fc-0006Ad-8J
	for qemu-devel@archiver.kernel.org; Tue, 19 Nov 2019 11:21:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60791)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63w-00023E-Be
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <paolo.bonzini@gmail.com>) id 1iX63v-0006AC-2Q
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:08 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:38330)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
 id 1iX63u-00069n-SJ
 for qemu-devel@nongnu.org; Tue, 19 Nov 2019 11:09:07 -0500
Received: by mail-wm1-x343.google.com with SMTP id z19so4349990wmk.3
 for <qemu-devel@nongnu.org>; Tue, 19 Nov 2019 08:09:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:from:to:subject:date:message-id:in-reply-to:references;
 bh=qHpVdmqCzVmXoW2Mq3yTyYlL6lxGnPFe8HxZarA2NvA=;
 b=ZW7VpqmJUX59VfNJeCJiGIUD9wixFMg4enTEmxRx65a17JZmTVIXZEiKJqQY19c3ez
 TE/TKhkyHdETL283ydPNigupIzoeri33oUlwHsZ4BHYbK1xorhkJjlbtAMsvmljWwJwZ
 azY+BAKufb293JaSj2gWCkopSXNes/uzxoE2quqaMXEjjv6hW/k024i9f0dFO1cb+V2h
 A7rGUZS8W5Ai6+VycvN3icXanidg//QBic0K2M4nx67hjGonXqKzjf/ocO76WxgzfKwq
 hCDJ3TNfGRsz7FFjpHphvYLkcfIoZ5GGlnPc12XKkEJQyLoOB9IEbLZoeG5z3GCyNx4F
 Kl/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:from:to:subject:date:message-id
 :in-reply-to:references;
 bh=qHpVdmqCzVmXoW2Mq3yTyYlL6lxGnPFe8HxZarA2NvA=;
 b=uAQX4HwuhN8nruTrZEnhLxW5lCb9O/pg9aN1Ch3AQIUwUUqQGAqlN85JZDC2qb341R
 PKNmKBuEbVk3cwF29yeJJ9WY+czsMFqnJwXXYCLosYmb0Ukyy4XjklZ1p4EuK0uohSk5
 AZJSGZ3DkFODca0x/7+AJEAZCHj3dDi3vc5fflEuGdjdDGikzErVqkanbXaQuOqGL2oa
 wllGI+wxfH+XT0fs5btPOd1jbC0Kj6CvNNZ5HxSiaEOJaipCb9tBJlBSQrsSsjdbX72/
 4FshVBXle28BAkGDceM6mt2iG4ce8r1GOrfGWuGptC0MmZoUcEYRP8qXN6VhE1ptVohk
 NuCQ==
X-Gm-Message-State: APjAAAVOBLksIr5q1xJPKES9D0Pw64Yxeq60qn2KIrHJc+Ftfw82igSl
 LQYVCNFMM/CslvrbjH/HxnIytQWv
X-Google-Smtp-Source: APXvYqytz0VHqF0XISX51gSasBIAPPaFfiyd1x2B+B6LO5mhngt7itkC8n1VxtTYbyXWkHahmxY/Rw==
X-Received: by 2002:a1c:720b:: with SMTP id n11mr6184568wmc.60.1574179745590; 
 Tue, 19 Nov 2019 08:09:05 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
 by smtp.gmail.com with ESMTPSA id n13sm3442203wmi.25.2019.11.19.08.09.04
 for <qemu-devel@nongnu.org>
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 19 Nov 2019 08:09:04 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 12/12] mc146818rtc: fix timer interrupt reinjection again
Date: Tue, 19 Nov 2019 17:08:48 +0100
Message-Id: <1574179728-35535-13-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
References: <1574179728-35535-1-git-send-email-pbonzini@redhat.com>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Commit 369b41359af46bded5799c9ef8be2b641d92e043 broke timer interrupt
reinjection when there is no period change by the guest.  In that
case, old_period is 0, which ends up zeroing irq_coalesced (counter of
reinjected interrupts).

The consequence is Windows 7 is unable to synchronize time via NTP.
Easily reproducible by playing a fullscreen video with cirrus and VNC.

Fix by passing s->period when periodic_timer_update is called due to
expiration of the timer.  With this change, old_period == 0 only
means that the periodic timer was off.

Reported-by: Marcelo Tosatti <mtosatti@redhat.com>
Co-developed-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/rtc/mc146818rtc.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/hw/rtc/mc146818rtc.c b/hw/rtc/mc146818rtc.c
index 9869dc5..74ae74b 100644
--- a/hw/rtc/mc146818rtc.c
+++ b/hw/rtc/mc146818rtc.c
@@ -168,12 +168,14 @@ static uint32_t rtc_periodic_clock_ticks(RTCState *s)
  * is just due to period adjustment.
  */
 static void
-periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
+periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period, bool period_change)
 {
     uint32_t period;
     int64_t cur_clock, next_irq_clock, lost_clock = 0;
 
     period = rtc_periodic_clock_ticks(s);
+    s->period = period;
+
     if (!period) {
         s->irq_coalesced = 0;
         timer_del(s->periodic_timer);
@@ -188,7 +190,7 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
      * if the periodic timer's update is due to period re-configuration,
      * we should count the clock since last interrupt.
      */
-    if (old_period) {
+    if (old_period && period_change) {
         int64_t last_periodic_clock, next_periodic_clock;
 
         next_periodic_clock = muldiv64(s->next_periodic_time,
@@ -215,7 +217,6 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
     if (s->lost_tick_policy == LOST_TICK_POLICY_SLEW) {
         uint32_t old_irq_coalesced = s->irq_coalesced;
 
-        s->period = period;
         lost_clock += old_irq_coalesced * old_period;
         s->irq_coalesced = lost_clock / s->period;
         lost_clock %= s->period;
@@ -245,7 +246,7 @@ static void rtc_periodic_timer(void *opaque)
 {
     RTCState *s = opaque;
 
-    periodic_timer_update(s, s->next_periodic_time, 0);
+    periodic_timer_update(s, s->next_periodic_time, s->period, false);
     s->cmos_data[RTC_REG_C] |= REG_C_PF;
     if (s->cmos_data[RTC_REG_B] & REG_B_PIE) {
         s->cmos_data[RTC_REG_C] |= REG_C_IRQF;
@@ -511,7 +512,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
 
             if (update_periodic_timer) {
                 periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
-                                      old_period);
+                                      old_period, true);
             }
 
             check_update_timer(s);
@@ -550,7 +551,7 @@ static void cmos_ioport_write(void *opaque, hwaddr addr,
 
             if (update_periodic_timer) {
                 periodic_timer_update(s, qemu_clock_get_ns(rtc_clock),
-                                      old_period);
+                                      old_period, true);
             }
 
             check_update_timer(s);
@@ -794,6 +795,7 @@ static int rtc_post_load(void *opaque, int version_id)
         s->offset = 0;
         check_update_timer(s);
     }
+    s->period = rtc_periodic_clock_ticks(s);
 
     /* The periodic timer is deterministic in record/replay mode,
      * so there is no need to update it after loading the vmstate.
@@ -803,7 +805,7 @@ static int rtc_post_load(void *opaque, int version_id)
         uint64_t now = qemu_clock_get_ns(rtc_clock);
         if (now < s->next_periodic_time ||
             now > (s->next_periodic_time + get_max_clock_jump())) {
-            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock), 0);
+            periodic_timer_update(s, qemu_clock_get_ns(rtc_clock), s->period, false);
         }
     }
 
-- 
1.8.3.1


