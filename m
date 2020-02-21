Return-Path: <SRS0=IEfc=4J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F18CC35646
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 592C52073A
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Feb 2020 16:12:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Qpn/yq2L"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 592C52073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j5AuH-0005EL-JJ
	for qemu-devel@archiver.kernel.org; Fri, 21 Feb 2020 11:12:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44656)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1j5AtW-0004QU-Jd
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:11:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1j5AtV-0007Bc-H7
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:11:14 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44230)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1j5AtV-0007BJ-CP
 for qemu-devel@nongnu.org; Fri, 21 Feb 2020 11:11:13 -0500
Received: by mail-oi1-x243.google.com with SMTP id d62so2048375oia.11
 for <qemu-devel@nongnu.org>; Fri, 21 Feb 2020 08:11:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZK17Xbja1c7DR9dFtnie1g2nFDB3v+CHLpa8VD3WOII=;
 b=Qpn/yq2LJC5midgWGcFtun3gRL2oZ/jeXVnRaINTfl3dSm5wgZiBE0orYxfnBOF3Rd
 ttF+3itiEyoZLU71domAJ6tUw7MRStZQTODqqdA0MEb6uYI9uwuiZEgeRWV0za01X2HD
 TKOy7+dZOfSv9DG+oq26cT/4dSGGzAUTKRTe0rqdCR6yE1p/np4CesmsGAJAsXKR3RNK
 rbd8qfGL+Uj9Lk5biD714ksL12oedUkffjIT6mg/HDwMezbzIe5AO1+JW1KT/6pa75HU
 zvJEee4Btfd5QYN/pgfrRvkiasTjFOfBrgFDHfZHFahpq6z0roitIjAw106Ojx/e7LMJ
 yjNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZK17Xbja1c7DR9dFtnie1g2nFDB3v+CHLpa8VD3WOII=;
 b=t5e/PZYqzYvoJXp0mEHZhF+z1oNsYIJqpQbFiAzRL0P8g1UKRI4bLA5ZsJhPK9UDzC
 MseS5cIvHPJd+Y85KLP+Yw8FO32d2F0CucACx62LVvO3Is6w5eM70aEdESDjcRt46sAO
 LqjeQ2nRtTDHVrLB2x4X9F6nXFQOKWpbpdPwhRoH491xQtuLe8zYfj3J/iprKyqR+v2W
 sA5qN8fH6PVcvbPwYYNVy1U/2mRjXPxB/oCM5ePukjAaFKNzjq2GJ6FounLpwGhbZtP4
 WFo/O6G4TUVx0ZuJNhFpmhVOZ0rZVbuc8Z0UBK4c9OIO/jm3vFXPGb/YVlVk98af7aa7
 4JIg==
X-Gm-Message-State: APjAAAV/fHs4tD6RLWey/ebYvfUcri/R/ozeOGYTpVx/2XT4SH0spv0a
 +qSORzjyxsGL0M+xZh0/v3sFCUmCZ+wjQ1tA+BQ0dA==
X-Google-Smtp-Source: APXvYqzChA1TpAuSjmX4920FUcrrhPHUHkPGzuILqh/pwWqjFfGFGWpAQ1zfx9nBr5HX6dcRr11/N5z9vZQDNcwTlNI=
X-Received: by 2002:aca:b2c5:: with SMTP id b188mr2601246oif.163.1582301472380; 
 Fri, 21 Feb 2020 08:11:12 -0800 (PST)
MIME-Version: 1.0
References: <20200218171702.979F074637D@zero.eik.bme.hu>
 <d9d4fba7-2dcf-8f09-8f3a-7e0408c297b6@linaro.org>
 <alpine.BSF.2.22.395.2002211643480.45267@zero.eik.bme.hu>
In-Reply-To: <alpine.BSF.2.22.395.2002211643480.45267@zero.eik.bme.hu>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Feb 2020 16:11:01 +0000
Message-ID: <CAFEAcA-teH7KXACL=5m0-X+g692EXKtqOy9d_uGjw6XA8S3vzA@mail.gmail.com>
Subject: Re: [RFC PATCH v2] target/ppc: Enable hardfloat for PPC
To: BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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

On Fri, 21 Feb 2020 at 16:05, BALATON Zoltan <balaton@eik.bme.hu> wrote:
>
> On Thu, 20 Feb 2020, Richard Henderson wrote:
> > On 2/18/20 9:10 AM, BALATON Zoltan wrote:
> >> +    DEFINE_PROP_BOOL("hardfloat", PowerPCCPU, hardfloat, true),
> >
> > I would also prefer a different name here -- perhaps x-no-fp-fi.
>
> What's wrong with hardfloat? That's how the code refers to this so if
> anyone searches what it does would turn up some meaningful results.

This prompted me to check what you're using the property for.
The cover letter says:
> This patch implements a simple way to keep the inexact flag set for
> hardfloat while still allowing to revert to softfloat for workloads
> that need more accurate albeit slower emulation. (Set hardfloat
> property of CPU, i.e. -cpu name,hardfloat=false for that.)

I think that is the wrong approach. Enabling use of the host
FPU should not affect the accuracy of the emulation, which
should remain bitwise-correct. We should only be using the
host FPU to the extent that we can do that without discarding
accuracy. As far as I'm aware that's how the hardfloat support
for other guest CPUs that use it works.

thanks
-- PMM

