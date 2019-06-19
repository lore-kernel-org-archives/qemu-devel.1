Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43765C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 14:32:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EE232166E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 14:32:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SueaBIZy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EE232166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38916 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdbdJ-0000v8-9w
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 10:32:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57848)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hdbbU-0000P1-UU
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:30:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hdbbT-0004n9-D2
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:30:24 -0400
Received: from mail-lj1-x242.google.com ([2a00:1450:4864:20::242]:40155)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hdbbT-0004jU-4z; Wed, 19 Jun 2019 10:30:23 -0400
Received: by mail-lj1-x242.google.com with SMTP id a21so3479138ljh.7;
 Wed, 19 Jun 2019 07:30:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GQeS01QZ2J0Fd6FspTGdoPD2uQOZXz6KHZnOuY1DEtY=;
 b=SueaBIZyckIRUQQCX+1E2zYhwQAic9t5z7u66YQDELNOtzngL1vTPgqHsMAlda66CY
 eWkCsTWR7Ko40D7vqVyZKc4SCjGJO5wD5coq89tCmLQxjLrICrRm0hTlgaIUn8y7sOdl
 2bH6LYmcDOLB0JA2kYcANdyHyjiZ1eVFnf0AFMxzjdQ0pfn2015RXlUmwoVk9UecU8MR
 5pxrl5t9AGoW8VZQWJ7J7zRKwfd5j/3U+NrVdDLR9Jg6E2fUNQKkYhOgfmUzpY6kBp+M
 eM8zh0jFpIDyxjL5tOObp4tCJ9ksHKUnC3NW76WEm7vP3ALVGAgc9QG5+uUOHLzaoUda
 9Ctg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GQeS01QZ2J0Fd6FspTGdoPD2uQOZXz6KHZnOuY1DEtY=;
 b=hc63rm1V727mXARd0qySWGYgh8I8ZLQfYsifFKkP3nyqpJUE20AybSplizzLp/O9ej
 Iq94YBocJY185rmvzDjibFCHwpjwdv99reNo52e9bB1HQFU7oLl2Wk7SUNMpBD9lkVyO
 pNrRaPIAOWrP8ljGn7tCv3bKFigAiVWmLeHFKQJeYahurH5B32nwrKSd4J6yrWpTmOfh
 hHlyJdJ6OMhPTFj3QvdX9MW83PklBwfigx9zpZZwu/jpN32cUjcIbw7HLIxACNVpSQB1
 QEWA6pFL2vKZgN0sPLbKoswPKZiNRHGRZD/oGikVoole5oaIqJ15q3abNyjCZdTCv7ov
 pYzw==
X-Gm-Message-State: APjAAAX0S7c1eCIz32zI7jYFaSw5KOJvpCRRkBtHQRZvJMf5xKg69m3+
 OSyvska+YceYen0uHmZDNeJa/OShby5BH0QhQao=
X-Google-Smtp-Source: APXvYqyNU+XhczgqVxrsy1FJOWLwv0xyoVNAdpqYFcUquNwOrytWABCNxS0/WRuSFaX2lLPr8cLllu9ie3FyY54ErYU=
X-Received: by 2002:a2e:9188:: with SMTP id f8mr7019825ljg.33.1560954621778;
 Wed, 19 Jun 2019 07:30:21 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560904640.git.alistair.francis@wdc.com>
 <CAEUhbmViJpKtiNXm7CYdF7SPRkOPkvpXJ5+We2m9tZSK_BWi-g@mail.gmail.com>
In-Reply-To: <CAEUhbmViJpKtiNXm7CYdF7SPRkOPkvpXJ5+We2m9tZSK_BWi-g@mail.gmail.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Wed, 19 Jun 2019 07:29:55 -0700
Message-ID: <CAKmqyKM4UU+CPKu07AK65bNofbbxxaRkSACqoV_vfFEaH-195A@mail.gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::242
Subject: Re: [Qemu-devel] [RFC v1 0/5] RISC-V: Add firmware loading support
 and default
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
 Palmer Dabbelt <palmer@sifive.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 7:26 AM Bin Meng <bmeng.cn@gmail.com> wrote:
