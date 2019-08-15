Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97436C32753
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 01:32:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 503FB2084F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 01:32:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ReiGh+Xt"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 503FB2084F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37058 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hy4cz-0006Ud-TR
	for qemu-devel@archiver.kernel.org; Wed, 14 Aug 2019 21:32:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41865)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bmeng.cn@gmail.com>) id 1hy4bl-00060G-1k
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 21:31:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hy4bj-0005oi-M8
 for qemu-devel@nongnu.org; Wed, 14 Aug 2019 21:31:16 -0400
Received: from mail-ed1-x544.google.com ([2a00:1450:4864:20::544]:39176)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hy4bg-0005lo-Vv; Wed, 14 Aug 2019 21:31:13 -0400
Received: by mail-ed1-x544.google.com with SMTP id g8so860151edm.6;
 Wed, 14 Aug 2019 18:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=6vvz9ApcA9pgDfQfHSMw5AtqukPjtkRFYVFa7YGh+E4=;
 b=ReiGh+XtIJHOY9tTl6Mt36nH306a5XVCJHOsPOxSgPuMWxd3bCQYCaiY7X2jRuDpTa
 eFvxR+xv6PnTnslHsP5GzYzwll8nwgcEwoOM/oueQ0buDO6j3RksAt5K/phZh4nP1sV0
 CktNKFRpoepHr/0UQtlrZ+kWhkOR92XhGHjULiCm53IKYgJXLL1UEklg8/lfgzAWCBOD
 J77KzDiwzapWLzbbE/iBNYnu/Nb4XwOpSxy2/NFG7NwdqeVb9enUfzsdwQrh026a9CLW
 lUSOCjqp6FzMIXwVZCgZix8aMycQg1EzWwnmsdm8qQ3qvgLbeRNJlb3naGodsUcmFcVV
 6sBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=6vvz9ApcA9pgDfQfHSMw5AtqukPjtkRFYVFa7YGh+E4=;
 b=cCYC5SDpOfVzmcUj7CtwYuxxxymk9ZluoaUfPl8K6v0H6+THVuGrsTt6NZNDqglbID
 NuxvErAqpC9dUCRiwflxUWnawlBvOVZhFvjiZzIdiKt/oGMKr6hk7xyK13P912VuW5NY
 IaRo9JInWlSPEOVgHI86RIkM+6R1fDEtblH3+YuMhS3z5FBVOFvd7zcpQ+2j6BTYsv5v
 1lRsZCHi41m85LXHmjHpsbS5yFBYtq9u/ibV/Xufz+HB9sBsLsWiXCp1pLYBvcRROIj7
 xFpDfkBEvKqSq9JpfmiAuiCLhCs91bxS8oemLKw4zOFrM/b/Z0SqAEryBzYMuob8X5OC
 odUQ==
X-Gm-Message-State: APjAAAU84ozdlw2fANJQMOEKQ7LCD4DDi+JHGc3OObSS3JMLeQWMbYtn
 zKvXBFMWvix27y4TgOrkhpS5PlGWLScv9Ah4je4=
X-Google-Smtp-Source: APXvYqyGpKnkGnxO1CQJO98zacq6OO+CdwT2fRBumi7qeTfT7UfIGWVOux3zjQ0JRqvNaP77mW1qi4qSsm+PeahRdos=
X-Received: by 2002:a17:906:f742:: with SMTP id
 jp2mr2107926ejb.87.1565832671261; 
 Wed, 14 Aug 2019 18:31:11 -0700 (PDT)
MIME-Version: 1.0
References: <CAEUhbmU8s5cEt4J-ae0wqfgFHEWe=YWQaDn_Au_MhtK1J7OntA@mail.gmail.com>
 <mhng-b7d8bc3c-3d03-4b2a-910f-8a9ceb18a046@palmer-si-x1c4>
In-Reply-To: <mhng-b7d8bc3c-3d03-4b2a-910f-8a9ceb18a046@palmer-si-x1c4>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Thu, 15 Aug 2019 09:30:59 +0800
Message-ID: <CAEUhbmVb-rfZ74mY_2QHTNw8R-FYTwxggHAPCCWviYpZZXNtAg@mail.gmail.com>
To: Palmer Dabbelt <palmer@sifive.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::544
Subject: Re: [Qemu-devel] [PATCH 1/3] riscv: sifive_u: Add support for
 loading initrd
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
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>, linux@roeck-us.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Palmer,

