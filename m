Return-Path: <SRS0=QduX=3Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D353C2D0B1
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:31:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 372972084E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Feb 2020 12:31:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Bfe+c+hr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 372972084E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57462 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyxMg-00026q-Ej
	for qemu-devel@archiver.kernel.org; Tue, 04 Feb 2020 07:31:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iyxLQ-0001Mp-BT
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:30:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iyxLN-0005lj-6e
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:30:20 -0500
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:46339)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iyxLL-0005j9-Gw
 for qemu-devel@nongnu.org; Tue, 04 Feb 2020 07:30:15 -0500
Received: by mail-ot1-x344.google.com with SMTP id g64so16857269otb.13
 for <qemu-devel@nongnu.org>; Tue, 04 Feb 2020 04:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JbvKPkW9GRFjDx6pR0+UM4e26jfwL9MyJeS6U1mOaoI=;
 b=Bfe+c+hrTpuU0pfsFaSvT7NIk9sQyrcX1PVQVk7m9cjfGDatJZRKV5CBSQZlSQBetU
 ha1tK0jB397cEth44yegs71qtNTu3kNQkzk8TPI5vnW5woFXCUtos07In9ldM5mRi1/9
 xAk8pAww85dLwPAbIfP2sBVnLnaI81qNYnv+D2zu+OTykTij8soRXjXu2pRhJY4DwGmy
 pPVwMaJxbDzYDzTjdFOLUhW6U8ucYJQkWH+6yXw7v6K+0LpINi/BAlkqRNJQ6qw89m6N
 YUfxeCadtPdQ81t38tuqDma+s1qrKzbVjmcWrs643WOXqNRQOyzSZOgkPKNahm+Qt/a2
 ZRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JbvKPkW9GRFjDx6pR0+UM4e26jfwL9MyJeS6U1mOaoI=;
 b=kq2ie/f4ve5g3CtHySUZskmj1xud/J+t8O6LAKlcZGUARkhWgxfsfXspQjYdAXjxQa
 O6LFINsDE2s27+4Pf0yoBEkaCUHDNSXBdew2vNbWS0dU6ta0/Fupi6sH6rD5BzKbg/XS
 kAT6nigZ1JnkbHc55iHN5WTYCXM4/4TICxltgUYHtlxNz3r9/zXr3TTkoaYWVUCtrDxq
 wR7yILh5iqyjnJQ32RH/rmzR43MxEf5Hzo7tkayai1Q7g0Qxv2RsjwyMUuUUTcArdnXH
 H0ChETipg6zJnYO65MrGEYLSjOLaWB3yRySl+MrP07lwjGopX8Gjkgit46Lk56QbkP6F
 AHZQ==
X-Gm-Message-State: APjAAAWM7gDxk3IkPoOLiCHo8oMCHJyknD1AoorIFlEwXVlew/jU3jBU
 wYTtyJyyZlYmOlhRVhMmJOKu3zqhT58WUQQs3RY=
X-Google-Smtp-Source: APXvYqw5CTa3DKDgrmTKK7yjh8EGBGvfjTkwegECFqqtMh4eqJxL0UNiG0yxybwp7XcWBe46bJvE/eLsg/tYaF0PAQE=
X-Received: by 2002:a05:6830:12c3:: with SMTP id
 a3mr22921786otq.341.1580819414487; 
 Tue, 04 Feb 2020 04:30:14 -0800 (PST)
MIME-Version: 1.0
References: <1580818058-16159-1-git-send-email-aleksandar.markovic@rt-rk.com>
In-Reply-To: <1580818058-16159-1-git-send-email-aleksandar.markovic@rt-rk.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Tue, 4 Feb 2020 13:30:03 +0100
Message-ID: <CAL1e-=jSJvwsqMsZfxy-D255hZ6SWPMv_xTXeCEyX7DGjhVE3w@mail.gmail.com>
Subject: Re: [PATCH 0/9] linux-user: Update syscall numbers to kernel 5.5 level
To: Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Marek Vasut <marex@denx.de>, Peter Maydell <peter.maydell@linaro.org>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 David Hildenbrand <david@redhat.com>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Chris Wulff <crwulff@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 QEMU Developers <qemu-devel@nongnu.org>, Laurent Vivier <laurent@vivier.eu>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Aleksandar Markovic <amarkovic@wavecomp.com>,
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, Stafford Horne <shorne@gmail.com>,
 Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Feb 4, 2020 at 1:08 PM Aleksandar Markovic
<aleksandar.markovic@rt-rk.com> wrote:
>
> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>
> Hello, folks!
>
> This series is a spin-off of another larger linux-user series
> that become too large to handle, hence these patches related to
> syscall numbers are now in this, separate, series.
>

I forgot to say that, compared to the previous larger linux-user
series, two new patches are added (arm and sh4 related), and
the remaining seven patches are identical (except that "R-b:"s
and "A-b:"s are added when needed).

Sincerely,
Aleksandar

