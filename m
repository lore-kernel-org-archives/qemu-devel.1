Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1921C282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:48:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3A320868
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 13:48:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MHCeACP+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3A320868
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36691 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTo4i-0004j0-M7
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 09:48:04 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37452)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTno4-0001Do-5O
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:30:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1hTno3-0002DI-Ce
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:30:52 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:40713)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1hTno3-0002CS-6k
	for qemu-devel@nongnu.org; Thu, 23 May 2019 09:30:51 -0400
Received: by mail-ot1-x344.google.com with SMTP id u11so5395286otq.7
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 06:30:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=R9zX5EHeDdKap0pvoAfYKP3tPzU8Pqu0/MLm1hSEHiw=;
	b=MHCeACP+QvRq0Yld21LhYoctUVrxKP1l8fmOAWrk8ZG+5uKO/IqQ01uKuSHeMNlPvG
	TzKUsDi0sB9v8r54w+Duc3XRpUNWeqYlH79Ie7ELUaGHjRjlmLnHZ4nM2STYdxAP560D
	3WJY5UNsgtmN9fgQzHsNnFTNGgpBlPjomfGzHBl5FyQ2Gmf/dQuh7QkS+QokHR2ChCon
	kV7LN5A8RCGj6C8Tat7V7W+U6pt0/uZ9kZxXiSctHMrbmqrj88gKGOZTZX6/Qp4IVNlf
	i2hpYBCebgDWz62nRHF3iO4l49cspzZoM/kSsb0bmp23Kw04D9NZ0NdmT6JUkLHQ93Gg
	32Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=R9zX5EHeDdKap0pvoAfYKP3tPzU8Pqu0/MLm1hSEHiw=;
	b=AZr//jDzFW+ZHLi4GT1ILuVVKJnF5f7bwHtOiBEz+TE+Mix05Qi7x7gNE0L1RjO2CI
	nDng8oH6wM5UaLSiYq57Ts4AuLDXEpHsHZfpWeB0y/tgeQVToCFvF+6XSEDgzO8SkqEy
	/HCSRBHFg4mirPCORB2qXGsBpw4muj9IjksrpAEIxO/jL4MkX1j3MehEX00d9JDazqRw
	hi6cNi+8+fdIzicoAlgI50KU7RBBLs5qBmGGyDg1FKiAGDbyGhbpZO+Jtn5pNG1Vs3kN
	rFTgNrvXvTzHD9JeW3hp+15Ovbsq82tJhiPjbLTLIm3U7sILjNr9Uh5YontbyeE33lbP
	kBQQ==
X-Gm-Message-State: APjAAAWq3mCbGgvflttev6KseqZEjZ+Z3g3dINxF17DKXskVcvQRBPM1
	gtjF2l2BTCgjyqKFWgskL6f6DjxcDMjIH73Od7CpWg==
X-Google-Smtp-Source: APXvYqxzVHGCvpYAb+gaMhX+jhMAmhhaxuLv0x01RauMvmBREoMXdMDw7vL0jbJpjZsd/v8Cdw2Q00RIkp/MArXipag=
X-Received: by 2002:a9d:6b0d:: with SMTP id g13mr21226630otp.91.1558618250247; 
	Thu, 23 May 2019 06:30:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190518191934.21887-1-richard.henderson@linaro.org>
	<20190518191934.21887-3-richard.henderson@linaro.org>
	<CAFEAcA88nA_2u1Yc-9ZPAy2w6LVk5f9Rrss0e53E11W4Xb4YpA@mail.gmail.com>
	<e177b43a-2abc-3aee-461c-2cfd9a8a0a20@linaro.org>
	<CAFEAcA_1XuWqVu9gonn5_Y9x1V=UcWNHEXtwop2s0qyUbwiZpg@mail.gmail.com>
	<13d9e22b-4ac5-fb87-622c-a99b5494d06c@linaro.org>
In-Reply-To: <13d9e22b-4ac5-fb87-622c-a99b5494d06c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 23 May 2019 14:30:39 +0100
Message-ID: <CAFEAcA--wutvPH5xSRm7yNCQ9+TpjJ84qbSLTUa7YFgKnLmi=Q@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PATCH 2/2] target/arm: Use tcg_gen_gvec_bitsel
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 23 May 2019 at 14:16, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 5/23/19 9:08 AM, Peter Maydell wrote:
> >> Because the three different instructions perform the same operation with
> >> reshuffled register arguments.
> >
> > Ah, so they do. Next question, how do I find out what the
> > order of arguments in the above code means so I can compare
> > it against the pseudocode expression we're implementing?
>
> >From tcg/README:
>
> * bitsel_vec v0, v1, v2, v3
>
>   Bitwise select, v0 = (v2 & v1) | (v3 & ~v1), across the entire vector.
>
> The "selector" is second, the first input operand.

Oh, this series is based on another patchset.

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

