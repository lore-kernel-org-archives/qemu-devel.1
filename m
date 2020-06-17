Return-Path: <SRS0=bzpH=76=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 625C2C433E0
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 22:04:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30A902082F
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2020 22:04:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zb4bTxHA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30A902082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlgAL-00033o-9I
	for qemu-devel@archiver.kernel.org; Wed, 17 Jun 2020 18:04:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfad-0001q9-2m
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:27:23 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:39012)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <robert.foley@linaro.org>)
 id 1jlfaa-0004GQ-Up
 for qemu-devel@nongnu.org; Wed, 17 Jun 2020 17:27:22 -0400
Received: by mail-lj1-x244.google.com with SMTP id a9so4703440ljn.6
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2020 14:27:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Aa6lyRAUmGeeJFGW7pM3rKQ6CCDTGdCvUZy1FPy0/r0=;
 b=zb4bTxHAMxHbydRD6xRwO4BhYjN/2qDZtmfiH9L20moDL8Z/cQwWNyq94QCpekxxVw
 6WoAzM8KT6Z1z9jGeBw3pd2vXQVDfvrDOIDZlx+3xQ7mUhEpOTiU3HVeLxd/FlWXic63
 JwctfO9kKto3w2KCABvmDCULg+ExPdzpQVkD063orCV6uCYQJ1M770ipedLwRQnVaRzJ
 crqR01S1QrSXjX2xMySPN6M8WwkazxZIwFga6OqkNo+c7ijIciRkviG+3YouhadT2qRe
 xIQawF0et9hIPaxweHLT8BHHCwChMHWHfTdde3+pu7tU/ddl9dCZwwjY7px2e+jdXWpa
 v6vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Aa6lyRAUmGeeJFGW7pM3rKQ6CCDTGdCvUZy1FPy0/r0=;
 b=K0sDoZAE3cxyuSKzL4XQHcDpsQ7+NFnL7YV3XsFZvuKXbQg5MPHw4BV4DdhOhy8oHt
 cJw8qLHSC3s4tIcC81fSg9BGSxugXJh0X5cVAyMCOOooOuWs7nVpP0cOnnvD7maX/58P
 nkRl9c/7xVfF/QX8cAHZMuTxsRA07VllsR0etSaH8XaRrzi1PuhDVVgNs+sPhbSYnuhl
 k+qXca4+JbuG/p47iurDA2riH+wS6iI2tR1OYx13IJSMqhOuwMvB10d6U4uYhAdi/2uY
 XrMFb+Icl6Q4fQ5n5MqZy6UslTOwL9cLIOBovTzOQhwZFU7ElWkHI1Jj6/sKDCOWnUR9
 29lg==
X-Gm-Message-State: AOAM532hdUZtaR/Kk7bKMYnJeX0IuR/C4kcz1bkeCC/cSFZTK4s9OPNs
 X3AEo5pNKHdxvDo4NBdqOQQYtiRgwLzl+lkoZirnLQ==
X-Google-Smtp-Source: ABdhPJx3ghWSprXkYznmn/ww2VfJsBQJ9inoJNOGKhGX6zUExe5BpFkJL17JfzsDRS7Ssv3muEqsEksRssTPwQwwxYo=
X-Received: by 2002:a2e:9cd5:: with SMTP id g21mr651908ljj.9.1592429238979;
 Wed, 17 Jun 2020 14:27:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200522160755.886-1-robert.foley@linaro.org>
 <20200522160755.886-2-robert.foley@linaro.org>
 <20200617142407.GH1728005@stefanha-x1.localdomain>
In-Reply-To: <20200617142407.GH1728005@stefanha-x1.localdomain>
From: Robert Foley <robert.foley@linaro.org>
Date: Wed, 17 Jun 2020 17:27:23 -0400
Message-ID: <CAEyhzFunvqHEGNPthRYvewqTp45Q4frZ-Y3qzsw_XZYk3wPKyQ@mail.gmail.com>
Subject: Re: [PATCH 01/19] configure: add --enable-tsan flag + fiber
 annotations for coroutine-ucontext
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::244;
 envelope-from=robert.foley@linaro.org; helo=mail-lj1-x244.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Peter Puhov <peter.puhov@linaro.org>, "Emilio G. Cota" <cota@braap.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Lingfeng Yang <lfy@google.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi,

