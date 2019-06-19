Return-Path: <SRS0=PARU=US=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 140A6C31E49
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 14:28:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18302166E
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Jun 2019 14:28:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LdsumGEE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D18302166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38892 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hdbZv-0006gr-2F
	for qemu-devel@archiver.kernel.org; Wed, 19 Jun 2019 10:28:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56885)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bmeng.cn@gmail.com>) id 1hdbXc-0004P1-DN
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:26:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bmeng.cn@gmail.com>) id 1hdbXZ-00004r-KQ
 for qemu-devel@nongnu.org; Wed, 19 Jun 2019 10:26:24 -0400
Received: from mail-ed1-x542.google.com ([2a00:1450:4864:20::542]:34185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bmeng.cn@gmail.com>)
 id 1hdbXX-0008Sd-GS; Wed, 19 Jun 2019 10:26:21 -0400
Received: by mail-ed1-x542.google.com with SMTP id s49so27585801edb.1;
 Wed, 19 Jun 2019 07:26:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=0Hof27XfEBt6nFyXuNV4cBKbPYkLIx8aVPU3b0vospE=;
 b=LdsumGEEHskfOYkQ582NoSl+dETkWeBmrTybLSX4koLP8+AAlsmaYG45otIo3OfxS7
 dXz42Xhq/NWTlxoyTpPcB26hJTBGklGYVMkE3vwsWrLo0vkDBt5rX7bjOC/X8XqY4qgR
 BlAfqSnUUkBhfn9RlnbIUUmTgjdOBTwU6LUf07LK6TbM038x85OEY9HaRHudw7BbP4x5
 D0P6prcL5TwYCBqDGfw+SMNPEAfrKU/w4eMk+p9xtQ+rHKZ+z5Iy6CDSg9DPzMs9y0Hs
 0DfVY4/VerOhdC0HfkO58Azq+vmoM5w2WRKFSOvtK3ZpTXl/dlrUMEoOfAMiRjmd8lQo
 9WCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=0Hof27XfEBt6nFyXuNV4cBKbPYkLIx8aVPU3b0vospE=;
 b=uZCf+pCRyUCiGHhmR7kc9INpbScljt0lJWQVY3QSY0AsMOge9FWPTXlPlvp8E4SS0M
 u59X4R5ZUdK8ATUXoXB5xji2NJkXJTr7QZDsmSmNajOfcteDMCbyOv5QF9B4yf0axjQc
 x2U+/+ci2gcchb5aUIazqd07b1+gAcareJdeTmRjCZ/4xbhCPynLkc8sKD3Ai+cNW8fb
 OpOKa4sICpyYgWqPBMeRaekn2/oLmfZJiH03Mb1wUxJj6/Vi1t3V2WhDc2ODGKbYQeIy
 cQfA6uSSYNSYrXzsAACNhd5Zh2iTtO5TC7e1ii4HcpWSCLetqKlTk/5gs87SEaOor5wU
 3Jcw==
X-Gm-Message-State: APjAAAXMhYwta7h+0mL2iO+BcY96OnKjsBtxLb4wVX6zSi14FrlaOxrt
 WhLC6vcjK65yzhvB01hcryHA1BPaBPeG0ERSjtc=
X-Google-Smtp-Source: APXvYqzd/a/M3y3H3x7fMMcBnodu7IJ1CIyI8oD9iAMp6R8rKUVnkcQryNI35YDFXFuTH/pMQf2CUNnZoZ1FQg85oM8=
X-Received: by 2002:a50:94e6:: with SMTP id t35mr93884542eda.137.1560954378292; 
 Wed, 19 Jun 2019 07:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1560904640.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1560904640.git.alistair.francis@wdc.com>
From: Bin Meng <bmeng.cn@gmail.com>
Date: Wed, 19 Jun 2019 22:26:04 +0800
Message-ID: <CAEUhbmViJpKtiNXm7CYdF7SPRkOPkvpXJ5+We2m9tZSK_BWi-g@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::542
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
Cc: Alistair Francis <alistair23@gmail.com>, Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, Jun 19, 2019 at 8:56 AM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> This is an RFC as it will break ALL current users! See below for details.
>
> This series consolidates the current RISC-V kernel loading
> impelementation while also adding support for the -bios option and more
> advanced kernel image types.
>
> After consolidating the kernel loading we can extend the boot loader to
> support a -bios option. We can also extend the kernel loading options to
> support not just ELF files but other standard formats.
>
> Finally we can include the OpenSBI firmware by default for QEMU users.
>
> At the end of this series we are in the good place of no longer
> requiring users to build firmware to boot a kernel. Instead users can
> just run QEMu with the -kernel option and everything will work. They can

This is great. I like booting kernel directly for testing without
bothering the firmware stuff.

> also override the firmware with their own using the -bios option. Using
> "-bios none" will result in no firmware being loaded (as it is today).
>
> !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
>
> Unfortunately this series (patch 5 specifically) results in all current
> Linux boots being broken as users are already loading in their own
> firmware, which overlaps with the now included default. They will
> see this error:
>
>   rom: requested regions overlap (rom phdr #0: ./images/qemuriscv64/fw_jump.elf. free=0x0000000080008090, addr=0x0000000080000000)
>   qemu-system-riscv64: rom check and register reset failed
>
> If a current user specieifies "-bios none" their flow will continue
> working. A user can instead no longer load their firmware and
> use the default or they can load their firmware with the -bios option.
>
> At the moment the best idea I have to not break all users is to only
> include the default firmware if the user specifies "-bios opensbi".
> That is change the default to not loading the firmware. Then we can work
> on updating documentation and maybe in future change the default to
> include a firmware and anyone who doesn't want a default firmware can
> specify "-bios none".
>
> Any other ideas on how to not break everything?
>
>
>
> Alistair Francis (5):
>   hw/riscv: Split out the boot functions
>   hw/riscv: Add support for loading a firmware
>   hw/riscv: Extend the kernel loading support
>   roms: Add OpenSBI version 0.3
>   hw/riscv: Load OpenSBI as the default firmware
>
>  .gitmodules                         |   3 +
>  Makefile                            |   3 +-
>  configure                           |   1 +
>  hw/riscv/Makefile.objs              |   1 +
>  hw/riscv/boot.c                     | 143 ++++++++++++++++++++++++++++
>  hw/riscv/sifive_e.c                 |  17 +---
>  hw/riscv/sifive_u.c                 |  19 +---
>  hw/riscv/spike.c                    |  21 +---
>  hw/riscv/virt.c                     |  54 ++---------
>  include/hw/riscv/boot.h             |  30 ++++++
>  pc-bios/opensbi-riscv32-fw_jump.elf | Bin 0 -> 197988 bytes
>  pc-bios/opensbi-riscv64-fw_jump.elf | Bin 0 -> 200192 bytes

Since we are considering adding "bios" images, I prefer to add the
pure binary images instead of ELF images here.

>  roms/Makefile                       |  17 ++++
>  roms/opensbi                        |   1 +
>  14 files changed, 216 insertions(+), 94 deletions(-)
>  create mode 100644 hw/riscv/boot.c
>  create mode 100644 include/hw/riscv/boot.h
>  create mode 100644 pc-bios/opensbi-riscv32-fw_jump.elf
>  create mode 100644 pc-bios/opensbi-riscv64-fw_jump.elf
>  create mode 160000 roms/opensbi

Regards,
Bin

