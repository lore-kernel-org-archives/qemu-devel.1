Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A961EC2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74B5120674
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 10:20:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ldRQG9DW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74B5120674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55756 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyvJL-0002ij-Mw
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 05:20:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47023)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iyvIm-0002Ai-CV
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:19:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iyvIj-0006dy-U2
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:19:28 -0500
Received: from mail-ot1-x32f.google.com ([2607:f8b0:4864:20::32f]:35206)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iyvIj-0006ax-Oh
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 05:19:25 -0500
Received: by mail-ot1-x32f.google.com with SMTP id r16so16625051otd.2
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 02:19:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=173IdKyuuI89MlenTQig4Cm50YKLpdBC0Tfd6V3LhG4=;
 b=ldRQG9DWno3iJVniCk4hzZsvZzno4i9D04ExMqxJdNGHRvAruSm9SBqrgbViUQxDyu
 L22x6jhRh2nRYntDPUknzpUR3j6fqKa5NFpk8WikCovYy2fXTpMMMqVgH2uH6UXBxodv
 NlmzUhGbWLsX3mAVmpD04Skqi+ah7Zfvau+XLDNE5hDmj9tBFonT9yecArwrJYPJReNH
 o1MJQsL2eolBIoRmtYxT1Sxx7fAy3MX83gWaDxnTOt11pZusmZYMaP1FRGYey9Wm7iBZ
 v3wTRb+GCtEpZW1WaNmQP9Eybw7kzFdEKC618gLdnkBmRfQY5Gk+yfeoZcc4Hj6i3pYA
 26Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=173IdKyuuI89MlenTQig4Cm50YKLpdBC0Tfd6V3LhG4=;
 b=qlyzOnv0IHQZwWUr6SLHgZMx0uE1VZbHIaEZyumVZBxJHm7og5pPk4IMTYqHFu3eR+
 /T01KU7eeGBDs92UBqRkTB2g0Q1noRg7eL6BGRAHVU8GOxEizYS9FAtTM/2zW8ye3EFU
 qfS/bB1air4w2o3CDw12nf0vNjRK3ZPNGn98knypm82Z2o9sQD71VKYYpH0udPy4bxdC
 EGFZkU31cVgEGyF4vFiwzPIdBMooNHdVBKJeipG1hLavieRTJtL9liIlEg2j5aZ9nxzx
 ir3enrui1L+V8MQZg/DRAvoyijXYC1FoBwFBASOe27SokXeF/dEjf1OGkhFDRUck1sSQ
 foiw==
X-Gm-Message-State: APjAAAU/gTt+bCfLp/SnVheLedO4+XNSCWaoaSzHR8VFBRpW7tf9Idjd
 o5pZjAKeOCorbxhrVsJ6bBcAY80Op040e1AkcVoF/1WP
X-Google-Smtp-Source: APXvYqyClzNX/MX9KEjDwPEUlRnOpvUDxkNS4nXZtDZ7MPgSW2fPHQcOqwr8CmAh/zZe8Skt+0aPivQ2kNdApvrs7Gc=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr21777299otd.91.1580811564678; 
 Tue, 04 Feb 2020 02:19:24 -0800 (PST)
MIME-Version: 1.0
References: <CAM2K0nr7+6NRW6CRYRdejS_BPjizV5yX7ykfctEFTyPzh=kSVA@mail.gmail.com>
 <CAFEAcA_0RxRUkmU3YGCF2RXmJu=vP1D8SQunhdPdwW88oreCvQ@mail.gmail.com>
 <CAM2K0nq1xw9XnJuCJD83vWx1DXi3DrHh8ku0d=0Ny6E6WNqJNA@mail.gmail.com>
In-Reply-To: <CAM2K0nq1xw9XnJuCJD83vWx1DXi3DrHh8ku0d=0Ny6E6WNqJNA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Feb 2020 10:19:13 +0000
Message-ID: <CAFEAcA_D-L6cshvr=VuSsvwAkW6hQpNVKVv7e32c1NE7sTkHzQ@mail.gmail.com>
Subject: Re: Need help understanding assertion fail.
To: Wayne Li <waynli329@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32f
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 3 Feb 2020 at 21:32, Wayne Li <waynli329@gmail.com> wrote:
>
> I see.  So you're saying that it might be possible that my guest could be=
 generating TCG ops that can't be translated into PPC instructions because =
the displacement value is to big.  While the same TCG ops can be translated=
 into x86 instructions because x86 allows for a bigger displacement value. =
 But on the other hand it could be some other problem causing me to have a =
large displacement value.
>
> In that case, I think it'd be super helpful if I print out this displacem=
ent value in the TCG ops when running on PPC versus x86 because they should=
 be the same right?  What option in QEMU -d allows me to see generated TCG =
ops?  Doing a -d --help shows the following options:

> There doesn't seem to be any option to print out the TCG ops specifically=
?  Maybe I'll have to go into the code to add print statements that print o=
ut the TCG ops?

'op' prints out the ops...

Note that in the TCG ops output there won't be a displacement value, becaus=
e
that is calculated in the TCG backend. At the ops level, the branches are t=
o
labels. But you'll be able to see if you're generating a super-enormous blo=
ck
really easily, because it'll have lots of ops in it. (See also the advice i=
n
tcg/README about generally preferring to use calls to helper functions
rather than directly generating more than about 20 TCG ops
for any one guest insn, and the overall MAX_OP_PER_INSTR limit).

thanks
-- PMM

