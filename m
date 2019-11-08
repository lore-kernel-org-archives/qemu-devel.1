Return-Path: <SRS0=73np=ZA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEAADC5DF60
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 18:43:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9807C21848
	for <qemu-devel@archiver.kernel.org>; Fri,  8 Nov 2019 18:43:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nEHT8quu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9807C21848
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58808 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iT9E4-0003Nc-RF
	for qemu-devel@archiver.kernel.org; Fri, 08 Nov 2019 13:43:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54726)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iT9D5-0002v3-St
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 13:42:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iT9D4-0003pH-0L
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 13:42:15 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:45730)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iT9D3-0003oc-PW
 for qemu-devel@nongnu.org; Fri, 08 Nov 2019 13:42:13 -0500
Received: by mail-ot1-x343.google.com with SMTP id r24so6008010otk.12
 for <qemu-devel@nongnu.org>; Fri, 08 Nov 2019 10:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ocU50U6KViLf6NA3LALKonlbE+WolkLGpq/0KShUpkw=;
 b=nEHT8quuCC1oIww16gcQ1KW1B6vEqXklrgFliJhQoSBtGRgKcMBTjxUPGa4CR5Vmsn
 H+j23n5tbXFL1x0Y9/ZTvKbu/NAo63TSoz82jgEsYJqCtvx0IqYu+sKwXOYMa1rnyNoa
 9kRTvo5+YruIIBUBstVfT2zTABrepwU0S6tvezsulN5xcbt9nh03a0K6RVuPkajbd9SQ
 cbetiblODQoYr/SvZJpBufrbQDinZV0j2qTpAnTC2zKhwjquLkj9Z3IakLOOmX4mLNJG
 kQlwm73jnnJyfKQVmjPEBUtP4xZ9Uv+dvRXVPbsLPjAqM8c796qjiShVyUaNqthZlq6/
 iZcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ocU50U6KViLf6NA3LALKonlbE+WolkLGpq/0KShUpkw=;
 b=o0WNnbNn1JFSdHskjkUI0131St9Qekl+yQFxN593B7uUMAb5dPAnhZHjKe2K0Sm7bH
 NkZven1bKs8bF9migfCtaVhUTiWJIN1LJNzicFECidlswGOmk0itWvV3oGeODx4tBgUT
 te3A7SNwg+HZAAM48JgtDUoX8EiOXQmI/ta/diZPWsqRCq0Sm16P6byNfIAzA6qcpp8X
 PkvOE+ArFufQysOZ6cHUzvzzG303fcv6SjOYya/pOERkaTmjApyx/pWzVhjIOjbb+lpL
 /I9FhIemJ26zR/FgX5x8/mRg3aJWyJsSu3CZDdieU+4odQLgNoD3yVUf9BBJMHGsKXP8
 mSIw==
X-Gm-Message-State: APjAAAUhp4ebi4WCFCH183eVSABrKyZRKPVl4u12rIqMPT1JI3YCzyc3
 Pij4nIqIN6zpVyPTpBvqJ03Brm6dND3aBWxPb8pDVw==
X-Google-Smtp-Source: APXvYqzXZCmnGGt5AaBaihNjxATjSbnp0emgt/5PjTTAIADHNouR2aJ82AUCbkH1H6dY/FZ8OtLhrfHC50QfdIZ3f60=
X-Received: by 2002:a9d:7f12:: with SMTP id j18mr9234233otq.221.1573238532664; 
 Fri, 08 Nov 2019 10:42:12 -0800 (PST)
MIME-Version: 1.0
References: <20191023020126.24991-1-eblake@redhat.com>
 <20191023020126.24991-2-eblake@redhat.com>
In-Reply-To: <20191023020126.24991-2-eblake@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 8 Nov 2019 18:42:01 +0000
Message-ID: <CAFEAcA_YYfyg4P6OXUo=w7ibM4pp-zbWT5ne+Eda3e7KfYFq+Q@mail.gmail.com>
Subject: Re: [PULL 1/3] qemu-coroutine-sleep: introduce qemu_co_sleep_wake
To: Eric Blake <eblake@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Stefan Hajnoczi <stefanha@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 23 Oct 2019 at 03:04, Eric Blake <eblake@redhat.com> wrote:
>
> From: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
>
> Introduce a function to gracefully wake a coroutine sleeping in
> qemu_co_sleep_ns().
>
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> Reviewed-by: Kevin Wolf <kwolf@redhat.com>
> Reviewed-by: Eric Blake <eblake@redhat.com>
> Message-Id: <20191009084158.15614-2-vsementsov@virtuozzo.com>
> Signed-off-by: Eric Blake <eblake@redhat.com>

Hi; Coverity reports an issue in this patch (CID 1406474):


