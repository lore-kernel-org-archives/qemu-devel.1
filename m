Return-Path: <SRS0=60Ee=WH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A4EC0650F
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 17:07:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC8D2087B
	for <qemu-devel@archiver.kernel.org>; Sun, 11 Aug 2019 17:07:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vkhh7RIn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC8D2087B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41040 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hwrJH-0004c4-TP
	for qemu-devel@archiver.kernel.org; Sun, 11 Aug 2019 13:07:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58128)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hwrIu-0004BU-Cn
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 13:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hwrIt-000459-9b
 for qemu-devel@nongnu.org; Sun, 11 Aug 2019 13:06:48 -0400
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:39564)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hwrIt-00043i-22; Sun, 11 Aug 2019 13:06:47 -0400
Received: by mail-lf1-x144.google.com with SMTP id x3so18999278lfn.6;
 Sun, 11 Aug 2019 10:06:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=fefee5hj4qCMqseaumEjOrmmk7cuIpcvE7QrGs/7DlA=;
 b=Vkhh7RInR08PRbc1TrQrL6fv0kp1fFoqVw+oQlrR/elafQbhpQmTSdMmDNykiL7xnT
 FK4f9rynVpbX7A8TICyxUOaymiNjXaZZAomx2zjbgy/tUX82SBCehBew4vzro/kx65Cj
 UvMhEz5tpgNFEK4eKvnPZGHT/86fnx3CKWofdPvQTtZtGTtL4529EIkmS+JgYXcg5QHl
 D3GIQeqKogPTEL5/gX1C264G9XdmZ2a1nfFhEmdbbO9PTLJyuVXjbu4mwPY3qw0d69uP
 /rjup/Sz/bnbbZGcXYnPwREt3/nQn1YJVlpuU1fgFgJW7k/2LSyMvrwnpeYEtwOAO8lw
 mzTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=fefee5hj4qCMqseaumEjOrmmk7cuIpcvE7QrGs/7DlA=;
 b=ECeTYihILLWkS18i5Kj/nxWBDoC6zTRgvLHB9nZptVS1SGtxwREpA6H7KcvSrB1Uud
 ayqxVOKfPzjOg4sXEniDklB+HEVLUb7aT7GqDxbz9afppDPdTkrvWUvhEr0su7NP3hiK
 35rD/1iQRtmOouvehV6rD6pZZeUHVBGlYM8HV70Nl4ooh/0+1Cb2kc7GkKr9Okz3by9N
 3u9GwdawGE+tUqkG9mPHc4rphBv921lrcISRpJ8hQb1Rq2AH6jfgTDGmBOxAX2F4epxK
 ldWWOooE1hPyhLEe8TqOXk9doJ1wm9eSEowOyqz+3EVlCSEY3O7z+d1C2Gups/R0Xqch
 N2VA==
X-Gm-Message-State: APjAAAVYcC9JQ2ahSXh48wmfCa+XWKMHmf4FQ6chL021lFhNLJWyblSR
 BW665GAASctVvV7Kv1KFGxuE2NHNemCNavyc60I=
X-Google-Smtp-Source: APXvYqwmuclqWTwsQpuGAnEDoPyb4ProEPxzhMJx8UrZJTiftOlpbBbSZ6PMvPpoRBg49nr5d+5lADc2aUR3/D7DwIg=
X-Received: by 2002:ac2:563c:: with SMTP id b28mr17488780lff.93.1565543205259; 
 Sun, 11 Aug 2019 10:06:45 -0700 (PDT)
MIME-Version: 1.0
References: <1565163924-18621-1-git-send-email-bmeng.cn@gmail.com>
 <1565163924-18621-12-git-send-email-bmeng.cn@gmail.com>
 <CAKmqyKOH-M5UK3EDpzpK3yQPSzvu+tafDiMk0FNx8KmLQktk+Q@mail.gmail.com>
 <CAEUhbmWENVV+DzX756OCUGYc5ES-aCdD8tpSoVoPspniuiGh2A@mail.gmail.com>
