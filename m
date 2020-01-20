Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 188E1C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:20:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF86D217F4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 22:20:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DF86D217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44812 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itfOp-0008G5-CX
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 17:19:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:51852)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itfGL-0005lw-UM
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:11:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itfGH-0000q4-Mq
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:11:13 -0500
Received: from mail-yw1-f68.google.com ([209.85.161.68]:40348)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itfGH-0000ps-J9
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 17:11:09 -0500
Received: by mail-yw1-f68.google.com with SMTP id i126so533478ywe.7
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 14:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=FOeycz1Hik4R60Yk1PrzfqoXquMK2+DP3NOFctrehTQ=;
 b=V+itgLjKJIjLPQgGnsF7TG8EdDWO+IuJfKg3gSh3dHfEAf7DdIB6sXJ2Eg36utrMlD
 NaLMX7l0RV10VtEE+5SV1WtsdrDsgJDQ91dgv51aqgP8fg/InU5ctXbc0UVOkH/fMkA5
 73guDQGOJ94oZoNmbumCSLlawwMj736ozA3INyU6+ftEYKGPahkPELISML1T4MgaFaZ7
 OuyfQJXfwFZcTZdR1IFmrKdhaYj1Ft3bIXpx8Q89rH1cNy4fR0SWcPWxHeZa277jsXYQ
 Ts07pi7Oq0dmmPsx2RdVKPc1uU4r8FzR9GwcqCNF7wpfgZDtGrKv7PhQERfT8wvdqvct
 IuYw==
X-Gm-Message-State: APjAAAXEy85Phq9eIEkH0YgBvE+0lWet/0IVhsguYshBiuKC+oxXC4qu
 Kvlf2VAVg7lLRIr9+u7HH5eGZdzFbVrWqwyz9io=
X-Google-Smtp-Source: APXvYqyT/84lQ9vtV5oa2MK62qHkxv2b7ouDfWYbuXvnHd/W/a6YWEeomZeLNWTmH5AZfOlsX8KviCMdNSG48sleJW0=
X-Received: by 2002:a81:3ad0:: with SMTP id h199mr908678ywa.37.1579558267859; 
 Mon, 20 Jan 2020 14:11:07 -0800 (PST)
MIME-Version: 1.0
References: <20200118191416.19934-1-mrolnik@gmail.com>
In-Reply-To: <20200118191416.19934-1-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Mon, 20 Jan 2020 23:10:56 +0100
Message-ID: <CAAdtpL6jxZOeofwV0e0PWNVJtrmh8Kfga_+jdYnb59=5fcF3QA@mail.gmail.com>
Subject: Re: [PATCH v41 00/21] QEMU AVR 8 bit cores
To: Michael Rolnik <mrolnik@gmail.com>, Richard Henderson <rth@twiddle.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.68
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
Cc: Igor Mammedov <imammedo@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, Jan 18, 2020 at 8:21 PM Michael Rolnik <mrolnik@gmail.com> wrote:
>
> This series of patches adds 8bit AVR cores to QEMU.
> All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not fully te=
sted yet.
> However I was able to execute simple code with functions. e.g fibonacci c=
alculation.
> This series of patches include a non real, sample board.
> No fuses support yet. PC is set to 0 at reset.
>
[...]
> Michael Rolnik (21):
>   target/avr: Add outward facing interfaces and core CPU logic
>   target/avr: Add instruction helpers
>   target/avr: Add instruction translation - Registers definition
>   target/avr: Add instruction translation - Arithmetic and Logic
>     Instructions
>   target/avr: Add instruction translation - Branch Instructions
>   target/avr: Add instruction translation - Data Transfer Instructions
>   target/avr: Add instruction translation - Bit and Bit-test
>     Instructions
>   target/avr: Add instruction translation - MCU Control Instructions
>   target/avr: Add instruction translation - CPU main translation
>     function
>   target/avr: Add instruction disassembly function
>   hw/avr: Add limited support for USART peripheral
>   hw/avr: Add limited support for 16 bit timer peripheral
>   hw/avr: Add dummy mask device
>   hw/avr: Add example board configuration
>   target/avr: Add section about AVR into QEMU documentation
>   target/avr: Register AVR support with the rest of QEMU
>   target/avr: Add machine none test
>   target/avr: Update build system
>   target/avr: Add boot serial test
>   target/avr: Add Avocado test
>   target/avr: Update MAINTAINERS file
>
>  qemu-doc.texi                    |   51 +
>  configure                        |    7 +
>  default-configs/avr-softmmu.mak  |    5 +
>  qapi/machine.json                |    3 +-
>  include/disas/dis-asm.h          |   19 +
>  include/elf.h                    |    2 +
>  include/hw/char/avr_usart.h      |   93 +
>  include/hw/elf_ops.h             |    6 +-
>  include/hw/loader.h              |    6 +-
>  include/hw/misc/avr_mask.h       |   47 +
>  include/hw/timer/avr_timer16.h   |   94 +
>  include/sysemu/arch_init.h       |    1 +
>  target/avr/cpu-param.h           |   37 +
>  target/avr/cpu-qom.h             |   54 +
>  target/avr/cpu.h                 |  259 +++
>  target/avr/helper.h              |   29 +
>  arch_init.c                      |    2 +
>  hw/avr/sample.c                  |  295 +++
>  hw/char/avr_usart.c              |  320 ++++
>  hw/core/loader.c                 |   15 +-
>  hw/misc/avr_mask.c               |  112 ++
>  hw/riscv/boot.c                  |    2 +-
>  hw/timer/avr_timer16.c           |  602 ++++++
>  target/avr/cpu.c                 |  826 ++++++++
>  target/avr/disas.c               |  245 +++
>  target/avr/gdbstub.c             |   84 +
>  target/avr/helper.c              |  347 ++++
>  target/avr/machine.c             |  121 ++
>  target/avr/translate.c           | 2997 ++++++++++++++++++++++++++++++
>  tests/qtest/boot-serial-test.c   |   10 +
>  tests/qtest/machine-none-test.c  |    1 +
>  MAINTAINERS                      |   21 +
>  gdb-xml/avr-cpu.xml              |   49 +
>  hw/Kconfig                       |    1 +
>  hw/avr/Kconfig                   |    6 +
>  hw/avr/Makefile.objs             |    1 +
>  hw/char/Kconfig                  |    3 +
>  hw/char/Makefile.objs            |    1 +
>  hw/misc/Kconfig                  |    3 +
>  hw/misc/Makefile.objs            |    2 +
>  hw/timer/Kconfig                 |    3 +
>  hw/timer/Makefile.objs           |    2 +
>  target/avr/Makefile.objs         |   34 +
>  target/avr/insn.decode           |  183 ++
>  tests/acceptance/machine_avr6.py |   53 +
>  tests/qtest/Makefile.include     |    2 +
>  46 files changed, 7044 insertions(+), 12 deletions(-)

Series:
Tested-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>

