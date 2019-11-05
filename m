Return-Path: <SRS0=HxLX=Y5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C92FAC5DF60
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:36:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 813B921882
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2019 21:36:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U3qpgrDv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 813B921882
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50436 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iS6VF-0005Rh-9f
	for qemu-devel@archiver.kernel.org; Tue, 05 Nov 2019 16:36:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59760)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iS5rW-0003ym-V4
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:55:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iS5rT-00044m-B9
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:55:36 -0500
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e]:43520)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iS5rT-00043t-5h
 for qemu-devel@nongnu.org; Tue, 05 Nov 2019 15:55:35 -0500
Received: by mail-oi1-x22e.google.com with SMTP id l20so6800721oie.10
 for <qemu-devel@nongnu.org>; Tue, 05 Nov 2019 12:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=5XvPHb0liGDSyzqWfyodYaHwqMy3DUUzWQ17uAiVI3I=;
 b=U3qpgrDvNWy873Do62C7Q+R8ejze+6Ip06g/TJ9RrK0CXyVhDdiPwmIXdTX6vDUQcg
 nShxYKSOJVM+1TC+MNdQYe2IPlZxwY3xhL2PT+KES145KgN7wZv22DBdEMkP54viHCGI
 bBNTA8uE2OHJvljzkO36A8qaByrMqw4hoCaJfznffqdVWMtxJ3YJDH+5+evH5ggDfazi
 C/zlDGXNTjYgoz//fEHKv/lJepMu64neRKw2fci+UAF9Jl1xHSlBBnsZkveI0xYSft/4
 1lcaBsE1DQg1LDnCFXhXsNNRzwdlqi5SYwL4qw20R04dXrapWEc8RSBktxnpCIyxG8Dm
 5EKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=5XvPHb0liGDSyzqWfyodYaHwqMy3DUUzWQ17uAiVI3I=;
 b=qbs64iBVlSr9xo4g9wigASVCGreNxCj0O9gh14+NMSpmDJ6TFkhtcHSsI+kJJXgrBa
 hQ1yhaHibr1uFblE2FQQE9mVs11h0MF6BGYAyUjFi1LiNQPuTTUz8R4iS+H+bi5+W8wO
 m0l7MA2oH5XlTN6wPHtfe1bZpChdjE9V5zCrgRVLljtnO41Blcg5yj91lnwHb7VYZUzP
 asVrZbfuWDCpvjOTlLw/xfrVueRO+x/qp+kE9Q7y2vPyJQ/SODpnVltp8F/6/h7H8nDq
 7oqIvdUgS79gAx+Vu9nJ5KbVxjvg3nAfMywAMum/lOdEAmP2UXVJJxNFvrVAyB3CiuJO
 CZiQ==
X-Gm-Message-State: APjAAAV/OTW6eTQ4GVgWnbIdhav+a4WRpNR5gMaJLBmT8mmmngEHeyC3
 8nTY8lKRdIfQkhcCxgTGZl80fBub91RGmt1PJQcDAg==
X-Google-Smtp-Source: APXvYqwxE6BXvUoNdnKW8wviK6OLmSqbfck8rAFPw0Ngp6PDCdFX3lYAjcZ2EqaKaCMW0xMqrYmxMPXlhj1SYDUctYs=
X-Received: by 2002:aca:451:: with SMTP id 78mr889263oie.170.1572987334000;
 Tue, 05 Nov 2019 12:55:34 -0800 (PST)
MIME-Version: 1.0
References: <1572911399018.17766@sandia.gov>
 <20191105164253.GJ166646@stefanha-x1.localdomain>
In-Reply-To: <20191105164253.GJ166646@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 5 Nov 2019 20:55:21 +0000
Message-ID: <CAFEAcA_5ZS=4gHW8yph_o7Z4XrO5r2YMbGTB0oNtQKriv-qS=A@mail.gmail.com>
Subject: Re: Adding New, Unsupported ISA to Qemu
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::22e
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
Cc: "Hanson, Seth" <shanson@sandia.gov>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 5 Nov 2019 at 16:44, Stefan Hajnoczi <stefanha@gmail.com> wrote
> The general advice I've seen is:
>
> 1. Look at existing TCG targets to learn how to implement aspects of
>    your ISA.

...and *don't* look at older/less maintained targets (including
x86), as they have a lot of bad habits you don't want to copy.
Using 'decodetree' is probably a good idea.

> 2. If you are unfamiliar with emulation, CPU ISA, or just-in-time
>    compiler concepts, try to read up on them and then look back at the
>    QEMU code.  Things will be clearer.

I would also add
3.  Don't expect getting this implemented and upstream to be easy.

(Apologies if the following sounds pessimistic and off-putting;
but I would prefer people to have a clear understanding of
what they're getting into and not assume the chances of
success are higher than they might actually be.)

"New TCG target" is an unlucky combination of:
 (1) it's quite a lot of work in pure amount-of-code terms
 (2) because it is a big feature it is not a good choice as a "first
   contribution to the project", but new targets often are proposed
   and written by people who don't have any previous history of
   writing QEMU code
 (3) we already have targets for the common CPU ISAs, so
   anything new is likely to be obscure and not have many people
   who care about it either in our userbase or in our dev community.
   (riscv is the obvious recent exception here, as it is clearly relevant
   as a new architecture and has attracted multiple people to work
   on it and contribute both code and reviews)

1 and 2 mean that code review of a new TCG target is a lot
of work, and 3 means it's not clear how much return the project
gets for that investment :-(

There is not a large community of upstream developers who are
interested in maintaining a lot of obscure guest architectures:
we essentially rely on the goodwill and not-entirely-work-time
of just a few people when it comes to reviewing new TCG targets.
That means that patchsets often hang around on list for a long
time without getting attention.

Our past historical experience has often been that when people
contribute TCG targets, we do a lot of work on our end with
code review and helping to get the code into upstream QEMU, and
then these people more or less disappear, leaving us with the
burden of something we have to support and no help doing it.
If in general people submitting new TCG targets were all
*helping each other*, passing on what they learned to the
next person along, contributing code review, updating older
code as QEMU APIs improve/churn, etc, then I think I'd feel
differently about this. But to be honest mostly I find myself
thinking "oh dear, not another one".

We already have two new TCG ports with patches on list
which are kind of stalled due to not having enough existing
upstream QEMU devs who can/will code review them (and
another which hasn't had patches posted but might do soon).
The odds for your new port having a happier future don't seem
too great to me :-(

thanks
-- PMM

