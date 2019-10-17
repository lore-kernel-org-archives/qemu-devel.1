Return-Path: <SRS0=yZS3=YK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3769FA372A
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:41:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7EDFC2089C
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Oct 2019 15:41:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xf3tAE9C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7EDFC2089C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iL7ti-0000VA-Bj
	for qemu-devel@archiver.kernel.org; Thu, 17 Oct 2019 11:41:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iL7AN-0001N2-WD
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:54:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iL7AM-0001qv-C8
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:54:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44837
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iL7AM-0001qI-5B
 for qemu-devel@nongnu.org; Thu, 17 Oct 2019 10:54:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1571324053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fFgW5Se6XfgeBSJbMeJJLtNFbsF1E5RfdMxY5hhwjAs=;
 b=Xf3tAE9CuvUf3V9x1E//gVZxukHXEwM2MI5+VNPfqBE8BZDmpxZKOJy+hVS/wHHHkDl86y
 CYaKHL+HnhPQjk6Vcwhqo6sP9blZ0ENlQMyl/LiUV0NpExvK6KTO9smguZYIa8bP8zu2Ez
 7BXVJBBP0xirTZfNtwYFw7l50sb4qbY=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-qa1aUo20MgeyJKXBg-iTsA-1; Thu, 17 Oct 2019 10:54:11 -0400
Received: by mail-wr1-f70.google.com with SMTP id e14so1072302wrm.21
 for <qemu-devel@nongnu.org>; Thu, 17 Oct 2019 07:54:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ONFvR+2nNf7DtaVDGzcbQp6qaCHCrPZNp0H5NB58D5c=;
 b=gckNg8osuJelv6/k5QdQGhKL2vILgDe7vnLTQ40Y/nq/006yChYrTn+vwshKeyhLI+
 6c93ETezuG+64Xs2iRDgxrHYQ5gr3mVbIZsulIe3rwS1+bihVCr8CPp0/HVwncbGQo/G
 Gqeenkk84oDiTro764///KdmZFKuMeWA2PcJDMCQFfxbR3VgDjHsfegciOQocNvr71P/
 5Z1k/o1g5tsYYCWhYkSXWcbm8jOYsJfC+ixkVt7n84fWYNZIFNKp8sc9605/Jh+xPAmn
 dRQToZzpFJfKjNnTFJSZZ111YHzO35b84fDgQ9mXU9J+6wq0DjxhlNaYEQrAMp63ak99
 tzFw==
X-Gm-Message-State: APjAAAW+54fwAcT0SyYcfjrYILaGyYQIPvGA5NnUghEKM1BxY+GFeB9T
 NrVr/ebD63caj8QqXENMQrxVf4F7cpEmjFsfu7bgGFuoo3xUnyJBrinH1RkAl+aLoU94KDXDCxu
 pzcLZgcmQzN/AAA0=
X-Received: by 2002:adf:eb8c:: with SMTP id t12mr3387096wrn.34.1571324050525; 
 Thu, 17 Oct 2019 07:54:10 -0700 (PDT)
X-Google-Smtp-Source: APXvYqwDDbMGFfB3v10ptuQWX2ANapfZw8ISeh1MsxmtDhhJCVXlipXJkLdq6qWXAk0wC8huzoKKNw==
X-Received: by 2002:adf:eb8c:: with SMTP id t12mr3387076wrn.34.1571324050262; 
 Thu, 17 Oct 2019 07:54:10 -0700 (PDT)
Received: from [192.168.50.32] (243.red-88-26-246.staticip.rima-tde.net.
 [88.26.246.243])
 by smtp.gmail.com with ESMTPSA id b12sm2383212wrt.21.2019.10.17.07.54.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 17 Oct 2019 07:54:09 -0700 (PDT)
Subject: Re: [PATCH 2/2] hw/timer/slavio_timer.c: Switch to transaction-based
 ptimer API
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20191017132351.4762-1-peter.maydell@linaro.org>
 <20191017132351.4762-3-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2210f783-1159-1263-dfff-3bd84111e2f5@redhat.com>