> ---
>  include/qemu/coroutine.h    | 23 +++++++++++++++--
>  util/qemu-coroutine-sleep.c | 51 +++++++++++++++++++++++++++----------
>  2 files changed, 59 insertions(+), 15 deletions(-)
>
> diff --git a/include/qemu/coroutine.h b/include/qemu/coroutine.h
> index 9801e7f5a497..8d55663062ad 100644
> --- a/include/qemu/coroutine.h
> +++ b/include/qemu/coroutine.h
> @@ -273,10 +273,29 @@ void qemu_co_rwlock_wrlock(CoRwlock *lock);
>   */
>  void qemu_co_rwlock_unlock(CoRwlock *lock);
>
> +typedef struct QemuCoSleepState QemuCoSleepState;
> +
>  /**
> - * Yield the coroutine for a given duration
> + * Yield the coroutine for a given duration. During this yield, @sleep_state
> + * (if not NULL) is set to an opaque pointer, which may be used for
> + * qemu_co_sleep_wake(). Be careful, the pointer is set back to zero when the
> + * timer fires. Don't save the obtained value to other variables and don't call
> + * qemu_co_sleep_wake from another aio context.
>   */
> -void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns);
> +void coroutine_fn qemu_co_sleep_ns_wakeable(QEMUClockType type, int64_t ns,
> +                                            QemuCoSleepState **sleep_state);
> +static inline void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
> +{
> +    qemu_co_sleep_ns_wakeable(type, ns, NULL);
> +}
> +
> +/**
> + * Wake a coroutine if it is sleeping in qemu_co_sleep_ns. The timer will be
> + * deleted. @sleep_state must be the variable whose address was given to
> + * qemu_co_sleep_ns() and should be checked to be non-NULL before calling
> + * qemu_co_sleep_wake().
> + */
> +void qemu_co_sleep_wake(QemuCoSleepState *sleep_state);
>
>  /**
>   * Yield until a file descriptor becomes readable
> diff --git a/util/qemu-coroutine-sleep.c b/util/qemu-coroutine-sleep.c
> index 4bfdd30cbf13..ae91b92b6e78 100644
> --- a/util/qemu-coroutine-sleep.c
> +++ b/util/qemu-coroutine-sleep.c
> @@ -17,31 +17,56 @@
>  #include "qemu/timer.h"
>  #include "block/aio.h"
>
> -static void co_sleep_cb(void *opaque)
> +static const char *qemu_co_sleep_ns__scheduled = "qemu_co_sleep_ns";
> +
> +struct QemuCoSleepState {
> +    Coroutine *co;
> +    QEMUTimer *ts;
> +    QemuCoSleepState **user_state_pointer;
> +};
> +
> +void qemu_co_sleep_wake(QemuCoSleepState *sleep_state)
>  {
> -    Coroutine *co = opaque;
> -
>      /* Write of schedule protected by barrier write in aio_co_schedule */
> -    atomic_set(&co->scheduled, NULL);
> -    aio_co_wake(co);
> +    const char *scheduled = atomic_cmpxchg(&sleep_state->co->scheduled,
> +                                           qemu_co_sleep_ns__scheduled, NULL);
> +
> +    assert(scheduled == qemu_co_sleep_ns__scheduled);
> +    if (sleep_state->user_state_pointer) {
> +        *sleep_state->user_state_pointer = NULL;
> +    }
> +    timer_del(sleep_state->ts);
> +    aio_co_wake(sleep_state->co);
> +}
> +
> +static void co_sleep_cb(void *opaque)
> +{
> +    qemu_co_sleep_wake(opaque);
>  }
>
> -void coroutine_fn qemu_co_sleep_ns(QEMUClockType type, int64_t ns)
> +void coroutine_fn qemu_co_sleep_ns_wakeable(QEMUClockType type, int64_t ns,
> +                                            QemuCoSleepState **sleep_state)
>  {
>      AioContext *ctx = qemu_get_current_aio_context();
> -    QEMUTimer *ts;
> -    Coroutine *co = qemu_coroutine_self();
> +    QemuCoSleepState state = {
> +        .co = qemu_coroutine_self(),
> +        .ts = aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, &state),
> +        .user_state_pointer = sleep_state,
> +    };

Here 'state' is a variable on the stack...

> -    const char *scheduled = atomic_cmpxchg(&co->scheduled, NULL, __func__);
> +    const char *scheduled = atomic_cmpxchg(&state.co->scheduled, NULL,
> +                                           qemu_co_sleep_ns__scheduled);
>      if (scheduled) {
>          fprintf(stderr,
>                  "%s: Co-routine was already scheduled in '%s'\n",
>                  __func__, scheduled);
>          abort();
>      }
> -    ts = aio_timer_new(ctx, type, SCALE_NS, co_sleep_cb, co);
> -    timer_mod(ts, qemu_clock_get_ns(type) + ns);
> +
> +    if (sleep_state) {
> +        *sleep_state = &state;

...here we save a pointer to it into *sleep_state which was
passed to us by the caller...

> +    }
> +    timer_mod(state.ts, qemu_clock_get_ns(type) + ns);
>      qemu_coroutine_yield();
> -    timer_del(ts);
> -    timer_free(ts);
> +    timer_free(state.ts);

...and here we return from this function, which means 'state'
is no longer in valid memory, but the caller has still been
given a pointer to it.

>  }

Is this just Coverity getting confused by our coroutine code?
(I certainly find it confusing...)

thanks
-- PMM

