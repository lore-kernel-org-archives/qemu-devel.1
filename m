Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 234CCC35244
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 11:42:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CFD5D206F0
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 11:42:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="F2d06GW0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CFD5D206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41014 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iuxMQ-0002bX-3X
	for qemu-devel@archiver.kernel.org; Fri, 24 Jan 2020 06:42:50 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:35939)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <mrolnik@gmail.com>) id 1iuxLc-00029m-Is
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 06:42:03 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mrolnik@gmail.com>) id 1iuxLa-0003Sa-03
 for qemu-devel@nongnu.org; Fri, 24 Jan 2020 06:42:00 -0500
Received: from mail-qk1-x742.google.com ([2607:f8b0:4864:20::742]:45855)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <mrolnik@gmail.com>)
 id 1iuxLZ-0003RG-Nl; Fri, 24 Jan 2020 06:41:57 -0500
Received: by mail-qk1-x742.google.com with SMTP id x1so1647423qkl.12;
 Fri, 24 Jan 2020 03:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=ZcpKws7lzIrJmcOh0UcKrtMk8NAi105EfUb6skcVsSQ=;
 b=F2d06GW0uGfvRH6/O0hc+dHR1IQ02A+p+eYcGRMd7aiQnRLr1vAunIb6bHZNc4oFLx
 cQKtXBBVBD+Nu91czmP87Qol4vvzQrhNEKt6rmCUwU34FcbudMoppgc+xH3wwYcmH2sy
 BMbdVVAz8pD5n66alGrhDeXPDkIkvLpx2P+1Hn7sdyMNWvnIKuXoymKrhT6t2cFD6aLg
 NdHTQsZOzW+/KMnPMh3Xqgrsph0IdEhb3x+if3S3VxdzwcMrgCNhYMsf1nwcefrnwWtD
 h3A7NFWJGP3wsb0MipKREQ1eQ58dnJwKragi3bZVbjleCVJQZzRztNdx/LklT2cs+GGS
 Fu1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZcpKws7lzIrJmcOh0UcKrtMk8NAi105EfUb6skcVsSQ=;
 b=Kdd8q+J07jxKYdrDWKYFLHkHuSqnU7M2mJhuxC7rEx3jTon24tSyJOx0mZUPTby5+B
 sVYUuo1HVc+exbr7INYxBNZ/blvf4VcFdYblcqU1abtVQgbMmt2bu6LUMHriMmFyKop0
 ksWQg9xnTkC6Q7nEccPEOKRn027vL6efkGYtSyR8VvOadLUolJM5HQJ4ibFqluUTpgAH
 DhwrqPsdIHXVZHACqm+NtGLv2zNjbk8/n37Md87oLT7ZoUpXh6esBOfj9K59jChfxRc+
 uSjpnDLyW7zMnPUie0Ry9astPgwd1eXWcW54aLyQVNsq9Hwj2KcbLHuqsgI8mnkOgQWv
 RilQ==
X-Gm-Message-State: APjAAAWzjmPunnMg9KEm1J8HL5SHJ2RJuMh9i/ldqPd+30vSbFRpCnPV
 9aMqWb6joVbGN1H92/2Qoth63xE0GlQWtgu744A=
X-Google-Smtp-Source: APXvYqx18/+jFV143J7I4e6j2U3eGNdnob7LQYvOEr75JuQsCyTTyAdnsV6n4jUTqB4nQhNp7DIsDXN3TlobI1wftEQ=
X-Received: by 2002:ae9:dc85:: with SMTP id q127mr2061465qkf.460.1579866116820; 
 Fri, 24 Jan 2020 03:41:56 -0800 (PST)
