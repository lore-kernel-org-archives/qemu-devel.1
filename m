Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F2ABC48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 17:10:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F14F7208CA
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 17:10:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QhS0CHPZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F14F7208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34160 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfoy8-0000Sc-6i
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 13:10:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55835)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <alistair23@gmail.com>) id 1hfowm-00083a-Ls
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 13:09:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1hfowl-0003rx-Jc
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 13:09:32 -0400
Received: from mail-lf1-x141.google.com ([2a00:1450:4864:20::141]:39373)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1hfowl-0003qq-B8; Tue, 25 Jun 2019 13:09:31 -0400
Received: by mail-lf1-x141.google.com with SMTP id p24so13182622lfo.6;
 Tue, 25 Jun 2019 10:09:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=lmVDqZcXAzlpBStGwkiT9Uw2BMcZ0MeP+OnYTD8rSgY=;
 b=QhS0CHPZHYLSMLXU9XNrzbRIZl5+yokkq4xiasNT+lHu9iBha3dEZ1oyazYxcU60m7
 f+/w7/yHXzjyvmEoC6cVP1h5fElbxe/ahkK54Pkq68Mgd8vV+axwaA35NH+ibsN3vvlf
 fABEVwRpcc6h6DenwHWfH/4NNAW8O5XiShv4OMFfIlzJycOyMYnpQvPQMcQxpgqC9A4a
 M8YX6NNSC9AABB/GITovqi7THgDNRWqU2lVri+qJPIJCiw5AAh6dUTCZgKmKuOzEA0A5
 VbVaZYTZIlUBhYSgw94MubstwQ2Fy5TgORE2cqUP/sb2x+Luo9lkpgVdT/ch4+0tnCWu
 B2QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=lmVDqZcXAzlpBStGwkiT9Uw2BMcZ0MeP+OnYTD8rSgY=;
 b=tANrJQy2E3Yb4hUvwMiCNgvEcUatv2Vey3LZfNQmJmATwTkgmGBG5gYXwRDfYZu4qM
 stV9jWeipKrZCOPHXa/reOA02RBWtaSCcjn7McwZ215UeS1WcLgKFEiUJ7LNWTBH8NGZ
 Vo/hWevtVXnYVip1+P2zzSKvoUWQRMUWuInhVi+5WW1TbiJfr2c66PjADu+2lWrD/coW
 Xs3i62TX8P0A4geKrLhC4GZ5w9WaBjLdCCJBTm67kw99A71NW/vbAQ1L/Bk5Oh6iGiLj
 mcKp67UvNjv6zpXipbegZQ6zLPRvHfMjLcyV/Sy7a+NlQhqrb23o5VLg3Yrie9mV8pmA
 g3Dw==
X-Gm-Message-State: APjAAAVdysiO+MngLGZC/wqZantdVpmg0nq5hP6vzoddi/eKSvlR2dbi
 6oiQVVDmKRER3DMlaqi8UFPhBztlxPsPkhDvEdc=
X-Google-Smtp-Source: APXvYqzWM40d1wWSSTqaSHRf9o09sK1TaS6EytbDp9CooyT4o6TiZX6UaIGdHxOohHxJJOyRoJ27627sp90to4zA/ww=
X-Received: by 2002:a19:6a01:: with SMTP id u1mr14684005lfu.141.1561482569618; 
 Tue, 25 Jun 2019 10:09:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1561414240.git.alistair.francis@wdc.com>
In-Reply-To: <cover.1561414240.git.alistair.francis@wdc.com>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 25 Jun 2019 10:06:33 -0700
Message-ID: <CAKmqyKOpxtB7SrT2i_UjVsE38=nzf1_q0fmYPhJ4D716j3ZriQ@mail.gmail.com>
To: Alistair Francis <alistair.francis@wdc.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::141
Subject: Re: [Qemu-devel] [PATCH v1 0/5] RISC-V: Add firmware loading
 support and default
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
Cc: Palmer Dabbelt <palmer@sifive.com>,
 "open list:RISC-V" <qemu-riscv@nongnu.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jun 24, 2019 at 3:14 PM Alistair Francis
<alistair.francis@wdc.com> wrote:
>
> This series consolidates the current RISC-V kernel loading
> impelementation while also adding support for the -bios option and more
> advanced kernel image types.
>
> After consolidating the kernel loading we can extend the boot loader to
> support a -bios option. We can also extend the kernel loading options to
> support not just ELF files but other standard formats.
>
> Finally we can include the OpenSBI firmware for QEMU users.
>
> To avoid breakages we have not changed the default behaviour of QEMU.
> The plan is to change the default though, which is why an entry to the
> qemu-deprecated.texi file has been added as well as a new warning.
>
> After this series QEMU 4.1 has three options:
>  1. ``-bios none`` - This is the current default behavior if no -bios option
>       is included. QEMU will not automatically load any firmware. It is up
>       to the user to load all the images they need.
>  2. ``-bios default`` - In a future QEMU release this will become the default
>       behaviour if no -bios option is specified. This option will load the
>       default OpenSBI firmware automatically. The firmware is included with
>       the QEMU release and no user interaction is required. All a user needs
>       to do is specify the kernel they want to boot with the -kernel option
>  3. ``-bios <file>`` - Tells QEMU to load the specified file as the firmwrae.
>
> All users should transition to using a -bios option. We can start
> updating all documentation after the release of 4.1.
>
> At the end of this series and the transition period we are in the good
> place of no longer requiring users to build firmware to boot a kernel.
> Instead users can just run QEMU with the -kernel option and everything
> will work. They can also override the firmware with their own using
> the -bios option. Using "-bios none" will result in no firmware being
> loaded (as it is today).
>

@Palmer Dabbelt can this go in your 4.1 PR? It has been reviewed and tested.

Alistair

>
> Alistair Francis (5):
>   hw/riscv: Split out the boot functions
>   hw/riscv: Add support for loading a firmware
>   hw/riscv: Extend the kernel loading support
>   roms: Add OpenSBI version 0.3
>   hw/riscv: Load OpenSBI as the default firmware
>
>  .gitmodules                                  |   3 +
>  Makefile                                     |   5 +-
>  hw/riscv/Makefile.objs                       |   1 +
>  hw/riscv/boot.c                              | 154 +++++++++++++++++++
>  hw/riscv/sifive_e.c                          |  17 +-
>  hw/riscv/sifive_u.c                          |  22 +--
>  hw/riscv/spike.c                             |  21 +--
>  hw/riscv/virt.c                              |  60 ++------
>  include/hw/riscv/boot.h                      |  32 ++++
>  pc-bios/opensbi-riscv32-virt-fw_jump.bin     | Bin 0 -> 28848 bytes
>  pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin | Bin 0 -> 28904 bytes
>  pc-bios/opensbi-riscv64-virt-fw_jump.bin     | Bin 0 -> 28904 bytes
>  qemu-deprecated.texi                         |  20 +++
>  roms/Makefile                                |  48 ++++--
>  roms/opensbi                                 |   1 +
>  15 files changed, 278 insertions(+), 106 deletions(-)
>  create mode 100644 hw/riscv/boot.c
>  create mode 100644 include/hw/riscv/boot.h
>  create mode 100644 pc-bios/opensbi-riscv32-virt-fw_jump.bin
>  create mode 100644 pc-bios/opensbi-riscv64-sifive_u-fw_jump.bin
>  create mode 100644 pc-bios/opensbi-riscv64-virt-fw_jump.bin
>  create mode 160000 roms/opensbi
>
> --
> 2.22.0
>

