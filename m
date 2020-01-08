Return-Path: <SRS0=peXq=25=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16EF5C00523
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:56:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DA26D20692
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2020 10:56:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zXMwK1G8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DA26D20692
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41872 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ip90f-0005cD-0w
	for qemu-devel@archiver.kernel.org; Wed, 08 Jan 2020 05:56:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33005)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ip8zm-0004yJ-EG
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:55:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ip8zk-0008SL-EW
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:55:26 -0500
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:33728)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ip8zi-0008PE-VB
 for qemu-devel@nongnu.org; Wed, 08 Jan 2020 05:55:24 -0500
Received: by mail-oi1-x244.google.com with SMTP id v140so2276278oie.0
 for <qemu-devel@nongnu.org>; Wed, 08 Jan 2020 02:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=hdHIjDHFWes/iN6CC2+ZdbXk+OaHyY6NCif2+zwOdu0=;
 b=zXMwK1G8bOpZLD55iCugOu27YxCOCxuKLxCTA+LH8kKG+UzgGtkBO6ucMlUEw21dcj
 shZl5WWkrxmWuNdzHP1SLOe6Ttp1jA2HUMhDd3V5M4Lw86xMJdMjoxmM38veeOZpV5ti
 LFr7mDrEZuytCC40lwd3WuNUnveIyTNtF8B/ygjxyaGEXe+Jc4Kla0EQwtFMeet3FqW5
 UlMiSQ7fui7WF+N76Z2Q+Qa+iQwRf8tONyPBnv8lOLgtv8BNrO1cveLB46ndxpuOxSgA
 KyyoKZQw47Tyd4chvTc6/XQoI1EweWedTg15jeZ2a3P1CmZ0/nbgcgLDqcE5wG6H4wdA
 h7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hdHIjDHFWes/iN6CC2+ZdbXk+OaHyY6NCif2+zwOdu0=;
 b=AVewK/03+hUkiTqrlo0YFM2FyMpyDLMQl3YRYKJn8CBkoTW2bhXdGYc+icUtzktWQH
 ODBaZbiSTQgP5Kw7Du5Yiwujnmkpj42jPxuvsCLudCmCaXWBa9D67cKx4YLmcfYdzKLV
 ZLqFWEDM9eyj2+Lbssru8hLSWUxLllg9rY9CbsamtbDeiZOi+A9hlQSp4Aivv9XSWaxg
 tBlqGIZEEYrZm2CO4gH5q2XuCkBNDx/OTEtx+yi0aeq5dZFMiF5n0oXRyzc1t1OwZZPS
 t1RXCmfYCi0IA/c+onkjU1l9z87FLxftSacKjA3edsUbmNdc+i2mi7RB/kiRjzSoavdw
 RYWg==
X-Gm-Message-State: APjAAAWEo08GZoN1sv87B8QMwoD9BoV9aQ1OU4KpqcKQm3G2/iH+ZaI1
 95Jnv+tYv2Mnj0vG2bX87DCug1vQs6KXMjiN4FooMw==
X-Google-Smtp-Source: APXvYqyT5Do074NyeHZ0J3E+WxbW6v7zzy/AcoPfAL1I88fUfGfl457CorhSVAMnIMxDQ6yCjzCAcBgGKxeiIYGmObc=
X-Received: by 2002:aca:3182:: with SMTP id x124mr2620548oix.170.1578480921409; 
 Wed, 08 Jan 2020 02:55:21 -0800 (PST)
MIME-Version: 1.0
References: <20191220202707.30641-1-beata.michalska@linaro.org>
 <20191220202707.30641-2-beata.michalska@linaro.org>
 <CAFEAcA-M=P=-6t5RX0bdO-8fbcd-_Ar_aBNskzs49aspvZ0+7Q@mail.gmail.com>
 <CADSWDzu3jVj7kmcmLwY7D_j2ErN4S2G82ZKMzTsScqanHV=MzQ@mail.gmail.com>
In-Reply-To: <CADSWDzu3jVj7kmcmLwY7D_j2ErN4S2G82ZKMzTsScqanHV=MzQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 8 Jan 2020 10:55:10 +0000
Message-ID: <CAFEAcA88-PYBf5nOpCdtt24SG-CDb4rT06iYzaBou5oiyif_Ww@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] target/arm: kvm: Handle DABT with no valid ISS
To: Beata Michalska <beata.michalska@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::244
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Christoffer Dall <Christoffer.Dall@arm.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 7 Jan 2020 at 21:37, Beata Michalska <beata.michalska@linaro.org> w=
rote:
>
> On Tue, 7 Jan 2020 at 14:28, Peter Maydell <peter.maydell@linaro.org> wro=
te:
> > Another thing that occurred to me last night -- why do we need
> > to do this adjustment of the PC/r15 ? If this is the kernel
> > handing control to userspace to say "this is not an instruction
> > I can handle, maybe you'd like to try" then surely it should
> > do so with the PC pointing at the offending instruction?
> > Similarly, if we ask the kernel to inject a data abort I
> > would expect that the kernel would do the work of adjusting
> > the PC forwards as the architecture requires when taking
> > the exception.
> >
>
> The code here is just for easing debugging from Qemu perspective
> and that is the only reason why we even try to read the value of PC
> - it is not in any way needed by kernel to inject the abort.
> One can use the monitor to decode the instruction, provided it is still
> available at the memory location pointed by PC (handy monitor_disas)
> - that is why logging the address with decoded instruction,
> as it is the only thing that is being done here. Still the address of act=
ually
> executed instruction for ARM would be PC=E2=80=938 (PC=E2=80=934 for Thum=
b)
> that's why the adjustment.

My point is that the kernel hasn't actually executed the instruction,
though -- that's why it's given us control. It seems a bit exposing
of the underlying hw mechanism for the kernel to hand control
back to userspace with the vcpu state in a sort of half-way-through
situation, rather than cleanly rolling it back to "this insn has not
executed at all yet".

thanks
-- PMM

