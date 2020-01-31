Return-Path: <SRS0=aXOp=3U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C7DC33C9E
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 01:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 257A220663
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jan 2020 01:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ele49jsB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 257A220663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47304 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ixLFS-0003QH-KC
	for qemu-devel@archiver.kernel.org; Thu, 30 Jan 2020 20:37:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40359)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1ixLEB-0001su-OH
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 20:36:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1ixL2U-0005lA-Eh
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 20:24:12 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:49386
 helo=us-smtp-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1ixL2U-0005kr-Ag
 for qemu-devel@nongnu.org; Thu, 30 Jan 2020 20:24:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1580433846;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8BUI1WNFL5KiljncoJhlayDf+ahbaT3CDLNtJSG4gxI=;
 b=Ele49jsBNFZOMFwL1E8fbTXfY/v0h4K/MajW1bWxC5NaoTUE/IrvZnMl+5RhxUDOxWcB7C
 BKbagvKBEjnONWw8jeV2ZUZ4pEQVKkYqvlOUK2Y0pcsHgUz+061zJNr/jpSucTNAQO+g+j
 5WKi2Hs+wfOR9+hTqJfl5zNGKllJ574=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-TaGVTdB2PdStNssfboWIPg-1; Thu, 30 Jan 2020 20:23:59 -0500
Received: by mail-wm1-f70.google.com with SMTP id b202so2115625wmb.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jan 2020 17:23:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vD6EB7gfxSialb4Jw1PQYey3Ec7gkxpqnf7pZmxcsFg=;
 b=EMnTDuA8mrQY3ltsL999LIAA640Lk0LI2U/96yQ+lz4xXbP10iBtx5EhIlIZJGFJg+
 Gnkw/nrnPNmrDx28UuQ/2tIERKXsbsNV4fFOREJ4EFfoI1tsIrMRf/fhyMyv+KeIHA0D
 vGi11kQh7p2fP0snsx5vVnb1YcJbGwGD7pr2d8y9ophz7R+B/rLloura7Akdwt751KiM
 CfZjgbLWzEP3uhAMJzfjhv7gpz1DzXFt/7Ia8qwQtF+vU8fJq3URPvrra3J42Npz1r7p
 XQzAslNwhHWwH5qCy06mm/NRAw9C4wX2765JNvWK/dfRl72+VYWnnEoTkrruK16U5u6h
 jc4Q==
X-Gm-Message-State: APjAAAXgvkkNTu/RFXEb9v8wSaIDJDtp8Ydp9lEdX+H2ah77m6bHQcmx
 ENalA3JdrK5LX3bTdZ7JpH1go330ZMVREaP0GGP2WmRH2fNiJ1qAPajN4BwOHDmjReLRx2Dh1rB
 ASLR+0f5cVf5/d7A=
X-Received: by 2002:a1c:6755:: with SMTP id b82mr8728843wmc.126.1580433837984; 
 Thu, 30 Jan 2020 17:23:57 -0800 (PST)
X-Google-Smtp-Source: APXvYqzgHXCr+GyWF7OohZZcbwrV4Ogyq6EDYlyG+MRplZovos1PJbNVHBs1lwcwLtxlGGYqZ9wb3g==
X-Received: by 2002:a1c:6755:: with SMTP id b82mr8728821wmc.126.1580433837665; 
 Thu, 30 Jan 2020 17:23:57 -0800 (PST)
Received: from [192.168.1.35] (113.red-83-57-172.dynamicip.rima-tde.net.
 [83.57.172.113])
 by smtp.gmail.com with ESMTPSA id y20sm8123744wmi.25.2020.01.30.17.23.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jan 2020 17:23:57 -0800 (PST)
