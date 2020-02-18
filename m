Return-Path: <SRS0=v1sw=4G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92716C34031
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:57:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CE7B24654
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2020 22:57:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BVxxHP2R"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CE7B24654
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42990 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j4Bnd-0004So-F0
	for qemu-devel@archiver.kernel.org; Tue, 18 Feb 2020 17:57:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37085)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alistair23@gmail.com>) id 1j4BmY-00040K-RF
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:56:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alistair23@gmail.com>) id 1j4BmX-0002Yp-3V
 for qemu-devel@nongnu.org; Tue, 18 Feb 2020 17:55:58 -0500
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144]:36895)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alistair23@gmail.com>)
 id 1j4BmR-0002Ri-MM; Tue, 18 Feb 2020 17:55:52 -0500
Received: by mail-lf1-x144.google.com with SMTP id b15so15806556lfc.4;
 Tue, 18 Feb 2020 14:55:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=56r9BUQhtjW1HnQ+Svvoir1aBWB3qyGE9cLA9OhOX/w=;
 b=BVxxHP2Rt6J2oImSNP+x3yeUhE6js9GBKrNXYSklEzI3tVBRB4sSSXLHaI8B3mWg3I
 LtBFIkYE3Z9b2Fff9/lRT1JhqSWsDVEjRDHC2pAOJHUVEXUG4XGk06vIwVhRhYq5tg+R
 rbf3CwJy+i8lIO15RLeszkb5d1TkVatU0eFyLxNwdbSP5y6MmQUS30wEpwcyyWfnZtAR
 EFoFyx0Ki5MtIoaMeqFNvDmW5/+Re37pSQGmSOzbBwc1c/pjZouif6jRCIEahsnWGIt9
 5JVJb5YvTk9seJZ986B5xe/kg7sNRCY3TS2boc0GDMrlyOdcF9GQGO0mbERg8nhqFO/6
 h/tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=56r9BUQhtjW1HnQ+Svvoir1aBWB3qyGE9cLA9OhOX/w=;
 b=eac5mu+egm3k4+cj8WPyFrq43Plh5ynSe9dI7UiYalZhpz/EYN3wRhsCh+3D8Ghwet
 p1Wl8tAolrqG1pPOrkhvPoBFzrwTLmvBVFBKbg0LCd2wwIfh90GJ0XjJOIckGf0Dn27L
 25lJztrltaxRkniSrUvYYvOTX2588EUCEDjLZ0drjHDIAm0AumqWtVfIr9TbYDwy5uXa
 8oTlpByPOD0ztL+W1gBPK6+Dfr/kyPULv07LEnvKK1VJ95jg/qgIZHW/s56En/0AIVJi
 hdcpGYd9KtspuGwRozk7ay87h/E5fLnwlovtE7ZMvtUlBD/Hmah9MdR1rrHIBSm5d3Jm
 IeDQ==
X-Gm-Message-State: APjAAAVBEL3jcNdF2c64QWnrY06Mpoa0RBDdaSjKXVHb2xu6fsFQIPOh
 HCg1FZHNXfQabdsgLxp7ZnCMQcSfmKmTt/ocZPA=
X-Google-Smtp-Source: APXvYqz81NwKIitn+7BRH8ap5g8oQYGSEZm3ZZB/Y3T1aVNMMowTukxLWKZKwXbzjea0ZWk5/uXPIvheaJPFQDHwu80=
X-Received: by 2002:ac2:5f68:: with SMTP id c8mr11315422lfc.196.1582066549902; 
 Tue, 18 Feb 2020 14:55:49 -0800 (PST)
