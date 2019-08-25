Return-Path: <SRS0=aJdJ=WV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09E04C3A5A1
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 20:44:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C179B2080C
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Aug 2019 20:44:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="db3F+n5+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C179B2080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47850 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i1zNN-0000z8-5v
	for qemu-devel@archiver.kernel.org; Sun, 25 Aug 2019 16:44:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50900)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1i1zMM-0000Mx-E7
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 16:43:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1i1zML-000605-5G
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 16:43:34 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:41643)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1i1zMK-0005yp-Nu
 for qemu-devel@nongnu.org; Sun, 25 Aug 2019 16:43:32 -0400
Received: by mail-ot1-x342.google.com with SMTP id o101so13342597ota.8
 for <qemu-devel@nongnu.org>; Sun, 25 Aug 2019 13:43:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=otFYkDYO1CCJWJ6//sofYnaWi+8sSZ9tkLiYX6S8Pgo=;
 b=db3F+n5+3xokQPra7+ckyTNMEe/hGj2nWekZnqnnirQU6MxjclPUR/F5A8xhl04EOc
 fYW9MFzoHqpoeXtioTgiELmGw+fgvCnRs/IkXbpagir9Vi7fCkPR8BG7eHw184zkmz5z
 u+DE/DD9DH4plrYonkfRBM4djnV8NGQKZl+IclJd3/pzqbqZo3VSzWqWc+HZVu72WNg0
 ae2neBobcJAdCFlAJ/Zs9HSlkBEmux9lgIA3hdszdaaJQ1uDVoZhqqMBNy06Ql+k4dXn
 MH2csh4uw5Tq5Atqh/A9YDx+OWMN3BopJ8iXqI9dNCL6ph0yIup34aK1H2XCHncGGz0T
 ElXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=otFYkDYO1CCJWJ6//sofYnaWi+8sSZ9tkLiYX6S8Pgo=;
 b=onhxmk/ZTxbE0NZi4EpCEO9+BomBmV41p394bYgOw0u08CKQxPS9U2/Uu6sgJfipRy
 GOJ/aZxeHZSJI+wpRQIZMgmcxHxLhvbDcVD+uYvASesv7zVGQcl7E0Xc+vYiCfGcV2ep
 OKqPfvefBsvO9FuJ5jD6fydt0LyXGsYMzRs/qGtzoCHeqVi/P1cwoh4fRzGwux6eJUM6
 vyL53vfT9WQrBabH0TVq1z/N1khSRbeaeTsMy6ayd9lxBTjiTPFih8yMXfSeIcGcogZ1
 T36RUmSpbPfILaWZ2MMWBagnyvMBVVLzIN5VpdslJsagCVgZUBvo1tqiuU+dt99fRZjR
 19Lg==
X-Gm-Message-State: APjAAAXVVOMAHYVNAi7JEwosCnZlSL/LNjcIGfhcgCT1nSSQWbcjHCTS
 dR38Ij9C6IZ52+02vgNkHIzNsYhsxNpgpm2AgRClxw==
X-Google-Smtp-Source: APXvYqwZBHBMezI/BSfkrYGqv7I1fRVxYzFR2ri5Xr3hkcB8gxHNZGIocCqa+I/8qUwqccaOl6a99JoI9S8ob1sLKxc=
X-Received: by 2002:a9d:6a94:: with SMTP id l20mr12076731otq.221.1566765810915; 
 Sun, 25 Aug 2019 13:43:30 -0700 (PDT)
MIME-Version: 1.0
References: <20190819213755.26175-1-richard.henderson@linaro.org>
 <20190819213755.26175-36-richard.henderson@linaro.org>
 <CAFEAcA8JGUdM5v0MCb98Jw+iJNC+ZMD5SDrPVR0dHGgtMOdk6A@mail.gmail.com>
 <162644ea-ae46-576f-7dea-6696db364c68@linaro.org>
In-Reply-To: <162644ea-ae46-576f-7dea-6696db364c68@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sun, 25 Aug 2019 21:43:19 +0100
Message-ID: <CAFEAcA-m76JW2=t8uX6nC8E54TMKLe4nbCGvd8bOKx+wSYRtGg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH v2 35/68] target/arm: Convert CPS
 (privileged)
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, 25 Aug 2019 at 18:28, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/25/19 9:20 AM, Peter Maydell wrote:
> > On Mon, 19 Aug 2019 at 22:38, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> >> ---
> >>  target/arm/translate.c       | 87 +++++++++++++++---------------------
> >>  target/arm/a32-uncond.decode |  3 ++
> >>  target/arm/t32.decode        |  3 ++
> >>  3 files changed, 42 insertions(+), 51 deletions(-)
> >> diff --git a/target/arm/t32.decode b/target/arm/t32.decode
> >> index 18c268e712..354ad77fe6 100644
> >> --- a/target/arm/t32.decode
> >> +++ b/target/arm/t32.decode
> >> @@ -44,6 +44,7 @@
> >>  &bfi             !extern rd rn lsb msb
> >>  &sat             !extern rd rn satimm imm sh
> >>  &pkh             !extern rd rn rm imm tb
> >> +&cps             !extern mode imod M A I F
> >>
> >>  # Data-processing (register)
> >>
> >> @@ -340,6 +341,8 @@ CLZ              1111 1010 1011 ---- 1111 .... 1000 ....      @rdm
> >>      SMC          1111 0111 1111 imm:4 1000 0000 0000 0000     &i
> >>      HVC          1111 0111 1110 ....  1000 .... .... ....     \
> >>                   &i imm=%imm16_16_0
> >> +    CPS          1111 0011 1010 1111 1000 0 imod:2 M:1 A:1 I:1 F:1 mode:5 \
> >> +                 &cps
> >
> > In T32 the CPS insn overlaps with the hint space (hint insns have
> > bits [10:8] all-zeroes, whereas all the valid CPS insns have either
> > M set or one of the imod bits set) -- why doesn't it need to be
> > in the same insn group as the hints? If we're going to put it
> > separated in the .decode file from the insns it overlaps with
> > I guess a comment to that effect would help so it doesn't get
> > inadvertently reordered with them.
>
> It is grouped.  It's not immediately visible in the patch because there are a
> *lot* of insns that overlap with the hints and 3 lines of context are
> insufficient to see that.
>
> But the grouping is semi-visible in the indentation here.

I'm still confused, I think. The hint space is
+  NOP            1111 0011 1010 1111 1000 0000 ---- ----
(plus the more specific hint insns before that pattern with
fixed values in the [7:0] bits).
CPS falls into that space; but you've placed it with
SMC and HVC which don't fall into the hint space, because
they have 0111 in bits [27:24], not 0011.

thanks
-- PMM