In-Reply-To: <CAEUhbmWENVV+DzX756OCUGYc5ES-aCdD8tpSoVoPspniuiGh2A@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Sun, 11 Aug 2019 10:06:16 -0700
Message-ID: <CAKmqyKPQiVE=XB0mNy6gbC9B0QokB=AN_MPKY72inj4CNu882w@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
Subject: Re: [Qemu-devel] [PATCH v2 11/28] riscv: sifive: Rename
 sifive_prci.{c, h} to sifive_e_prci.{c, h}
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
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@sifive.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sun, Aug 11, 2019 at 1:00 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> Hi Alistair,
>
> On Sat, Aug 10, 2019 at 9:51 AM Alistair Francis <alistair23@gmail.com> wrote:
> >
> > On Wed, Aug 7, 2019 at 12:49 AM Bin Meng <bmeng.cn@gmail.com> wrote:
> > >
> > > Current SiFive PRCI model only works with sifive_e machine, as it
> > > only emulates registers or PRCI block in the FE310 SoC.
> > >
> > > Rename the file name to make it clear that it is for sifive_e.
> > >
> > > Signed-off-by: Bin Meng <bmeng.cn@gmail.com>
> > > ---
> > >
> > > Changes in v2: None
> > >
> > >  hw/riscv/Makefile.objs                              |  2 +-
> > >  hw/riscv/sifive_e.c                                 |  4 ++--
> > >  hw/riscv/{sifive_prci.c => sifive_e_prci.c}         | 14 +++++++-------
> > >  include/hw/riscv/{sifive_prci.h => sifive_e_prci.h} | 14 +++++++-------
> > >  4 files changed, 17 insertions(+), 17 deletions(-)
> > >  rename hw/riscv/{sifive_prci.c => sifive_e_prci.c} (90%)
> > >  rename include/hw/riscv/{sifive_prci.h => sifive_e_prci.h} (82%)
> > >
> > > diff --git a/hw/riscv/Makefile.objs b/hw/riscv/Makefile.objs
> > > index eb9d4f9..c859697 100644
> > > --- a/hw/riscv/Makefile.objs
> > > +++ b/hw/riscv/Makefile.objs
> > > @@ -2,9 +2,9 @@ obj-y += boot.o
> > >  obj-$(CONFIG_SPIKE) += riscv_htif.o
> > >  obj-$(CONFIG_HART) += riscv_hart.o
> > >  obj-$(CONFIG_SIFIVE_E) += sifive_e.o
> > > +obj-$(CONFIG_SIFIVE_E) += sifive_e_prci.o
> > >  obj-$(CONFIG_SIFIVE) += sifive_clint.o
> > >  obj-$(CONFIG_SIFIVE) += sifive_gpio.o
> > > -obj-$(CONFIG_SIFIVE) += sifive_prci.o
> > >  obj-$(CONFIG_SIFIVE) += sifive_plic.o
> > >  obj-$(CONFIG_SIFIVE) += sifive_test.o
> > >  obj-$(CONFIG_SIFIVE_U) += sifive_u.o
> > > diff --git a/hw/riscv/sifive_e.c b/hw/riscv/sifive_e.c
> > > index 2a499d8..2d67670 100644
> > > --- a/hw/riscv/sifive_e.c
> > > +++ b/hw/riscv/sifive_e.c
> > > @@ -41,9 +41,9 @@
> > >  #include "hw/riscv/riscv_hart.h"
> > >  #include "hw/riscv/sifive_plic.h"
> > >  #include "hw/riscv/sifive_clint.h"
> > > -#include "hw/riscv/sifive_prci.h"
> > >  #include "hw/riscv/sifive_uart.h"
> > >  #include "hw/riscv/sifive_e.h"
> > > +#include "hw/riscv/sifive_e_prci.h"
> > >  #include "hw/riscv/boot.h"
> > >  #include "chardev/char.h"
> > >  #include "sysemu/arch_init.h"
> > > @@ -174,7 +174,7 @@ static void riscv_sifive_e_soc_realize(DeviceState *dev, Error **errp)
> > >          SIFIVE_SIP_BASE, SIFIVE_TIMECMP_BASE, SIFIVE_TIME_BASE);
> > >      sifive_mmio_emulate(sys_mem, "riscv.sifive.e.aon",
> > >          memmap[SIFIVE_E_AON].base, memmap[SIFIVE_E_AON].size);
> > > -    sifive_prci_create(memmap[SIFIVE_E_PRCI].base);
> > > +    sifive_e_prci_create(memmap[SIFIVE_E_PRCI].base);
> > >
> > >      /* GPIO */
> > >
> > > diff --git a/hw/riscv/sifive_prci.c b/hw/riscv/sifive_e_prci.c
> > > similarity index 90%
> > > rename from hw/riscv/sifive_prci.c
> > > rename to hw/riscv/sifive_e_prci.c
> > > index f406682..acb914d 100644
> > > --- a/hw/riscv/sifive_prci.c
> > > +++ b/hw/riscv/sifive_e_prci.c
> > > @@ -1,5 +1,5 @@
> > >  /*
> > > - * QEMU SiFive PRCI (Power, Reset, Clock, Interrupt)
> > > + * QEMU SiFive E PRCI (Power, Reset, Clock, Interrupt)
> > >   *
> > >   * Copyright (c) 2017 SiFive, Inc.
> > >   *
> > > @@ -22,7 +22,7 @@
> > >  #include "hw/sysbus.h"
> > >  #include "qemu/module.h"
> > >  #include "target/riscv/cpu.h"
> > > -#include "hw/riscv/sifive_prci.h"
> > > +#include "hw/riscv/sifive_e_prci.h"
> > >
> > >  static uint64_t sifive_prci_read(void *opaque, hwaddr addr, unsigned int size)
> > >  {
> > > @@ -82,10 +82,10 @@ static const MemoryRegionOps sifive_prci_ops = {
> > >
> > >  static void sifive_prci_init(Object *obj)
> > >  {
> > > -    SiFivePRCIState *s = SIFIVE_PRCI(obj);
> > > +    SiFivePRCIState *s = SIFIVE_E_PRCI(obj);
> >
> > Should we not rename the struct as well?
> >
>
> I think this is OK given it's only used by sifive_e machine and will
> not be mixed with sifive_u.

Structs can be public though, so this seems risky. I feel like it
should be renamed with the file.

Alistair

>
> Regards,
> Bin