> Now that kernel 5.5 is released few days ago, it is time to
> reflect what can be updated in linux-user for upcomming QEMU 5.0.
>
> An obvoius kernel change we should take into account are new
> system calls, and the foirst step is updating syscall numbers
> mainteined within QEMU linux-user.
>
> Regarding kernel syscal numbers there is good news and bad news.
>
> The good news is that kernel developers decided to make future
> syscall numbers much more synchonized accross architectures than
> before. They already reached that state.
>
> The bad news is that we in QEMU did not reach that state yet, since
> we lag after kernel significantly.
>
> The good news again is that we will reach that state if we update
> syscall numbers accross the board now. This is the main intention
> and motivation of this series.
>
> The bad news again is that in order to update syscall numebrs we
> need to be very careful at this moment. There are a number of new
> syscalls added to the kernel recently that QEMU doesn't know about
> at all. Significant number of new syscalls deal with 32/64-bit
> compatibility, traditionally a problematic area in kernel, and in
> QEMU as well. Moreover, some of the new syscalls are applicable to
> 32-bit architectures only.
>
> This series covers updating syscall numbers defined in the following
> files:
>
>   - linux-user/alpha/syscall_nr.h
>   - linux-user/arm/syscall_nr.h
>   - linux-user/m68k/syscall_nr.h
>   - linux-user/microblaze/syscall_nr.h
>   - linux-user/mips/cpu_loop.c
>   - linux-user/mips/syscall_nr.h
>   - linux-user/mips64/syscall_nr.h
>   - linux-user/sh4/syscall_nr.h
>   - linux-user/x86_64/syscall_nr.h
>   - linux-user/xtensa/syscall_nr.h
>
> This series doesn't cover following files (since they use certain
> proprietary rules for mapping between kernel source and qemu source,
> I don't feel quite comfortable changing them - therefore I am asking
> corresponding target maintainers or Lauren to update them, if
> possible, before our 5.0 release):
>
>   - linux-user/aarch64/syscall_nr.h
>   - linux-user/i386/syscall_nr.h
>   - linux-user/nios2/syscall_nr.h
>   - linux-user/ppc/syscall_nr.h
>   - linux-user/riscv/syscall_nr.h
>   - linux-user/s390x/syscall_nr.h
>   - linux-user/sparc/syscall_nr.h
>   - linux-user/sparc64/syscall_nr.h
>
> CC: Peter Maydell <peter.maydell@linaro.org>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Eduardo Habkost <ehabkost@redhat.com>
> CC: Chris Wulff <crwulff@gmail.com>
> CC: Marek Vasut <marex@denx.de>
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Palmer Dabbelt <palmer@dabbelt.com>
> CC: Alistair Francis <Alistair.Francis@wdc.com>
> CC: Sagar Karandikar <sagark@eecs.berkeley.edu>
> CC: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
> CC: David Hildenbrand <david@redhat.com>
> CC: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Artyom Tarasenko <atar4qemu@gmail.com>
>
> This series also doesn't cover following files (since I can't find
> corresponding kernel code - and I am also asking corresponding
> target maintainers or Lauren to update them, if possible, before
> our 5.0 release):
>
>   - linux-user/cris/cpu_loop.c
>   - linux-user/hppa/syscall_nr.h
>   - linux-user/openrisc/syscall_nr.h
>   - linux-user/tilegx/syscall_nr.h
>
> CC: Edgar E. Iglesias <edgar.iglesias@gmail.com>
> CC: Richard Henderson <rth@twiddle.net>
> CC: Stafford Horne <shorne@gmail.com>
>
> Again, I don't plan (I am really running out of time resources) to
> work in a significant way on this issue any more, and I am asking
> you guys other maintainers to help finish updating syscall numbers
> before QEMU 5.0 release.
>
> Once we do that, updating syscall numbers in QEMU should and will
> be significantly easier.
>
> Thanks in advance!
>
> Truly yours,
> Aleksandar
>
> -----------------------------------------------------------------------
>
> Aleksandar Markovic (9):
>   linux-user: alpha: Update syscall numbers to kernel 5.5 level
>   linux-user: arm: Update syscall numbers to kernel 5.5 level
>   linux-user: m68k: Update syscall numbers to kernel 5.5 level
>   linux-user: microblaze: Update syscall numbers to kernel 5.5 level
>   linux-user: mips: Update syscall numbers to kernel 5.5 level
>   linux-user: sh4: Update syscall numbers to kernel 5.5 level
>   linux-user: x86_64: Update syscall numbers to kernel 5.5 level
>   linux-user: xtensa: Update syscall numbers to kernel 5.5 level
>   linux-user: xtensa: Remove unused constant TARGET_NR_syscall_count
>
>  linux-user/alpha/syscall_nr.h      | 35 +++++++++++++++++
>  linux-user/arm/syscall_nr.h        | 44 +++++++++++++++++++++
>  linux-user/m68k/syscall_nr.h       | 50 +++++++++++++++++++++++-
>  linux-user/microblaze/syscall_nr.h | 45 ++++++++++++++++++++++
>  linux-user/mips/cpu_loop.c         | 78 +++++++++++++++++++++++++++++++++++++-
>  linux-user/mips/syscall_nr.h       | 45 ++++++++++++++++++++++
>  linux-user/mips64/syscall_nr.h     | 13 +++++++
>  linux-user/sh4/syscall_nr.h        | 48 +++++++++++++++++++++++
>  linux-user/x86_64/syscall_nr.h     | 24 ++++++++++++
>  linux-user/xtensa/syscall_nr.h     | 36 +++++++++++++++++-
>  10 files changed, 414 insertions(+), 4 deletions(-)
>
> --
> 2.7.4
>
>

