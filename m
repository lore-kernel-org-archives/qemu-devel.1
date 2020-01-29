Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1CA6C2D0DB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:19:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D24D20716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 15:19:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="svOCGEU3"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9D24D20716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47930 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwp7q-00074W-Oi
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 10:19:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42427)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwp6p-0006dt-Vr
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:18:29 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwp6o-0002YG-I6
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:18:27 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:32817)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iwp6o-0002Ws-Ae
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 10:18:26 -0500
Received: by mail-oi1-x243.google.com with SMTP id q81so81471oig.0
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 07:18:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5TendGIZpcqjRr/+l2jreCiosle69Lj8NZxbB/+Vydo=;
 b=svOCGEU3IZPqL8Z5ejx6C9lbqyNwnPHybPLR7xupNouLHP0lgrT5oo/p9JPPG6JNNB
 bKDgcnwc037CvFt/a/8X6sMg0D5HPU966019ihgou7ah1cyysBqHQlRE05NiDsRXgWrd
 B2VufGFFsLMsD5YWHLzi6urkjPEqAHpHo0v69i6YBsEV7Z4c5FZMiMqeKn4FQrnLtixN
 Ong0oPHWa5ZlxRDLgv1PM3bOT4YMG3WQGXsKo7VuVRv5FtRShOXhNUk2irieGx6DapaI
 dlr1RJhdE/WzXK0AdGiBgjsJzhE3+DIXeg3946pUQwdQ38kGCnCwZaPMOAkGnVvPMTNj
 neMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5TendGIZpcqjRr/+l2jreCiosle69Lj8NZxbB/+Vydo=;
 b=IaoE0WcMZj+zddLveXlAI4jC1lIC4ftUogK3jDcDfM9UPlJADkCjvXQ/MxFNi80TI8
 yoLVynGbCXlQEKcRkAipFR5Eb9bzm9KRykeNNhh1P5vbsDr5D+QGElBwL6NfIiHImpjE
 RnTg9lkH8HgoWK0+YPjfuAdmphAjNz88LrEPsSjzmiqLEMnu+gFAIWL1p4ctubP9fJVL
 v6QwW7KFZk2NtNS7qI1kdNYITWB79JRlaYGnWaSacufAlxOJ7x2eiUeIAr3RRCVs6vTX
 eLgF/+oqbrZXCOiPvPa4IjPcEG6kEwIqT68LGw/IEpRZS/6ZTTJL8hm8CyumtSYjba2x
 rxQg==
X-Gm-Message-State: APjAAAXRg1WVajBgOnBZai2s8gjV77IxWmoutfz8cP3p2ATDCCNCMgo/
 eQPolACCryQMn+FezEKragSAQ6Ds7MdTqNkBgc0=
X-Google-Smtp-Source: APXvYqxxiOOBKx8XI/zxgi08AVnsAABebCOKixJ7i7Slt3LC076KbqRSWSODzRCDSciSO5JkU/+SkgPgMXkFQi2VI70=
X-Received: by 2002:aca:4ece:: with SMTP id c197mr451267oib.53.1580311105016; 
 Wed, 29 Jan 2020 07:18:25 -0800 (PST)
MIME-Version: 1.0
References: <1580242161-20333-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1580242161-20333-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 29 Jan 2020 16:18:14 +0100
Message-ID: <CAL1e-=h-NzYsFr7LU7RP7DypcO5wdb7jjk57GoMbCEGJVWmkVw@mail.gmail.com>
Subject: Re: [PULL 0/6] MIPS queue for January 28th, 2020
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 28, 2020 at 9:19 PM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> The following changes since commit 4c60e3289875ae6c516a37523bcecb87f68ce6=
7c:
>
>   Merge remote-tracking branch 'remotes/rth/tags/pull-pa-20200127' into s=
taging (2020-01-28 15:11:04 +0000)
>
> are available in the git repository at:
>
>   https://github.com/AMarkovic/qemu tags/mips-queue-jan-28-2020
>
> for you to fetch changes up to 370bf3a4196ebef247752a68b89d497522168ebb:
>
>   target/mips: Add implementation of GINVT instruction (2020-01-28 20:52:=
20 +0100)
>
> ----------------------------------------------------------------
>

Hello, Peter,

Please discard this pull request entirely.

