Return-Path: <SRS0=ZEKs=WJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 645BFC32750
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:56:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2953F2067D
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Aug 2019 16:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QGT8qPFE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2953F2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54402 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxa6A-0006QA-G2
	for qemu-devel@archiver.kernel.org; Tue, 13 Aug 2019 12:56:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33098)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hxa5i-0005hj-Fd
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:56:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hxa5h-0004so-IZ
 for qemu-devel@nongnu.org; Tue, 13 Aug 2019 12:56:10 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:34658)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hxa5e-0004ng-Ip; Tue, 13 Aug 2019 12:56:07 -0400
Received: by mail-lj1-x244.google.com with SMTP id x18so5752756ljh.1;
 Tue, 13 Aug 2019 09:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D358X566ZgimjRC7oywqd1XTNsDgIhkfhz7vsMsGqcs=;
 b=QGT8qPFEiDDZr19GkwzbZBbsNl6wAvSOD6un1esyR2dLAZxEZzQ6hn3FaMewoD0Io2
 B/UQp8T0MQ8JVK4IRZIt4laMyTW3zx2qesprnqaoTlGnftFAKvX8iee8cZ4zcpK6maRa
 WX3RFYI3mfQcmnrabBeaRLDqPnO0XteA+gTjmnHnJNJyWIXia9fEDQv/x0QbTE5NW40j
 p+9hQN1moNFhMFh56w1m9Z4WSzGk63IJyxnL9473CMEZQuQgM+sbnTdAlNTx2F6YCTGy
 MxhsTQeDxbVkF4VjPT67fRbgZPCy9KStnbC1/O66ruLjQKcP/cta3HAXb63uCrBUdQoT
 LgzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D358X566ZgimjRC7oywqd1XTNsDgIhkfhz7vsMsGqcs=;
 b=S4p62J6ZN3CReSQco82GGnAdoWIl3ZZASpyvsjMu1w/7FtPI4kIugNYwd9bc/pTVxK
 nYMpKmXdbS0VQs8pi/Ss+W0/zEJq+ZUxwMQoTR5xN0fhtbWGY7aHpZS/ZGWRmYD8hjuI
 W3qgTVJTFnuTWmFbZYqDY7kz8NCrzEk6e5ozZE1aTPZp4UhzzqIjmanuO5CYEpKXqlp2
 dH+2kyI2WrBsdwVELQLiufAhaactJKPOWXeqdf6Ud7FEgdqUCcg9iMa4Tg23JOajx27u
 2/RN3sZkp5sLbXmB8zw0JbGYARQtHsC5nx3yvGhzPMm49h1+ZJ8CymDm4Gg2JOxNWknT
 qkIw==
X-Gm-Message-State: APjAAAXAuVsjF3kDouBEjgmidE/nY6QuIDAPosrR722rlIE4J9JNTKgn
 JANEj30mshv6BR871Zrv7ZH8J2NVQMbuhqM10j4=
X-Google-Smtp-Source: APXvYqzLYKVEGeXpbxdkAKlbhKWcatWxy8IKprfvStMSyVmiUFlDAXCOM8bfTV3s7lfCJGy0lTcwXY3UASf6E0zR48w=
X-Received: by 2002:a2e:a202:: with SMTP id h2mr2641072ljm.146.1565715364751; 
 Tue, 13 Aug 2019 09:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <1564812484-20385-1-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKPW-nMc2zV-VwG_sY9ca7uSenUJW+mEcV2qaKT5dELmgA@mail.gmail.com>
 <CAEUhbmWwkMR4xKu9v=10ePj=feJ7b7e5Ko75zv1xMBf+JrVwwA@mail.gmail.com>
 <CAFEAcA91uvheC1gdu7DZSkaVtgA3Laoob6G+bQMQOdfsQj9aSA@mail.gmail.com>
 <CAFEAcA-J_QHUX4cnrTgtKLrRmOtBwzEP1fg1HTjWP5geENw50A@mail.gmail.com>
In-Reply-To: <CAFEAcA-J_QHUX4cnrTgtKLrRmOtBwzEP1fg1HTjWP5geENw50A@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 13 Aug 2019 09:52:13 -0700
Message-ID: <CAKmqyKNFTFjzHpt5YewksjW=eEZp+A=tmrcb3AynXK56e0tLXg@mail.gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [FOR 4.1 PATCH] riscv: roms: Fix make rules for
 building sifive_u bios
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
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>, Bin Meng <bmeng.cn@gmail.com>,
 Laszlo Ersek <lersek@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Aug 13, 2019 at 6:00 AM Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Mon, 12 Aug 2019 at 09:38, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Sun, 11 Aug 2019 at 08:17, Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Hi Palmer,
> > >
> > > On Tue, Aug 6, 2019 at 1:04 AM Alistair Francis <alistair23@gmail.com> wrote:
> > > >
> > > > On Fri, Aug 2, 2019 at 11:08 PM Bin Meng <bmeng.cn@gmail.com> wrote:
> > > > >
> > > > > Currently the make rules are wrongly using qemu/virt opensbi image
> > > > > for sifive_u machine. Correct it.
> > > > >
> > > > > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > > >
> > > > Good catch.
> > > >
> > > > @Palmer Dabbelt can you take this for 4.1?
> > > >
> > >
> > > Is this patch merged for 4.1? Thanks!
> >
> > Sorry, it doesn't look like it is, and it's now missed the
> > deadline for 4.1 (only critical showstopper bugs and security
> > issues would go in at this point).
>
> Since a very late ppc pullreq turned up which needed to also go into
> rc5 and meant we couldn't just have a single-change rc, I figured this
> was safe enough to also apply for rc5, so I've put it in.

Thanks Peter!

Alistair

>
> thanks
> -- PMM