MIME-Version: 1.0
References: <20200124005131.16276-1-f4bug@amsat.org>
In-Reply-To: <20200124005131.16276-1-f4bug@amsat.org>
From: Michael Rolnik <mrolnik@gmail.com>
Date: Fri, 24 Jan 2020 13:41:14 +0200
Message-ID: <CAK4993iG+t7fZS=cekXfJVpDQ_L7jLu8i2V4mHVLbS-r69=AVg@mail.gmail.com>
Subject: Re: [PATCH rc2 00/25] target/avr merger
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Content-Type: multipart/alternative; boundary="000000000000af927c059ce13e20"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::742
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
Cc: Fam Zheng <fam@euphon.net>, Sarah Harris <S.E.Harris@kent.ac.uk>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Joaquin de Andres <me@xcancerberox.com.ar>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Markus Armbruster <armbru@redhat.com>, Pavel Dovgalyuk <dovgaluk@ispras.ru>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Laurent Vivier <lvivier@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, qemu-riscv@nongnu.org,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Palmer Dabbelt <palmer@dabbelt.com>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--000000000000af927c059ce13e20
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Tested-by: Michael Rolnik <mrolnik@gmail.com>



The only thing I want to change is instead of -kernel put -bios in
qemu-doc.texi file. Should I send a new series?

On Fri, Jan 24, 2020 at 2:51 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.or=
g>
wrote:

