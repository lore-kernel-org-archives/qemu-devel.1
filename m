Return-Path: <SRS0=H6GY=TQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA446C04E84
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:13:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B6A5F20818
	for <qemu-devel@archiver.kernel.org>; Thu, 16 May 2019 13:13:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uKgJHhpD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B6A5F20818
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:55860 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRGCQ-0003fJ-UR
	for qemu-devel@archiver.kernel.org; Thu, 16 May 2019 09:13:30 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56450)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRFqH-0001dw-4O
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:50:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hRFqD-0001mn-FZ
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:50:37 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38438)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hRFqB-0001hC-10
	for qemu-devel@nongnu.org; Thu, 16 May 2019 08:50:31 -0400
Received: by mail-oi1-x241.google.com with SMTP id u199so2394884oie.5
	for <qemu-devel@nongnu.org>; Thu, 16 May 2019 05:50:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc:content-transfer-encoding;
	bh=RAGm2eojEsJmTRqIVa/btgSfZPQBtSL47sejD+InDmU=;
	b=uKgJHhpDNOQae6YiA0y5UeVg9d17tYYiucJvczEA4HFudEAGGFFZTbv6MTApe1Lsm5
	Nq5y5Lvptr493bmKFX5O9Y/qXdfu+rQepN6MhHLvYTEgA68awZG7ZF/MBqIUvEZ1yzju
	GVENDxXpeBvUzlPCSTX4okCCPCk8VtL0LH9pUm/B6v4QJgDZfp7M759F69/yIJRKONsM
	HM7hwBMVikNH0cftUVgu/p0E/VJ38tY8Ts0M1gtn0shoeuWQ3OSAR7Osx3DbruV8un75
	zBe8I1jHya4T/hJ1FqotCzYc9U4fUMFecJoyJ8V/coxVfaWXtVlBEEK82Y4Y0sAfjGi9
	lUzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc:content-transfer-encoding;
	bh=RAGm2eojEsJmTRqIVa/btgSfZPQBtSL47sejD+InDmU=;
	b=nQWJXQjPgBMBPc37VGxWiRdtnv2blQsV3q/0dMjZRvOuIdxsZLK7S6s8Ze0ZDihp8r
	Z05/UicE9YhQr+Btw6H8VLDf+xUULg74OIJ6mxQFUD/vPVsFlhMihu/112XmfAHeAD2z
	HE1X/Kzf6ZRYiiKj0syD1j1CD/MyxlU8kWC6WM7P6KsLP2f+viFQuWlA/Sv0ZyCp91t4
	3u4+O5kM51YbcjmeWz9uak2lO2lhjspkZ8qvinTsK+Qp+kc/SI1eRt8RNmEPTwVHXxA1
	f6QMnXpL9XlFhWMc+TQyHfWsWBAubcslsvEot8zJsyEZLCz9QCQp4LlPyzRVrVP3aRpC
	/QOw==
X-Gm-Message-State: APjAAAXskRzG1Zw2cd6hQ+5r/K3YqmOuw+1Lfw9YOuLH50qXCD4fEjXG
	pf2jwhVw0ftHuGvS5q4FB/XHwSAVVzu1d1Xk/Lz3aw==
X-Google-Smtp-Source: APXvYqyK67LNNQLzjDxIuUVYzFutOS2qV9YXCdpD7k1w0Exn27AdrIQnl+KWxO5GNU0U6U+YdgYR2Zi31/SlSwYATpc=
X-Received: by 2002:aca:5785:: with SMTP id l127mr9418993oib.48.1558011027532; 
	Thu, 16 May 2019 05:50:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190504120528.6389-1-pbonzini@redhat.com>
	<877eb4c3jm.fsf@zen.linaroharston>
	<CAFEAcA_+baJCxf1vQMJJP2cwzZ3snyHNJTWWgUqo26vUPKfszQ@mail.gmail.com>
	<20190515094830.GB29507@stefanha-x1.localdomain>
In-Reply-To: <20190515094830.GB29507@stefanha-x1.localdomain>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 16 May 2019 13:50:15 +0100
Message-ID: <CAFEAcA-XC3UjNxRZ5OU5i16Nc515rYoaxEhMVc+8nD1M+VZVVg@mail.gmail.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::241
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/9] Assembly coroutine
 backend and x86 CET support
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Cornelia Huck <cohuck@redhat.com>,
	=?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
	QEMU Developers <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 15 May 2019 at 10:48, Stefan Hajnoczi <stefanha@gmail.com> wrote:
>
> On Thu, May 09, 2019 at 02:44:39PM +0100, Peter Maydell wrote:
> > On Sun, 5 May 2019 at 16:41, Alex Benn=C3=A9e <alex.bennee@linaro.org> =
wrote:
> > >
> > >
> > > Paolo Bonzini <pbonzini@redhat.com> writes:
> > >
> > > > *** BLURB HERE ***
> > >
> > > I assume there was going to be a bit more background here?
> >
> > Mmm, could we have the rationale, please ?
>
> Paolo can add more if necessary, but my understanding is:
>
> 1. It's required for Intel Control-flow Enforcement Technology (CET).
>    The existing ucontext backend doesn't work with CET.
> 2. It's faster than the existing ucontext implementation.

Mmm, I think we've talked about 1 before, but I think it would
be useful to clearly state why we need to do things here.
It's also useful for identifying whether we need an asm
backend for every host, or only some hosts (and if so which).

I'm unconvinced by 2 as a rationale for adding more host asm.
Coroutines were already bad enough when they were at least
vaguely portable C code.

thanks
-- PMM

