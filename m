Return-Path: <SRS0=qKtL=YC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 806F0C47404
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:40:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 531DE206BB
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Oct 2019 21:40:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 531DE206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iIJgt-0002fj-EY
	for qemu-devel@archiver.kernel.org; Wed, 09 Oct 2019 17:40:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45805)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iIJGv-0007d3-7z
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:13:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iIJGs-0001uh-6n
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:13:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37902)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iIJGr-0001u2-TE
 for qemu-devel@nongnu.org; Wed, 09 Oct 2019 17:13:22 -0400
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 87069C0718BE
 for <qemu-devel@nongnu.org>; Wed,  9 Oct 2019 21:13:19 +0000 (UTC)
Received: by mail-wr1-f71.google.com with SMTP id v18so1659666wro.16
 for <qemu-devel@nongnu.org>; Wed, 09 Oct 2019 14:13:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5pOCpkDtqxO8PaQeES7waoMMgRUxoF4gjpAu7uY2V+s=;
 b=jmU9cU6B0CeUnGyyTVrtk3Ou6dT/+DhPt2fMpRgoDvVCxNi/I9LQfCGgo9TLbU9qv+
 nntAWYeNxcef16PtfqGzs0koGnUBezAkEpUDsJ/tCobJi8AEGVS98du1tDxoKIFBPEc6
 nzjCpMBeTmqm8oWE1i+8pjGXh0mIujRuY0uOCUfw9XwEKJFvIK47pDykxQQcXXU5RnT5
 TlaeJxwuu/tHy8FUkAeW8L6MQiT5Wc+tmlsYu2yCVJVVZhU5ygMHu6Nrq3rpGQA8FczW
 1PTg5iZunuVK4Loi1nf5NSj9LSzuf5fqfs0RyQjqQ/qlTemHkKJjzRpzLwpwibOKPrnU
 qxZw==
X-Gm-Message-State: APjAAAVCdyKSynzWgQMrWuWTIKFX0kfkNFo1LQQJzi/U5+yMn72ycLPv
 0JmW07XliCcNKHTrKUEhwG6VjmMv1t/wNGc9aTyGtIa8xf4rkQYrL8FsIideKhbfISLU8+gC/Aj
 ViZvwWEfLC5I9aik=
X-Received: by 2002:adf:f68f:: with SMTP id v15mr4519650wrp.234.1570655598189; 
 Wed, 09 Oct 2019 14:13:18 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxtmKaAq/QrTH2vE9uahCLIExEjJVlHC+OWfangqo+F0udQc2Q+ldQjzeEa/DfCF+Mdd1S4TA==
X-Received: by 2002:adf:f68f:: with SMTP id v15mr4519623wrp.234.1570655597863; 
 Wed, 09 Oct 2019 14:13:17 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:1032:7ea1:7f8f:1e5?
 ([2001:b07:6468:f312:1032:7ea1:7f8f:1e5])
 by smtp.gmail.com with ESMTPSA id f18sm2345315wmh.43.2019.10.09.14.13.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Oct 2019 14:13:17 -0700 (PDT)
Subject: Re: [PATCH] mc146818rtc: fix timer interrupt reinjection
To: Marcelo Tosatti <mtosatti@redhat.com>, qemu-devel <qemu-devel@nongnu.org>
References: <20191009184011.GA26234@amt.cnet>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8319ce4d-2775-a68d-c08b-f4312d9c30a2@redhat.com>
Date: Wed, 9 Oct 2019 23:13:16 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191009184011.GA26234@amt.cnet>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Tai Yunfang <yunfangtai@tencent.com>,
 Xiao Guangrong <guangrong.xiao@gmail.com>,
 Vadim Rozenfeld <vrozenfe@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/10/19 20:40, Marcelo Tosatti wrote:
>              s->period = period;
>              lost_clock += old_irq_coalesced * old_period;
> -            s->irq_coalesced = lost_clock / s->period;
> +            if (old_period) {
> +                s->irq_coalesced = lost_clock / s->period;
> +            }
> +
>              lost_clock %= s->period;
>              if (old_irq_coalesced != s->irq_coalesced ||
>                  old_period != s->period) {

I think none of the code in the "if (s->lost_tick_policy == 
LOST_TICK_POLICY_SLEW) {" matters if old_period == 0 (and lost_clock 
will always be 0).  So perhaps we should place all that big "if" under
the existing "if (old_period)"?

Or even something like:

diff --git a/hw/timer/mc146818rtc.c b/hw/timer/mc146818rtc.c
index 6cb378751b..3337a8da98 100644
--- a/hw/timer/mc146818rtc.c
+++ b/hw/timer/mc146818rtc.c
@@ -202,25 +202,33 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
     int64_t cur_clock, next_irq_clock, lost_clock = 0;
 
     period = rtc_periodic_clock_ticks(s);
+    if (old_period && old_period == period) {
+        return;
+    }
 
-    if (period) {
-        /* compute 32 khz clock */
-        cur_clock =
-            muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
+    if (!period) {
+        s->irq_coalesced = 0;
+        timer_del(s->periodic_timer);
+        return;
 
-        /*
-        * if the periodic timer's update is due to period re-configuration,
-        * we should count the clock since last interrupt.
-        */
-        if (old_period) {
-            int64_t last_periodic_clock, next_periodic_clock;
-
-            next_periodic_clock = muldiv64(s->next_periodic_time,
-                                    RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
-            last_periodic_clock = next_periodic_clock - old_period;
-            lost_clock = cur_clock - last_periodic_clock;
-            assert(lost_clock >= 0);
-        }
+    }
+
+    /* compute 32 khz clock */
+    cur_clock =
+        muldiv64(current_time, RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
+
+    /*
+     * if the periodic timer's update is due to period re-configuration,
+     * we should count the clock since last interrupt.
+     */
+    if (old_period) {
+        int64_t last_periodic_clock, next_periodic_clock;
+
+        next_periodic_clock = muldiv64(s->next_periodic_time,
+                                       RTC_CLOCK_RATE, NANOSECONDS_PER_SECOND);
+        last_periodic_clock = next_periodic_clock - old_period;
+        lost_clock = cur_clock - last_periodic_clock;
+        assert(lost_clock >= 0);
 
         /*
          * s->irq_coalesced can change for two reasons:
@@ -243,13 +251,10 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
             lost_clock += old_irq_coalesced * old_period;
             s->irq_coalesced = lost_clock / s->period;
             lost_clock %= s->period;
-            if (old_irq_coalesced != s->irq_coalesced ||
-                old_period != s->period) {
-                DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, "
-                          "period scaled from %d to %d\n", old_irq_coalesced,
-                          s->irq_coalesced, old_period, s->period);
-                rtc_coalesced_timer_update(s);
-            }
+            DPRINTF_C("cmos: coalesced irqs scaled from %d to %d, "
+                      "period scaled from %d to %d\n", old_irq_coalesced,
+                      s->irq_coalesced, old_period, s->period);
+            rtc_coalesced_timer_update(s);
         } else {
            /*
              * no way to compensate the interrupt if LOST_TICK_POLICY_SLEW
@@ -257,16 +262,12 @@ periodic_timer_update(RTCState *s, int64_t current_time, uint32_t old_period)
              */
             lost_clock = MIN(lost_clock, period);
         }
-
         assert(lost_clock >= 0 && lost_clock <= period);
-
-        next_irq_clock = cur_clock + period - lost_clock;
-        s->next_periodic_time = periodic_clock_to_ns(next_irq_clock) + 1;
-        timer_mod(s->periodic_timer, s->next_periodic_time);
-    } else {
-        s->irq_coalesced = 0;
-        timer_del(s->periodic_timer);
     }
+
+    next_irq_clock = cur_clock + period - lost_clock;
+    s->next_periodic_time = periodic_clock_to_ns(next_irq_clock) + 1;
+    timer_mod(s->periodic_timer, s->next_periodic_time);
 }
 
 static void rtc_periodic_timer(void *opaque)


Best read with "diff -b".

Paolo