> This is the AVR port from Michael release (merge) candidate 2.
>
> Since v1 [1]:
> - Addressed Thomas comments
> - Fixed a non-critical bug in ATmega (incorrect SRAM base address)
> - Added ELF parsing requested by Aleksandar
> - Dropped default machine (as with the ARM port)
>
> Change since rc1:
>
> $ git backport-diff -u avr-rc1 -r origin/master..
> Key:
> [----] : patches are identical
> [####] : number of functional differences between upstream/downstream pat=
ch
> [down] : patch is downstream-only
> The flags [FC] indicate (F)unctional and (C)ontextual differences,
> respectively
>
> 001/25:[----] [--] 'target/avr: Add outward facing interfaces and core CP=
U
> logic'
> 002/25:[----] [--] 'target/avr: Add instruction helpers'
> 003/25:[----] [--] 'target/avr: Add instruction translation - Registers
> definition'
> 004/25:[----] [--] 'target/avr: Add instruction translation - Arithmetic
> and Logic Instructions'
> 005/25:[----] [--] 'target/avr: Add instruction translation - Branch
> Instructions'
> 006/25:[----] [--] 'target/avr: Add instruction translation - Data
> Transfer Instructions'
> 007/25:[----] [--] 'target/avr: Add instruction translation - Bit and
> Bit-test Instructions'
> 008/25:[----] [--] 'target/avr: Add instruction translation - MCU Control
> Instructions'
> 009/25:[----] [--] 'target/avr: Add instruction translation - CPU main
> translation function'
> 010/25:[----] [--] 'target/avr: Add instruction disassembly function'
> 011/25:[----] [--] 'hw/char: Add limited support for Atmel USART
> peripheral'
> 012/25:[0045] [FC] 'hw/timer: Add limited support for Atmel 16 bit timer
> peripheral'
> 013/25:[----] [--] 'hw/misc: Add Atmel power device'
> 014/25:[0024] [FC] 'target/avr: Add section about AVR into QEMU
> documentation'
> 015/25:[----] [--] 'target/avr: Register AVR support with the rest of QEM=
U'
> 016/25:[----] [--] 'target/avr: Add machine none test'
> 017/25:[0002] [FC] 'target/avr: Update MAINTAINERS file'
> 018/25:[down]      'hw/core/loader: Let load_elf populate the
> processor-specific flags'
> 019/25:[down]      'hw/avr: Add helper to load raw/ELF firmware binaries'
> 020/25:[0015] [FC] 'hw/avr: Add some ATmega microcontrollers'
> 021/25:[0040] [FC] 'hw/avr: Add some Arduino boards'
> 022/25:[----] [--] 'target/avr: Update build system'
> 023/25:[----] [--] 'tests/boot-serial-test: Test some Arduino boards (AVR
> based)'
> 024/25:[----] [--] 'tests/acceptance: Test the Arduino MEGA2560 board'
> 025/25:[----] [--] '.travis.yml: Run the AVR acceptance tests'
>
> Repo: https://gitlab.com/philmd/qemu/commits/avr-rc2
>
> [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg672926.html
> Supersedes: <20200123000307.11541-1-richard.henderson@linaro.org>
>
> Michael Rolnik (20):
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
>   hw/char: Add limited support for Atmel USART peripheral
>   hw/timer: Add limited support for Atmel 16 bit timer peripheral
>   hw/misc: Add Atmel power device
>   target/avr: Add section about AVR into QEMU documentation
>   target/avr: Register AVR support with the rest of QEMU
>   target/avr: Add machine none test
>   target/avr: Update MAINTAINERS file
>   target/avr: Update build system
>   tests/boot-serial-test: Test some Arduino boards (AVR based)
>   tests/acceptance: Test the Arduino MEGA2560 board
>
> Philippe Mathieu-Daud=C3=A9 (5):
>   hw/core/loader: Let load_elf populate the processor-specific flags
>   hw/avr: Add helper to load raw/ELF firmware binaries
>   hw/avr: Add some ATmega microcontrollers
>   hw/avr: Add some Arduino boards
>   .travis.yml: Run the AVR acceptance tests
>
>  qemu-doc.texi                    |   51 +
>  configure                        |    7 +
>  default-configs/avr-softmmu.mak  |    5 +
>  qapi/machine.json                |    3 +-
>  hw/avr/atmel_atmega.h            |   48 +
>  hw/avr/boot.h                    |   33 +
>  include/disas/dis-asm.h          |   19 +
>  include/elf.h                    |    2 +
>  include/hw/char/atmel_usart.h    |   93 +
>  include/hw/elf_ops.h             |    6 +-
>  include/hw/loader.h              |    6 +-
>  include/hw/misc/atmel_power.h    |   46 +
>  include/hw/timer/atmel_timer16.h |   94 +
>  include/sysemu/arch_init.h       |    1 +
>  target/avr/cpu-param.h           |   37 +
>  target/avr/cpu-qom.h             |   54 +
>  target/avr/cpu.h                 |  259 +++
>  target/avr/helper.h              |   29 +
>  arch_init.c                      |    2 +
>  hw/avr/arduino.c                 |  151 ++
>  hw/avr/atmel_atmega.c            |  470 +++++
>  hw/avr/boot.c                    |   74 +
>  hw/char/atmel_usart.c            |  320 ++++
>  hw/core/loader.c                 |   15 +-
>  hw/misc/atmel_power.c            |  112 ++
>  hw/riscv/boot.c                  |    2 +-
>  hw/timer/atmel_timer16.c         |  605 ++++++
>  target/avr/cpu.c                 |  826 ++++++++
>  target/avr/disas.c               |  246 +++
>  target/avr/gdbstub.c             |   84 +
>  target/avr/helper.c              |  347 ++++
>  target/avr/machine.c             |  121 ++
>  target/avr/translate.c           | 2997 ++++++++++++++++++++++++++++++
>  tests/qtest/boot-serial-test.c   |   11 +
>  tests/qtest/machine-none-test.c  |    1 +
>  .travis.yml                      |    2 +-
>  MAINTAINERS                      |   30 +
>  gdb-xml/avr-cpu.xml              |   49 +
>  hw/avr/Kconfig                   |    9 +
>  hw/avr/Makefile.objs             |    3 +
>  hw/char/Kconfig                  |    3 +
>  hw/char/Makefile.objs            |    1 +
>  hw/misc/Kconfig                  |    3 +
>  hw/misc/Makefile.objs            |    2 +
>  hw/timer/Kconfig                 |    3 +
>  hw/timer/Makefile.objs           |    2 +
>  target/avr/Makefile.objs         |   34 +
>  target/avr/insn.decode           |  182 ++
>  tests/acceptance/machine_avr6.py |   50 +
>  tests/qtest/Makefile.include     |    2 +
>  50 files changed, 7539 insertions(+), 13 deletions(-)
>  create mode 100644 default-configs/avr-softmmu.mak
>  create mode 100644 hw/avr/atmel_atmega.h
>  create mode 100644 hw/avr/boot.h
>  create mode 100644 include/hw/char/atmel_usart.h
>  create mode 100644 include/hw/misc/atmel_power.h
>  create mode 100644 include/hw/timer/atmel_timer16.h
>  create mode 100644 target/avr/cpu-param.h
>  create mode 100644 target/avr/cpu-qom.h
>  create mode 100644 target/avr/cpu.h
>  create mode 100644 target/avr/helper.h
>  create mode 100644 hw/avr/arduino.c
>  create mode 100644 hw/avr/atmel_atmega.c
>  create mode 100644 hw/avr/boot.c
>  create mode 100644 hw/char/atmel_usart.c
>  create mode 100644 hw/misc/atmel_power.c
>  create mode 100644 hw/timer/atmel_timer16.c
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
>  create mode 100644 target/avr/insn.decode
>  create mode 100644 tests/acceptance/machine_avr6.py
>
> --
> 2.21.1
>
>

--=20
Best Regards,
Michael Rolnik

--000000000000af927c059ce13e20
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr">





<p style=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:=
normal;font-stretch:normal;font-size:12px;line-height:normal;font-family:Me=
nlo">Tested-by: Michael Rolnik &lt;<a href=3D"mailto:mrolnik@gmail.com" tar=
get=3D"_blank">mrolnik@gmail.com</a>&gt;</p><p style=3D"margin:0px;font-var=
iant-numeric:normal;font-variant-east-asian:normal;font-stretch:normal;font=
-size:12px;line-height:normal;font-family:Menlo"><br></p><p style=3D"margin=
:0px;font-variant-numeric:normal;font-variant-east-asian:normal;font-stretc=
h:normal;font-size:12px;line-height:normal;font-family:Menlo"><br></p><p st=
yle=3D"margin:0px;font-variant-numeric:normal;font-variant-east-asian:norma=
l;font-stretch:normal;font-size:12px;line-height:normal;font-family:Menlo">=
The only thing I want to change is instead of -kernel put -bios in qemu-doc=
.texi file. Should I send a new series?</p></div><br><div class=3D"gmail_qu=
ote"><div dir=3D"ltr" class=3D"gmail_attr">On Fri, Jan 24, 2020 at 2:51 AM =
Philippe Mathieu-Daud=C3=A9 &lt;<a href=3D"mailto:f4bug@amsat.org" target=
=3D"_blank">f4bug@amsat.org</a>&gt; wrote:<br></div><blockquote class=3D"gm=
ail_quote" style=3D"margin:0px 0px 0px 0.8ex;border-left:1px solid rgb(204,=
204,204);padding-left:1ex">This is the AVR port from Michael release (merge=
) candidate 2.<br>
<br>
Since v1 [1]:<br>
- Addressed Thomas comments<br>
- Fixed a non-critical bug in ATmega (incorrect SRAM base address)<br>
- Added ELF parsing requested by Aleksandar<br>
- Dropped default machine (as with the ARM port)<br>
<br>
Change since rc1:<br>
<br>
$ git backport-diff -u avr-rc1 -r origin/master..<br>
Key:<br>
[----] : patches are identical<br>
[####] : number of functional differences between upstream/downstream patch=
<br>
[down] : patch is downstream-only<br>
The flags [FC] indicate (F)unctional and (C)ontextual differences, respecti=
vely<br>
<br>
001/25:[----] [--] &#39;target/avr: Add outward facing interfaces and core =
CPU logic&#39;<br>
002/25:[----] [--] &#39;target/avr: Add instruction helpers&#39;<br>
003/25:[----] [--] &#39;target/avr: Add instruction translation - Registers=
 definition&#39;<br>
004/25:[----] [--] &#39;target/avr: Add instruction translation - Arithmeti=
c and Logic Instructions&#39;<br>
005/25:[----] [--] &#39;target/avr: Add instruction translation - Branch In=
structions&#39;<br>
006/25:[----] [--] &#39;target/avr: Add instruction translation - Data Tran=
sfer Instructions&#39;<br>
007/25:[----] [--] &#39;target/avr: Add instruction translation - Bit and B=
it-test Instructions&#39;<br>
008/25:[----] [--] &#39;target/avr: Add instruction translation - MCU Contr=
ol Instructions&#39;<br>
009/25:[----] [--] &#39;target/avr: Add instruction translation - CPU main =
translation function&#39;<br>
010/25:[----] [--] &#39;target/avr: Add instruction disassembly function&#3=
9;<br>
011/25:[----] [--] &#39;hw/char: Add limited support for Atmel USART periph=
eral&#39;<br>
012/25:[0045] [FC] &#39;hw/timer: Add limited support for Atmel 16 bit time=
r peripheral&#39;<br>
013/25:[----] [--] &#39;hw/misc: Add Atmel power device&#39;<br>
014/25:[0024] [FC] &#39;target/avr: Add section about AVR into QEMU documen=
tation&#39;<br>
015/25:[----] [--] &#39;target/avr: Register AVR support with the rest of Q=
EMU&#39;<br>
016/25:[----] [--] &#39;target/avr: Add machine none test&#39;<br>
017/25:[0002] [FC] &#39;target/avr: Update MAINTAINERS file&#39;<br>
018/25:[down]=C2=A0 =C2=A0 =C2=A0 &#39;hw/core/loader: Let load_elf populat=
e the processor-specific flags&#39;<br>
019/25:[down]=C2=A0 =C2=A0 =C2=A0 &#39;hw/avr: Add helper to load raw/ELF f=
irmware binaries&#39;<br>
020/25:[0015] [FC] &#39;hw/avr: Add some ATmega microcontrollers&#39;<br>
021/25:[0040] [FC] &#39;hw/avr: Add some Arduino boards&#39;<br>
022/25:[----] [--] &#39;target/avr: Update build system&#39;<br>
023/25:[----] [--] &#39;tests/boot-serial-test: Test some Arduino boards (A=
VR based)&#39;<br>
024/25:[----] [--] &#39;tests/acceptance: Test the Arduino MEGA2560 board&#=
39;<br>
025/25:[----] [--] &#39;.travis.yml: Run the AVR acceptance tests&#39;<br>
<br>
Repo: <a href=3D"https://gitlab.com/philmd/qemu/commits/avr-rc2" rel=3D"nor=
eferrer" target=3D"_blank">https://gitlab.com/philmd/qemu/commits/avr-rc2</=
a><br>
<br>
[1] <a href=3D"https://www.mail-archive.com/qemu-devel@nongnu.org/msg672926=
.html" rel=3D"noreferrer" target=3D"_blank">https://www.mail-archive.com/qe=
mu-devel@nongnu.org/msg672926.html</a><br>
Supersedes: &lt;<a href=3D"mailto:20200123000307.11541-1-richard.henderson@=
linaro.org" target=3D"_blank">20200123000307.11541-1-richard.henderson@lina=
ro.org</a>&gt;<br>
<br>
Michael Rolnik (20):<br>
=C2=A0 target/avr: Add outward facing interfaces and core CPU logic<br>
=C2=A0 target/avr: Add instruction helpers<br>
=C2=A0 target/avr: Add instruction translation - Registers definition<br>
=C2=A0 target/avr: Add instruction translation - Arithmetic and Logic<br>
=C2=A0 =C2=A0 Instructions<br>
=C2=A0 target/avr: Add instruction translation - Branch Instructions<br>
=C2=A0 target/avr: Add instruction translation - Data Transfer Instructions=
<br>
=C2=A0 target/avr: Add instruction translation - Bit and Bit-test<br>
=C2=A0 =C2=A0 Instructions<br>
=C2=A0 target/avr: Add instruction translation - MCU Control Instructions<b=
r>
=C2=A0 target/avr: Add instruction translation - CPU main translation<br>
=C2=A0 =C2=A0 function<br>
=C2=A0 target/avr: Add instruction disassembly function<br>
=C2=A0 hw/char: Add limited support for Atmel USART peripheral<br>
=C2=A0 hw/timer: Add limited support for Atmel 16 bit timer peripheral<br>
=C2=A0 hw/misc: Add Atmel power device<br>
=C2=A0 target/avr: Add section about AVR into QEMU documentation<br>
=C2=A0 target/avr: Register AVR support with the rest of QEMU<br>
=C2=A0 target/avr: Add machine none test<br>
=C2=A0 target/avr: Update MAINTAINERS file<br>
=C2=A0 target/avr: Update build system<br>
=C2=A0 tests/boot-serial-test: Test some Arduino boards (AVR based)<br>
=C2=A0 tests/acceptance: Test the Arduino MEGA2560 board<br>
<br>
Philippe Mathieu-Daud=C3=A9 (5):<br>
=C2=A0 hw/core/loader: Let load_elf populate the processor-specific flags<b=
r>
=C2=A0 hw/avr: Add helper to load raw/ELF firmware binaries<br>
=C2=A0 hw/avr: Add some ATmega microcontrollers<br>
=C2=A0 hw/avr: Add some Arduino boards<br>
=C2=A0 .travis.yml: Run the AVR acceptance tests<br>
<br>
=C2=A0qemu-doc.texi=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A051 +<br>
=C2=A0configure=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 7 +<br>
=C2=A0default-configs/avr-softmmu.mak=C2=A0 |=C2=A0 =C2=A0 5 +<br>
=C2=A0qapi/machine.json=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 |=C2=A0 =C2=A0 3 +-<br>
=C2=A0hw/avr/atmel_atmega.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A048 +<br>
=C2=A0hw/avr/boot.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A033 +<br>
=C2=A0include/disas/dis-asm.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=
=A019 +<br>
=C2=A0include/elf.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
=C2=A0include/hw/char/atmel_usart.h=C2=A0 =C2=A0 |=C2=A0 =C2=A093 +<br>
=C2=A0include/hw/elf_ops.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 6 +-<br>
=C2=A0include/hw/loader.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A0 6 +-<br>
=C2=A0include/hw/misc/atmel_power.h=C2=A0 =C2=A0 |=C2=A0 =C2=A046 +<br>
=C2=A0include/hw/timer/atmel_timer16.h |=C2=A0 =C2=A094 +<br>
=C2=A0include/sysemu/arch_init.h=C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 1=
 +<br>
