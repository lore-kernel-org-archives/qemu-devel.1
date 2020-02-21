Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C94C35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:54:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E6F8C208C4
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:54:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UwHvHedT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E6F8C208C4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33294 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5BZN-0002K8-2s
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:54:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:59799)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j5BWo-0006Kt-75
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:51:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1j5BWm-0007jK-Tk
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:51:50 -0500
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:46740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1j5BWm-0007i3-Ot; Fri, 21 Feb 2020 11:51:48 -0500
Received: by mail-ot1-x343.google.com with SMTP id g64so2529007otb.13;
 Fri, 21 Feb 2020 08:51:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BX0Hhqmk60VfWSXk+83MT3Mi0s9q+PZrJOzfHezJQow=;
 b=UwHvHedTV2eDb1qM3JzTQgPnijbEPkvGR2ZhHgUo/Sr4cE6c1dZSFsIbVtucqXldI/
 3l1VtudNWfQj9gVogXTDi1Aqr2zYrkSJmVfaMALwfNuA7zitJWEWbWh8YGXEYOlaXzjo
 wQXLfnTQrXl5h9PPaK2Jdl0aeE2E8wNLMYqnvfopxvU9qwbVO8cMFNAgOptfxV/GrGUC
 /8rB04H6M9rmQPA0BCX/0r3wFQ+qJ6AWE2tV1alNH9N/tJAAwbAKCR13wWwvsrL+4B4A
 HfGQH+tg78a0s27rTn8+By0TMApcKUSNfy4qOt+o3Jz35MTJQj7Hcxz9UHxOo8YJhLF0
 dKww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BX0Hhqmk60VfWSXk+83MT3Mi0s9q+PZrJOzfHezJQow=;
 b=dIAAsv1ExzDxn2WPFOJF8EGWE3SEV6I68JE8V80CASH3La5uW3RfbUd1GClWK9C4Eh
 NObTvkvUkMPbkWIFX9UZA6BlyfH0jylcNJbg+YuuCWJ8jJlV/NdqQpy2PmsXZ7NvF28g
 mi0qpVRqPNekSrTOqxkiPJ/BRTK6TupUFJfYFrTyHFhcIFzq2VuIpAQqXheMCuYQFg71
 JgMFAKI8Yyrc+BVt/DcknJUXImjAjZIAL7jYo5+jZclynAtlrCieikUr2JqZXaueBSzv
 4a6fOYnfO8NyjoQlY53IRLAHP8j/9jMalSA1z3fiNX2AzRRqmxPwpLbMUoBr18o/8ml2
 ZxuA==
X-Gm-Message-State: APjAAAUcdz8BBXWEoaCAKn5LAbgz/B9neS9CIM+KLHWrHPjsGc7ApQ7s
 jRioJ7ZzS7RtBZR+0ePQGbj0THvPVTTKg4BEPYg=
X-Google-Smtp-Source: APXvYqxsNO2Hjm2segl4y3nq5iQJ3x9aiPGJy5x1psimR1w6j4r3XO08UaLHFg+KwIYbtxpgAYOGL642U02yhJY+rJY=
X-Received: by 2002:a9d:7305:: with SMTP id e5mr27672043otk.64.1582303906521; 
 Fri, 21 Feb 2020 08:51:46 -0800 (PST)
MIME-Version: 1.0
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <d9d4fba7-2dcf-8f09-8f3a-7e0408c297b6@linaro.org>
 <alpine.BSF.2.22.395.2002211643480.45267@zero.eik.bme.hu>
 <CAFEAcA-teH7KXACL=5m0-X+g692EXKtqOy9d_uGjw6XA8S3vzA@mail.gmail.com>
In-Reply-To: <CAFEAcA-teH7KXACL=5m0-X+g692EXKtqOy9d_uGjw6XA8S3vzA@mail.gmail.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Fri, 21 Feb 2020 17:51:35 +0100
Message-ID: <CAL1e-=hvhBXq1X4iN09jK=-ZyE999rQBGt3m3uHHNMjm2PRaLA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
To: Peter Maydell <peter.maydell@linaro.org>
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
Cc: Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 John Arbuckle <programmingkidx@gmail.com>, qemu-ppc <qemu-ppc@nongnu.org>,
 Paul Clarke <pc@us.ibm.com>, Howard Spoelstra <hsp.cat7@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Feb 21, 2020 at 5:11 PM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Fri, 21 Feb 2020 at 16:05, BALATON Zoltan <balaton@eik.bme.hu> wrote:
> >
> > On Thu, 20 Feb 2020, Richard Henderson wrote:
> > > On 2/18/20 9:10 AM, BALATON Zoltan wrote:
> > >> +    DEFINE_PROP_BOOL("hardfloat", PowerPCCPU, hardfloat, true),
> > >
> > > I would also prefer a different name here -- perhaps x-no-fp-fi.
> >
> > What's wrong with hardfloat? That's how the code refers to this so if
> > anyone searches what it does would turn up some meaningful results.
>
> This prompted me to check what you're using the property for.
> The cover letter says:
> > This patch implements a simple way to keep the inexact flag set for
> > hardfloat while still allowing to revert to softfloat for workloads
> > that need more accurate albeit slower emulation. (Set hardfloat
> > property of CPU, i.e. -cpu name,hardfloat=false for that.)
>
> I think that is the wrong approach. Enabling use of the host
> FPU should not affect the accuracy of the emulation, which
> should remain bitwise-correct. We should only be using the
> host FPU to the extent that we can do that without discarding
> accuracy. As far as I'm aware that's how the hardfloat support
> for other guest CPUs that use it works.
>

Right, that is my understanding as well. There shouldn't be
"hardfloat" switch at all. If there is, it is either a mistake, or for
experimental or other similar purposes. In my understanding,
hardfloat feature should work entirely transparently, making
the decision whether to use host math functions (instead of
softfloat library) by itself, based on the particular execution
circumstances.

In other words, the accuracy of FP emulation should not be
compromised in absolutely any case (there should not be an
option "ok, we are happy with approximate calculations").

On top of that, artificial generating of "inexact" flag really
seems problematic (or, speaking bluntly, looks like a hack)).

Perhaps hardfloat feature needs a little bit of more work,
but not in this way.

Yours,
Aleksandar

> thanks
> -- PMM
>