On Thu, Aug 15, 2019 at 1:06 AM Palmer Dabbelt <palmer@sifive.com> wrote:
>
> On Mon, 12 Aug 2019 16:48:00 PDT (-0700), bmeng.cn@gmail.com wrote:
> > Hi Palmer,
> >
> > On Tue, Aug 13, 2019 at 6:45 AM Palmer Dabbelt <palmer@sifive.com> wrote:
> >>
> >> On Fri, 19 Jul 2019 06:40:43 PDT (-0700), linux@roeck-us.net wrote:
> >> > Add support for loading initrd with "-initrd <filename>"
> >> > to the sifive_u machine. This lets us boot into Linux without
> >> > disk drive.
> >> >
> >> > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> >> > ---
> >> >  hw/riscv/sifive_u.c | 20 +++++++++++++++++---
> >> >  1 file changed, 17 insertions(+), 3 deletions(-)
> >> >
> >> > diff --git a/hw/riscv/sifive_u.c b/hw/riscv/sifive_u.c
> >> > index 71b8083..0657046 100644
> >> > --- a/hw/riscv/sifive_u.c
> >> > +++ b/hw/riscv/sifive_u.c
> >> > @@ -67,7 +67,7 @@ static const struct MemmapEntry {
> >> >
> >> >  #define GEM_REVISION        0x10070109
> >> >
> >> > -static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
> >> > +static void *create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
> >> >      uint64_t mem_size, const char *cmdline)
> >> >  {
> >> >      void *fdt;
> >> > @@ -244,11 +244,14 @@ static void create_fdt(SiFiveUState *s, const struct MemmapEntry *memmap,
> >> >          qemu_fdt_setprop_string(fdt, "/chosen", "bootargs", cmdline);
> >> >      }
> >> >      g_free(nodename);
> >> > +
> >> > +    return fdt;
> >> >  }
> >> >
> >> >  static void riscv_sifive_u_init(MachineState *machine)
> >> >  {
> >> >      const struct MemmapEntry *memmap = sifive_u_memmap;
> >> > +    void *fdt;
> >> >
> >> >      SiFiveUState *s = g_new0(SiFiveUState, 1);
> >> >      MemoryRegion *system_memory = get_system_memory();
> >> > @@ -269,13 +272,24 @@ static void riscv_sifive_u_init(MachineState *machine)
> >> >                                  main_mem);
> >> >
> >> >      /* create device tree */
> >> > -    create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
> >> > +    fdt = create_fdt(s, memmap, machine->ram_size, machine->kernel_cmdline);
> >> >
> >> >      riscv_find_and_load_firmware(machine, BIOS_FILENAME,
> >> >                                   memmap[SIFIVE_U_DRAM].base);
> >> >
> >> >      if (machine->kernel_filename) {
> >> > -        riscv_load_kernel(machine->kernel_filename);
> >> > +        uint64_t kernel_entry = riscv_load_kernel(machine->kernel_filename);
> >> > +
> >> > +        if (machine->initrd_filename) {
> >> > +            hwaddr start;
> >> > +            hwaddr end = riscv_load_initrd(machine->initrd_filename,
> >> > +                                           machine->ram_size, kernel_entry,
> >> > +                                           &start);
> >> > +            qemu_fdt_setprop_cell(fdt, "/chosen",
> >> > +                                  "linux,initrd-start", start);
> >> > +            qemu_fdt_setprop_cell(fdt, "/chosen", "linux,initrd-end",
> >> > +                                  end);
> >> > +        }
> >> >      }
> >> >
> >> >      /* reset vector */
> >>
> >> Thanks.  I've queued all three of these.
> >>
> >
> > Ah, looks I did a duplicate.
> > http://patchwork.ozlabs.org/patch/1145247/
> >
> > Which git repo/branch should I rebase my series on?
>
> github.com/palmer-dabbelt/riscv-qemu -b for-master

I did not see branch "for-master" in the riscv-qemu repo. However I
did find the branch in the github.com/palmer-dabbelt/qemu repo.

I assume that's the correct one I should rebase my patch series on.

Regards,
Bin

