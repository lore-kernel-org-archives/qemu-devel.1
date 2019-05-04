Return-Path: <SRS0=Uyhh=TE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3081C43219
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 05:26:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE689206BB
	for <qemu-devel@archiver.kernel.org>; Sat,  4 May 2019 05:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jLxelOe2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE689206BB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51392 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hMnBr-0001V6-27
	for qemu-devel@archiver.kernel.org; Sat, 04 May 2019 01:26:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38013)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hMnB8-00013B-5o
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:25:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alistair23@gmail.com>) id 1hMnB6-0004ck-Px
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:25:42 -0400
Received: from mail-lj1-x241.google.com ([2a00:1450:4864:20::241]:36402)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alistair23@gmail.com>)
	id 1hMnB6-0004c5-1B
	for qemu-devel@nongnu.org; Sat, 04 May 2019 01:25:40 -0400
Received: by mail-lj1-x241.google.com with SMTP id y8so6678234ljd.3
	for <qemu-devel@nongnu.org>; Fri, 03 May 2019 22:25:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:references:in-reply-to:from:date:message-id:subject:to
	:cc; bh=7eACfNRIVjwruczcDOFdl73676OC+RlOp47EoiGzApo=;
	b=jLxelOe2g0eNiJg0RDwIgx86vRJFVT8uZCKNhcYZqHwcAKWzb264Nswpv3dq23F6s2
	6nJeKxcLZuWj96iGhv0qhyMGAF/Dyro+By/lFX2N2bFV0UVLh1ONSfopasme7DgRc7T9
	g+aoUyOXpvQLSyGxHUSbduqKRHR5oFQvN2z3m2conwTr5ncVuOWTOki4iCiBBbF5sJxk
	sFPXWgp11R4AxzndrRqL4Z7B86/4E143Iw9yaP8uErfz3wf3/9pn1adDOR8mxPnediLp
	/BqZSfmu1bfzqsfhq5Bnx8fLFI94lbvENS2XUw1r5F7ECcWHi7TTiZpCgv18fFg1goQP
	oong==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=7eACfNRIVjwruczcDOFdl73676OC+RlOp47EoiGzApo=;
	b=GNZ67qCs+GYav8YjzW/1Fdhcww4QniaEjhGlUbfgo+OSHuP1SlpGk6GKDKSGFFkN9E
	VhPCCo1RFggt8L5Npx0Vtc+TICDbSGXePx5fvFhnhJBlQIanSvgRtpvrCfVM/4ykn2Kd
	HsOB+CHdTiOJ9oH2m1YIhcf3+wSQcOK07sGV4ydz2xMDlo0uDUnV84Br/9Nvjws3lHtp
	LgKr2EEmjrUABBsTePYzreyYYV97HBQTjxbRNUVsiqCRWWpaGmShCXbpIi3wOfxg81K/
	uSMRcdRGa9I0pMHT/fKD6abcz4vSAUQNCWgJrYs6Qg8gT36YZoGLlrjxxfak+7lHiWVe
	p0sw==
X-Gm-Message-State: APjAAAXIdp+QNZppWhkbAmDpSS9kh0zpp8sMwdJwap85cPGQqRVqvdTK
	NZ/RBM8F21+jDEk6UIlaIu8Oc0Azgz7iciSE2hu1qkAtXTQ=
X-Google-Smtp-Source: APXvYqxM135BoqqlObQ13F1gILDu0fgrTbbltnMohyzPDsX+FlR9kswKIKTdxRwn0KzNeYH84mRbYznMN47ADUGQk0E=
X-Received: by 2002:a2e:5ce:: with SMTP id 197mr7262657ljf.140.1556947537647; 
	Fri, 03 May 2019 22:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1556515687.git.alistair@alistair23.me>
	<PSXP216MB02771957D4B9C5A15914D05FDD390@PSXP216MB0277.KORP216.PROD.OUTLOOK.COM>
	<CAFEAcA86i3aZx-h2ys5kmc35AMqzd6k=JrfVXObdbcppnn-J8w@mail.gmail.com>
	<CAKmqyKMM0QHgdS3Z9Fd13XjeFsiG1UnZYz5brdjJgnbHXmxBrQ@mail.gmail.com>
	<CAFEAcA-dZ5qdh58QCmX+t2RpJim8Fu9FY0UBY1tMpQOHkG06mA@mail.gmail.com>
	<97245929-a8b5-4b67-bfee-656db4438cd0@www.fastmail.com>
In-Reply-To: <97245929-a8b5-4b67-bfee-656db4438cd0@www.fastmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Fri, 3 May 2019 22:25:11 -0700
Message-ID:
 <CAKmqyKOhfjwO+8UBj+-RiZiYUHM7LeDeJk+cmXfuKd5psowP3A@mail.gmail.com>
