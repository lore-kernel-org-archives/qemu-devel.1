Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E0CAC433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 08:59:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 191BD2077D
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 08:59:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YFBFD9zh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 191BD2077D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juBMT-0002oN-Cv
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 04:59:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60590)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juBLc-0002Aj-Aj
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 04:59:05 -0400
Received: from mail-wr1-x435.google.com ([2a00:1450:4864:20::435]:32831)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1juBLa-0000G7-FR
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 04:59:04 -0400
Received: by mail-wr1-x435.google.com with SMTP id f18so8156746wrs.0
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 01:59:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Nlmz2E4IfyuOxyhM/Y94bRYzo6veeSfG1vv4fdlgl2w=;
 b=YFBFD9zhzoo1vDvNrvAfqpTdtCd4fcfcFjlgXgvc/yTO5F/6fR0/YdLVdDnChcxkS7
 /S0f3GLcixVhyy1YvhzbxbHh/4nkRwHNv6tpOBrdId39gEk3Gk/buVy3cNsc2fqt1DSv
 mvV9nqFdqcLCrBRhZdGNNL/ahkQL95wCD/hWcAMjocOKsPkYxk+z74foAnQJFojeLTXD
 9p4G8htcwl1dEbnLkZt7FYWqbIAFCkhEhY6H1Mmdd6UUnldFLhbdq4laBOSmA6Iuio1I
 FFbRXH+5NlJ549O0uR7igJUBfyoTv4CfzHzydqcdS6IWr82a9hsGBGJdii8DqCLaU2KU
 6e1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Nlmz2E4IfyuOxyhM/Y94bRYzo6veeSfG1vv4fdlgl2w=;
 b=Ek3tOUt7KW00YYA3v5wxl9ssjg2cWzB3svU7eN81xhhCHeoBuEv/iFUTdOxcVSuwso
 C7AUlljjeFb5c9Cc9UDUjHnoJLLxZQbbK1WyjSJzrbIX8MwPF/pmzUsNyznqaFL41IwT
 tLv3yOYNBS6wIjibZcECvEDMeuuaf6WAxgK4kr14byK/P4wtsHWEQyq9/u/my8WRbUOU
 yb3Rc8hJAwSCeA5ZVEOkM0v44LVTX7QpgejIrnIW5d7ZHIXRNk/E0X99xYRptPq5TCud
 IvuuTIcUGd7xC/kwVqLKw2RvjNejehqUQfQ5jyzk9tMM38/IISrBWaIyJva4378T2mbg
 IEqA==
X-Gm-Message-State: AOAM532jLAP37HUFGnpN0xAMlYQfk0/1OZIRNsNY8HkMv6EPchrMX3pa
 ZiouzrtfUeTW/S0AO9mwKkw=
X-Google-Smtp-Source: ABdhPJw//R+6ahlMtM/WlfhuSFLfeewI3actdI0cFwo9TApMuArwCr6Mpj0DYgCSAaLPG3+rr/Fz8Q==
X-Received: by 2002:adf:e80d:: with SMTP id o13mr39311149wrm.112.1594457940997; 
 Sat, 11 Jul 2020 01:59:00 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id d28sm13477131wrc.50.2020.07.11.01.59.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Jul 2020 01:59:00 -0700 (PDT)
Subject: Re: [PULL v2 00/32] AVR port
To: qemu-devel@nongnu.org
References: <20200710170447.23412-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <ade9c405-0919-d1df-1175-354eade56f9b@amsat.org>
Date: Sat, 11 Jul 2020 10:58:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200710170447.23412-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::435;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x435.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
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
Cc: Thomas Huth <huth@tuxfamily.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Peter, please disregard this pullreq as I committed an incorrect line
while rebasing the fix :/ I'll send v3 shortly.

