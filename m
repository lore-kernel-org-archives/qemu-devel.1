Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE2FC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 18:32:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9836920B1F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 18:32:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Cq3K03vb"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9836920B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56530 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huhmR-0003i4-8k
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 14:32:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60428)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1huhlh-00037A-UD
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 14:31:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1huhlg-000511-SF
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 14:31:37 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:37003)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1huhlg-00050d-Mb
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 14:31:36 -0400
Received: by mail-ot1-x341.google.com with SMTP id s20so20750863otp.4
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 11:31:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hR1VILiTwmBkb45dDAsR3geq6akR0sPqsW7yO4H/MAc=;
 b=Cq3K03vbT1d45jXBR9d/pJH70c9NcU7aiNQJfiAG3kHc6sqn6iydU/iUF8o0zhVm6l
 TGtwv9q59oU9rILAaKOZqnikod4Ezp+O3tFdrp7I6GQOtSDHFRKE/SYSW3To0f9whMxr
 xr5gxE3YN/e1pLuZKOh0hWSrKl7dDTjkh0QLet0nzqQ0+Oj8DseagrISsmRq7qEmA3tw
 M6qD0Etznxjwld6mM+GW07dYCqi0YP/qHAbAa7No24i5Un3iLHtBzomTimYBcYshFDMH
 n0FTYjaL9hICz+0nhuWQwcguHEWpOUAnqxFQQxGxRht90TKkZoqZ3xGX2n7i7V7uNsft
 ardQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hR1VILiTwmBkb45dDAsR3geq6akR0sPqsW7yO4H/MAc=;
 b=TxfNiIHv0xpbASgVWH5Q5rFjzuLvxDrcPL9oa5M94qx50JlcznmYTZD74NHGdOAIfg
 q4k8ImA4dfyOAGRQCLwKwG/voHktLtDjd0IOZ87n1bniK9ZGfkXNR5jmUStfEkqiYe7U
 hcEXRhZKqJsGT3f4efqlVZEBHz8Dc2lMcfM9SpTfWfi1sj4v6bA98LC6RCiQ6F4QHZlI
 vk1gPrOQoeegmhA/acfedgzDO30eV3BVJNekEq3hVBIXO4uQjgso4DKSBxQGOPr3mCSD
 UgX3DE13SKT3IIfhrnGTSTUCy3K0psXVV0osjo+gru9LZUN3fEXsEJivvBD5eHpJeCkj
 gR0g==
X-Gm-Message-State: APjAAAU5/4UhuNODvWlX1eUUPqik4E7Lmct96YyuvgriBFS2T7iYPyzO
 H89T0T/ofpRx0jrs5x2CBwcLAVpdz6gIL8daJWCLXA==
X-Google-Smtp-Source: APXvYqytMxa3nK1GOf2A5Act9/uxMR0vr8mBDaBlxz797GB9kvvRNb90+jF9R0GOz0w2bNyCzIXaE5kZ/dAyyyBAGP4=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr56594337oti.91.1565029896079; 
 Mon, 05 Aug 2019 11:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20190805163740.23616-1-mreitz@redhat.com>
 <CAFEAcA9UH0g2A5g=akRbcLS4RXKQcDfFySFum3-fgO=R=mE=Ng@mail.gmail.com>
 <18e1fec2-00b7-1a00-df41-8d818524a875@redhat.com>
In-Reply-To: <18e1fec2-00b7-1a00-df41-8d818524a875@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Aug 2019 19:31:25 +0100
Message-ID: <CAFEAcA_mtPrpbfNwvc=ytxV0kBZOWi8XEUf67YeTJ6+qUNU11Q@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PULL 0/7] Block patches for 4.1.0-rc4
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Aug 2019 at 19:21, Max Reitz <mreitz@redhat.com> wrote:
> Would dropping the test patches make it better? :-)
>
> I am reasonably (i.e., rc4-levels of) confident that the patches don=E2=
=80=99t
> break anything that wasn=E2=80=99t broken before.
>
> (I=E2=80=99m least confident about the test patches working for everyone =
and
> everywhere, as with all new test cases.  But it was my impression that
> it=E2=80=99s always fine to include test case additions.)
>
> Patch 1 is very important.  I=E2=80=99m very confident about it.
> It fixes a silent corruption in the backup job, so I=E2=80=99m not too su=
rprised
> people haven=E2=80=99t noticed.  I would be surprised if really noone was
> affected so far.
>
> Patch 3 is not that important, but it is sufficiently simple, so I think
> we should take it, even into rc4.
>
> Patch 5 is very important for a specific mirror copying mode.  It can be
> argued that nobody really uses this mode because otherwise somebody
> should have noticed the corruption, because if you hit it, you will
> simply lose data (as opposed to the backup case, where you will simply
> get the wrong version of the data in the output image).
> But that is why it=E2=80=99s so important.  I really don=E2=80=99t want a=
nyone to hit it.
> It is probably the most complicated patch here, but at any other point,
> it would still be considered a simple patch.  (Just not quite trivial.)
> I think it is worth taking it.
>
> Patch 7 is actually not important.  But it=E2=80=99s an obvious trivial
> one-liner.  I thought I might as well.

Thanks for the clarifications -- these all sound worth taking.
The thing about rc4 is that we don't really have much chance
to find any problems with patches we put in at this point,
so I like to be pretty cautious.

thanks
-- PMM