On Wed, 17 Jun 2020 at 10:24, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Fri, May 22, 2020 at 12:07:37PM -0400, Robert Foley wrote:
> > +#define UC_DEBUG 0
> > +#if UC_DEBUG && defined(CONFIG_TSAN)
> > +#define UC_TRACE(fmt, ...) fprintf(stderr, "%s:%d:%p " fmt "\n", \
> > +    __func__, __LINE__, __tsan_get_current_fiber(), ##__VA_ARGS__);
> > +#else
> > +#define UC_TRACE(fmt, ...)
> > +#endif
>
> QEMU has tracing support, see docs/devel/tracing.txt. These fprintfs
> should be trace events defined in the util/trace-events file.

Thanks for the details.  We removed this tracing in a later patch.
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg02506.html
>
> > +
> >  /**
> >   * Per-thread coroutine bookkeeping
> >   */
> > @@ -65,7 +80,20 @@ union cc_arg {
> >      int i[2];
> >  };
> >
> > -static void finish_switch_fiber(void *fake_stack_save)
> > +/* QEMU_ALWAYS_INLINE only does so if __OPTIMIZE__, so we cannot use it. */
> > +static inline __attribute__((always_inline))
>
> Please document why always_inline is necessary here and in other
> functions. Is it for performance or because the __tsan_*() functions
> need to be called from a the parent function?

We will look into this and add documentation here or (if it is no
longer needed),
remove the inline.

<snip>
> > -static void start_switch_fiber(void **fake_stack_save,
> > -                               const void *bottom, size_t size)
> > +static inline __attribute__((always_inline)) void start_switch_fiber(
> > +    CoroutineAction action, void **fake_stack_save,
> > +    const void *bottom, size_t size, void *new_fiber)
> >  {
> >  #ifdef CONFIG_ASAN
> > -    __sanitizer_start_switch_fiber(fake_stack_save, bottom, size);
> > +    if (action == COROUTINE_TERMINATE) {
> > +        __sanitizer_start_switch_fiber(
> > +            action == COROUTINE_TERMINATE ? NULL : fake_stack_save,
>
> The if statement already checks action == COROUTINE_TERMINATE, why is it
> being checked again?
>
> I think the old behavior can be retained by dropping the if statement
> like this:
>
>   __sanitizer_start_switch_fiber(action == COROUTINE_TERMINATE ?
>                                  NULL : fake_stack_save,
>                                  bottom, size);
>
> > +            bottom, size);

Good point.  We did change this by dropping the if in a later patch.
https://lists.gnu.org/archive/html/qemu-devel/2020-06/msg02506.html


> > +    }
> > +#endif
> > +#ifdef CONFIG_TSAN
> > +    void *curr_fiber =
> > +        __tsan_get_current_fiber();
> > +    __tsan_acquire(curr_fiber);
> > +
> > +    UC_TRACE("Current fiber: %p.", curr_fiber);
> > +    *fake_stack_save = curr_fiber;
> > +    UC_TRACE("Switch to fiber %p", new_fiber);
> > +    __tsan_switch_to_fiber(new_fiber, 0);  /* 0=synchronize */
> >  #endif
> >  }
>
> Please split start_switch_fiber() into two functions:
> start_switch_fiber_asan() and start_switch_fiber_tsan(). That way the
> asan- and tsan-specific arguments can be kept separate and the
> co->tsan_* fields only need to be compiled in when CONFIG_TSAN is
> defined.
>
> For example:
>
>   static inline __attribute__((always_inline))
>   void start_switch_fiber_tsan(void **fake_stack_save,
>                                CoroutineUContext *co,
>                              bool caller)
>   {
>   #ifdef CONFIG_TSAN
>       void *new_fiber = caller ?
>                         co->tsan_caller_fiber :
>                         co->tsan_co_fiber;
>       void *curr_fiber = __tsan_get_current_fiber();
>       __tsan_acquire(curr_fiber);
>
>       UC_TRACE("Current fiber: %p.", curr_fiber);
>       *fake_stack_save = curr_fiber;
>       UC_TRACE("Switch to fiber %p", new_fiber);
>       __tsan_switch_to_fiber(new_fiber, 0);  /* 0=synchronize */
>   #endif
>   }
>
> This does two things:
> 1. Unrelated ASAN and TSAN code is separate and each function only
>    has arguments that are actually needed.
> 2. The co->tsan_caller_fiber and co->tsan_co_fiber fields are only
>    access from within #ifdef CONFIG_TSAN.

Makes sense, we will make these changes and submit a cleanup patch.

Thanks & Regards,
-Rob

