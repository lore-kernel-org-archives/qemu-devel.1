Return-Path: <SRS0=OEAU=5Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2ADA5C2D0F4
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 16:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E92A720784
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Apr 2020 16:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RcPvNu/d"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E92A720784
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38456 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jMDYU-0001y0-1B
	for qemu-devel@archiver.kernel.org; Wed, 08 Apr 2020 12:27:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42279)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1jMDXp-0001RU-97
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 12:27:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1jMDXn-0006sh-Jk
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 12:27:17 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:41508)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1jMDXn-0006s5-7J
 for qemu-devel@nongnu.org; Wed, 08 Apr 2020 12:27:15 -0400
Received: by mail-ot1-x343.google.com with SMTP id f52so7346279otf.8
 for <qemu-devel@nongnu.org>; Wed, 08 Apr 2020 09:27:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=bIri/yt0m1uy/qDkJOYMe+nJBkj0pSEqTeyqKjpnWuM=;
 b=RcPvNu/dNX9o/Hgt8K1NKEG2ameyzoSyA/2vaRVT8X9MIFwqbYKDWdrtW+dcvD/J4E
 MX0CpI9GNgApqW20LRascbKR5ODGphd49CSrya7bMnHfxtKuHbKiaBjwX7Wy4MuvbyBO
 14soc0jr64opWoRKa22MKA4paZ05qDIq6fsRcy1UsexrHCXFKMb+i7xeyo4TAV/b1/R7
 b9qAY9DSyyf6fomyvdljuYSY9qIYmMq+jmYuHZuhIdDoqj9HfF7KpAj4aKQl8xpXnj8a
 gEutw/BeDdNCHr6iL5UH3pOVzjOW38wTAETIczmW8xs+XrysweADHSBe0q6QOK52Qd3v
 L4dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=bIri/yt0m1uy/qDkJOYMe+nJBkj0pSEqTeyqKjpnWuM=;
 b=NjYfPjzSbklaTMafTVRttT5nAWxfAz2Gh/gYLoehztQV6wojjAXPjk6zJkk3AHFYbm
 ZJMJiHil41V+Xla7PGvi3/pxfSRrUyyE69h/tku7eIOrkgPC/O4MN7voIc93A8qsK4xy
 OUvUrld/5wFmFkewIxwS0n3QdYiPkFe0owTcc7mD0vxnXDd5+dHHFF/jeYrEOZ6+ys5S
 ZO7kyoKXj/FCzNto9rAwYl2AGGCqo29Fz1KCO+1oood2cB10DIoBQs9jcC2/Sur7xiHl
 9YrsfjbY4jIJBTDjvpm78e+XwbAEEpXrx4pZxTrEj+Xl9O/Yi51VV5I8fpHqGeNqV6ty
 BdRw==
X-Gm-Message-State: AGi0PuYyueeLGCyxDQiR85L/v24ZUSIjpmR2upO1lROhci/A+MUsf3wR
 4ddITul5JSTjz+euGMwuEstbHz1C3DQisLkkPG+Ozg==
X-Google-Smtp-Source: APiQypLWT7nVAM+wa2Zf9MFUiOuMeW5w7tL/9cXp1HXpRfPn+/2TI+n0P4ELaNj6EiD4/rsmWvKwd5NE9freaslkc/g=
X-Received: by 2002:a05:6830:11d5:: with SMTP id
 v21mr6415013otq.91.1586363233146; 
 Wed, 08 Apr 2020 09:27:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200408115953.1158-1-fredrik@strupe.net>
 <20200408115953.1158-2-fredrik@strupe.net>
In-Reply-To: <20200408115953.1158-2-fredrik@strupe.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Apr 2020 17:27:01 +0100
Message-ID: <CAFEAcA_kVi_LWFduY241vB-nZn2rG0_13Y80t3CZVO3=u_pM-A@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/arm: Fail on invalid size for VMUL (float)
To: Fredrik Strupe <fredrik@strupe.net>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 8 Apr 2020 at 16:29, Fredrik Strupe <fredrik@strupe.net> wrote:
>
> Bit 1 of VMUL (float)'s size field encodes the opcode and must be 0,
> with 1 making it undefined. Thus, make VMUL (float) instructions
> with size=0b10 or size=0b11 (size >= 2) undefined.
>
> (U is 1 for VMUL, while it is 0 for VMLA/VMLS.)
>
> Signed-off-by: Fredrik Strupe <fredrik@strupe.net>
> ---
>  target/arm/translate.c | 5 +++++
>  1 file changed, 5 insertions(+)

Thanks for this patch. I'm actually in the middle of a
refactoring of this code to use decodetree, but I'll make
sure I check that the refactoring fixes this decode bug.

Also undef-checks like this in the old neon decode structure
should be in the switch (op) outside the loop-for-each-element:
compare NEON_3R_FLOAT_CMP; but it's a bit moot with the
refactoring as all that code will be deleted.

thanks
-- PMM

