Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5EAC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:28:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0C6E0217F4
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 14:28:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0C6E0217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52118 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqIGD-000081-6i
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 10:28:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57909)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqIG0-0008BP-Gm
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:28:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqIFz-0003Zu-IC
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:28:40 -0400
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42009)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqIFz-0003ZT-C3
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 10:28:39 -0400
Received: by mail-wr1-f66.google.com with SMTP id x1so32250262wrr.9
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 07:28:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2utKydVgvXFXqEVBzFbB8ukXgtxJIaeolAbpBlmqs2Y=;
 b=On7bwexYyugwDAIrQ7e+IRmUffSZ9wUihVW0ITBy1XzppRZH8whbzOO7Jm8Quqj9Yo
 ZxdcIj7rZoaGG8nPK12hgc2edWvtSlADedvCReJvKRvrPrHk9+NKkxug6YOiy6TpC8aY
 hjbZChEDWDpdeZPB7HIV0XiijKpVVL150BItlaUS/APWgBe7pfK1BZTtv9764pKxEoJ6
 RkqAB2vqtkvRXiVUit791HuCBPK9TCR6VprIvSbTnLYqMi9yGIAm3BK/jyee5itbRWQP
 +RRw+0EtjEDZCQ6UTeqoA9TBQ47gSnNJ86LP4lvn1vH96i3HK0Pue1/bvQsT3CxBatqv
 8/og==
X-Gm-Message-State: APjAAAVBjshTO1BSjLfFZmbfdIQasVqv/zhsPg8yClZbe6WAZUki5ub9
 bDIi7wBSMFt3w5qz4nsoUVue5w==
X-Google-Smtp-Source: APXvYqyd16pelinc7pn0wCXcy4LM//j1SFhgpOM6eCH/bmta4q92eVa918Z9tykJxYdA0GIqZKxYjg==
X-Received: by 2002:adf:c003:: with SMTP id z3mr2902128wre.243.1563978518191; 
 Wed, 24 Jul 2019 07:28:38 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:10f7:67c8:abb4:8512?
 ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
 by smtp.gmail.com with ESMTPSA id x185sm35617468wmg.46.2019.07.24.07.28.36
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2019 07:28:37 -0700 (PDT)
To: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>, qemu-devel@nongnu.org
References: <156395778867.510.17588721322993616668.stgit@pasha-Precision-3630-Tower>
 <156395785017.510.9244716077158313815.stgit@pasha-Precision-3630-Tower>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <55b86868-36a1-def1-8ef0-ca00ab273645@redhat.com>
Date: Wed, 24 Jul 2019 16:28:35 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <156395785017.510.9244716077158313815.stgit@pasha-Precision-3630-Tower>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.66
Subject: Re: [Qemu-devel] [PATCH for-4.2 10/14] util/qemu-timer: refactor
 deadline calculation for external timers
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 quintela@redhat.com, ciro.santilli@gmail.com, jasowang@redhat.com,
 crosthwaite.peter@gmail.com, armbru@redhat.com, mreitz@redhat.com,
 alex.bennee@linaro.org, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 dovgaluk@ispras.ru, artem.k.pisarenko@gmail.com, dgilbert@redhat.com,
 rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 24/07/19 10:44, Pavel Dovgalyuk wrote:
> -int64_t qemu_clock_deadline_ns_all(QEMUClockType type)
> +int64_t virtual_clock_deadline_ns(void)
>  {
>      int64_t deadline = -1;
> +    int64_t delta;
> +    int64_t expire_time;
> +    QEMUTimer *ts;
>      QEMUTimerList *timer_list;
> -    QEMUClock *clock = qemu_clock_ptr(type);
> +    QEMUClock *clock = qemu_clock_ptr(QEMU_CLOCK_VIRTUAL);
> +
> +    if (!clock->enabled) {
> +        return -1;
> +    }
> +
>      QLIST_FOREACH(timer_list, &clock->timerlists, list) {
> -        deadline = qemu_soonest_timeout(deadline,
> -                                        timerlist_deadline_ns(timer_list));
> +        qemu_mutex_lock(&timer_list->active_timers_lock);
> +        ts = timer_list->active_timers;
> +        /* Skip all external timers */
> +        while (ts && (ts->attributes & QEMU_TIMER_ATTR_EXTERNAL)) {
> +            ts = ts->next;
> +        }
> +        if (!ts) {
> +            qemu_mutex_unlock(&timer_list->active_timers_lock);
> +            continue;
> +        }
> +        expire_time = ts->expire_time;
> +        qemu_mutex_unlock(&timer_list->active_timers_lock);
> +
> +        delta = expire_time - qemu_clock_get_ns(QEMU_CLOCK_VIRTUAL);
> +        if (delta <= 0) {
> +            delta = 0;
> +        }
> +        deadline = qemu_soonest_timeout(deadline, delta);
>      }
>      return deadline;
>  }
> 

Why would this change be exclusive to QEMU_CLOCK_VIRTUAL?  I don't think
it's useful to remove the argument.  Otherwise, the patch makes sense.

Paolo