Date: Thu, 17 Oct 2019 16:54:08 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191017132351.4762-3-peter.maydell@linaro.org>
Content-Language: en-US
X-MC-Unique: qa1aUo20MgeyJKXBg-iTsA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: KONRAD Frederic <frederic.konrad@adacore.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Fabien Chouteau <chouteau@adacore.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Peter,

On 10/17/19 3:23 PM, Peter Maydell wrote:
> Switch the slavio_timer code away from bottom-half based ptimers to
> the new transaction-based ptimer API.  This just requires adding
> begin/commit calls around the various places that modify the ptimer
> state, and using the new ptimer_init() function to create the timer.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>   hw/timer/slavio_timer.c | 20 ++++++++++++++++----
>   1 file changed, 16 insertions(+), 4 deletions(-)
>=20
> diff --git a/hw/timer/slavio_timer.c b/hw/timer/slavio_timer.c
> index 692d213897d..0e2efe6fe89 100644
> --- a/hw/timer/slavio_timer.c
> +++ b/hw/timer/slavio_timer.c
> @@ -30,7 +30,6 @@
>   #include "hw/sysbus.h"
>   #include "migration/vmstate.h"
>   #include "trace.h"
> -#include "qemu/main-loop.h"
>   #include "qemu/module.h"
>  =20
>   /*
> @@ -213,6 +212,7 @@ static void slavio_timer_mem_writel(void *opaque, hwa=
ddr addr,
>       saddr =3D addr >> 2;
>       switch (saddr) {
>       case TIMER_LIMIT:
> +        ptimer_transaction_begin(t->timer);
>           if (slavio_timer_is_user(tc)) {
>               uint64_t count;


This part is odd since there is a check on t->timer !=3D NULL later, and=20
ptimer_transaction_commit() can't take NULL.

This won't happen if you restrict to ptimer_* calls:

-- >8 --
@@ -222,18 +222,22 @@ static void slavio_timer_mem_writel(void *opaque,=20
hwaddr addr,
              t->reached =3D 0;
              count =3D ((uint64_t)t->counthigh << 32) | t->count;
              trace_slavio_timer_mem_writel_limit(timer_index, count);
+            ptimer_transaction_begin(t->timer);
              ptimer_set_count(t->timer, LIMIT_TO_PERIODS(t->limit -=20
count));
+            ptimer_transaction_commit(t->timer);
          } else {
              // set limit, reset counter
              qemu_irq_lower(t->irq);
              t->limit =3D val & TIMER_MAX_COUNT32;
              if (t->timer) {
+                ptimer_transaction_begin(t->timer);
                  if (t->limit =3D=3D 0) { /* free-run */
                      ptimer_set_limit(t->timer,
=20
LIMIT_TO_PERIODS(TIMER_MAX_COUNT32), 1);
                  } else {
                      ptimer_set_limit(t->timer,=20
LIMIT_TO_PERIODS(t->limit), 1);
                  }
+                ptimer_transaction_commit(t->timer);
              }
          }
          break;
---