>
> On Wed, Jun 19, 2019 at 8:56 AM Alistair Francis
> <alistair.francis@wdc.com> wrote:
> >
> > This is an RFC as it will break ALL current users! See below for details.
> >
> > This series consolidates the current RISC-V kernel loading
> > impelementation while also adding support for the -bios option and more
> > advanced kernel image types.
> >
> > After consolidating the kernel loading we can extend the boot loader to
> > support a -bios option. We can also extend the kernel loading options to
> > support not just ELF files but other standard formats.
> >
> > Finally we can include the OpenSBI firmware by default for QEMU users.
> >
> > At the end of this series we are in the good place of no longer
> > requiring users to build firmware to boot a kernel. Instead users can
> > just run QEMu with the -kernel option and everything will work. They can
>
> This is great. I like booting kernel directly for testing without
> bothering the firmware stuff.

That's the goal! Now we just need to not break everything.

>
> > also override the firmware with their own using the -bios option. Using
> > "-bios none" will result in no firmware being loaded (as it is today).
> >
> > !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
> >
> > Unfortunately this series (patch 5 specifically) results in all current
> > Linux boots being broken as users are already loading in their own
> > firmware, which overlaps with the now included default. They will
> > see this error:
> >
> >   rom: requested regions overlap (rom phdr #0: ./images/qemuriscv64/fw_jump.elf. free=0x0000000080008090, addr=0x0000000080000000)
> >   qemu-system-riscv64: rom check and register reset failed
> >
> > If a current user specieifies "-bios none" their flow will continue
> > working. A user can instead no longer load their firmware and
> > use the default or they can load their firmware with the -bios option.
> >
> > At the moment the best idea I have to not break all users is to only
> > include the default firmware if the user specifies "-bios opensbi".
> > That is change the default to not loading the firmware. Then we can work
> > on updating documentation and maybe in future change the default to
> > include a firmware and anyone who doesn't want a default firmware can
> > specify "-bios none".
> >
> > Any other ideas on how to not break everything?
> >
> >
> >
> > Alistair Francis (5):
> >   hw/riscv: Split out the boot functions
> >   hw/riscv: Add support for loading a firmware
> >   hw/riscv: Extend the kernel loading support
> >   roms: Add OpenSBI version 0.3
> >   hw/riscv: Load OpenSBI as the default firmware
> >
> >  .gitmodules                         |   3 +
> >  Makefile                            |   3 +-
> >  configure                           |   1 +
> >  hw/riscv/Makefile.objs              |   1 +
> >  hw/riscv/boot.c                     | 143 ++++++++++++++++++++++++++++
> >  hw/riscv/sifive_e.c                 |  17 +---
> >  hw/riscv/sifive_u.c                 |  19 +---
> >  hw/riscv/spike.c                    |  21 +---
> >  hw/riscv/virt.c                     |  54 ++---------
> >  include/hw/riscv/boot.h             |  30 ++++++
> >  pc-bios/opensbi-riscv32-fw_jump.elf | Bin 0 -> 197988 bytes
> >  pc-bios/opensbi-riscv64-fw_jump.elf | Bin 0 -> 200192 bytes
>
> Since we are considering adding "bios" images, I prefer to add the
> pure binary images instead of ELF images here.

I didn't think about that. Can we just boot them in QEMU like we do
with the ELFs?

Alistair

>
> >  roms/Makefile                       |  17 ++++
> >  roms/opensbi                        |   1 +
> >  14 files changed, 216 insertions(+), 94 deletions(-)
> >  create mode 100644 hw/riscv/boot.c
> >  create mode 100644 include/hw/riscv/boot.h
> >  create mode 100644 pc-bios/opensbi-riscv32-fw_jump.elf
> >  create mode 100644 pc-bios/opensbi-riscv64-fw_jump.elf
> >  create mode 160000 roms/opensbi
>
> Regards,
> Bin