Subject: Re: [PATCH rc4 00/29] target/avr merger
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Michael Rolnik <mrolnik@gmail.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <f4bug@amsat.org>
References: <1580428993-4767-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAL1e-=jVVSad52xEe0Fich+iWywmPtmtR2P9KLjeMtYNC1JqwQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <afe50719-04f8-bec4-ab37-61c7a327f14b@redhat.com>
Date: Fri, 31 Jan 2020 02:23:56 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <CAL1e-=jVVSad52xEe0Fich+iWywmPtmtR2P9KLjeMtYNC1JqwQ@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: TaGVTdB2PdStNssfboWIPg-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.120
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
Cc: QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <amarkovic@wavecomp.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/31/20 1:12 AM, Aleksandar Markovic wrote:
> Michael, Philippe,
>=20
> Can you guys do a quick checkup of this rc4? rc4, rc3,and rc2 should
> be functionally 100% equivalent.

Tested OK.

git-backport-diff with rc2:

Key:
[----] : patches are identical
[####] : number of functional differences between upstream/downstream patch
[down] : patch is downstream-only
The flags [FC] indicate (F)unctional and (C)ontextual differences,=20
respectively

001/31:[down] 'target/avr: Add basic parameters for new AVR platform'
002/31:[down] 'target/avr: Introduce AVR CPU class object'
003/31:[down] 'target/avr: Add migration support'
004/31:[down] 'target/avr: Add GDB support'
005/31:[down] 'target/avr: Introduce enumeration AVRFeature'
006/31:[down] 'target/avr: Add defintions of AVR core types'
007/31:[0148] [FC] 'target/avr: Add instruction helpers'
008/31:[down] 'target/avr: Add instruction translation - Register=20
definitions'
009/31:[----] [--] 'target/avr: Add instruction translation - Arithmetic=20
and Logic Instructions'
010/31:[----] [--] 'target/avr: Add instruction translation - Branch=20
Instructions'
011/31:[----] [--] 'target/avr: Add instruction translation - Data=20
Transfer Instructions'
012/31:[----] [--] 'target/avr: Add instruction translation - Bit and=20
Bit-test Instructions'
013/31:[----] [--] 'target/avr: Add instruction translation - MCU=20
Control Instructions'
014/31:[----] [--] 'target/avr: Add instruction translation - CPU main=20
translation function'
015/31:[----] [--] 'target/avr: Add instruction disassembly function'
016/31:[down] 'hw/char: Add limited support for AVR USART peripheral'
017/31:[down] 'hw/timer: Add limited support for AVR 16-bit timer=20
peripheral'
018/31:[down] 'hw/misc: Add limited support for AVR power device'
019/31:[0012] [FC] 'target/avr: Add section about AVR into QEMU=20
documentation'
020/31:[0002] [FC] 'target/avr: Register AVR support with the rest of QEMU'
021/31:[----] [--] 'target/avr: Add machine none test'
022/31:[0014] [FC] 'target/avr: Update MAINTAINERS file'
023/31:[0002] [FC] 'hw/avr: Add helper to load raw/ELF firmware binaries'
024/31:[0026] [FC] 'hw/avr: Add some ATmega microcontrollers'
025/31:[0009] [FC] 'hw/avr: Add some Arduino boards'
026/31:[----] [--] 'target/avr: Update build system'
027/31:[----] [--] 'tests/boot-serial-test: Test some Arduino boards=20
(AVR based)'
028/31:[----] [--] 'tests/acceptance: Test the Arduino MEGA2560 board'
029/31:[----] [--] '.travis.yml: Run the AVR acceptance tests'
030/31:[down] '!fixup "hw/misc: Add limited support for AVR power device"'
031/31:[down] '!fixup "hw/timer: Add limited support for AVR 16-bit=20
timer peripheral"'

One thing that annoys me is we ignored the review comments from Joaquin,=20
but I think it might now be easier to address them as new patches, once=20
this series is merged.

I made 2 comments (definitions in incorrect patch, and definition=20
misplaced in elf.h), and sent 2 patches converting the PRINTF() to=20
trace-events. Thanks for preparing the rc4, hopefully we are done!

>=20
> Thank you,
> Aleksandar
>=20
> On Fri, Jan 31, 2020 at 1:06 AM Aleksandar Markovic
> <aleksandar.markovic@rt-rk.com> wrote:
>>
>> From: Aleksandar Markovic <amarkovic@wavecomp.com>
>>
>> This is the AVR port from Michael, release (merge) candidate 4.
>>
>> The series can be found also in this repository:
>>
>> https://github.com/AMarkovic/qemu-avr-merger-rc4
>>
>> History:
>>
>> Since v3:
>>
>> - Removed a patch on load_elf() modification, since it has been merged
>> - Removed references to CONFIG_USER_ONLY and provided a guard against
>>    building lunux user mode for AVR
>> - Removed all references to 'Atmel' (including file renames)
>> - Rebased the code (there was common interface change regarding 'props')
>> - Various corrections of commit messages
>> - A bit field for AVRFeatures is nor 64 bit long
>> - Other minor fixes
>>
>> Since v2:
>>
>> - First patch is split into six smaller logical units (net result
>>    remains the same)
>> - Patch "hw/core/loader: Let load_elf populate the processor-specific
>>    flags" was redone to reflect the original intent that was lost in
>>    transalation between multiple autors
>> - Patch "hw/avr: Add helper to load raw/ELF firmware binaries" was
>>    corrected only in one line to rectify type of "e_flags"
>> - Patch "target/avr: Add section about AVR into QEMU documentation"
>> - Spurious <message-Id:> elements were removed
>> - The series was rebased to the latest code
>>
>> Since v1:
>>
>> - Addressed Thomas comments
>> - Fixed a non-critical bug in ATmega (incorrect SRAM base address)
>> - Added ELF parsing requested by Aleksandar
>> - Dropped default machine (as with the ARM port)
>>
>> Michael Rolnik (25):
>>    target/avr: Add basic parameters for new AVR platform
>>    target/avr: Introduce AVR CPU class object
>>    target/avr: Add migration support
>>    target/avr: Add GDB support
>>    target/avr: Introduce enumeration AVRFeature
>>    target/avr: Add defintions of AVR core types
>>    target/avr: Add instruction helpers
>>    target/avr: Add instruction translation - Register definitions
>>    target/avr: Add instruction translation - Arithmetic and Logic
>>      Instructions
>>    target/avr: Add instruction translation - Branch Instructions
>>    target/avr: Add instruction translation - Data Transfer Instructions
>>    target/avr: Add instruction translation - Bit and Bit-test
>>      Instructions
>>    target/avr: Add instruction translation - MCU Control Instructions
>>    target/avr: Add instruction translation - CPU main translation
>>      function
>>    target/avr: Add instruction disassembly function
>>    hw/char: Add limited support for AVR USART peripheral
>>    hw/timer: Add limited support for AVR 16-bit timer peripheral
>>    hw/misc: Add limited support for AVR power device
>>    target/avr: Add section about AVR into QEMU documentation
>>    target/avr: Register AVR support with the rest of QEMU
>>    target/avr: Add machine none test
>>    target/avr: Update MAINTAINERS file
>>    target/avr: Update build system
>>    tests/boot-serial-test: Test some Arduino boards (AVR based)
>>    tests/acceptance: Test the Arduino MEGA2560 board
>>
>> Philippe Mathieu-Daud=C3=A9 (4):
>>    hw/avr: Add helper to load raw/ELF firmware binaries
>>    hw/avr: Add some ATmega microcontrollers
>>    hw/avr: Add some Arduino boards
>>    .travis.yml: Run the AVR acceptance tests
>>
>>   .travis.yml                      |    2 +-
>>   MAINTAINERS                      |   31 +
>>   arch_init.c                      |    2 +
>>   configure                        |    7 +
>>   default-configs/avr-softmmu.mak  |    5 +
>>   gdb-xml/avr-cpu.xml              |   49 +
>>   hw/avr/Kconfig                   |    9 +
>>   hw/avr/Makefile.objs             |    3 +
>>   hw/avr/arduino.c                 |  151 ++
>>   hw/avr/atmega.c                  |  470 ++++++
>>   hw/avr/atmega.h                  |   48 +
>>   hw/avr/boot.c                    |   74 +
>>   hw/avr/boot.h                    |   33 +
>>   hw/char/Kconfig                  |    3 +
>>   hw/char/Makefile.objs            |    1 +
>>   hw/char/avr_usart.c              |  320 ++++
>>   hw/misc/Kconfig                  |    3 +
>>   hw/misc/Makefile.objs            |    2 +
>>   hw/misc/avr_power.c              |  112 ++
>>   hw/timer/Kconfig                 |    3 +
>>   hw/timer/Makefile.objs           |    2 +
>>   hw/timer/avr_timer16.c           |  604 ++++++++
>>   include/disas/dis-asm.h          |   19 +
>>   include/elf.h                    |    2 +
>>   include/hw/char/avr_usart.h      |   93 ++
>>   include/hw/misc/avr_power.h      |   46 +
>>   include/hw/timer/avr_timer16.h   |   94 ++
>>   include/sysemu/arch_init.h       |    1 +
>>   qapi/machine.json                |    3 +-
>>   qemu-doc.texi                    |   51 +
>>   target/avr/Makefile.objs         |   34 +
>>   target/avr/cpu-param.h           |   37 +
>>   target/avr/cpu-qom.h             |   54 +
>>   target/avr/cpu.c                 |  818 +++++++++++
>>   target/avr/cpu.h                 |  259 ++++
>>   target/avr/disas.c               |  246 ++++
>>   target/avr/gdbstub.c             |   84 ++
>>   target/avr/helper.c              |  342 +++++
>>   target/avr/helper.h              |   29 +
>>   target/avr/insn.decode           |  182 +++
>>   target/avr/machine.c             |  121 ++
>>   target/avr/translate.c           | 2997 ++++++++++++++++++++++++++++++=
++++++++
>>   tests/acceptance/machine_avr6.py |   50 +
>>   tests/qtest/Makefile.include     |    2 +
>>   tests/qtest/boot-serial-test.c   |   11 +
>>   tests/qtest/machine-none-test.c  |    1 +
>>   46 files changed, 7508 insertions(+), 2 deletions(-)
>>   create mode 100644 default-configs/avr-softmmu.mak
>>   create mode 100644 gdb-xml/avr-cpu.xml
>>   create mode 100644 hw/avr/Kconfig
>>   create mode 100644 hw/avr/Makefile.objs
>>   create mode 100644 hw/avr/arduino.c
>>   create mode 100644 hw/avr/atmega.c
>>   create mode 100644 hw/avr/atmega.h
>>   create mode 100644 hw/avr/boot.c
>>   create mode 100644 hw/avr/boot.h
>>   create mode 100644 hw/char/avr_usart.c
>>   create mode 100644 hw/misc/avr_power.c
>>   create mode 100644 hw/timer/avr_timer16.c
>>   create mode 100644 include/hw/char/avr_usart.h
>>   create mode 100644 include/hw/misc/avr_power.h
>>   create mode 100644 include/hw/timer/avr_timer16.h
>>   create mode 100644 target/avr/Makefile.objs
>>   create mode 100644 target/avr/cpu-param.h
>>   create mode 100644 target/avr/cpu-qom.h
>>   create mode 100644 target/avr/cpu.c
>>   create mode 100644 target/avr/cpu.h
>>   create mode 100644 target/avr/disas.c
>>   create mode 100644 target/avr/gdbstub.c
>>   create mode 100644 target/avr/helper.c
>>   create mode 100644 target/avr/helper.h
>>   create mode 100644 target/avr/insn.decode
>>   create mode 100644 target/avr/machine.c
>>   create mode 100644 target/avr/translate.c
>>   create mode 100644 tests/acceptance/machine_avr6.py
>>
>> --
>> 2.7.4
>>
>>
>=20


