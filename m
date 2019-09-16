Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0728CC49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 17:08:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4962214D9
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 17:08:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="t7loyxUC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4962214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37676 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9uUZ-0007Z5-RY
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 13:08:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50549)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1i9uTa-00075A-7P
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 13:07:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1i9uTU-0003zh-D4
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 13:07:46 -0400
Received: from mail-lj1-x244.google.com ([2a00:1450:4864:20::244]:42847)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1i9uTJ-0003ub-Ez; Mon, 16 Sep 2019 13:07:29 -0400
Received: by mail-lj1-x244.google.com with SMTP id y23so634867lje.9;
 Mon, 16 Sep 2019 10:07:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=D36R4TxC9kabrXw4LckB9IixL5aslsuDDTMAnaEx/ng=;
 b=t7loyxUCDt53/J47VQr+1KckMz5a1DRiZomr3eq7Jow5xw1mHlDni43TBWQZV8lvRT
 cv5kbjqH7TN4QoYYmd1GkBbo1ZATCzQjJ0qlC8sKC7IrEYfWHgatVcq3lYwPPXP2BVsb
 BP1bI9yQWYBX4cnC++3T4M2Mvt0ay/9vjXGkYWN9fUICoXzm86DvF7W29nJHvyAp/rwT
 xYsY4W0cid+AbsmuJChgfGU91ETRRx6fDMOPcJmWvEbCFoB3ymXmOCJPsrqUdkrHL8PT
 JRLyk3wYALGXTm3jJ5vtBswqXrtJlIg45tplUkJoh6u1PWFEL+KYfAb8njvigjMfivkD
 68/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=D36R4TxC9kabrXw4LckB9IixL5aslsuDDTMAnaEx/ng=;
 b=gN70sCnn/EqbA4gFlI1lPmbqG8YcgY1gU0ZEqB81MjJmCRHlFkZN1sopYZZu0U1SXV
 8zex5kYl7XuB/Kl6gkF3WAYbtvZpB0fs0HkniMSdSagRoZsrCLeeuPeANpC4vO7R+KBf
 2NaImxrms1742X3OMu2kg2x/v8jLkoXSxKmH6lhCA+rYf4stb/cM7Xyqq+O5t/k0pXi2
 y7l/KWlUVIwV3pY0Pn3m7pBTG23lssX57z9ZuXOTF8bYsTyYfkRADPRXkRr16F9uSewF
 PNmUbU6Om/sOH2WvIsnV7XFE5ZpK8Gi52zdNEWZ3ReLRhbTXcT9iwlxEIYBF1G+1pyuP
 g3Pw==
X-Gm-Message-State: APjAAAUcrW4spE7kUWag34Xe2u8sYd8WN1VvFhOJzjaE7MuYVnm8B/qU
 m1g7ErGpAuQItWUhIUoDM0UcLeNBumzkJWNtwFw=
X-Google-Smtp-Source: APXvYqzyRgR7ygR3MrnpIq4dYBOkMAtYElG55UWFQ/bNMy+RBHvc5GdAv3m/eyxK+AskwGacXWH3YSwBGRAjp/PZypI=
X-Received: by 2002:a2e:91d9:: with SMTP id u25mr355859ljg.85.1568653647468;
 Mon, 16 Sep 2019 10:07:27 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUhbmUksfEiGLZ0qzsWkaDOaocTvkEYefiSUmGZT7TftYfmEg@mail.gmail.com>
 <mhng-165ebd8f-3595-48d3-a614-79f52d81c14c@palmer-si-x1e>
 <CAEUhbmV=v62a0CAHe2mt1Qzz0n+fESgVYDtjdoXfyhH6_j5zFw@mail.gmail.com>