>  =20
> @@ -236,6 +236,7 @@ static void slavio_timer_mem_writel(void *opaque, hwa=
ddr addr,
>                   }
>               }
>           }
> +        ptimer_transaction_commit(t->timer);
>           break;
>       case TIMER_COUNTER:
>           if (slavio_timer_is_user(tc)) {
> @@ -247,7 +248,9 @@ static void slavio_timer_mem_writel(void *opaque, hwa=
ddr addr,
>               t->reached =3D 0;
>               count =3D ((uint64_t)t->counthigh) << 32 | t->count;
>               trace_slavio_timer_mem_writel_limit(timer_index, count);
> +            ptimer_transaction_begin(t->timer);
>               ptimer_set_count(t->timer, LIMIT_TO_PERIODS(t->limit - coun=
t));
> +            ptimer_transaction_commit(t->timer);
>           } else {
>               trace_slavio_timer_mem_writel_counter_invalid();
>           }
> @@ -255,13 +258,16 @@ static void slavio_timer_mem_writel(void *opaque, h=
waddr addr,
>       case TIMER_COUNTER_NORST:
>           // set limit without resetting counter
>           t->limit =3D val & TIMER_MAX_COUNT32;
> +        ptimer_transaction_begin(t->timer);
>           if (t->limit =3D=3D 0) { /* free-run */
>               ptimer_set_limit(t->timer, LIMIT_TO_PERIODS(TIMER_MAX_COUNT=
32), 0);
>           } else {
>               ptimer_set_limit(t->timer, LIMIT_TO_PERIODS(t->limit), 0);
>           }
> +        ptimer_transaction_commit(t->timer);
>           break;
>       case TIMER_STATUS:
> +        ptimer_transaction_begin(t->timer);
>           if (slavio_timer_is_user(tc)) {

I'd move the begin() here.

>               // start/stop user counter
>               if (val & 1) {
> @@ -273,6 +279,7 @@ static void slavio_timer_mem_writel(void *opaque, hwa=
ddr addr,
>               }
>           }
>           t->run =3D val & 1;
> +        ptimer_transaction_commit(t->timer);
>           break;
>       case TIMER_MODE:
>           if (timer_index =3D=3D 0) {
> @@ -282,6 +289,7 @@ static void slavio_timer_mem_writel(void *opaque, hwa=
ddr addr,
>                   unsigned int processor =3D 1 << i;
>                   CPUTimerState *curr_timer =3D &s->cputimer[i + 1];
>  =20
> +                ptimer_transaction_begin(curr_timer->timer);
>                   // check for a change in timer mode for this processor
>                   if ((val & processor) !=3D (s->cputimer_mode & processo=
r)) {

Ditto, begin() here.

>                       if (val & processor) { // counter -> user timer
> @@ -308,6 +316,7 @@ static void slavio_timer_mem_writel(void *opaque, hwa=
ddr addr,
>                           trace_slavio_timer_mem_writel_mode_counter(time=
r_index);
>                       }
>                   }
> +                ptimer_transaction_commit(curr_timer->timer);
>               }
>           } else {
>               trace_slavio_timer_mem_writel_mode_invalid();
> @@ -367,10 +376,12 @@ static void slavio_timer_reset(DeviceState *d)
>           curr_timer->count =3D 0;
>           curr_timer->reached =3D 0;
>           if (i <=3D s->num_cpus) {
> +            ptimer_transaction_begin(curr_timer->timer);
>               ptimer_set_limit(curr_timer->timer,
>                                LIMIT_TO_PERIODS(TIMER_MAX_COUNT32), 1);
>               ptimer_run(curr_timer->timer, 0);
>               curr_timer->run =3D 1;
> +            ptimer_transaction_commit(curr_timer->timer);
>           }
>       }
>       s->cputimer_mode =3D 0;
> @@ -380,7 +391,6 @@ static void slavio_timer_init(Object *obj)
>   {
>       SLAVIO_TIMERState *s =3D SLAVIO_TIMER(obj);
>       SysBusDevice *dev =3D SYS_BUS_DEVICE(obj);
> -    QEMUBH *bh;
>       unsigned int i;
>       TimerContext *tc;
>  =20
> @@ -392,9 +402,11 @@ static void slavio_timer_init(Object *obj)
>           tc->s =3D s;
>           tc->timer_index =3D i;
>  =20
> -        bh =3D qemu_bh_new(slavio_timer_irq, tc);
> -        s->cputimer[i].timer =3D ptimer_init_with_bh(bh, PTIMER_POLICY_D=
EFAULT);
> +        s->cputimer[i].timer =3D ptimer_init(slavio_timer_irq, tc,
> +                                           PTIMER_POLICY_DEFAULT);
> +        ptimer_transaction_begin(s->cputimer[i].timer);
>           ptimer_set_period(s->cputimer[i].timer, TIMER_PERIOD);
> +        ptimer_transaction_commit(s->cputimer[i].timer);
>  =20
>           size =3D i =3D=3D 0 ? SYS_TIMER_SIZE : CPU_TIMER_SIZE;
>           snprintf(timer_name, sizeof(timer_name), "timer-%i", i);
>=20


