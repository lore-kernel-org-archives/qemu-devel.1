Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D1A2ECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:52:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3333D217D9
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 11:52:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3333D217D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJyte-0008Nv-DN
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 07:52:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47397)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <pbonzini@redhat.com>) id 1iJyGS-0005Jk-IQ
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:11:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1iJyGQ-0004R6-Fu
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:11:47 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53716)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1iJyGQ-0004Q5-6M
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 07:11:46 -0400
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id DD7FC4E924
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 11:11:44 +0000 (UTC)
Received: by mail-wm1-f69.google.com with SMTP id l3so6992244wmf.8
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 04:11:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=SDE5qd2wcaa/++EVD56kSyJc2TP5Z4liIwQNkdzLSrw=;
 b=Ha+0wr5JCt5V6satbuGP6o5Ncyl05W6f8Dz/heHj8iJQRlTXgm/rEZ687ae/lbtvF5
 1zqRo0GZkXUM9oSQw6IDTR5SXA+6fOsADrutu4SK9fpOb6KN/yCNZp/pClPlxM8mif1e
 xQRlVAS/0/s7VgPWzefFsjVIfPsi4FTgS1G5E8gBzDbO1t7pMz8xeleG+WLpR03g//eB
 nr5jhuhdXjjW5DDqv07rAnIAmrghd8L/Fa1FKoH8t36ELm1ntM2Zy/AZw4kdzJ4rq3GV
 aFiJ3W8mx1QutLGfoIUIIJwXZj24yjvOtFdvZR/B3IZtCC/xPw1GOzie9Z3aQTztKT1R
 POIA==
X-Gm-Message-State: APjAAAWpjSRtlklxNsqtnID7H0Hs1MBSGIzOLfNCJJ7XiJMnzmGiPvwl
 Ym3REjESj4hlGhgDsey7hdfDc9cbkXFPG/9/vJ9MawGr7aCrRdHPFUJxeslGvID+b6PG7k8vYLe
 rTne69mxvhnZG3Rw=
X-Received: by 2002:a5d:56c4:: with SMTP id m4mr24336168wrw.195.1571051503437; 
 Mon, 14 Oct 2019 04:11:43 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyqP5SZS//sCgDvG5aja6cvIoKCoFC/qKmjlzR+aw5YYBdxteDIrdxjvwRIQP/LcFqcKJnI/g==
X-Received: by 2002:a5d:56c4:: with SMTP id m4mr24336144wrw.195.1571051503140; 
 Mon, 14 Oct 2019 04:11:43 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:ddc7:c53c:581a:7f3e?
 ([2001:b07:6468:f312:ddc7:c53c:581a:7f3e])
 by smtp.gmail.com with ESMTPSA id a71sm15361763wme.11.2019.10.14.04.11.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Oct 2019 04:11:42 -0700 (PDT)
Subject: Re: [PULL 1/1] test-bdrv-drain: fix iothread_join() hang
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20191014085211.25800-1-stefanha@redhat.com>
 <20191014085211.25800-2-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <8fd9e071-c62d-f90f-a7d7-b5b320cbde9b@redhat.com>
Date: Mon, 14 Oct 2019 13:11:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191014085211.25800-2-stefanha@redhat.com>
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Max Reitz <mreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 14/10/19 10:52, Stefan Hajnoczi wrote:
> tests/test-bdrv-drain can hang in tests/iothread.c:iothread_run():
> 
>   while (!atomic_read(&iothread->stopping)) {
>       aio_poll(iothread->ctx, true);
>   }
> 
> The iothread_join() function works as follows:
> 
>   void iothread_join(IOThread *iothread)
>   {
>       iothread->stopping = true;
>       aio_notify(iothread->ctx);
>       qemu_thread_join(&iothread->thread);
> 
> If iothread_run() checks iothread->stopping before the iothread_join()
> thread sets stopping to true, then aio_notify() may be optimized away
> and iothread_run() hangs forever in aio_poll().
> 
> The correct way to change iothread->stopping is from a BH that executes
> within iothread_run().  This ensures that iothread->stopping is checked
> after we set it to true.
> 
> This was already fixed for ./iothread.c (note this is a different source
> file!) by commit 2362a28ea11c145e1a13ae79342d76dc118a72a6 ("iothread:
> fix iothread_stop() race condition"), but not for tests/iothread.c.

Aha, I did have some kind of dejavu when sending the patch I have just
sent; let's see if this also fixes the test-aio-multithread assertion
failure.

Note that with this change the atomic read of iothread->stopping can go
away; I can send a separate patch later.

Paolo

> Fixes: 0c330a734b51c177ab8488932ac3b0c4d63a718a
>        ("aio: introduce aio_co_schedule and aio_co_wake")
> Reported-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
> Message-Id: <20191003100103.331-1-stefanha@redhat.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  tests/iothread.c | 10 ++++++++--
>  1 file changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/iothread.c b/tests/iothread.c
> index 777d9eea46..13c9fdcd8d 100644
> --- a/tests/iothread.c
> +++ b/tests/iothread.c
> @@ -55,10 +55,16 @@ static void *iothread_run(void *opaque)
>      return NULL;
>  }
>  
> -void iothread_join(IOThread *iothread)
> +static void iothread_stop_bh(void *opaque)
>  {
> +    IOThread *iothread = opaque;
> +
>      iothread->stopping = true;
> -    aio_notify(iothread->ctx);
> +}
> +
> +void iothread_join(IOThread *iothread)
> +{
> +    aio_bh_schedule_oneshot(iothread->ctx, iothread_stop_bh, iothread);
>      qemu_thread_join(&iothread->thread);
>      qemu_cond_destroy(&iothread->init_done_cond);
>      qemu_mutex_destroy(&iothread->init_done_lock);
> 