To: Alistair <alistair@alistair23.me>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::241
Subject: Re: [Qemu-devel] [PATCH v1 5/5] hw/arm: Add the Netduino Plus 2
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190504052511.g64TfV3YFH3xgKbOHioX5rJxC1nVU0sVXgU48btOF80@z>

On Fri, May 3, 2019 at 9:26 PM Alistair <alistair@alistair23.me> wrote:
>
> On Thu, May 2, 2019, at 3:06 AM, Peter Maydell wrote:
> > On Tue, 30 Apr 2019 at 21:29, Alistair Francis <alistair23@gmail.com> wrote:
> > >
> > > On Tue, Apr 30, 2019 at 9:02 AM Peter Maydell <peter.maydell@linaro.org> wrote:
> > > > Can you explain the purpose of the reset code? None of the other
> > > > v7m boards seem to need to do a manual qemu_register_reset().
> > >
> > > The reset code allows the machine to work with the -kernel option.
> > > Without the reset override using -kernel results in the guest starting
> > > at the wrong address. We can use the -device loader option without the
> > > reset code though.
> >
> > That sounds in line with how -kernel works on the other armv7m
> > boards -- the expectation is that your image file includes a
> > full vector table and the CPU will read the PC and SP from it
> > when it resets. If you want "honour the entry point" you can
> > use -device loader, as you say.
> >
> > Ignoring the entry point for -kernel ELF files is certainly
> > a bit confusing, but I think if we want to change this we should
> > do it globally, rather than having one board which behaves
> > differently to the rest. Changing it does have some awkwardness:
>
> Hmm... That is a good point. It is confusing having something just for one board. I'll drop this part and we can re-evaluate later.
>
> > * possibility of breaking previously working images
>
> I have no way to test the other boards, so this might be difficult to change.
>
> > * we can get the initial PC from the ELF entrypoint, but if
> >  we do this what do we do about the initial SP value ?
>
> Not sure about this one either. I'm guessing it changes between the different M cores.

Ah, it seems like -device loader doesn't work, it looks like not
setting the thumb register causes this core dump:

qemu: fatal: Lockup: can't escalate 3 to HardFault (current priority -1)

R00=20000000 R01=00000574 R02=200015d0 R03=200015d0
R04=00000000 R05=00000000 R06=00000000 R07=00000000
R08=00000000 R09=00000000 R10=00000000 R11=00000000
R12=00000000 R13=ffffffe0 R14=fffffff9 R15=0800cba4
XPSR=61000003 -ZC- T handler
s00=00000000 s01=00000000 d00=0000000000000000
s02=00000000 s03=00000000 d01=0000000000000000
s04=00000000 s05=00000000 d02=0000000000000000
s06=00000000 s07=00000000 d03=0000000000000000
s08=00000000 s09=00000000 d04=0000000000000000
s10=00000000 s11=00000000 d05=0000000000000000
s12=00000000 s13=00000000 d06=0000000000000000
s14=00000000 s15=00000000 d07=0000000000000000
s16=00000000 s17=00000000 d08=0000000000000000
s18=00000000 s19=00000000 d09=0000000000000000
s20=00000000 s21=00000000 d10=0000000000000000
s22=00000000 s23=00000000 d11=0000000000000000
s24=00000000 s25=00000000 d12=0000000000000000
s26=00000000 s27=00000000 d13=0000000000000000
s28=00000000 s29=00000000 d14=0000000000000000
s30=00000000 s31=00000000 d15=0000000000000000
s32=00000000 s33=00000000 d16=0000000000000000
s34=00000000 s35=00000000 d17=0000000000000000
s36=00000000 s37=00000000 d18=0000000000000000
s38=00000000 s39=00000000 d19=0000000000000000
s40=00000000 s41=00000000 d20=0000000000000000
s42=00000000 s43=00000000 d21=0000000000000000
s44=00000000 s45=00000000 d22=0000000000000000
s46=00000000 s47=00000000 d23=0000000000000000
s48=00000000 s49=00000000 d24=0000000000000000
s50=00000000 s51=00000000 d25=0000000000000000
s52=00000000 s53=00000000 d26=0000000000000000
s54=00000000 s55=00000000 d27=0000000000000000
s56=00000000 s57=00000000 d28=0000000000000000
s58=00000000 s59=00000000 d29=0000000000000000
s60=00000000 s61=00000000 d30=0000000000000000
s62=00000000 s63=00000000 d31=0000000000000000
FPSCR: 00000000
Aborted (core dumped)

Alistair

>
> Alistair
>
> >
> > thanks
> > -- PMM
> >
> >
>

