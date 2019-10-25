Return-Path: <SRS0=bySr=YS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBCEECA9EA0
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 21:04:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 82C1621D7B
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2019 21:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i3VQXrrT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 82C1621D7B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36228 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iO6l6-0008AH-J0
	for qemu-devel@archiver.kernel.org; Fri, 25 Oct 2019 17:04:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38529)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iO6iB-0007Zi-93
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 17:01:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iO6iA-00053L-4q
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 17:01:31 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:35724)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iO6i9-00051D-Vo
 for qemu-devel@nongnu.org; Fri, 25 Oct 2019 17:01:30 -0400
Received: by mail-ot1-x344.google.com with SMTP id z6so2999707otb.2
 for <qemu-devel@nongnu.org>; Fri, 25 Oct 2019 14:01:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=uhknvv6JSmoL0jL8CNQDIF2omF8f33zN4a+jFkGoeAQ=;
 b=i3VQXrrTiV0E4Kv67Z21Gze9k91ETI7UjfrBnYuKH5WoxbelGjf8AUenVvwxaUo6FM
 k7bz5EhnGzpHz3MTbFLoJjpKOL2LxGyW/44Njibag0JXVsnUEDnbERlpRizQTU82NX8R
 dOmOQxQXsy3/FHTvWb9nubfq+yQU8iL8exDcR+mPbtLXEbidUj4VhVX30PH0oswvBgR5
 DG/MWigoXev22/QG+8DgCGXqPJy1PY1dgjZ6G4ZRI7vqdMr4I25pKMqz1heCqnXHJVEQ
 3Vy6D2aRmk2Gfmw3dOIvv5B8UMkmqsrNoxsmsSjBZWW1/76iVlg5McD92I0hRcT+Ilom
 KiBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=uhknvv6JSmoL0jL8CNQDIF2omF8f33zN4a+jFkGoeAQ=;
 b=FP1Aq9KfGExtuCKvqwviBCdFgHJ3FV4XkRPtQYfQZPpNiAiJmb+5Fdfcm+4Z3GTmvI
 40mpEP4CF3Wra0wzi8Lg9NZfzCmS+cftcg2iVyPh4XM5yNmxgyzbe0xSadyOcPpIICU2
 UoHsgVgg5UXsCEtECj5HXrE5Jk2gS8Sef8s480dPEMsXqRftIvIQUgRPgJ7xlmzYj0j2
 ALDU4SWqROJiS9WckJ36B0V/XlzTrcQYfUCqOM/F1+d5+4ZVYjJa2uZB10O3NIUuswvN
 a87qeZdHP6eHQ86u36trzOhLLiGi4f4uysHl3xjuw/cB255KpMzYXO8tW60GhyZAvxbG
 1wKQ==
X-Gm-Message-State: APjAAAVT0xZxDWyGKKZOTydUuVDsrj0ieORmF+VjzvDesVN20iRUXray
 jnTyjRdl+gPNCyMc+eU9yT/ON9v4NVRPDkQmtJ+mrA==
X-Google-Smtp-Source: APXvYqydRPLafcOnxdee74nt0QXp5EBHp/pdUmbXrkxuDrslIwHrrqvQB8E5H3yGabjpJUdbrJX5Z7k0CBCyXxby1Tc=
X-Received: by 2002:a05:6830:ca:: with SMTP id
 x10mr4198414oto.221.1572037287563; 
 Fri, 25 Oct 2019 14:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20191023154505.30521-1-richard.henderson@linaro.org>
 <20191023154505.30521-5-richard.henderson@linaro.org>
 <CAFEAcA8unCxb-4E561fnOFd=LCXv1y7YSd9xUb2GAutjcYXeGg@mail.gmail.com>
 <2d65342e-ed48-1fe6-7e6c-97f51ac21a76@linaro.org>
In-Reply-To: <2d65342e-ed48-1fe6-7e6c-97f51ac21a76@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 25 Oct 2019 22:01:15 +0100
Message-ID: <CAFEAcA99ABj9LU4fox-7Zaz4NG-yKQ7cD21M9xv=AwtSSOr1mA@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] exec: Use const alias for TARGET_PAGE_BITS_VARY
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 25 Oct 2019 at 21:43, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 10/25/19 10:51 AM, Peter Maydell wrote:
> >> + * We want to declare the "target_page" variable as const, which tells
> >> + * the compiler that it can cache any value that it reads across calls.
> >> + * This avoids multiple assertions and multiple reads within any one user.
> >> + *
> >> + * This works because we initialize the target_page data very early, in a
> >> + * location far removed from the functions that require the final results.
> >
> > I have to say that this feels like a worryingly large amount
> > of magic. Is this actually guaranteed to work by the compiler?
>
> Yes.

I'm curious to know how the compiler engineers define
"very early" and "far removed" -- in my experience they
usually prefer to be more precise than that :-)

thanks
-- PMM