On 7/10/20 7:04 PM, Philippe Mathieu-Daudé wrote:
> Since v1:
> 
> Fixed issue on big-endian host reported by Peter Maydell.
> 
> Possible false-positives from checkpatch:
> 
>   WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
> 
> The following changes since commit f2a1cf9180f63e88bb38ff21c169da97c3f2bad5:
> 
>   Merge remote-tracking branch 'remotes/armbru/tags/pull-error-2020-07-07-v2'=
>  into staging (2020-07-10 14:41:23 +0100)
> 
> are available in the Git repository at:
> 
>   https://gitlab.com/philmd/qemu.git tags/avr-port-20200710
> 
> for you to fetch changes up to 23623ca1f27427d76cc111eb567cac6ce18dab3a:
> 
>   target/avr/disas: Fix store instructions display order (2020-07-10 18:13:39=
>  +0200)
> 
> ----------------------------------------------------------------
> 8bit AVR port from Michael Rolnik.
> 
> Michael started to work on the AVR port few years ago [*] and kept
> improving the code over various series.
> 
> List of people who help him (in chronological order):
> - Richard Henderson
> - Sarah Harris and Edward Robbins
> - Philippe Mathieu-Daud=C3=A9 and Aleksandar Markovic
> - Pavel Dovgalyuk
> - Thomas Huth
> 
> [*] The oldest contribution I could find on the list is from 2016:
> https://lists.nongnu.org/archive/html/qemu-devel/2016-06/msg02985.html
> 
> ----------------------------------------------------------------
> 
> Michael Rolnik (25):
>   target/avr: Add basic parameters of the new platform
>   target/avr: Introduce basic CPU class object
>   target/avr: CPU class: Add interrupt handling support
>   target/avr: CPU class: Add memory management support
>   target/avr: CPU class: Add migration support
>   target/avr: CPU class: Add GDB support
>   target/avr: Introduce enumeration AVRFeature
>   target/avr: Add definitions of AVR core types
>   target/avr: Add instruction helpers
>   target/avr: Add instruction translation - Register definitions
>   target/avr: Add instruction translation - Arithmetic and Logic
>     Instructions
>   target/avr: Add instruction translation - Branch Instructions
>   target/avr: Add instruction translation - Data Transfer Instructions
>   target/avr: Add instruction translation - Bit and Bit-test
>     Instructions
>   target/avr: Add instruction translation - MCU Control Instructions
>   target/avr: Add instruction translation - CPU main translation
>     function
>   target/avr: Initialize TCG register variables
>   target/avr: Add support for disassembling via option '-d in_asm'
>   target/avr: Register AVR support with the rest of QEMU
>   tests/machine-none: Add AVR support
>   hw/char: avr: Add limited support for USART peripheral
>   hw/timer: avr: Add limited support for 16-bit timer peripheral
>   hw/misc: avr: Add limited support for power reduction device
>   tests/boot-serial: Test some Arduino boards (AVR based)
>   tests/acceptance: Test the Arduino MEGA2560 board
> 
> Philippe Mathieu-Daud=C3=A9 (6):
>   hw/avr: Add support for loading ELF/raw binaries
>   hw/avr: Add some ATmega microcontrollers
>   hw/avr: Add limited support for some Arduino boards
>   target/avr/cpu: Drop tlb_flush() in avr_cpu_reset()
>   target/avr/cpu: Fix $PC displayed address
>   target/avr/disas: Fix store instructions display order
> 
> Thomas Huth (1):
>   target/avr: Add section into QEMU documentation
> 
>  docs/system/target-avr.rst       |   37 +
>  docs/system/targets.rst          |    1 +
>  configure                        |    7 +
>  default-configs/avr-softmmu.mak  |    5 +
>  qapi/machine.json                |    3 +-
>  hw/avr/atmega.h                  |   48 +
>  hw/avr/boot.h                    |   33 +
>  include/disas/dis-asm.h          |   19 +
>  include/elf.h                    |    4 +
>  include/hw/char/avr_usart.h      |   93 +
>  include/hw/misc/avr_power.h      |   46 +
>  include/hw/timer/avr_timer16.h   |   94 +
>  include/sysemu/arch_init.h       |    1 +
>  target/avr/cpu-param.h           |   36 +
>  target/avr/cpu-qom.h             |   53 +
>  target/avr/cpu.h                 |  256 +++
>  target/avr/helper.h              |   29 +
>  target/avr/insn.decode           |  187 ++
>  arch_init.c                      |    2 +
>  hw/avr/arduino.c                 |  149 ++
>  hw/avr/atmega.c                  |  458 +++++
>  hw/avr/boot.c                    |  115 ++
>  hw/char/avr_usart.c              |  320 ++++
>  hw/misc/avr_power.c              |  113 ++
>  hw/timer/avr_timer16.c           |  621 ++++++
>  target/avr/cpu.c                 |  366 ++++
>  target/avr/disas.c               |  245 +++
>  target/avr/gdbstub.c             |   84 +
>  target/avr/helper.c              |  348 ++++
>  target/avr/machine.c             |  119 ++
>  target/avr/translate.c           | 3061 ++++++++++++++++++++++++++++++
>  tests/qtest/boot-serial-test.c   |   11 +
>  tests/qtest/machine-none-test.c  |    1 +
>  MAINTAINERS                      |   30 +
>  gdb-xml/avr-cpu.xml              |   49 +
>  hw/Kconfig                       |    1 +
>  hw/avr/Kconfig                   |    9 +
>  hw/avr/Makefile.objs             |    3 +
>  hw/char/Kconfig                  |    3 +
>  hw/char/Makefile.objs            |    1 +
>  hw/misc/Kconfig                  |    3 +
>  hw/misc/Makefile.objs            |    2 +
>  hw/misc/trace-events             |    4 +
>  hw/timer/Kconfig                 |    3 +
>  hw/timer/Makefile.objs           |    2 +
>  hw/timer/trace-events            |   12 +
>  target/avr/Makefile.objs         |   34 +
>  tests/acceptance/machine_avr6.py |   50 +
>  tests/qtest/Makefile.include     |    2 +
>  49 files changed, 7172 insertions(+), 1 deletion(-)
>  create mode 100644 docs/system/target-avr.rst
>  create mode 100644 default-configs/avr-softmmu.mak
>  create mode 100644 hw/avr/atmega.h
>  create mode 100644 hw/avr/boot.h
>  create mode 100644 include/hw/char/avr_usart.h
>  create mode 100644 include/hw/misc/avr_power.h
>  create mode 100644 include/hw/timer/avr_timer16.h
>  create mode 100644 target/avr/cpu-param.h
>  create mode 100644 target/avr/cpu-qom.h
>  create mode 100644 target/avr/cpu.h
>  create mode 100644 target/avr/helper.h
>  create mode 100644 target/avr/insn.decode
>  create mode 100644 hw/avr/arduino.c
>  create mode 100644 hw/avr/atmega.c
>  create mode 100644 hw/avr/boot.c
>  create mode 100644 hw/char/avr_usart.c
>  create mode 100644 hw/misc/avr_power.c
>  create mode 100644 hw/timer/avr_timer16.c
>  create mode 100644 target/avr/cpu.c
>  create mode 100644 target/avr/disas.c
>  create mode 100644 target/avr/gdbstub.c
>  create mode 100644 target/avr/helper.c
>  create mode 100644 target/avr/machine.c
>  create mode 100644 target/avr/translate.c
>  create mode 100644 gdb-xml/avr-cpu.xml
>  create mode 100644 hw/avr/Kconfig
>  create mode 100644 hw/avr/Makefile.objs
>  create mode 100644 target/avr/Makefile.objs
>  create mode 100644 tests/acceptance/machine_avr6.py
> 
> --=20
> 2.21.3
> 
> 