MIME-Version: 1.0
References: <20200217223558.863199-1-laurent@vivier.eu>
In-Reply-To: <20200217223558.863199-1-laurent@vivier.eu>
From: Alistair Francis <alistair23@gmail.com>
Date: Tue, 18 Feb 2020 14:48:23 -0800
Message-ID: <CAKmqyKNjL-+H_7wwK5iU4uZS2LALCw_GZnSHeRdphGQvOsc8SA@mail.gmail.com>
Subject: Re: [PATCH 00/22] linux-user: generate syscall_nr.sh
To: Laurent Vivier <laurent@vivier.eu>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::144
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
Cc: Cornelia Huck <cohuck@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 qemu-s390x <qemu-s390x@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 Aleksandar Rikalo <aleksandar.rikalo@rt-rk.com>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Feb 17, 2020 at 2:36 PM Laurent Vivier <laurent@vivier.eu> wrote:
>
> This series copies the files syscall.tbl from linux v5.5 and generates
> the file syscall_nr.h from them.
>
> This is done for all the QEMU targets that have a syscall.tbl
> in the linux source tree: mips, mips64, i386, x86_64, sparc, s390x,
> ppc, arm, microblaze, sh4, xtensa, m68k, hppa and alpha.
>
> tilegx and cris are depecrated in linux (tilegx has no maintainer in QEMU)
>
> aarch64, nios2, openrisc and riscv have no syscall.tbl in linux.

What's the plan with these other architectures?

RISC-V uses asm-generic, is there some way to generate syscall_nr.h from that?

Alistair