I will shortly send a new one. This will have some non-trivial fixes
and improvements of commit messages, but code-wise will be equivalent
to this one.

Sorry for any inconvenience.

Yours,
Aleksandar

> MIPS queue for January 28th, 2020
>
>   A diverse set of fixes and improvements:
>
>     - finalize documentation on deprecating r4k machine
>     - enable disassembler to receive target-specific data
>     - enable kernel loader to get e_flags from ELF header
>     - improve code flow in helper_do_semihosting()
>     - amend CP0 WatchHi register implementation
>     - add GINVT instruction emulation
>
> ----------------------------------------------------------------
>
> Aleksandar Markovic (2):
>   target/mips: Rectify documentation on deprecating r4k machine
>   disas: Add a field for target-dependant data
>
> Daniel Henrique Barboza (1):
>   mips-semi.c: remove 'uhi_done' label in helper_do_semihosting()
>
> Philippe Mathieu-Daud=C3=A9 (1):
>   hw/core/loader: Let load_elf() populate the processor-specific flags
>
> Yongbok Kim (2):
>   target/mips: Amend CP0 WatchHi register implementation
>   target/mips: Add implementation of GINVT instruction
>
>  disas/mips.c                   |  10 +++
>  hw/alpha/dp264.c               |   4 +-
>  hw/arm/armv7m.c                |   2 +-
>  hw/arm/boot.c                  |   2 +-
>  hw/core/generic-loader.c       |   2 +-
>  hw/core/loader.c               |  37 +++++-----
>  hw/cris/boot.c                 |   2 +-
>  hw/hppa/machine.c              |   4 +-
>  hw/i386/multiboot.c            |   2 +-
>  hw/i386/x86.c                  |   2 +-
>  hw/lm32/lm32_boards.c          |   4 +-
>  hw/lm32/milkymist.c            |   2 +-
>  hw/m68k/an5206.c               |   2 +-
>  hw/m68k/mcf5208.c              |   2 +-
>  hw/m68k/q800.c                 |   2 +-
>  hw/microblaze/boot.c           |   4 +-
>  hw/mips/mips_fulong2e.c        |   2 +-
>  hw/mips/mips_malta.c           |   3 +-
>  hw/mips/mips_mipssim.c         |   2 +-
>  hw/mips/mips_r4k.c             |   2 +-
>  hw/moxie/moxiesim.c            |   2 +-
>  hw/nios2/boot.c                |   4 +-
>  hw/openrisc/openrisc_sim.c     |   2 +-
>  hw/pci-host/prep.c             |   3 +-
>  hw/ppc/e500.c                  |   2 +-
>  hw/ppc/mac_newworld.c          |   4 +-
>  hw/ppc/mac_oldworld.c          |   4 +-
>  hw/ppc/ppc440_bamboo.c         |   2 +-
>  hw/ppc/sam460ex.c              |   3 +-
>  hw/ppc/spapr.c                 |   6 +-
>  hw/ppc/virtex_ml507.c          |   2 +-
>  hw/riscv/boot.c                |   4 +-
>  hw/s390x/ipl.c                 |   7 +-
>  hw/sparc/leon3.c               |   2 +-
>  hw/sparc/sun4m.c               |   4 +-
>  hw/sparc64/sun4u.c             |   5 +-
>  hw/tricore/tricore_testboard.c |   2 +-
>  hw/xtensa/sim.c                |   2 +-
>  hw/xtensa/xtfpga.c             |   2 +-
>  include/disas/dis-asm.h        |   3 +
>  include/hw/elf_ops.h           |   6 +-
>  include/hw/loader.h            |  21 +++---
>  qemu-deprecated.texi           |   2 +-
>  target/mips/cpu.h              |   4 +-
>  target/mips/helper.c           |  20 ++++--
>  target/mips/helper.h           |   5 ++
>  target/mips/internal.h         |   1 +
>  target/mips/machine.c          |   6 +-
>  target/mips/mips-semi.c        |  15 ++--
>  target/mips/op_helper.c        | 152 +++++++++++++++++++++++++++++++++++=
------
>  target/mips/translate.c        |  88 +++++++++++++++++++++++-
>  51 files changed, 356 insertions(+), 121 deletions(-)
>
> --
> 2.7.4
>
>