=C2=A0target/avr/cpu-param.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A037 +<br>
=C2=A0target/avr/cpu-qom.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A054 +<br>
=C2=A0target/avr/cpu.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 259 +++<br>
=C2=A0target/avr/helper.h=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A029 +<br>
=C2=A0arch_init.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +<br>
=C2=A0hw/avr/arduino.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 151 ++<br>
=C2=A0hw/avr/atmel_atmega.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 470 +++++<br>
=C2=A0hw/avr/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 |=C2=A0 =C2=A074 +<br>
=C2=A0hw/char/atmel_usart.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 320 ++++<br>
=C2=A0hw/core/loader.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A015 +-<br>
=C2=A0hw/misc/atmel_power.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 112 ++<br>
=C2=A0hw/riscv/boot.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 2 +-<br>
=C2=A0hw/timer/atmel_timer16.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 605=
 ++++++<br>
=C2=A0target/avr/cpu.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 826 ++++++++<br>
=C2=A0target/avr/disas.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0|=C2=A0 246 +++<br>
=C2=A0target/avr/gdbstub.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A084 +<br>
=C2=A0target/avr/helper.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 347 ++++<br>
=C2=A0target/avr/machine.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 121 ++<br>
=C2=A0target/avr/translate.c=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0| 2997=
 ++++++++++++++++++++++++++++++<br>
