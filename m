Return-Path: <SRS0=8ZcK=YO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 197D3CA9EAF
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:29:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8491205ED
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2019 16:29:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="BXZuI3Od"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8491205ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iMaYX-00077w-Uy
	for qemu-devel@archiver.kernel.org; Mon, 21 Oct 2019 12:29:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37493)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iMaX6-0005lw-5Z
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:27:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iMaX4-0001AU-4x
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:27:48 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37979)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iMaX3-00019y-Tu
 for qemu-devel@nongnu.org; Mon, 21 Oct 2019 12:27:46 -0400
Received: by mail-ot1-x343.google.com with SMTP id e11so11527182otl.5
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2019 09:27:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=9ZNUWf1s5ZzdOG4N1Puad+d5Vq0KIO/FQxDYDdjJado=;
 b=BXZuI3Odp0oHkkeLxqj/rMa2AIlyJE7ZPP9yvxHDMloOGtBe5521axVSf5VFAWdtT/
 YhkwGG3niQSSpNO/PpdTieeMOz9uF7P25WimDnUECE1n+RwXtit1tQOsPUybVBqYKvhV
 Im/DxX72/nf3XmxUHfHft4byxvUFRrA2AW0mtythz+TKjR8sm5aUp+rhZ3+UxIv1dy8k
 c4Ds5Nty6YmBAO3UOsxVCfKPxD2mfdLJfYrvv5RMop0Nl5NwYQ8v8BXZS2qiKes87ZHk
 cF38U2Ll1v4zPQ+pnWfmNrNHEZ3tDqwN/RLFdrngvacbgAJzQM41UYPO09nU8juVRARD
 4LnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=9ZNUWf1s5ZzdOG4N1Puad+d5Vq0KIO/FQxDYDdjJado=;
 b=i4pPb+GSU9v60nhwMAbwQNy5qvWi+upEguoA03i3aQQ3FGfSYDy58W6WInE9PmY3mp
 CIKau3QQRfe3rma3Px3Xw57NhzpioVnGRWkYKyRPLxQ1sgVTo+Qkc3fXyNJ8vCI0YUTv
 x1S6QG+sOYw8rNiasMc8qQ/aMYC7B0HxFGqfHOFu4p0yaXYeugIiPFwfT2gvz2Zr1jxq
 GOhmQjJ2WG9/S0JpxcBz3M9+rFy9SZTWGxMF9umVi6/Zc1bhZAegN4gSaPT/ev/GEh+R
 zKXDZxzoJfUJy9JQsErIGwTgN3jHjRMKp1WEbSZZwMnrmry5h6/FlnZrOHCUJEPdMW8F
 +GgQ==
X-Gm-Message-State: APjAAAWzy6N9ydn8gEwSEE09YY35YmgZd8EMr12AEWgM4mXbpLakxVhr
 Tff0jLMGkB3K4rbdCTO9xF/caBfavm0jCARbRvT39Q==
X-Google-Smtp-Source: APXvYqyW+v6pYSYQUu9l0g7Aypv2FdBF0RZyAjjvaDVrjfntn5Z61+jU7WXyRvQ9+67Fk06FCVhWFGU2/Z4WKW0GZtI=
X-Received: by 2002:a9d:30c1:: with SMTP id r1mr19697952otg.91.1571675264364; 
 Mon, 21 Oct 2019 09:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <20191021145839.12684-1-peter.maydell@linaro.org>
 <06e15851-0b4e-63c3-001d-dd7ea5855872@linaro.org>
 <155991c2-523f-0721-c7a8-4fbe4986387c@linaro.org>
In-Reply-To: <155991c2-523f-0721-c7a8-4fbe4986387c@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2019 17:27:33 +0100
Message-ID: <CAFEAcA9trXJ_g=HtqFrvXvCH+WMtJ8w3x7xX7=8jNm1PdxbMbA@mail.gmail.com>
Subject: Re: [PATCH] tcg/LICENSE: Remove no-longer-true statement that TCG is
 BSD-licensed
To: Richard Henderson <richard.henderson@linaro.org>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Claudio Fontana <claudio.fontana@gmail.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 21 Oct 2019 at 17:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/21/19 8:52 AM, Richard Henderson wrote:
> > On 10/21/19 7:58 AM, Peter Maydell wrote:
> >> Since 2008 the tcg/LICENSE file has not changed: it claims that
> >> everything under tcg/ is BSD-licensed.
> >>
> >> This is not true and hasn't been true for years: in 2013 we
> >> accepted the tcg/aarch64 target code under a GPLv2-or-later
> >> license statement. We don't really consider the tcg
> >> subdirectory to be a distinct part of QEMU anyway.
> >>
> >> Remove the LICENSE file, since claiming false information
> >> about the license of the code is confusing, and update
> >> the main project LICENSE file also to be clearer about
> >> the license used by TCG.
> >>
> >> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> >> ---
> >> This patch takes the simple approach of just documenting
> >> the de-facto current reality; does anybody want to argue
> >> for something else? Other possibilities I guess would be
> >> specifically documenting tcg/aarch64 as an accidental
> >> exception to the general licensing rule for tcg/, or even
> >> trying to get it relicensed.
> >>
> >> Does having tcg/ be BSD-licensed gain the project anything?
> >> From my point of view I don't really see it as a cleanly
> >> separable module of code -- it's quite tightly integrated
> >> with the rest of QEMU, including code in accel/tcg which
> >> is variously GPL or LGPL.
> >
> > I think this is the best solution.  I've never been convinced that TCG can
> > usefully be extracted and reused for something else.
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
>
> Queued to tcg-next, as I think there's a couple of other things pending.

As a licensing issue, I think it would be better to have it on-list
for review/comment by interested people for a bit longer
than that -- it's not like it really needs to get in before
the softfreeze.

thanks
-- PMM

