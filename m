Return-Path: <SRS0=nJ0+=TL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BF69C04AB1
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 19:27:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8CCF217D6
	for <qemu-devel@archiver.kernel.org>; Sat, 11 May 2019 19:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QiWHcUXC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8CCF217D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34513 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hPXf3-0008LA-Ue
	for qemu-devel@archiver.kernel.org; Sat, 11 May 2019 15:27:57 -0400
Received: from eggs.gnu.org ([209.51.188.92]:49425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hPXdV-0007Pi-04
	for qemu-devel@nongnu.org; Sat, 11 May 2019 15:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <aleksandar.m.mail@gmail.com>) id 1hPXdS-0006aR-3W
	for qemu-devel@nongnu.org; Sat, 11 May 2019 15:26:20 -0400
Received: from mail-ot1-x32b.google.com ([2607:f8b0:4864:20::32b]:46165)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
	id 1hPXdM-0006MO-T8
	for qemu-devel@nongnu.org; Sat, 11 May 2019 15:26:14 -0400
Received: by mail-ot1-x32b.google.com with SMTP id j49so818097otc.13
	for <qemu-devel@nongnu.org>; Sat, 11 May 2019 12:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
	h=mime-version:in-reply-to:references:from:date:message-id:subject:to
	:cc; bh=hs4vtOZq5/5X/A7Dwzr+NLzHKsWIFjAUymLOavrrhSs=;
	b=QiWHcUXCHrH44VICcxlmHVjqqreEnPqdffSlG2AqKC/vzV1goWxveBpptvcgn5afWy
	7pC2o/AoDnOsPDMn7NPh4KMWX1OsebKJAwQOhtWMFrkRXkOg4sOF6RYgjGxaWP4Jb/Ra
	ygQLleLLD5lzo2l+Iif6DKbzKwwc6QNyGxjm0kazbcFC2ghju5enOOzwtVU3VIEL7Pe8
	ffiCNfEeVIHgo1/k4UqU4TS8jOso0wejISTYGclARTC+jUbZ+GbbdCMHsc316TNsaOT9
	enMQL2+cowKoRoyJLUOfO14zSb6DDw+0+I6dM3kGlNIxBrRa+1VIBOvmiPNHZidNFsca
	yKrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:in-reply-to:references:from:date
	:message-id:subject:to:cc;
	bh=hs4vtOZq5/5X/A7Dwzr+NLzHKsWIFjAUymLOavrrhSs=;
	b=tGfK/4FfsK1yDOEsVI3qWNPCRyerQ5U3YaxHwIU0KXg/8mS/B6cJbPJ+Qv/O4LiUpv
	RXs1/Fxr9v9OYS6osIGVWpglfGPU3inLz22ApQlnw8S4PerYkuaOOE7ecxu5oW3xECBX
	yz7GzTko/WgzERq3Xb2LlM1TK3IqK6Vr9YNSyowGvtWmgqizdiE32gt10Mj4Xdqj9kg3
	NwaZqsHV41qi77WgdIC0UzN/5DhlRwySQdD/2c5UxgwyfvuJzh88uHsS86Z+DUbPuW9Q
	dQWLLI7GbQ4PAb53X3Q6kJZ2AdIeTAByxQNw4QYKIH8WFfgxn+fZbI6n+ZiiEdeAKkyf
	bggA==
X-Gm-Message-State: APjAAAXWehMLayKANhMZoZawy5dFT+q0bPpCvGCS/21pctr9ZyTt/6V9
	cYxNWhimWGCBND2/Q3VFjE/+aCzOtySwK2cvUbg=
X-Google-Smtp-Source: APXvYqyaUstC8xnFgdT68a6jqyRhliwUTzlIedIsRtsTErC2ukqmpKzVkJVCRSbLlkcHiPu07FeefaNGxdL5MLQ5F0I=
X-Received: by 2002:a05:6830:200d:: with SMTP id
	e13mr1079623otp.304.1557602762398; 
	Sat, 11 May 2019 12:26:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Sat, 11 May 2019 12:26:01
	-0700 (PDT)
Received: by 2002:a9d:3be5:0:0:0:0:0 with HTTP; Sat, 11 May 2019 12:26:01
	-0700 (PDT)