=C2=A0tests/qtest/boot-serial-test.c=C2=A0 =C2=A0|=C2=A0 =C2=A011 +<br>
=C2=A0tests/qtest/machine-none-test.c=C2=A0 |=C2=A0 =C2=A0 1 +<br>
=C2=A0.travis.yml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A0 2 +-<br>
=C2=A0MAINTAINERS=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =
=C2=A0 =C2=A0 =C2=A0 |=C2=A0 =C2=A030 +<br>
=C2=A0gdb-xml/avr-cpu.xml=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=
=C2=A0 =C2=A049 +<br>
=C2=A0hw/avr/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0=
 =C2=A0 =C2=A0|=C2=A0 =C2=A0 9 +<br>
=C2=A0hw/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=
=C2=A0 =C2=A0 3 +<br>
=C2=A0hw/char/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 3 +<br>
=C2=A0hw/char/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A0 1 +<br>
=C2=A0hw/misc/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 |=C2=A0 =C2=A0 3 +<br>
=C2=A0hw/misc/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 |=C2=
=A0 =C2=A0 2 +<br>
=C2=A0hw/timer/Kconfig=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0|=C2=A0 =C2=A0 3 +<br>
=C2=A0hw/timer/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 =C2=A0 2 +<br>
=C2=A0target/avr/Makefile.objs=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=
=A034 +<br>
=C2=A0target/avr/insn.decode=C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0|=C2=
=A0 182 ++<br>
=C2=A0tests/acceptance/machine_avr6.py |=C2=A0 =C2=A050 +<br>
=C2=A0tests/qtest/Makefile.include=C2=A0 =C2=A0 =C2=A0|=C2=A0 =C2=A0 2 +<br=
>
=C2=A050 files changed, 7539 insertions(+), 13 deletions(-)<br>
=C2=A0create mode 100644 default-configs/avr-softmmu.mak<br>
=C2=A0create mode 100644 hw/avr/atmel_atmega.h<br>
=C2=A0create mode 100644 hw/avr/boot.h<br>
=C2=A0create mode 100644 include/hw/char/atmel_usart.h<br>
=C2=A0create mode 100644 include/hw/misc/atmel_power.h<br>
=C2=A0create mode 100644 include/hw/timer/atmel_timer16.h<br>
=C2=A0create mode 100644 target/avr/cpu-param.h<br>
=C2=A0create mode 100644 target/avr/cpu-qom.h<br>
=C2=A0create mode 100644 target/avr/cpu.h<br>
=C2=A0create mode 100644 target/avr/helper.h<br>
=C2=A0create mode 100644 hw/avr/arduino.c<br>
=C2=A0create mode 100644 hw/avr/atmel_atmega.c<br>
=C2=A0create mode 100644 hw/avr/boot.c<br>
=C2=A0create mode 100644 hw/char/atmel_usart.c<br>
=C2=A0create mode 100644 hw/misc/atmel_power.c<br>
=C2=A0create mode 100644 hw/timer/atmel_timer16.c<br>
=C2=A0create mode 100644 target/avr/cpu.c<br>
=C2=A0create mode 100644 target/avr/disas.c<br>
=C2=A0create mode 100644 target/avr/gdbstub.c<br>
=C2=A0create mode 100644 target/avr/helper.c<br>
=C2=A0create mode 100644 target/avr/machine.c<br>
=C2=A0create mode 100644 target/avr/translate.c<br>
=C2=A0create mode 100644 gdb-xml/avr-cpu.xml<br>
=C2=A0create mode 100644 hw/avr/Kconfig<br>
=C2=A0create mode 100644 hw/avr/Makefile.objs<br>
=C2=A0create mode 100644 target/avr/Makefile.objs<br>
=C2=A0create mode 100644 target/avr/insn.decode<br>
=C2=A0create mode 100644 tests/acceptance/machine_avr6.py<br>
<br>
-- <br>
2.21.1<br>
<br>
</blockquote></div><br clear=3D"all"><div><br></div>-- <br><div dir=3D"ltr"=
>Best Regards,<br>Michael Rolnik</div>

--000000000000af927c059ce13e20--

