Return-Path: <SRS0=PUPy=YH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAB1FECE587
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:27:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75EA62064A
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Oct 2019 10:27:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="O22+yngN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75EA62064A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46622 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iJxZZ-0001M4-MM
	for qemu-devel@archiver.kernel.org; Mon, 14 Oct 2019 06:27:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41154)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iJxYm-0000uD-TY
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:26:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iJxYl-0001GT-MV
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:26:40 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:42109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iJxYl-0001D6-Du
 for qemu-devel@nongnu.org; Mon, 14 Oct 2019 06:26:39 -0400
Received: by mail-ot1-x329.google.com with SMTP id c10so13347272otd.9
 for <qemu-devel@nongnu.org>; Mon, 14 Oct 2019 03:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=6Lv0KZF4Ncl6oML/WG02Vf5tmSo2RCWHPze4mYa8L7Q=;
 b=O22+yngNROBqjrrboRD0yAIJjMz4QzRzhqC0KF0RgTqwteO4trlbp3ncnQ6CBpprfH
 XZxu2kqN3Pjh5XoMcgzIPFjD1YlWFhiazhGi55wGSp/vPyH4YBeFSM8gKxXtV8AxFH+j
 7AunXUHmBfH5exAu4uZWlzlPRwTxGEhEWwElKl/u3fCqHSQxC/uU0gngKOGnUh+cyEPP
 cXzNA9HMqJ3s6TWAK2WK3jwQW8Og4wnSllhThRHoA+c1lw/GToqbOvalnf/IM+eTApqj
 ZQEWH/8auSggT0YDiH7CK2Fwh6zRaR/NyuVOhk2XqkhNvJoW1da8ilGT/wJXIsAUiZcR
 ZPCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=6Lv0KZF4Ncl6oML/WG02Vf5tmSo2RCWHPze4mYa8L7Q=;
 b=t0St2xT5nZyECXJ1aa26+kHBVaWX1tZJnu697YYYLBzdvOvy3EzhH+B6AoIhdKii/9
 n/2stzjPDLrjkkGCmdio5JeDDOWbuRVxO89VdS/K6A+2vp6w2JTGOLziIc6DTYCpxkjY
 O4GmVe4BsNBeOngL2AYlXWzkPwgsO1InlOWBbvaYWtMo09QTGocoGt9Ap98L/X4Xlh7o
 Qlu0UYWiwpPuO6YXuk5OnNxkUT6jhX5+s0YOzQntUvvLFAKO3R/ym43LW8gsaEIZLk0z
 AKo2V+D/iXFN5a7CSXygeAwyauL1NCwE4xx9JE1bDBXT8Mgqmf9Ugj6JDZF/wkobWNTf
 81hw==
X-Gm-Message-State: APjAAAVhuFt01CHw/8bUl3gR8Q8DG8WRftL+bzDobbZ2w9EvyiwmRVlx
 NJdjgjxU0E6/wQM5L8Is4fQwG0wHlhByTnl/ejFKRUoQ9ew=
X-Google-Smtp-Source: APXvYqwi0aoWGauA9xbeenomgna2fUbQv2WJtxWgflF68l5KZ7fg7B1Vk9Q3csfXgYN8uioXqrBcjej45RT7tWxYwmE=
X-Received: by 2002:a9d:708e:: with SMTP id l14mr24024576otj.135.1571048797728; 
 Mon, 14 Oct 2019 03:26:37 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA88YR0mU2N=-immpWVFCnnU6fJsorZYHSyerfMO72iZaA@mail.gmail.com>
 <CAFEAcA9vHZc=s+2f7-a88DsLPph=PE2noz+ai+q5tM+KGabkSg@mail.gmail.com>
In-Reply-To: <CAFEAcA9vHZc=s+2f7-a88DsLPph=PE2noz+ai+q5tM+KGabkSg@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 14 Oct 2019 11:26:26 +0100
Message-ID: <CAFEAcA_cAaJ7Q=FNf8dZJuGAjjuCANW2QkMFFjfSLaSAFBN6Vw@mail.gmail.com>
Subject: Re: test-aio-multithread assertion
To: QEMU Developers <qemu-devel@nongnu.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
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

On Thu, 5 Sep 2019 at 14:17, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Wed, 4 Sep 2019 at 12:50, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > Hi; I've been seeing intermittently on the BSDs this assertion
> > running test-aio-multithread as part of 'make check':
> >
> > MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> > tests/test-aio-multithread -m=quick -k --tap < /dev/null |
> > ./scripts/tap-drive
> > r.pl --test-name="test-aio-multithread"
> > PASS 1 test-aio-multithread /aio/multi/lifecycle
> > PASS 2 test-aio-multithread /aio/multi/schedule
> > ERROR - too few tests run (expected 5, got 2)
> > Assertion failed: (!qemu_lockcnt_count(&ctx->list_lock)), function
> > aio_ctx_finalize, file /home/qemu/qemu-test.kaRA0o/src/util/async.c,
> > line 283.
> > Abort trap (core dumped)
> > gmake: *** [/home/qemu/qemu-test.kaRA0o/src/tests/Makefile.include:905:
> > check-unit] Error 1
> >
> > Anybody got any ideas?
>
> Here's a different intermittent assertion on Netbsd from test-aio-multithread:
>
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-aio-multithread -m=quick
> -k --tap < /dev/null | ./scripts/tap-driver.pl
> --test-name="test-aio-multithread"
> PASS 1 test-aio-multithread /aio/multi/lifecycle
> PASS 2 test-aio-multithread /aio/multi/schedule
> assertion "QSLIST_EMPTY(&ctx->scheduled_coroutines)" failed: file
> "util/async.c", line 279, function "
> aio_ctx_finalize"
> ERROR - too few tests run (expected 5, got 2)

Just saw this QSLIST_EMPTY(&ctx->scheduled_coroutines) assertion
from FreeBSD as well, so it's still around as a definite
intermittent.

thanks
-- PMM

