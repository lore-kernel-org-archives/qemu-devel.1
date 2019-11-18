Return-Path: <SRS0=QE2o=ZK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12BB9C432C0
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:15:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D1F1D20409
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Nov 2019 17:15:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="F34vocLW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D1F1D20409
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37354 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iWkcv-0007io-Nv
	for qemu-devel@archiver.kernel.org; Mon, 18 Nov 2019 12:15:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55019)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iWkah-0005tq-FD
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:13:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iWkae-0007UW-7x
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:13:29 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:28565
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iWkae-0007U4-3S
 for qemu-devel@nongnu.org; Mon, 18 Nov 2019 12:13:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574097206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hcejMn1qD1TvwJ2rE2f9ttU+RvIkbjpec22lj0vXwpQ=;
 b=F34vocLWYblOtH7f+5IrZn6kxR0i4dwcV3U+DyzbzW6ckUboXU8O1g8K9CgIx8fx+hhAIJ
 Y08W5udqHlDgbgDww8lmDPAowrMzFBL8BCI2lxIESYvssliCMW5/qBuJa78Gk+SHAofiuK
 XpRay9HHU2ez2e69F8XraQOYzUjGKrI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-Ygmxa2wrMbOc1iSTQG8pgQ-1; Mon, 18 Nov 2019 12:13:23 -0500
Received: by mail-wr1-f70.google.com with SMTP id 4so15711312wrf.19
 for <qemu-devel@nongnu.org>; Mon, 18 Nov 2019 09:13:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=2OSYdSXlgXQ9OeK2bUCO3MNOIBWKJhPGIa6PotayTpM=;
 b=UmMFmef1GHlUfyNQFZK+am6drhULHltbIKjrGNHjZii3S6XB2KuahKSiayxYIsBs9b
 ZKukS+HHPUMMr/FhFfsiyiReVIlbOpIkhjfnb5NCjEbReSiu5tGsTqGQFywR8M1zGYQQ
 DO5yj3yfU6P9nOZNpWQII6FiFusa/Y3I7ygy38LkVio45EPZidj+F/lWCFi3Cb6UQVTQ
 xl3XkyrXf2JUwuOWrH9R4hd9kmsLZ6uCIMAxrFx1oF57N3H8LiGLAFX1GfOkE2CA3aEY
 gvU9euy3m9hv81+y99JTnOUrIUDfvzOjxbpAmCfQfnXq05bG9bJFBuz3rKr0CMYke6d1
 TBig==
X-Gm-Message-State: APjAAAXK45ATVOnJe4espiFzWzsR8s5IFqtVrC3Ez5iiICt+6RfXmw5T
 p5czj56hDaaOpESgPfKMhsv4zdE12bXbOI4dlfWspXuznTxLFwGMnhnc33IHVgtYH/fhjYKo4ig
 XB16KdO/4T+k2cbo=
X-Received: by 2002:a7b:c84b:: with SMTP id c11mr49217wml.158.1574097202591;
 Mon, 18 Nov 2019 09:13:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqyGhW0wKAWnj7rupj+5m6M7rfTsptOOpkVv48CcA6ifBmsAHmRsi9QmN3WIhrSI+1AOwV0Bwg==
X-Received: by 2002:a7b:c84b:: with SMTP id c11mr49192wml.158.1574097202318;
 Mon, 18 Nov 2019 09:13:22 -0800 (PST)
Received: from [192.168.1.35] (131.red-88-21-102.staticip.rima-tde.net.
 [88.21.102.131])
 by smtp.gmail.com with ESMTPSA id u26sm24287wmj.9.2019.11.18.09.13.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Nov 2019 09:13:21 -0800 (PST)
Subject: Re: [PATCH v35 00/13] QEMU AVR 8 bit cores
To: Michael Rolnik <mrolnik@gmail.com>, qemu-devel@nongnu.org,
 Joaquin de Andres <me@xcancerberox.com.ar>
References: <20191029212430.20617-1-mrolnik@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8d4b6ae5-68c4-546a-2d1d-e12c95176cb6@redhat.com>
Date: Mon, 18 Nov 2019 18:13:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20191029212430.20617-1-mrolnik@gmail.com>
Content-Language: en-US
X-MC-Unique: Ygmxa2wrMbOc1iSTQG8pgQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 205.139.110.61
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
Cc: thuth@redhat.com, richard.henderson@linaro.org,
 Sarah Harris <S.E.Harris@kent.ac.uk>, dovgaluk@ispras.ru, imammedo@redhat.com,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael, Joaquin.