In-Reply-To: <CAEUhbmV=v62a0CAHe2mt1Qzz0n+fESgVYDtjdoXfyhH6_j5zFw@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Mon, 16 Sep 2019 10:02:56 -0700
Message-ID: <CAKmqyKN3kF3EtKJxQ3iZRaiVrvaBEmkFuX6fsfP7FSbOwpnD3Q@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::244
Subject: Re: [Qemu-devel] [PATCH v8 18/32] riscv: sifive_u: Set the minimum
 number of cpus to 2
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@sifive.com>, "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Sep 15, 2019 at 6:07 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Palmer,
>
> On Sun, Sep 15, 2019 at 3:00 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >
> > On Fri, 13 Sep 2019 08:25:21 PDT (-0700), bmeng.cn@gmail.com wrote:
> > > Hi Palmer,
> > >
> > > On Fri, Sep 13, 2019 at 10:33 PM Palmer Dabbelt <palmer@sifive.com> wrote:
> > >>
> > >> On Fri, 06 Sep 2019 09:20:05 PDT (-0700), bmeng.cn@gmail.com wrote:
> > >> > It is not useful if we only have one management CPU.
> > >> >
> > >> > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > >> > Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> > >> >
> > >> > ---
> > >> >
> > >> > Changes in v8: None
> > >> > Changes in v7: None
> > >> > Changes in v6: None
> > >> > Changes in v5: None
> > >> > Changes in v4: None
> > >> > Changes in v3:
> > >> > - use management cpu count + 1 for the min_cpus
> > >> >
> > >> > Changes in v2:
> > >> > - update the file header to indicate at least 2 harts are created
> > >> >
> > >> >  hw/riscv/sifive_u.c         | 4 +++-
> > >> >  include/hw/riscv/sifive_u.h | 2 ++
> > >> >  2 files changed, 5 insertions(+), 1 deletion(-)
> > >> >
> > >> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > >> > index 2947e06..2023b71 100644
> > >> > --- a/hw/riscv/sifive_u.c
> > >> > +++ b/hw/riscv/sifive_u.c
> > >> > @@ -10,7 +10,8 @@
> > >> >   * 1) CLINT (Core Level Interruptor)
> > >> >   * 2) PLIC (Platform Level Interrupt Controller)
> > >> >   *
> > >> > - * This board currently uses a hardcoded devicetree that indicates one hart.
> > >> > + * This board currently generates devicetree dynamically that indicates at least
> > >> > + * two harts.
> > >> >   *
> > >> >   * This program is free software; you can redistribute it and/or modify it
> > >> >   * under the terms and conditions of the GNU General Public License,
> > >> > @@ -433,6 +434,7 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
> > >> >       * management CPU.
> > >> >       */
> > >> >      mc->max_cpus = 4;
> > >> > +    mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
> > >> >  }
> > >> >
> > >> >  DEFINE_MACHINE("sifive_u", riscv_sifive_u_machine_init)
> > >> > diff --git a/include/hw/riscv/sifive_u.h b/include/hw/riscv/sifive_u.h
> > >> > index f25bad8..6d22741 100644
> > >> > --- a/include/hw/riscv/sifive_u.h
> > >> > +++ b/include/hw/riscv/sifive_u.h
> > >> > @@ -69,6 +69,8 @@ enum {
> > >> >      SIFIVE_U_GEM_CLOCK_FREQ = 125000000
> > >> >  };
> > >> >
> > >> > +#define SIFIVE_U_MANAGEMENT_CPU_COUNT   1
> > >> > +
> > >> >  #define SIFIVE_U_PLIC_HART_CONFIG "MS"
> > >> >  #define SIFIVE_U_PLIC_NUM_SOURCES 54
> > >> >  #define SIFIVE_U_PLIC_NUM_PRIORITIES 7
> > >>
> > >> This fails "make check", so I'm going to squash in this
> > >>
> > >> diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> > >> index ca9f7fea41..adecbf1dd9 100644
> > >> --- a/hw/riscv/sifive_u.c
> > >> +++ b/hw/riscv/sifive_u.c
> > >> @@ -528,6 +528,7 @@ static void riscv_sifive_u_machine_init(MachineClass *mc)
> > >>      mc->init = riscv_sifive_u_init;
> > >>      mc->max_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + SIFIVE_U_COMPUTE_CPU_COUNT;
> > >>      mc->min_cpus = SIFIVE_U_MANAGEMENT_CPU_COUNT + 1;
> > >> +    mc->default_cpus = mc->max_cpus;
> > >
> > > Thank you for fixing the 'make check'. Shouldn't it be:
> > >
> > > mc->default_cpus = mc->min_cpus;
> >
> > We have 5 harts on the board that this matches, so I figured that'd be the
> > better default.
> >
>
> Per my understanding mc->default_cpus is used when invoking QEMU
> without passing '-smp n' (that's what 'make check' uses), and with the
> updated sifive_u machine, '-smp 2' is the actual useful configuration
> to boot Linux. For consistency with user experience on other machines,
> without '-smp' means we want a uni-processor machine hence I would
> suggest we set "mc->default_cpus = mc->min_cpus".

Agreed!

Alistair

>
> Regards,
> Bin
>

