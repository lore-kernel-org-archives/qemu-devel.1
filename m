Return-Path: <SRS0=bVMU=B5=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43232C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 21:11:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01B11207DE
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2020 21:11:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Mry/Xvi2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01B11207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59034 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8VNC-0001GH-Pt
	for qemu-devel@archiver.kernel.org; Wed, 19 Aug 2020 17:11:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8VMc-0000qi-9v
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 17:11:18 -0400
Received: from mail-ej1-x642.google.com ([2a00:1450:4864:20::642]:35122)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k8VMZ-00069S-Qe
 for qemu-devel@nongnu.org; Wed, 19 Aug 2020 17:11:17 -0400
Received: by mail-ej1-x642.google.com with SMTP id a26so130519ejc.2
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2020 14:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GBOHJ1hzbmDUjFBA/W3PGvGj68TJPhUSpLkFAtYeczo=;
 b=Mry/Xvi2iHasQwYwzUEIz1OFzQ40oeH0/tXuQp3g8Imo0hjegsLIM5TbqHefzYx3cy
 iGxD2IbnxZqJtRG9ePleKjdXRM9qanDLc4Eun/CZ33oyw//EU8aUgqMTftNL0zOsnF03
 rID2bzhQr0+q6gC7R398UPMx8KzxYj1YapSJOnB5PiCawn9VA0HuzNz7vp0uHDTtldrl
 Dnyb0LAFb8An+UNePBsAfbC4A/MCv7mr7s1q5lwDmvOh9lKakGquMYMzFj5JgIbGeCAM
 76T8ULK3cFjetRBnjxJwo9toTwBgdQK306uBblsoSo/XbqtBVBCFgKIVjLU+Sphq3t/n
 D0ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GBOHJ1hzbmDUjFBA/W3PGvGj68TJPhUSpLkFAtYeczo=;
 b=LuBXY1Pdvp8QwGeB6eap6BJ8eIv6U8BPuq3KhELLsiCEyzgwLUz6SyTMo9OecDjHcD
 CH8cTgz4C799o9OKJXyrHlmT+O/S0tSGZPM73zghQeMPznvEXIcHW3AvHjgDS6nfC8gz
 DEstC6LaI0xFc9fbMDdLRTGeaINBGD33Lo5NTw/5Nc33P/7PgV9WMUNLPZzxurLWw7zT
 yYvRKxi3EffKYy8M5G/mF9SKX9v2kXe4dCDRJhc59ED5g0V7+81rJBnFdmR/aCTfxgG3
 8csbkLPEZmCZ2lcBY4Ce4ceITJrEVEg/x2A2bzOWKe4Mgi3nlWyWfharCrXQtPytDucN
 zu6Q==
X-Gm-Message-State: AOAM5308R+ol/gqIa42AVDI9rw8GT/a+pHtFQFuIayOVuUo2FAZZGdC6
 bVXJoOfPKUlpEvq5op8EVhTaPFALTrz7uwvzibY+lA==
X-Google-Smtp-Source: ABdhPJz/bN6RFzsn5b7unqfcy6Pl9huLIZ24X0YfBjrtMHMGMYDXQFnZR9qSmtT7aw7iPPoTlWktbNQuVPa6sGrJJeg=
X-Received: by 2002:a17:906:2cc2:: with SMTP id
 r2mr212744ejr.482.1597871474279; 
 Wed, 19 Aug 2020 14:11:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200819143525.2175-1-pbonzini@redhat.com>
 <CAFEAcA_8VJecDyK8FR0ty=pknmo+Hc5s0OFj+-Y1Ah-OJ01FDQ@mail.gmail.com>
 <5d247082-4928-b47c-76c4-c366a9421e1a@msgid.tls.msk.ru>
 <CAFEAcA_YU8QY_VRNdXmBV=YKuBFaX=scT0Pnk1F8JBWrrbsbJA@mail.gmail.com>
 <72597e7a-6ee2-9875-536d-c5cd2d81950d@redhat.com>
In-Reply-To: <72597e7a-6ee2-9875-536d-c5cd2d81950d@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 19 Aug 2020 22:11:03 +0100
Message-ID: <CAFEAcA-RF4T43zeNMBb_NWaOqWOVS6H5iiRN4s4ocvnGgN65bw@mail.gmail.com>
Subject: Re: [PULL v6 000/150] Meson-based build system
To: Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::642;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 19 Aug 2020 at 20:44, Paolo Bonzini <pbonzini@redhat.com> wrote:
> On 19/08/20 21:04, Peter Maydell wrote:
> >> is it really that important? We've changed single target build
> >> rules already (from subdir-x86_64-softmmu to x86_64-softmmu/all
> >> for one), which broke quite some mostly automatic build
> >> systems which needed some fixing. Moving executables isn't a
> >> big deal after that, methinks..
> > It breaks my setups and also my muscle memory for where
> > executables live. So this is the limit of how much I'm
> > willing to allow Meson to mess us around, I think.
>
> It's totally possible to accomodate this and I appreciate the help and
> effort you're putting into something that you (understandably) are not
> too confident in.
>
> However, this change was already in the first series that was posted
> like a year ago...

It's a hundred-and-fifty patch series, and I can't review everything.
I took it on trust that it would be basically a drop-in replacement
for our current makefile setup.

thanks
-- PMM