Michael: Joaquin asked at the KVM Forum how he can start contributing to=20
QEMU, having an electronic background, and being custom the the AVR=20
microprocessor. I told him about your ongoing work. Joaquin is=20
interested in adding a new board to QEMU, and the Arduino would be his=20
board of choice.

Joaquin: This is the series I was tell you about. This series will=20
likely be merged during the 5.0 development window. It lacks a real=20
hardware model. Michael and Sarah didn't wrote one because they focus on=20
the architecture part, which is enough for them (to test that AVR GCC).

See below for more comments about the codebase organization.

On 10/29/19 10:24 PM, Michael Rolnik wrote:
> This series of patches adds 8bit AVR cores to QEMU.
> All instruction, except BREAK/DES/SPM/SPMX, are implemented. Not fully te=
sted yet.
> However I was able to execute simple code with functions. e.g fibonacci c=
alculation.
> This series of patches include a non real, sample board.
> No fuses support yet. PC is set to 0 at reset.
>=20
> the patches include the following
> 1. just a basic 8bit AVR CPU, without instruction decoding or translation
> 2. CPU features which allow define the following 8bit AVR cores
>       avr1
>       avr2 avr25
>       avr3 avr31 avr35
>       avr4
>       avr5 avr51
>       avr6
>       xmega2 xmega4 xmega5 xmega6 xmega7
> 3. a definition of sample machine with SRAM, FLASH and CPU which allows t=
o execute simple code
> 4. encoding for all AVR instructions
> 5. interrupt handling
> 6. helpers for IN, OUT, SLEEP, WBR & unsupported instructions
> 7. a decoder which given an opcode decides what istruction it is
> 8. translation of AVR instruction into TCG
> 9. all features together
[...]

>   MAINTAINERS                      |    9 +
>   arch_init.c                      |    2 +
>   configure                        |    7 +
>   default-configs/avr-softmmu.mak  |    5 +
>   gdb-xml/avr-cpu.xml              |   49 +

The part under hw/avr/ is the 'board' part.

You can take a AVR cpu, glue it with peripherals (mapping blocks and=20
wiring IRQ), put it on a PCB ('board') and connect external devices.

You get a QEMU machine. You can load a ELF program directly to memory=20
and execute it, or you can load a firmware from ROM/flash.

>   hw/Kconfig                       |    1 + >   hw/avr/Kconfig           =
        |    6 +
>   hw/avr/Makefile.objs             |    1 +
>   hw/avr/sample.c                  |  282 +++
>   hw/char/Kconfig                  |    3 +
>   hw/char/Makefile.objs            |    1 +
>   hw/char/avr_usart.c              |  324 ++++
>   hw/misc/Kconfig                  |    3 +
>   hw/misc/Makefile.objs            |    2 +
>   hw/misc/avr_mask.c               |  112 ++
>   hw/timer/Kconfig                 |    3 +
>   hw/timer/Makefile.objs           |    2 +
>   hw/timer/avr_timer16.c           |  605 ++++++
>   include/disas/dis-asm.h          |    6 +
>   include/hw/char/avr_usart.h      |   97 +
>   include/hw/misc/avr_mask.h       |   47 +
>   include/hw/timer/avr_timer16.h   |   97 +
>   include/sysemu/arch_init.h       |    1 +
>   qapi/machine.json                |    3 +-

The files under target/avr/ are the architecture part.
Michael and Sarah run the GCC test suite on this, so this part should be=20
quite correct and you shouldn't worry about looking here, except if some=20
instruction behaves incorrectly. I strongly suggest you to stay focused=20
with the files under hw/ and include/hw/.

>   target/avr/Makefile.objs         |   33 +
>   target/avr/cpu-param.h           |   37 +
>   target/avr/cpu-qom.h             |   54 +
>   target/avr/cpu.c                 |  576 ++++++
>   target/avr/cpu.h                 |  253 +++
>   target/avr/gdbstub.c             |   85 +
>   target/avr/helper.c              |  354 ++++
>   target/avr/helper.h              |   29 +
>   target/avr/insn.decode           |  175 ++
>   target/avr/machine.c             |  121 ++
>   target/avr/translate.c           | 3028 ++++++++++++++++++++++++++++++
>   tests/Makefile.include           |    2 +
>   tests/acceptance/machine_avr6.py |   36 +
>   tests/boot-serial-test.c         |   10 +
>   tests/machine-none-test.c        |    1 +
>   39 files changed, 6461 insertions(+), 1 deletion(-)

Hope this helps a bit to start looking at QEMU.

You are welcome to ask any question on this list or on IRC.

Regards,

Phil.


