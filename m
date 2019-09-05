Return-Path: <SRS0=/Jg5=XA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B60DC3A5A5
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 13:19:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0FEE0206BB
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Sep 2019 13:19:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="s21ZRlRq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0FEE0206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45960 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i5rfM-0006ZM-6X
	for qemu-devel@archiver.kernel.org; Thu, 05 Sep 2019 09:19:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45179)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i5re6-0005mD-QB
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 09:17:55 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i5re5-0002oo-Ih
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 09:17:54 -0400
Received: from mail-ot1-x331.google.com ([2607:f8b0:4864:20::331]:42266)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i5re5-0002oN-Cj
 for qemu-devel@nongnu.org; Thu, 05 Sep 2019 09:17:53 -0400
Received: by mail-ot1-x331.google.com with SMTP id c10so2101286otd.9
 for <qemu-devel@nongnu.org>; Thu, 05 Sep 2019 06:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
 bh=kkPAVFPH9w2NGxoeNi9HMM1m8MOep6sH/qhA8PIe174=;
 b=s21ZRlRquEFs7rsR8J6/kcHHFZ1Grj5MyIsfDG8cL81ovhwmt9Lq6RXmZXrtWG9oyU
 PW4E8f6DdlOpt8VCz4yEYevKndZsYq61la7983ScflNcjwyGUKBOxv+4jPMweKeGtZ7y
 jCbX7EI2F1+rNEx6Pi+4QrYXCmrWeK79GEGgbibDlknh5BdaYdypTHo0UeO9r9UYhoaO
 gHtXU3YDpaP85ttwvtAI4aL0NP/2moMbhgHv+CK//j6eREYkeTNcaoROPBjJJmrrI3M1
 IPT7aNsmDYgmLIVAJAj5tFtdP/veOXgkilDTqtAoZdvghTr0fu+y+/P07LbU7anoebPe
 mJgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to;
 bh=kkPAVFPH9w2NGxoeNi9HMM1m8MOep6sH/qhA8PIe174=;
 b=uJVbQqDRVnms+4vB+xrNQDOmDKPZYSBj5OzGAy/lEv0l1+VsXxiVNt70F9y1zcFpgP
 e+/ry1oAxLGNSoQge2IYOHeytM/GcjXP1PVdZr7lCZsLDgbUbcv1zQjG1XS7TCJE7qwD
 zdTBcJPtU6GYI1sQ4CyF2KA72R9K5vMoPHlO5548WmqqGP/FQfR8dtrWFDzV3UnHbPjx
 NBxyF2P++QVXE6MOPNSbUMYFwVCsMX/ob3T/J+RMv5q6TEjn9BUtCRdsRs2OBMc4Y7Yd
 PRFjhjKlLwAHpsEYHt5HpoSbX4LMn73YpawTVIGITyfH5pDKN5sDV8+kWdNs/AnJM5c3
 WyFQ==
X-Gm-Message-State: APjAAAUrWxVDtqnOuZCVNAW2KnRApquA3F1EAtPyyFSffbYA+NFNNdJl
 FpvKmQuPjfcsWXMR7ai9XsdcHCSkt4CDC73j/lOWCrfTvBs=
X-Google-Smtp-Source: APXvYqxJecPnRHPMmWzjS4uFi/o0RuPjkn5R9G44/VhM1GIxVTSCS1sHtjLTLhwUrntdlmnNYQUBX9iWg4Eeaw1JYts=
X-Received: by 2002:a9d:5e11:: with SMTP id d17mr2568481oti.135.1567689472263; 
 Thu, 05 Sep 2019 06:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <CAFEAcA88YR0mU2N=-immpWVFCnnU6fJsorZYHSyerfMO72iZaA@mail.gmail.com>
In-Reply-To: <CAFEAcA88YR0mU2N=-immpWVFCnnU6fJsorZYHSyerfMO72iZaA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 5 Sep 2019 14:17:40 +0100
Message-ID: <CAFEAcA9vHZc=s+2f7-a88DsLPph=PE2noz+ai+q5tM+KGabkSg@mail.gmail.com>
To: QEMU Developers <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::331
Subject: Re: [Qemu-devel] test-aio-multithread assertion
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

On Wed, 4 Sep 2019 at 12:50, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Hi; I've been seeing intermittently on the BSDs this assertion
> running test-aio-multithread as part of 'make check':
>
> MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
> tests/test-aio-multithread -m=quick -k --tap < /dev/null |
> ./scripts/tap-drive
> r.pl --test-name="test-aio-multithread"
> PASS 1 test-aio-multithread /aio/multi/lifecycle
> PASS 2 test-aio-multithread /aio/multi/schedule
> ERROR - too few tests run (expected 5, got 2)
> Assertion failed: (!qemu_lockcnt_count(&ctx->list_lock)), function
> aio_ctx_finalize, file /home/qemu/qemu-test.kaRA0o/src/util/async.c,
> line 283.
> Abort trap (core dumped)
> gmake: *** [/home/qemu/qemu-test.kaRA0o/src/tests/Makefile.include:905:
> check-unit] Error 1
>
> Anybody got any ideas?

Here's a different intermittent assertion on Netbsd from test-aio-multithread:

MALLOC_PERTURB_=${MALLOC_PERTURB_:-$(( ${RANDOM:-0} % 255 + 1))}
tests/test-aio-multithread -m=quick
-k --tap < /dev/null | ./scripts/tap-driver.pl
--test-name="test-aio-multithread"
PASS 1 test-aio-multithread /aio/multi/lifecycle
PASS 2 test-aio-multithread /aio/multi/schedule
assertion "QSLIST_EMPTY(&ctx->scheduled_coroutines)" failed: file
"util/async.c", line 279, function "
aio_ctx_finalize"
ERROR - too few tests run (expected 5, got 2)

thanks
-- PMM

