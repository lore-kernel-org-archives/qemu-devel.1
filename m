Return-Path: <SRS0=qU7A=VV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6651AC7618B
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 08:48:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9EE227BF
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Jul 2019 08:48:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B9EE227BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49836 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hqCwJ-0007sF-6U
	for qemu-devel@archiver.kernel.org; Wed, 24 Jul 2019 04:47:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35399)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <pbonzini@redhat.com>) id 1hqCvr-0006bP-Tw
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:47:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <pbonzini@redhat.com>) id 1hqCvq-0004ca-RB
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:47:31 -0400
Received: from mail-wm1-f68.google.com ([209.85.128.68]:50230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hqCvq-0004cB-J1
 for qemu-devel@nongnu.org; Wed, 24 Jul 2019 04:47:30 -0400
Received: by mail-wm1-f68.google.com with SMTP id v15so41024556wml.0
 for <qemu-devel@nongnu.org>; Wed, 24 Jul 2019 01:47:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=c3PohLBx/jDy88dv1OeoJfGBMbiEykVSWAJ5lbldAww=;
 b=gBLb+ayoS1dERpRntg7zInbLBd3ixdSu7nthnCmIHWEstVgwqhSVp5eSITl2IjDL1J
 gGskMo+5WRgxLkw1pl2OoB5PqnEQ9952RUeym/kxk+tV7uvHJ5XKmzTOUNE1V2Ohrq+D
 a9idx+BiFMTFcKNJgyf7r1ASncHrx2olW0WZaKr59VvUXSpw1OpOYEZfdf9QiF9DRrCy
 RAzWIT72rrWO7LJkISi+o0OTw/hgrEk8D/QxpumEWtQJPH1uBiuTJpajkRMUV+9Ftrtl
 69solUhHmZX58rZwJOGEoLpsZ5ZvEd+W7lH5/C2uajbZvj5zXaW995RR1J5tnekURh3K
 QPrA==
X-Gm-Message-State: APjAAAWrB6+lbExzn1ysYJ9EgeblSXpDfh7jWGUvDCNSbj6YOeKRHBUL
 bId6LPx1+GNZacWNE+b5+9+02A==
X-Google-Smtp-Source: APXvYqzuNPmjpMJEL7nOvaosA4eFhkh2++HqFYXRGwAdMKoy43S5p+oSolKeQG8DvZ4T/tiuhRTvaA==
X-Received: by 2002:a1c:f408:: with SMTP id z8mr47827707wma.97.1563958049507; 
 Wed, 24 Jul 2019 01:47:29 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:10f7:67c8:abb4:8512?
 ([2001:b07:6468:f312:10f7:67c8:abb4:8512])
 by smtp.gmail.com with ESMTPSA id o11sm41889770wmh.37.2019.07.24.01.47.28
 (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
 Wed, 24 Jul 2019 01:47:29 -0700 (PDT)
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
References: <20190723190623.21537-1-stefanha@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Openpgp: preference=signencrypt
Message-ID: <7287eae6-0c19-e082-9a8c-4fbd47afcd94@redhat.com>
Date: Wed, 24 Jul 2019 10:47:28 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190723190623.21537-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.68
Subject: Re: [Qemu-devel] [PATCH] util/async: hold AioContext ref to prevent
 use-after-free
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
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 23/07/19 21:06, Stefan Hajnoczi wrote:
> The tests/test-bdrv-drain /bdrv-drain/iothread/drain test case does the
> following:
> 
> 1. The preadv coroutine calls aio_bh_schedule_oneshot() and then yields.
> 2. The one-shot BH executes in another AioContext.  All it does is call
>    aio_co_wakeup(preadv_co).
> 3. The preadv coroutine is re-entered and returns.
> 
> There is a race condition in aio_co_wake() where the preadv coroutine
> returns and the test case destroys the preadv IOThread.  aio_co_wake()
> can still be running in the other AioContext and it performs an access
> to the freed IOThread AioContext.
> 
> Here is the race in aio_co_schedule():
> 
>   QSLIST_INSERT_HEAD_ATOMIC(&ctx->scheduled_coroutines,
>                             co, co_scheduled_next);
>   <-- race: co may execute before we invoke qemu_bh_schedule()!
>   qemu_bh_schedule(ctx->co_schedule_bh);
> 
> So if co causes ctx to be freed then we're in trouble.  Fix this problem
> by holding a reference to ctx.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  util/async.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/util/async.c b/util/async.c
> index 8d2105729c..4e4c7af51e 100644
> --- a/util/async.c
> +++ b/util/async.c
> @@ -459,9 +459,17 @@ void aio_co_schedule(AioContext *ctx, Coroutine *co)
>          abort();
>      }
>  
> +    /* The coroutine might run and release the last ctx reference before we
> +     * invoke qemu_bh_schedule().  Take a reference to keep ctx alive until
> +     * we're done.
> +     */
> +    aio_context_ref(ctx);
> +
>      QSLIST_INSERT_HEAD_ATOMIC(&ctx->scheduled_coroutines,
>                                co, co_scheduled_next);
>      qemu_bh_schedule(ctx->co_schedule_bh);
> +
> +    aio_context_unref(ctx);
>  }
>  
>  void aio_co_wake(struct Coroutine *co)
> 

This must have been painful to debug.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>

Paolo

