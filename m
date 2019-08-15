Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69370C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:49:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2E715206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 21:49:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A/3zwQid"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2E715206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47488 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyNcO-0005Gt-D3
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 17:49:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60893)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1hyNVL-0006cO-Ba
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:41:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hyNVJ-0008U6-S0
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 17:41:54 -0400
Received: from mail-lj1-x243.google.com ([2a00:1450:4864:20::243]:39521)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hyNVF-0008Rt-Ce; Thu, 15 Aug 2019 17:41:49 -0400
Received: by mail-lj1-x243.google.com with SMTP id x4so3506849ljj.6;
 Thu, 15 Aug 2019 14:41:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=mpzB4QzWmrsVeeBHmrRO/WNE0c5CLLv1hTvhcVikB4s=;
 b=A/3zwQidzMhR7Tr5pZegryyE38yRZiJNfTRGbEb7vEfLg6KJ0LOnhYEX7tT4UeANQn
 VOQn3KKYg2SnBsDbr12qrpBzAx7/c42/EA3TAVEidYcxo8et8PzLDdrn06ZT7U8dwrbg
 lxxDdxBlt0vWs8/8hpbs7izx9eJzuuqPeqXnzbSdKwutTXJEVuamOVw317p38sf1JfM7
 KtnH7NqCKi30NttCfMDYvKrTcKeJTJbudY6TSRpY/3/x9ZApVsLB4x6mtQBQIKuWy8HB
 ZKery89ulACNoBPR0zP/IdbfiRRV/QzHzUQtJfu7Al6I6+uEPI9p2gp3fUU+Cfk0Gk5t
 SesA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=mpzB4QzWmrsVeeBHmrRO/WNE0c5CLLv1hTvhcVikB4s=;
 b=tXA/drSwbqD5oS5hpmbhkv3DhXgmfZpDQWipFJqqUsd0axX4sfOmsjGJu48tvfUzxH
 QXrkfSvw7tlmtKCvJASClf+/PuMItZwTZZDsSgNzeKHPtL96rmMffiXYQ8WTG5emCGZM
 WnV5DJkOeEIR7yLS6MVBuSiR8unUrPbzsDN5m7ffIG+6zDNXqrgD/N/yQRblZmT2Shae
 doI9DH2oq5Ztw/+qlmQRaYoBG2QdIvzLI+F6Oghm584RyEo+MSMPvUad4MH0hd5pgO4C
 6KRD4u14k0i7+vGynMEjkgzaKWA0tJLXYLOhqLLDw+vbmSJSgAPZ90OL9ALzCxLfl2/O
 K9fw==
X-Gm-Message-State: APjAAAXpTNUXEI/93oRn7pP1bkrrFn+Xvu80VOX5a+J0HDr6WvxIw5Q2
 XIpLjbwcehizIe7qKHv0jAyqTI7jCRmFt4qM720=
X-Google-Smtp-Source: APXvYqyp2xcTt+mGhvjKglsdioB01Mv74JsBI8e1onvbpxCOSvvDU841enpFwUqjdHDQBeRThNDFVge5AppgknhD4SU=
X-Received: by 2002:a2e:a202:: with SMTP id h2mr3723716ljm.146.1565905307701; 
 Thu, 15 Aug 2019 14:41:47 -0700 (PDT)
MIME-Version: 1.0
References: <97a6ae9f-2845-4a3c-2a31-367787622268@c-sky.com>
 <CAKmqyKMqCKS_-rxZ2WYEn+m2gDom27rd2f2FCe0LmVs9brPcAQ@mail.gmail.com>
 <c502163b-ed8a-89d1-6437-9b0f49e88a84@c-sky.com>
 <CAKmqyKM5zneojhPe57h1+h3pav5kQxFaMnhNiwWRUa=nbzS3Ag@mail.gmail.com>
 <CAL1e-=hVLQWThYSm78bTCbQPfAABjx_rG9nEa9gV6PvSN8ge2w@mail.gmail.com>
 <CAFEAcA9bDU4AWetkR4w4WLUzMW_MMy0CsVa5SibWqf85RyaX5g@mail.gmail.com>
In-Reply-To: <CAFEAcA9bDU4AWetkR4w4WLUzMW_MMy0CsVa5SibWqf85RyaX5g@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Thu, 15 Aug 2019 14:37:52 -0700
Message-ID: <CAKmqyKM44ZAHgc5cYAiAXXtVG=dMcX1i7FLn+2mMwM1Av4Gqzg@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::243
Subject: Re: [Qemu-devel] RISC-V: Vector && DSP Extension
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>, bastian@mail.uni-paderborn.de,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, LIU ZhiWei <zhiwei_liu@c-sky.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Aug 15, 2019 at 2:07 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Thu, 15 Aug 2019 at 09:53, Aleksandar Markovic
> <aleksandar.m.mail@gmail.com> wrote:
> >
> > > We can accept draft
> > > extensions in QEMU as long as they are disabled by default.
>
> > Hi, Alistair, Palmer,
> >
> > Is this an official stance of QEMU community, or perhaps Alistair's
> > personal judgement, or maybe a rule within risv subcomunity?
>
> Alistair asked on a previous thread; my view was:
> https://lists.gnu.org/archive/html/qemu-devel/2019-07/msg03364.html
> and nobody else spoke up disagreeing (summary: should at least be
> disabled-by-default and only enabled by setting an explicit
> property whose name should start with the 'x-' prefix).

Agreed!

>
> In general QEMU does sometimes introduce experimental extensions
> (we've had them in the block layer, for example) and so the 'x-'
> property to enable them is a reasonably established convention.
> I think it's a reasonable compromise to allow this sort of work
> to start and not have to live out-of-tree for a long time, without
> confusing users or getting into a situation where some QEMU
> versions behave differently or to obsolete drafts of a spec
> without it being clear from the command line that experimental
> extensions are being enabled.
>
> There is also an element of "submaintainer judgement" to be applied
> here -- upstream is probably not the place for a draft extension
> to be implemented if it is:
>  * still fast moving or subject to major changes of design direction
>  * major changes to the codebase (especially if it requires
>    changes to core code) that might later need to be redone
>    entirely differently
>  * still experimental

Yep, agreed. For RISC-V I think this would extend to only allowing
extensions that have backing from the foundation and are under active
discussion.

Alistair

>
> thanks
> -- PMM