In-Reply-To: <20190510185438.29533-1-richard.henderson@linaro.org>
References: <20190510185438.29533-1-richard.henderson@linaro.org>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sat, 11 May 2019 21:26:01 +0200
Message-ID: <CAL1e-=iAvpW8wHmoGorfi+gE=62xhwoko=3jt9xML3h69j12bw@mail.gmail.com>
To: Richard Henderson <richard.henderson@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::32b
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.21
Subject: Re: [Qemu-devel] [PULL v2 00/27] tcg: Add CPUClass::tlb_fill
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On May 10, 2019 8:55 PM, "Richard Henderson" <richard.henderson@linaro.org>
wrote:
>
> Changes in v2:
>
>   * Fix --disable-tcg compilation for x86 and s390x.
>     I adjusted every target/ that used any CONFIG_TCG in cpu.c.
>     but then afterward I see that only x86 and s390x have had
>     their Makefiles adjusted to make --disable-tcg actually work.
>
>   * Fix Werror for 64-bit on 32-bit.
>
> Only re-posting changed patches.
>

Hello, Richard.

Just want to stress that there are unaddressed concerns for patch 12/27.

Thanks,
Aleksamdar

>
> r~
>
>
> The following changes since commit
efb4f3b62c69383a7308d7b739a3193e7c0ccae8:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request'
into staging (2019-05-10 14:49:36 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/rth7680/qemu.git tags/pull-tcg-20190510
>
> for you to fetch changes up to 4811e9095c0491bc6f5450e5012c9c4796b9e59d:
>
>   tcg: Use tlb_fill probe from tlb_vaddr_to_host (2019-05-10 11:12:50
-0700)
>
> ----------------------------------------------------------------
> Add CPUClass::tlb_fill.
> Improve tlb_vaddr_to_host for use by ARM SVE no-fault loads.
>
> ----------------------------------------------------------------
> Richard Henderson (27):
>       tcg: Add CPUClass::tlb_fill
>       target/alpha: Convert to CPUClass::tlb_fill
>       target/arm: Convert to CPUClass::tlb_fill
>       target/cris: Convert to CPUClass::tlb_fill
>       target/hppa: Convert to CPUClass::tlb_fill
>       target/i386: Convert to CPUClass::tlb_fill
>       target/lm32: Convert to CPUClass::tlb_fill
>       target/m68k: Convert to CPUClass::tlb_fill
>       target/microblaze: Convert to CPUClass::tlb_fill
>       target/mips: Pass a valid error to raise_mmu_exception for user-only
>       target/mips: Tidy control flow in mips_cpu_handle_mmu_fault
>       target/mips: Convert to CPUClass::tlb_fill
>       target/moxie: Convert to CPUClass::tlb_fill
>       target/nios2: Convert to CPUClass::tlb_fill
>       target/openrisc: Convert to CPUClass::tlb_fill
>       target/ppc: Convert to CPUClass::tlb_fill
>       target/riscv: Convert to CPUClass::tlb_fill
>       target/s390x: Convert to CPUClass::tlb_fill
>       target/sh4: Convert to CPUClass::tlb_fill
>       target/sparc: Convert to CPUClass::tlb_fill
>       target/tilegx: Convert to CPUClass::tlb_fill
>       target/tricore: Convert to CPUClass::tlb_fill
>       target/unicore32: Convert to CPUClass::tlb_fill
>       target/xtensa: Convert to CPUClass::tlb_fill
>       tcg: Use CPUClass::tlb_fill in cputlb.c
>       tcg: Remove CPUClass::handle_mmu_fault
>       tcg: Use tlb_fill probe from tlb_vaddr_to_host
>
>  include/exec/cpu_ldst.h         |  50 +++--------
>  include/exec/exec-all.h         |   9 --
>  include/qom/cpu.h               |  12 ++-
>  target/alpha/cpu.h              |   5 +-
>  target/arm/internals.h          |  10 ++-
>  target/cris/cpu.h               |   5 +-
>  target/hppa/cpu.h               |   8 +-
>  target/i386/cpu.h               |   5 +-
>  target/lm32/cpu.h               |   5 +-
>  target/m68k/cpu.h               |   5 +-
>  target/microblaze/cpu.h         |   5 +-
>  target/mips/internal.h          |   5 +-
>  target/moxie/cpu.h              |   5 +-
>  target/nios2/cpu.h              |   5 +-
>  target/openrisc/cpu.h           |   5 +-
>  target/ppc/cpu.h                |   7 +-
>  target/riscv/cpu.h              |   5 +-
>  target/s390x/internal.h         |   5 +-
>  target/sh4/cpu.h                |   5 +-
>  target/sparc/cpu.h              |   5 +-
>  target/tricore/cpu.h            |   6 +-
>  target/unicore32/cpu.h          |   5 +-
>  target/xtensa/cpu.h             |   5 +-
>  accel/tcg/cputlb.c              |  88 +++++++++++++++++--
>  accel/tcg/user-exec.c           |  36 ++------
>  target/alpha/cpu.c              |   5 +-
>  target/alpha/helper.c           |  24 +++--
>  target/alpha/mem_helper.c       |  16 ----
>  target/arm/cpu.c                |  22 +----
>  target/arm/helper.c             |  90 +++++++++++--------
>  target/arm/op_helper.c          |  29 +-----
>  target/arm/sve_helper.c         |   6 +-
>  target/cris/cpu.c               |   5 +-
>  target/cris/helper.c            |  61 ++++++-------
>  target/cris/op_helper.c         |  28 ------
>  target/hppa/cpu.c               |   5 +-
>  target/hppa/mem_helper.c        |  16 ++--
>  target/i386/cpu.c               |   5 +-
>  target/i386/excp_helper.c       |  53 ++++++-----
>  target/i386/mem_helper.c        |  21 -----
>  target/lm32/cpu.c               |   5 +-
>  target/lm32/helper.c            |   8 +-
>  target/lm32/op_helper.c         |  16 ----
>  target/m68k/cpu.c               |   2 +-
>  target/m68k/helper.c            |  89 +++++++++----------
>  target/m68k/op_helper.c         |  15 ----
>  target/microblaze/cpu.c         |   5 +-
>  target/microblaze/helper.c      | 101 ++++++++++-----------
>  target/microblaze/op_helper.c   |  19 ----
>  target/mips/cpu.c               |   5 +-
>  target/mips/helper.c            |  81 ++++++++---------
>  target/mips/op_helper.c         |  15 ----
>  target/moxie/cpu.c              |   5 +-
>  target/moxie/helper.c           |  65 +++-----------
>  target/nios2/cpu.c              |   5 +-
>  target/nios2/helper.c           | 170
+++++++++++++++++-------------------
>  target/nios2/mmu.c              |  12 ---
>  target/openrisc/cpu.c           |   5 +-
>  target/openrisc/mmu.c           |  69 +++++++--------
>  target/ppc/mmu_helper.c         |  16 ++--
>  target/ppc/translate_init.inc.c |   5 +-
>  target/ppc/user_only_helper.c   |  14 +--
>  target/riscv/cpu.c              |   5 +-
>  target/riscv/cpu_helper.c       |  50 +++++------
>  target/s390x/cpu.c              |   5 +-
>  target/s390x/excp_helper.c      |  67 +++++++++-----
>  target/s390x/mem_helper.c       |  16 ----
>  target/sh4/cpu.c                |   5 +-
>  target/sh4/helper.c             | 189
+++++++++++++++++++---------------------
>  target/sh4/op_helper.c          |  12 ---
>  target/sparc/cpu.c              |   5 +-
>  target/sparc/ldst_helper.c      |  15 ----
>  target/sparc/mmu_helper.c       |  58 +++++++-----
>  target/tilegx/cpu.c             |  10 ++-
>  target/tricore/cpu.c            |   1 +
>  target/tricore/helper.c         |  23 +++--
>  target/tricore/op_helper.c      |  26 ------
>  target/unicore32/cpu.c          |   5 +-
>  target/unicore32/helper.c       |  23 -----
>  target/unicore32/op_helper.c    |  14 ---
>  target/unicore32/softmmu.c      |  13 ++-
>  target/xtensa/cpu.c             |   5 +-
>  target/xtensa/helper.c          |  33 ++++---
>  83 files changed, 868 insertions(+), 1131 deletions(-)
>
