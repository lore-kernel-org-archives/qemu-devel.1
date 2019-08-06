Return-Path: <SRS0=MhU4=WC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94E36C31E40
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 10:02:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 661FF20C01
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Aug 2019 10:02:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z4iZ23ta"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 661FF20C01
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60032 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huwIO-0003jT-Kr
	for qemu-devel@archiver.kernel.org; Tue, 06 Aug 2019 06:02:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38838)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1huwHT-0002tK-Vc
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:01:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1huwHS-0008RB-Pt
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:01:23 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:37142)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1huwHS-0008Qj-K4
 for qemu-devel@nongnu.org; Tue, 06 Aug 2019 06:01:22 -0400
Received: by mail-ot1-x343.google.com with SMTP id s20so25525081otp.4
 for <qemu-devel@nongnu.org>; Tue, 06 Aug 2019 03:01:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=OyCkWYd4rR9Q+Suj817p2WoAsuYr+I0FZ+hkdGRfV3c=;
 b=Z4iZ23taEgEeTDYfZCBlLw1Ljp5ApuvHcd3EKiCGwFNd3iM9DjgXwO7BRFwiBLfTvr
 +5gapkcyKfHHUlSO4ynABfo8wBMj87/niamQ5cAh51grf8Mgik5SCbRTpXMS7dTehmbF
 gZ+XspEFhJc0AWRRt9IYnpCoCLac/zRXzoaKzhn/FH6TI0vCmfNMk4emrdZ68gV23rLa
 SXqmXHBL0SRiB5hM57/pShLm7Dq6v09hOLL0+blaUa+nrEgq5imarQwc4OkkbKDQ5Dum
 6Ki0rrSN5boa7ELWJCgfb6sMwMA6VMz/opPzONMDoJ/c9PVqSqQcssK/wOf9AdFRevMX
 FJuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=OyCkWYd4rR9Q+Suj817p2WoAsuYr+I0FZ+hkdGRfV3c=;
 b=I5fTZixjA+W4SfvzoKWBm62nuUKr3LJFgHDAy+5kaiTrA72C3+b5HsyfirxZahBsBr
 3JEJl2gagFaDYeNFVtDkh4li6cSXnGjYZVC8141qwpP0ovd9EvdrcTM7o9s52p35INOJ
 1Xr2FOgDSxTHRRAWsUBaIMXvMEljxXMwgGmp85FNMGPf+Z6/FC43BzJXAYX29S5eUgG0
 b16y246AF5aWFQPjbY+GCUjdxTQ0Z3rjbK17yJUBxOyMqaj860U05Xb7FAJGqse0kClz
 KOhEH+KPP1Dv5PaTvmxoESoDz38+Bij8LaPuP+YhDki53ZX6/U5ZyAe6ReSb9pFqLOu+
 YIlQ==
X-Gm-Message-State: APjAAAVyY1/cavfemVXnrl6a398fHev+7bdakZBrDvu2WA5IKtFfqsIm
 w5TBO8/VMrUeiChzLpr7CzNNnDeof4QcdmXsWmga7KWJ
X-Google-Smtp-Source: APXvYqwjgN0OJG4Xw+aMuYsKoc4K0duH+s8ErPXEkBAxpJq5g/0E1CNjkt14ma3vF5bvCmDbki44X3pW8JTIqOQLi3s=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr2498351oti.91.1565085682005; 
 Tue, 06 Aug 2019 03:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20190726175032.6769-1-richard.henderson@linaro.org>
 <CAFEAcA_JDfN+Njo8J0EhbtECWEW5_LcCVehbxmpY6AX3BLbOsA@mail.gmail.com>
 <d2b6ae73-6f48-1808-fb95-631bc12834f0@linaro.org>
In-Reply-To: <d2b6ae73-6f48-1808-fb95-631bc12834f0@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Aug 2019 11:01:11 +0100
Message-ID: <CAFEAcA91b4FpbiUnZCVbs+nPvLo_q-iKwWkx94yxpXrZDnLhcg@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH 00/67] target/arm: Convert aa32 base isa to
 decodetree
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
Cc: qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Aug 2019 at 22:26, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 8/5/19 8:44 AM, Peter Maydell wrote:
> > On Fri, 26 Jul 2019 at 18:50, Richard Henderson
> > <richard.henderson@linaro.org> wrote:
> >>
> >> This unifies the implementation of the actual instructions
> >> for a32, t32, and t16.  In order to make this happen, we
> >> need several preliminary cleanups.  Most importantly to how
> >> we handle the architectural representation of PC.
> >
> > I'd be happy to take the preliminary-cleanups part (subject
> > to the various review comments) without waiting for the
> > rest of the series to get respun.
>
> I had an outstanding question re patch 4:
> Message-ID: <c7a3ef78-d541-aa0a-21a5-8b4f48db1fd7@linaro.org>
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg06520.html
>
> and another re patch 6:
> Message-ID: <09b930e2-0a92-25a3-4e26-8bea1f437039@linaro.org>
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg06508.html

I've followed up to 4, 6 and 7 giving some thoughts on those.
Anywhere I've still not been very specific it's because I don't
have a clear idea of the right thing, so use your own judgement :-)

thanks
-- PMM