>
> It seems there is a bug in QEMU that forces to disable manually arch_prctl
> with i386 target: do_arch_prctl() is only defined with TARGET_ABI32 but
> TARGET_ABI32 is never defined with TARGET_I386 (nor TARGET_X86_64).
>
> I have also removed all syscalls in s390x/syscall_nr.h defined for
> !defined(TARGET_S390X).
>
> I have added a script to copy all these files from linux and updated
> them at the end of the series with their latest version for today.
>
> The two last patches manage the special case for mips O32 that needs
> to know the number of arguments. We find them in strace sources.
>
> Laurent Vivier (22):
>   linux-user: introduce parameters to generate syscall_nr.h
>   linux-user,alpha: add syscall table generation support
>   linux-user,hppa: add syscall table generation support
>   linux-user,m68k: add syscall table generation support
>   linux-user,xtensa: add syscall table generation support
>   linux-user,sh4: add syscall table generation support
>   linux-user,microblaze: add syscall table generation support
>   linux-user,arm: add syscall table generation support
>   linux-user,ppc: split syscall_nr.h
>   linux-user,ppc: add syscall table generation support
>   linux-user,s390x: remove syscall definitions for !TARGET_S390X
>   linux-user,s390x: add syscall table generation support
>   linux-user,sparc,sparc64: add syscall table generation support
>   linux-user,i386: add syscall table generation support
>   linux-user,x86_64: add syscall table generation support
>   linux-user,mips: add syscall table generation support
>   linux-user,mips64: split syscall_nr.h
>   linux-user,mips64: add syscall table generation support
>   linux-user,scripts: add a script to update syscall.tbl
>   linux-user: update syscall.tbl from linux 0bf999f9c5e7
>   linux-user,mips: move content of mips_syscall_args
>   linux-user,mips: update syscall-args-o32.c.inc
>
>  MAINTAINERS                            |   1 +
>  Makefile.target                        |   3 +-
>  configure                              |  23 +
>  linux-user/Makefile.objs               |  19 +-
>  linux-user/alpha/Makefile.objs         |   5 +
>  linux-user/alpha/syscall.tbl           | 479 ++++++++++++++++
>  linux-user/alpha/syscall_nr.h          | 492 -----------------
>  linux-user/alpha/syscallhdr.sh         |  32 ++
>  linux-user/arm/Makefile.objs           |   8 +
>  linux-user/arm/syscall.tbl             | 453 ++++++++++++++++
>  linux-user/arm/syscall_nr.h            | 447 ---------------
>  linux-user/arm/syscallhdr.sh           |  31 ++
>  linux-user/hppa/Makefile.objs          |   5 +
>  linux-user/hppa/syscall.tbl            | 437 +++++++++++++++
>  linux-user/hppa/syscall_nr.h           | 358 ------------
>  linux-user/hppa/syscallhdr.sh          |  32 ++
>  linux-user/i386/Makefile.objs          |   5 +
>  linux-user/i386/syscall_32.tbl         | 444 +++++++++++++++
>  linux-user/i386/syscall_nr.h           | 387 -------------
>  linux-user/i386/syscallhdr.sh          |  28 +
>  linux-user/m68k/Makefile.objs          |   5 +
>  linux-user/m68k/syscall.tbl            | 439 +++++++++++++++
>  linux-user/m68k/syscall_nr.h           | 434 ---------------
>  linux-user/m68k/syscallhdr.sh          |  32 ++
>  linux-user/microblaze/Makefile.objs    |   5 +
>  linux-user/microblaze/syscall.tbl      | 445 +++++++++++++++
>  linux-user/microblaze/syscall_nr.h     | 442 ---------------
>  linux-user/microblaze/syscallhdr.sh    |  32 ++
>  linux-user/mips/Makefile.objs          |   5 +
>  linux-user/mips/cpu_loop.c             | 440 +--------------
>  linux-user/mips/syscall-args-o32.c.inc | 436 +++++++++++++++
>  linux-user/mips/syscall_nr.h           | 425 ---------------
>  linux-user/mips/syscall_o32.tbl        | 427 +++++++++++++++
>  linux-user/mips/syscallhdr.sh          |  36 ++
>  linux-user/mips64/Makefile.objs        |   9 +
>  linux-user/mips64/syscall_n32.tbl      | 378 +++++++++++++
>  linux-user/mips64/syscall_n64.tbl      | 354 ++++++++++++
>  linux-user/mips64/syscall_nr.h         | 719 +------------------------
>  linux-user/mips64/syscallhdr.sh        |  33 ++
>  linux-user/ppc/Makefile.objs           |   9 +
>  linux-user/ppc/signal.c                |   2 +-
>  linux-user/ppc/syscall.tbl             | 521 ++++++++++++++++++
>  linux-user/ppc/syscall_nr.h            | 394 +-------------
>  linux-user/ppc/syscallhdr.sh           |  34 ++
>  linux-user/s390x/Makefile.objs         |   5 +
>  linux-user/s390x/syscall.tbl           | 442 +++++++++++++++
>  linux-user/s390x/syscall_nr.h          | 398 --------------
>  linux-user/s390x/syscallhdr.sh         |  32 ++
>  linux-user/sh4/Makefile.objs           |   5 +
>  linux-user/sh4/syscall.tbl             | 442 +++++++++++++++
>  linux-user/sh4/syscall_nr.h            | 441 ---------------
>  linux-user/sh4/syscallhdr.sh           |  32 ++
>  linux-user/sparc/Makefile.objs         |   5 +
>  linux-user/sparc/syscall.tbl           | 485 +++++++++++++++++
>  linux-user/sparc/syscall_nr.h          | 363 -------------
>  linux-user/sparc/syscallhdr.sh         |  32 ++
>  linux-user/sparc64/Makefile.objs       |   5 +
>  linux-user/sparc64/syscall.tbl         | 485 +++++++++++++++++
>  linux-user/sparc64/syscall_nr.h        | 366 -------------
>  linux-user/sparc64/syscallhdr.sh       |  32 ++
>  linux-user/x86_64/Makefile.objs        |   5 +
>  linux-user/x86_64/syscall_64.tbl       | 404 ++++++++++++++
>  linux-user/x86_64/syscall_nr.h         | 356 ------------
>  linux-user/x86_64/syscallhdr.sh        |  28 +
>  linux-user/xtensa/Makefile.objs        |   5 +
>  linux-user/xtensa/syscall.tbl          | 410 ++++++++++++++
>  linux-user/xtensa/syscall_nr.h         | 469 ----------------
>  linux-user/xtensa/syscallhdr.sh        |  32 ++
>  scripts/update-mips-syscall-args.sh    |  57 ++
>  scripts/update-syscalltbl.sh           |  49 ++
>  70 files changed, 8201 insertions(+), 6929 deletions(-)
>  create mode 100644 linux-user/alpha/Makefile.objs
>  create mode 100644 linux-user/alpha/syscall.tbl
>  delete mode 100644 linux-user/alpha/syscall_nr.h
>  create mode 100644 linux-user/alpha/syscallhdr.sh
>  create mode 100644 linux-user/arm/Makefile.objs
>  create mode 100644 linux-user/arm/syscall.tbl
>  delete mode 100644 linux-user/arm/syscall_nr.h
>  create mode 100644 linux-user/arm/syscallhdr.sh
>  create mode 100644 linux-user/hppa/Makefile.objs
>  create mode 100644 linux-user/hppa/syscall.tbl
>  delete mode 100644 linux-user/hppa/syscall_nr.h
>  create mode 100644 linux-user/hppa/syscallhdr.sh
>  create mode 100644 linux-user/i386/Makefile.objs
>  create mode 100644 linux-user/i386/syscall_32.tbl
>  delete mode 100644 linux-user/i386/syscall_nr.h
>  create mode 100644 linux-user/i386/syscallhdr.sh
>  create mode 100644 linux-user/m68k/Makefile.objs
>  create mode 100644 linux-user/m68k/syscall.tbl
>  delete mode 100644 linux-user/m68k/syscall_nr.h
>  create mode 100644 linux-user/m68k/syscallhdr.sh
>  create mode 100644 linux-user/microblaze/Makefile.objs
>  create mode 100644 linux-user/microblaze/syscall.tbl
>  delete mode 100644 linux-user/microblaze/syscall_nr.h
>  create mode 100644 linux-user/microblaze/syscallhdr.sh
>  create mode 100644 linux-user/mips/Makefile.objs
>  create mode 100644 linux-user/mips/syscall-args-o32.c.inc
>  delete mode 100644 linux-user/mips/syscall_nr.h
>  create mode 100644 linux-user/mips/syscall_o32.tbl
>  create mode 100644 linux-user/mips/syscallhdr.sh
>  create mode 100644 linux-user/mips64/Makefile.objs
>  create mode 100644 linux-user/mips64/syscall_n32.tbl
>  create mode 100644 linux-user/mips64/syscall_n64.tbl
>  create mode 100644 linux-user/mips64/syscallhdr.sh
>  create mode 100644 linux-user/ppc/Makefile.objs
>  create mode 100644 linux-user/ppc/syscall.tbl
>  create mode 100644 linux-user/ppc/syscallhdr.sh
>  create mode 100644 linux-user/s390x/Makefile.objs
>  create mode 100644 linux-user/s390x/syscall.tbl
>  delete mode 100644 linux-user/s390x/syscall_nr.h
>  create mode 100755 linux-user/s390x/syscallhdr.sh
>  create mode 100644 linux-user/sh4/Makefile.objs
>  create mode 100644 linux-user/sh4/syscall.tbl
>  delete mode 100644 linux-user/sh4/syscall_nr.h
>  create mode 100644 linux-user/sh4/syscallhdr.sh
>  create mode 100644 linux-user/sparc/Makefile.objs
>  create mode 100644 linux-user/sparc/syscall.tbl
>  delete mode 100644 linux-user/sparc/syscall_nr.h
>  create mode 100644 linux-user/sparc/syscallhdr.sh
>  create mode 100644 linux-user/sparc64/Makefile.objs
>  create mode 100644 linux-user/sparc64/syscall.tbl
>  delete mode 100644 linux-user/sparc64/syscall_nr.h
>  create mode 100644 linux-user/sparc64/syscallhdr.sh
>  create mode 100644 linux-user/x86_64/Makefile.objs
>  create mode 100644 linux-user/x86_64/syscall_64.tbl
>  delete mode 100644 linux-user/x86_64/syscall_nr.h
>  create mode 100644 linux-user/x86_64/syscallhdr.sh
>  create mode 100644 linux-user/xtensa/Makefile.objs
>  create mode 100644 linux-user/xtensa/syscall.tbl
>  delete mode 100644 linux-user/xtensa/syscall_nr.h
>  create mode 100644 linux-user/xtensa/syscallhdr.sh
>  create mode 100755 scripts/update-mips-syscall-args.sh
>  create mode 100755 scripts/update-syscalltbl.sh
>
> --
> 2.24.1
>
>

