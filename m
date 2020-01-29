Return-Path: <SRS0=192v=3S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D141C33CB2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:10:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2451020716
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Jan 2020 10:10:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tRt4vK4l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2451020716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43696 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iwkIO-0002ky-6z
	for qemu-devel@archiver.kernel.org; Wed, 29 Jan 2020 05:10:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37592)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwkHi-0002MQ-SR
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:09:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iwkHg-0002UI-2V
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:09:22 -0500
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:38160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iwkHf-0002RT-Nc
 for qemu-devel@nongnu.org; Wed, 29 Jan 2020 05:09:19 -0500
Received: by mail-oi1-x241.google.com with SMTP id l9so13410019oii.5
 for <qemu-devel@nongnu.org>; Wed, 29 Jan 2020 02:09:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Yvymi94t1wmmfiof2rC6SA1q1XHdJPvop3KA6eldLNs=;
 b=tRt4vK4lCXAwOG7DZm/SN6/mkwy4KECy9E3OGP2Ps6LV/d0YUMr7SEKkrLAwIvJxkB
 wJsr8AjZwy1gBcAMyE8qIRmBgzR7g1FlOyldifNfHyD2/d9vv2XuMtv2ql80Gaz1FY93
 CjmM8Hg9rUiSAr8WVCTG3En9fbg9EeLJLiMiHdfdQT3QlBbeMIhFhKtTKJdZkGFEsB2V
 29sF9GfvtSYncbotWhYXuWOUbe6DQBURLS5GDAWLS/ZtqB7ydX6DYIeCpR+93Gargk/j
 1uPJumej5cbT1fouSzNlY6alb8598JH8diEEBG1A/uqHearh1QMoPBItKI4otIEuesQx
 Gqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Yvymi94t1wmmfiof2rC6SA1q1XHdJPvop3KA6eldLNs=;
 b=Cw95yw63Zk+3Sf73j/HX3Gb70Mh994T4nKV6ONFIslervT5i29NJNM1x8414BPl9IQ
 qh00ZHhiK305okbIScgC+t4wnYiahEE3q2vUw2q2ddfbIBRH+KQp4cyQw3x7GqS2KmCt
 wmFp1WqURYMrOT+CuSsMwXrEMU441V/zHHxkC18MYBNtEfbRWWv15icU3+Cqu7Qfh3n5
 cOPqxqwV0TvkfaSPC7pGDMim1GjgIYr6VP6UW1wEbmrrHoXPZpIy63TllCvUeUFTf3Oa
 7ddWpFxJOPyLe6KUk+BRWhRBc5QMo/rphAp0d2Qugos4t+a9NhuO0K6svTHSm0MXuK5u
 5uwg==
X-Gm-Message-State: APjAAAU+XmEjzSliK5YBtun5vJ1PFrhVafwf07G2f6LApLZsJ0BeWI8B
 RP61/u1nuH6zEpRCuGMky0hIe8MTlJiwH7Dh4ko=
X-Google-Smtp-Source: APXvYqwgupT/y0DfArRDBp7d4FlYEffV2jc2kHvlM7TsMNSfY9Rv3ageUqLO0GSHPkcv+k5gz96Cpx7p3kQ+YCLN61U=
X-Received: by 2002:aca:5844:: with SMTP id m65mr5979180oib.136.1580292558760; 
 Wed, 29 Jan 2020 02:09:18 -0800 (PST)
MIME-Version: 1.0
References: <1580079311-20447-1-git-send-email-aleksandar.markovic@rt-rk.com>
 <1580079311-20447-2-git-send-email-aleksandar.markovic@rt-rk.com>
 <CAK4993itnp5EyT8g-zGcMY6Oud9pC9GRv1Aa2dvofrH8mLWnOQ@mail.gmail.com>
 <CAK4993hTqhuZArVNbNs8M8MJkdQbneq0fCsW2b2-fEKaAtCuOQ@mail.gmail.com>
 <CAL1e-=jeQAqQ3GrVg2z9Y9qW+5KXvOURhpX6ApM5SJ2aJ8oDMQ@mail.gmail.com>
 <CAK4993jy-nPPANFW9aFW7Kk=B7EpOqdq8Pf9qStn5g+gevNHYg@mail.gmail.com>
 <CAL1e-=hn3kJw6hVkDeP=-45WxMUVZfdrj=_DyAGJGFTTMJQp6w@mail.gmail.com>
 <3ea8b187-e425-d7ac-bc91-6d36b3eaba69@redhat.com>
In-Reply-To: <3ea8b187-e425-d7ac-bc91-6d36b3eaba69@redhat.com>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Wed, 29 Jan 2020 11:09:02 +0100
Message-ID: <CAL1e-=h=N4zfCDh1bQ1hxQdmAm8JyTMasWtK44ZwhotrFHMa_A@mail.gmail.com>
Subject: Re: [PATCH rc3 01/30] target/avr: Add basic parameters for new AVR
 platform
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Content-Type: multipart/alternative; boundary="0000000000009b2d40059d448859"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::241
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>,
 Aleksandar Markovic <aleksandar.markovic@rt-rk.com>,
 Michael Rolnik <mrolnik@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--0000000000009b2d40059d448859
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

08:38 Sre, 29.01.2020. Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com> =D1=
=98=D0=B5
=D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=BE/=D0=BB=D0=B0:
>
> On 1/28/20 7:01 PM, Aleksandar Markovic wrote:
> > Works for me too.
> >
> >
> > 16:10 Uto, 28.01.2020. Michael Rolnik <mrolnik@gmail.com
> > <mailto:mrolnik@gmail.com>> =D1=98=D0=B5 =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=BE/=D0=BB=D0=B0:
> >
> >     Sounds good to me.
> >
> >     On Tue, Jan 28, 2020 at 3:49 PM Aleksandar Markovic
> >     <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>>
> >     wrote:
> >
> >
> >
> >         On Tuesday, January 28, 2020, Michael Rolnik <mrolnik@gmail.com
> >         <mailto:mrolnik@gmail.com>> wrote:
> >
> >             Hi all.
> >
> >             I am totally lost in the email.
> >             Are there any action items for me / someone else ?
> >
> >             Regards,
> >             Michael Rolnik
> >
> >
> >         I think it would be helpful if we have rc4 with two action
items:
> >
> >             - remove CONFIG_USER_ONLY references, and all dead code tha=
y
> >         may have come with it + add check in cpu.h that Philippe
suggested.
> >             - remove "Atmel" word from all elements of the series (patc=
h
> >         names, messages, filenames, structure names, ...)
> >
> >         Needless to say that this must be done with extreme care.
> >
> >         I propose that Philippe do rc4.
>
> I won't have time to work on AVR this week-end and the next one (family
> plans). If I find time I prefer prioritize the raspi machine because I
> want to see some work merged before Igor "use memdev for RAM" series get
> in. So if you guys have time & motivation, go for it!
>

OK, I am going to do and send rc4.

Yours,
Aleksandar

> >
> >         Sincerely,
> >         Aleksandar
> >
> >
> >             On Mon, Jan 27, 2020 at 10:54 AM Michael Rolnik
> >             <mrolnik@gmail.com <mailto:mrolnik@gmail.com>> wrote:
> >
> >                 Thanks for you help guys.
> >
> >                 On Mon, Jan 27, 2020 at 12:55 AM Aleksandar Markovic
> >                 <aleksandar.markovic@rt-rk.com
> >                 <mailto:aleksandar.markovic@rt-rk.com>> wrote:
> >
> >                     From: Michael Rolnik <mrolnik@gmail.com
> >                     <mailto:mrolnik@gmail.com>>
> >
> >                     This includes definitions of various basic
> >                     parameters needed
> >                     for integration of a new platform into QEMU.
> >
> >                     Co-developed-by: Michael Rolnik <mrolnik@gmail.com
> >                     <mailto:mrolnik@gmail.com>>
> >                     Co-developed-by: Sarah Harris <S.E.Harris@kent.ac.u=
k
> >                     <mailto:S.E.Harris@kent.ac.uk>>
> >                     Signed-off-by: Michael Rolnik <mrolnik@gmail.com
> >                     <mailto:mrolnik@gmail.com>>
> >                     Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk
> >                     <mailto:S.E.Harris@kent.ac.uk>>
> >                     Signed-off-by: Michael Rolnik <mrolnik@gmail.com
> >                     <mailto:mrolnik@gmail.com>>
> >                     Acked-by: Igor Mammedov <imammedo@redhat.com
> >                     <mailto:imammedo@redhat.com>>
> >                     Tested-by: Philippe Mathieu-Daud=C3=A9 <philmd@redh=
at.com
> >                     <mailto:philmd@redhat.com>>
> >                     Signed-off-by: Richard Henderson
> >                     <richard.henderson@linaro.org
> >                     <mailto:richard.henderson@linaro.org>>
> >                     Signed-off-by: Aleksandar Markovic
> >                     <aleksandar.m.mail@gmail.com
> >                     <mailto:aleksandar.m.mail@gmail.com>>
> >                     ---
> >                       target/avr/cpu-param.h | 37
++++++++++++++++++++++++++
> >                       target/avr/cpu.h       | 72
> >                     ++++++++++++++++++++++++++++++++++++++++++++++++++
> >                       2 files changed, 109 insertions(+)
> >                       create mode 100644 target/avr/cpu-param.h
> >                       create mode 100644 target/avr/cpu.h
> >
> >                     diff --git a/target/avr/cpu-param.h
> >                     b/target/avr/cpu-param.h
> >                     new file mode 100644
> >                     index 0000000..0c29ce4
> >                     --- /dev/null
> >                     +++ b/target/avr/cpu-param.h
> >                     @@ -0,0 +1,37 @@
> >                     +/*
> >                     + * QEMU AVR CPU
> >                     + *
> >                     + * Copyright (c) 2019 Michael Rolnik
> >                     + *
> >                     + * This library is free software; you can
> >                     redistribute it and/or
> >                     + * modify it under the terms of the GNU Lesser
> >                     General Public
> >                     + * License as published by the Free Software
> >                     Foundation; either
> >                     + * version 2.1 of the License, or (at your option)
> >                     any later version.
> >                     + *
> >                     + * This library is distributed in the hope that it
> >                     will be useful,
> >                     + * but WITHOUT ANY WARRANTY; without even the
> >                     implied warranty of
> >                     + * MERCHANTABILITY or FITNESS FOR A PARTICULAR
> >                     PURPOSE.  See the GNU
> >                     + * Lesser General Public License for more details.
> >                     + *
> >                     + * You should have received a copy of the GNU
> >                     Lesser General Public
> >                     + * License along with this library; if not, see
> >                     + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> >                     + */
> >                     +
> >                     +#ifndef AVR_CPU_PARAM_H
> >                     +#define AVR_CPU_PARAM_H
> >                     +
> >                     +#define TARGET_LONG_BITS 32
> >                     +/*
> >                     + * TARGET_PAGE_BITS cannot be more than 8 bits
because
> >                     + * 1.  all IO registers occupy [0x0000 .. 0x00ff]
> >                     address range, and they
> >                     + *     should be implemented as a device and not
memory
> >                     + * 2.  SRAM starts at the address 0x0100
> >                     + */
> >                     +#define TARGET_PAGE_BITS 8
> >                     +#define TARGET_PHYS_ADDR_SPACE_BITS 24
> >                     +#define TARGET_VIRT_ADDR_SPACE_BITS 24
> >                     +#define NB_MMU_MODES 2
> >                     +
> >                     +
> >                     +#endif
> >                     diff --git a/target/avr/cpu.h b/target/avr/cpu.h
> >                     new file mode 100644
> >                     index 0000000..d122611
> >                     --- /dev/null
> >                     +++ b/target/avr/cpu.h
> >                     @@ -0,0 +1,72 @@
> >                     +/*
> >                     + * QEMU AVR CPU
> >                     + *
> >                     + * Copyright (c) 2019 Michael Rolnik
> >                     + *
> >                     + * This library is free software; you can
> >                     redistribute it and/or
> >                     + * modify it under the terms of the GNU Lesser
> >                     General Public
> >                     + * License as published by the Free Software
> >                     Foundation; either
> >                     + * version 2.1 of the License, or (at your option)
> >                     any later version.
> >                     + *
> >                     + * This library is distributed in the hope that it
> >                     will be useful,
> >                     + * but WITHOUT ANY WARRANTY; without even the
> >                     implied warranty of
> >                     + * MERCHANTABILITY or FITNESS FOR A PARTICULAR
> >                     PURPOSE.  See the GNU
> >                     + * Lesser General Public License for more details.
> >                     + *
> >                     + * You should have received a copy of the GNU
> >                     Lesser General Public
> >                     + * License along with this library; if not, see
> >                     + * <http://www.gnu.org/licenses/lgpl-2.1.html>
> >                     + */
> >                     +
> >                     +#ifndef QEMU_AVR_CPU_H
> >                     +#define QEMU_AVR_CPU_H
> >                     +
> >                     +#include "cpu-qom.h"
> >                     +#include "exec/cpu-defs.h"
> >                     +
> >                     +#define TCG_GUEST_DEFAULT_MO 0
> >                     +#define AVR_CPU_TYPE_SUFFIX "-" TYPE_AVR_CPU
> >                     +#define AVR_CPU_TYPE_NAME(name) (name
> >                     AVR_CPU_TYPE_SUFFIX)
> >                     +#define CPU_RESOLVING_TYPE TYPE_AVR_CPU
> >                     +
> >                     +/*
> >                     + * AVR has two memory spaces, data & code.
> >                     + * e.g. both have 0 address
> >                     + * ST/LD instructions access data space
> >                     + * LPM/SPM and instruction fetching access code
> >                     memory space
> >                     + */
> >                     +#define MMU_CODE_IDX 0
> >                     +#define MMU_DATA_IDX 1
> >                     +
> >                     +#define EXCP_RESET 1
> >                     +#define EXCP_INT(n) (EXCP_RESET + (n) + 1)
> >                     +
> >                     +/* Number of CPU registers */
> >                     +#define NUMBER_OF_CPU_REGISTERS 32
> >                     +/* Number of IO registers accessible by
ld/st/in/out */
> >                     +#define NUMBER_OF_IO_REGISTERS 64
> >                     +
> >                     +/*
> >                     + * Offsets of AVR memory regions in host memory
space.
> >                     + *
> >                     + * This is needed because the AVR has separate cod=
e
> >                     and data address
> >                     + * spaces that both have start from zero but have
> >                     to go somewhere in
> >                     + * host memory.
> >                     + *
> >                     + * It's also useful to know where some things are,
> >                     like the IO registers.
> >                     + */
> >                     +/* Flash program memory */
> >                     +#define OFFSET_CODE 0x00000000
> >                     +/* CPU registers, IO registers, and SRAM */
> >                     +#define OFFSET_DATA 0x00800000
> >                     +/* CPU registers specifically, these are mapped at
> >                     the start of data */
> >                     +#define OFFSET_CPU_REGISTERS OFFSET_DATA
> >                     +/*
> >                     + * IO registers, including status register, stack
> >                     pointer, and memory
> >                     + * mapped peripherals, mapped just after CPU
registers
> >                     + */
> >                     +#define OFFSET_IO_REGISTERS (OFFSET_DATA +
> >                     NUMBER_OF_CPU_REGISTERS)
> >                     +
> >                     +#define EF_AVR_MACH 0x7F
> >                     +
> >                     +#endif /* !defined (QEMU_AVR_CPU_H) */
> >                     --
> >                     2.7.4
> >
> >
> >
> >                 --
> >                 Best Regards,
> >                 Michael Rolnik
> >
> >
> >
> >             --
> >             Best Regards,
> >             Michael Rolnik
> >
> >
> >
> >     --
> >     Best Regards,
> >     Michael Rolnik
> >
>

--0000000000009b2d40059d448859
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: base64

PHAgZGlyPSJsdHIiPjwvcD4NCjxwIGRpcj0ibHRyIj4wODozOCBTcmUsIDI5LjAxLjIwMjAuIFBo
aWxpcHBlIE1hdGhpZXUtRGF1ZMOpICZsdDs8YSBocmVmPSJtYWlsdG86cGhpbG1kQHJlZGhhdC5j
b20iPnBoaWxtZEByZWRoYXQuY29tPC9hPiZndDsg0ZjQtSDQvdCw0L/QuNGB0LDQvi/Qu9CwOjxi
cj4NCiZndDs8YnI+DQomZ3Q7IE9uIDEvMjgvMjAgNzowMSBQTSwgQWxla3NhbmRhciBNYXJrb3Zp
YyB3cm90ZTo8YnI+DQomZ3Q7ICZndDsgV29ya3MgZm9yIG1lIHRvby48YnI+DQomZ3Q7ICZndDsg
PGJyPg0KJmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0OyAxNjoxMCBVdG8sIDI4LjAxLjIwMjAuIE1p
Y2hhZWwgUm9sbmlrICZsdDs8YSBocmVmPSJtYWlsdG86bXJvbG5pa0BnbWFpbC5jb20iPm1yb2xu
aWtAZ21haWwuY29tPC9hPiA8YnI+DQomZ3Q7ICZndDsgJmx0O21haWx0bzo8YSBocmVmPSJtYWls
dG86bXJvbG5pa0BnbWFpbC5jb20iPm1yb2xuaWtAZ21haWwuY29tPC9hPiZndDsmZ3Q7INGY0LUg
0L3QsNC/0LjRgdCw0L4v0LvQsDo8YnI+DQomZ3Q7ICZndDsgPGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqBTb3VuZHMgZ29vZCB0byBtZS48YnI+DQomZ3Q7ICZndDsgPGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqBPbiBUdWUsIEphbiAyOCwgMjAyMCBhdCAzOjQ5IFBNIEFsZWtzYW5kYXIgTWFya292aWM8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCZsdDs8YSBocmVmPSJtYWlsdG86YWxla3NhbmRhci5tLm1haWxA
Z21haWwuY29tIj5hbGVrc2FuZGFyLm0ubWFpbEBnbWFpbC5jb208L2E+ICZsdDttYWlsdG86PGEg
aHJlZj0ibWFpbHRvOmFsZWtzYW5kYXIubS5tYWlsQGdtYWlsLmNvbSI+YWxla3NhbmRhci5tLm1h
aWxAZ21haWwuY29tPC9hPiZndDsmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqB3cm90ZTo8YnI+
DQomZ3Q7ICZndDsgPGJyPg0KJmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0OyA8YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoCDCoCDCoE9uIFR1ZXNkYXksIEphbnVhcnkgMjgsIDIwMjAsIE1pY2hhZWwgUm9s
bmlrICZsdDs8YSBocmVmPSJtYWlsdG86bXJvbG5pa0BnbWFpbC5jb20iPm1yb2xuaWtAZ21haWwu
Y29tPC9hPjxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJt
YWlsdG86bXJvbG5pa0BnbWFpbC5jb20iPm1yb2xuaWtAZ21haWwuY29tPC9hPiZndDsmZ3Q7IHdy
b3RlOjxicj4NCiZndDsgJmd0OyA8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoEhp
IGFsbC48YnI+DQomZ3Q7ICZndDsgPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBJ
IGFtIHRvdGFsbHkgbG9zdCBpbiB0aGUgZW1haWwuPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqBBcmUgdGhlcmUgYW55IGFjdGlvbiBpdGVtcyBmb3IgbWUgLyBzb21lb25lwqBlbHNl
ID88YnI+DQomZ3Q7ICZndDsgPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBSZWdh
cmRzLDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgTWljaGFlbCBSb2xuaWs8YnI+
DQomZ3Q7ICZndDsgPGJyPg0KJmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
SSB0aGluayBpdCB3b3VsZCBiZSBoZWxwZnVsIGlmIHdlIGhhdmUgcmM0IHdpdGggdHdvIGFjdGlv
biBpdGVtczo8YnI+DQomZ3Q7ICZndDsgPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAtIHJlbW92ZSBDT05GSUdfVVNFUl9PTkxZIHJlZmVyZW5jZXMsIGFuZCBhbGwgZGVhZCBjb2Rl
IHRoYXk8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoG1heSBoYXZlIGNvbWUgd2l0aCBpdCAr
IGFkZCBjaGVjayBpbiBjcHUuaCB0aGF0IFBoaWxpcHBlIHN1Z2dlc3RlZC48YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoC0gcmVtb3ZlICZxdW90O0F0bWVsJnF1b3Q7IHdvcmQgZnJv
bSBhbGwgZWxlbWVudHMgb2YgdGhlIHNlcmllcyAocGF0Y2g8YnI+DQomZ3Q7ICZndDvCoCDCoCDC
oCDCoCDCoG5hbWVzLCBtZXNzYWdlcywgZmlsZW5hbWVzLCBzdHJ1Y3R1cmUgbmFtZXMsIC4uLik8
YnI+DQomZ3Q7ICZndDsgPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqBOZWVkbGVzcyB0byBz
YXkgdGhhdCB0aGlzIG11c3QgYmUgZG9uZSB3aXRoIGV4dHJlbWUgY2FyZS48YnI+DQomZ3Q7ICZn
dDsgPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqBJIHByb3Bvc2UgdGhhdCBQaGlsaXBwZSBk
byByYzQuPGJyPg0KJmd0Ozxicj4NCiZndDsgSSB3b24mIzM5O3QgaGF2ZSB0aW1lIHRvIHdvcmsg
b24gQVZSIHRoaXMgd2Vlay1lbmQgYW5kIHRoZSBuZXh0IG9uZSAoZmFtaWx5IDxicj4NCiZndDsg
cGxhbnMpLiBJZiBJIGZpbmQgdGltZSBJIHByZWZlciBwcmlvcml0aXplIHRoZSByYXNwaSBtYWNo
aW5lIGJlY2F1c2UgSSA8YnI+DQomZ3Q7IHdhbnQgdG8gc2VlIHNvbWUgd29yayBtZXJnZWQgYmVm
b3JlIElnb3IgJnF1b3Q7dXNlIG1lbWRldiBmb3IgUkFNJnF1b3Q7IHNlcmllcyBnZXQgPGJyPg0K
Jmd0OyBpbi4gU28gaWYgeW91IGd1eXMgaGF2ZSB0aW1lICZhbXA7IG1vdGl2YXRpb24sIGdvIGZv
ciBpdCE8YnI+DQomZ3Q7PC9wPg0KPHAgZGlyPSJsdHIiPk9LLCBJIGFtIGdvaW5nIHRvIGRvIGFu
ZCBzZW5kIHJjNC48L3A+DQo8cCBkaXI9Imx0ciI+WW91cnMsPGJyPg0KQWxla3NhbmRhcjxicj48
L3A+DQo8cCBkaXI9Imx0ciI+Jmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
U2luY2VyZWx5LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgQWxla3NhbmRhcjxicj4NCiZn
dDsgJmd0OyA8YnI+DQomZ3Q7ICZndDsgPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqBPbiBNb24sIEphbiAyNywgMjAyMCBhdCAxMDo1NCBBTSBNaWNoYWVsIFJvbG5pazxicj4NCiZn
dDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgJmx0OzxhIGhyZWY9Im1haWx0bzptcm9sbmlrQGdt
YWlsLmNvbSI+bXJvbG5pa0BnbWFpbC5jb208L2E+ICZsdDttYWlsdG86PGEgaHJlZj0ibWFpbHRv
Om1yb2xuaWtAZ21haWwuY29tIj5tcm9sbmlrQGdtYWlsLmNvbTwvYT4mZ3Q7Jmd0OyB3cm90ZTo8
YnI+DQomZ3Q7ICZndDsgPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBU
aGFua3MgZm9yIHlvdSBoZWxwIGd1eXMuPGJyPg0KJmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgT24gTW9uLCBKYW4gMjcsIDIwMjAgYXQgMTI6NTUgQU0g
QWxla3NhbmRhciBNYXJrb3ZpYzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgJmx0OzxhIGhyZWY9Im1haWx0bzphbGVrc2FuZGFyLm1hcmtvdmljQHJ0LXJrLmNvbSI+YWxl
a3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb208L2E+PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzphbGVrc2FuZGFyLm1hcmtv
dmljQHJ0LXJrLmNvbSI+YWxla3NhbmRhci5tYXJrb3ZpY0BydC1yay5jb208L2E+Jmd0OyZndDsg
d3JvdGU6PGJyPg0KJmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgRnJvbTogTWljaGFlbCBSb2xuaWsgJmx0OzxhIGhyZWY9Im1haWx0bzptcm9s
bmlrQGdtYWlsLmNvbSI+bXJvbG5pa0BnbWFpbC5jb208L2E+PGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzptcm9s
bmlrQGdtYWlsLmNvbSI+bXJvbG5pa0BnbWFpbC5jb208L2E+Jmd0OyZndDs8YnI+DQomZ3Q7ICZn
dDsgPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBUaGlzIGlu
Y2x1ZGVzIGRlZmluaXRpb25zIG9mIHZhcmlvdXMgYmFzaWM8YnI+DQomZ3Q7ICZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHBhcmFtZXRlcnMgbmVlZGVkPGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBmb3IgaW50ZWdyYXRpb24gb2YgYSBuZXcg
cGxhdGZvcm0gaW50byBRRU1VLjxicj4NCiZndDsgJmd0OyA8YnI+DQomZ3Q7ICZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoENvLWRldmVsb3BlZC1ieTogTWljaGFlbCBSb2xuaWsg
Jmx0OzxhIGhyZWY9Im1haWx0bzptcm9sbmlrQGdtYWlsLmNvbSI+bXJvbG5pa0BnbWFpbC5jb208
L2E+PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmbHQ7bWFp
bHRvOjxhIGhyZWY9Im1haWx0bzptcm9sbmlrQGdtYWlsLmNvbSI+bXJvbG5pa0BnbWFpbC5jb208
L2E+Jmd0OyZndDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oENvLWRldmVsb3BlZC1ieTogU2FyYWggSGFycmlzICZsdDs8YSBocmVmPSJtYWlsdG86Uy5FLkhh
cnJpc0BrZW50LmFjLnVrIj5TLkUuSGFycmlzQGtlbnQuYWMudWs8L2E+PGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0
bzpTLkUuSGFycmlzQGtlbnQuYWMudWsiPlMuRS5IYXJyaXNAa2VudC5hYy51azwvYT4mZ3Q7Jmd0
Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgU2lnbmVkLW9m
Zi1ieTogTWljaGFlbCBSb2xuaWsgJmx0OzxhIGhyZWY9Im1haWx0bzptcm9sbmlrQGdtYWlsLmNv
bSI+bXJvbG5pa0BnbWFpbC5jb208L2E+PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzptcm9sbmlrQGdtYWlsLmNv
bSI+bXJvbG5pa0BnbWFpbC5jb208L2E+Jmd0OyZndDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoFNpZ25lZC1vZmYtYnk6IFNhcmFoIEhhcnJpcyAmbHQ7PGEg
aHJlZj0ibWFpbHRvOlMuRS5IYXJyaXNAa2VudC5hYy51ayI+Uy5FLkhhcnJpc0BrZW50LmFjLnVr
PC9hPjxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O21h
aWx0bzo8YSBocmVmPSJtYWlsdG86Uy5FLkhhcnJpc0BrZW50LmFjLnVrIj5TLkUuSGFycmlzQGtl
bnQuYWMudWs8L2E+Jmd0OyZndDs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUm9sbmlrICZsdDs8YSBocmVmPSJtYWls
dG86bXJvbG5pa0BnbWFpbC5jb20iPm1yb2xuaWtAZ21haWwuY29tPC9hPjxicj4NCiZndDsgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWls
dG86bXJvbG5pa0BnbWFpbC5jb20iPm1yb2xuaWtAZ21haWwuY29tPC9hPiZndDsmZ3Q7PGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBBY2tlZC1ieTogSWdvciBN
YW1tZWRvdiAmbHQ7PGEgaHJlZj0ibWFpbHRvOmltYW1tZWRvQHJlZGhhdC5jb20iPmltYW1tZWRv
QHJlZGhhdC5jb208L2E+PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAmbHQ7bWFpbHRvOjxhIGhyZWY9Im1haWx0bzppbWFtbWVkb0ByZWRoYXQuY29tIj5pbWFt
bWVkb0ByZWRoYXQuY29tPC9hPiZndDsmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqBUZXN0ZWQtYnk6IFBoaWxpcHBlIE1hdGhpZXUtRGF1ZMOpICZsdDs8
YSBocmVmPSJtYWlsdG86cGhpbG1kQHJlZGhhdC5jb20iPnBoaWxtZEByZWRoYXQuY29tPC9hPjxi
cj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O21haWx0bzo8
YSBocmVmPSJtYWlsdG86cGhpbG1kQHJlZGhhdC5jb20iPnBoaWxtZEByZWRoYXQuY29tPC9hPiZn
dDsmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBTaWdu
ZWQtb2ZmLWJ5OiBSaWNoYXJkIEhlbmRlcnNvbjxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgJmx0OzxhIGhyZWY9Im1haWx0bzpyaWNoYXJkLmhlbmRlcnNvbkBs
aW5hcm8ub3JnIj5yaWNoYXJkLmhlbmRlcnNvbkBsaW5hcm8ub3JnPC9hPjxicj4NCiZndDsgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0O21haWx0bzo8YSBocmVmPSJtYWls
dG86cmljaGFyZC5oZW5kZXJzb25AbGluYXJvLm9yZyI+cmljaGFyZC5oZW5kZXJzb25AbGluYXJv
Lm9yZzwvYT4mZ3Q7Jmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgU2lnbmVkLW9mZi1ieTogQWxla3NhbmRhciBNYXJrb3ZpYzxicj4NCiZndDsgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgJmx0OzxhIGhyZWY9Im1haWx0bzphbGVrc2Fu
ZGFyLm0ubWFpbEBnbWFpbC5jb20iPmFsZWtzYW5kYXIubS5tYWlsQGdtYWlsLmNvbTwvYT48YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCZsdDttYWlsdG86PGEg
aHJlZj0ibWFpbHRvOmFsZWtzYW5kYXIubS5tYWlsQGdtYWlsLmNvbSI+YWxla3NhbmRhci5tLm1h
aWxAZ21haWwuY29tPC9hPiZndDsmZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAtLS08YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoHRhcmdldC9hdnIvY3B1LXBhcmFtLmggfCAzNyArKysrKysrKysrKysrKysrKysr
KysrKysrKzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
dGFyZ2V0L2F2ci9jcHUuaMKgIMKgIMKgIMKgfCA3Mjxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKys8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoDIgZmlsZXMgY2hhbmdlZCwgMTA5IGluc2VydGlvbnMoKyk8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGNyZWF0ZSBtb2RlIDEwMDY0NCB0YXJn
ZXQvYXZyL2NwdS1wYXJhbS5oPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqBjcmVhdGUgbW9kZSAxMDA2NDQgdGFyZ2V0L2F2ci9jcHUuaDxicj4NCiZndDsg
Jmd0OyA8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGRpZmYg
LS1naXQgYS90YXJnZXQvYXZyL2NwdS1wYXJhbS5oPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBiL3RhcmdldC9hdnIvY3B1LXBhcmFtLmg8YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoG5ldyBmaWxlIG1vZGUgMTAwNjQ0PGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBpbmRleCAwMDAwMDAw
Li4wYzI5Y2U0PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAt
LS0gL2Rldi9udWxsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqArKysgYi90YXJnZXQvYXZyL2NwdS1wYXJhbS5oPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqBAQCAtMCwwICsxLDM3IEBAPGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArLyo8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCsgKiBRRU1VIEFWUiBDUFU8YnI+DQomZ3Q7ICZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsgKjxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgKyAqIENvcHlyaWdodCAoYykgMjAxOSBNaWNoYWVsIFJvbG5pazxi
cj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKyAqPGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArICogVGhpcyBsaWJyYXJ5IGlz
IGZyZWUgc29mdHdhcmU7IHlvdSBjYW48YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoHJlZGlzdHJpYnV0ZSBpdCBhbmQvb3I8YnI+DQomZ3Q7ICZndDvCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsgKiBtb2RpZnkgaXQgdW5kZXIgdGhlIHRlcm1zIG9m
IHRoZSBHTlUgTGVzc2VyPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBHZW5lcmFsIFB1YmxpYzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgKyAqIExpY2Vuc2UgYXMgcHVibGlzaGVkIGJ5IHRoZSBGcmVlIFNvZnR3YXJlPGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBGb3VuZGF0aW9uOyBl
aXRoZXI8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsgKiB2
ZXJzaW9uIDIuMSBvZiB0aGUgTGljZW5zZSwgb3IgKGF0IHlvdXIgb3B0aW9uKTxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgYW55IGxhdGVyIHZlcnNpb24uPGJy
Pg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArICo8YnI+DQomZ3Q7
ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsgKiBUaGlzIGxpYnJhcnkgaXMg
ZGlzdHJpYnV0ZWQgaW4gdGhlIGhvcGUgdGhhdCBpdDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgd2lsbCBiZSB1c2VmdWwsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArICogYnV0IFdJVEhPVVQgQU5ZIFdBUlJBTlRZOyB3
aXRob3V0IGV2ZW4gdGhlPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBpbXBsaWVkIHdhcnJhbnR5IG9mPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqArICogTUVSQ0hBTlRBQklMSVRZIG9yIEZJVE5FU1MgRk9SIEEgUEFSVElD
VUxBUjxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgUFVSUE9T
RS7CoCBTZWUgdGhlIEdOVTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgKyAqIExlc3NlciBHZW5lcmFsIFB1YmxpYyBMaWNlbnNlIGZvciBtb3JlIGRldGFpbHMu
PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArICo8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsgKiBZb3Ugc2hvdWxkIGhh
dmUgcmVjZWl2ZWQgYSBjb3B5IG9mIHRoZSBHTlU8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoExlc3NlciBHZW5lcmFsIFB1YmxpYzxicj4NCiZndDsgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKyAqIExpY2Vuc2UgYWxvbmcgd2l0aCB0aGlz
IGxpYnJhcnk7IGlmIG5vdCwgc2VlPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqArICogJmx0OzxhIGhyZWY9Imh0dHA6Ly93d3cuZ251Lm9yZy9saWNlbnNlcy9s
Z3BsLTIuMS5odG1sIj5odHRwOi8vd3d3LmdudS5vcmcvbGljZW5zZXMvbGdwbC0yLjEuaHRtbDwv
YT4mZ3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArICov
PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArPGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArI2lmbmRlZiBBVlJfQ1BVX1BB
UkFNX0g8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsjZGVm
aW5lIEFWUl9DUFVfUEFSQU1fSDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgKzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
KyNkZWZpbmUgVEFSR0VUX0xPTkdfQklUUyAzMjxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgKy8qPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqArICogVEFSR0VUX1BBR0VfQklUUyBjYW5ub3QgYmUgbW9yZSB0aGFuIDggYml0
cyBiZWNhdXNlPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAr
ICogMS7CoCBhbGwgSU8gcmVnaXN0ZXJzIG9jY3VweSBbMHgwMDAwIC4uIDB4MDBmZl08YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGFkZHJlc3MgcmFuZ2UsIGFu
ZCB0aGV5PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArICrC
oCDCoCDCoHNob3VsZCBiZSBpbXBsZW1lbnRlZCBhcyBhIGRldmljZSBhbmQgbm90IG1lbW9yeTxi
cj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKyAqIDIuwqAgU1JB
TSBzdGFydHMgYXQgdGhlIGFkZHJlc3MgMHgwMTAwPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqArICovPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqArI2RlZmluZSBUQVJHRVRfUEFHRV9CSVRTIDg8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsjZGVmaW5lIFRBUkdFVF9QSFlTX0FERFJf
U1BBQ0VfQklUUyAyNDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgKyNkZWZpbmUgVEFSR0VUX1ZJUlRfQUREUl9TUEFDRV9CSVRTIDI0PGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArI2RlZmluZSBOQl9NTVVfTU9ERVMgMjxi
cj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKzxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKzxicj4NCiZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKyNlbmRpZjxicj4NCiZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgZGlmZiAtLWdpdCBhL3RhcmdldC9hdnIvY3B1LmggYi90
YXJnZXQvYXZyL2NwdS5oPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBuZXcgZmlsZSBtb2RlIDEwMDY0NDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgaW5kZXggMDAwMDAwMC4uZDEyMjYxMTxicj4NCiZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLS0tIC9kZXYvbnVsbDxicj4NCiZndDsgJmd0O8Kg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKysrIGIvdGFyZ2V0L2F2ci9jcHUuaDxicj4N
CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQEAgLTAsMCArMSw3MiBA
QDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKy8qPGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArICogUUVNVSBBVlIgQ1BV
PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArICo8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsgKiBDb3B5cmlnaHQgKGMp
IDIwMTkgTWljaGFlbCBSb2xuaWs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCsgKjxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgKyAqIFRoaXMgbGlicmFyeSBpcyBmcmVlIHNvZnR3YXJlOyB5b3UgY2FuPGJyPg0KJmd0OyAm
Z3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqByZWRpc3RyaWJ1dGUgaXQgYW5kL29y
PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArICogbW9kaWZ5
IGl0IHVuZGVyIHRoZSB0ZXJtcyBvZiB0aGUgR05VIExlc3Nlcjxicj4NCiZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgR2VuZXJhbCBQdWJsaWM8YnI+DQomZ3Q7ICZndDvC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsgKiBMaWNlbnNlIGFzIHB1Ymxpc2hlZCBi
eSB0aGUgRnJlZSBTb2Z0d2FyZTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgRm91bmRhdGlvbjsgZWl0aGVyPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqArICogdmVyc2lvbiAyLjEgb2YgdGhlIExpY2Vuc2UsIG9yIChhdCB5
b3VyIG9wdGlvbik8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oGFueSBsYXRlciB2ZXJzaW9uLjxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgKyAqPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqArICogVGhpcyBsaWJyYXJ5IGlzIGRpc3RyaWJ1dGVkIGluIHRoZSBob3BlIHRoYXQgaXQ8YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHdpbGwgYmUgdXNlZnVs
LDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKyAqIGJ1dCBX
SVRIT1VUIEFOWSBXQVJSQU5UWTsgd2l0aG91dCBldmVuIHRoZTxicj4NCiZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgaW1wbGllZCB3YXJyYW50eSBvZjxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKyAqIE1FUkNIQU5UQUJJTElUWSBv
ciBGSVRORVNTIEZPUiBBIFBBUlRJQ1VMQVI8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoFBVUlBPU0UuwqAgU2VlIHRoZSBHTlU8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsgKiBMZXNzZXIgR2VuZXJhbCBQdWJsaWMgTGlj
ZW5zZSBmb3IgbW9yZSBkZXRhaWxzLjxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgKyAqPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqArICogWW91IHNob3VsZCBoYXZlIHJlY2VpdmVkIGEgY29weSBvZiB0aGUgR05VPGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBMZXNzZXIgR2VuZXJhbCBQ
dWJsaWM8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsgKiBM
aWNlbnNlIGFsb25nIHdpdGggdGhpcyBsaWJyYXJ5OyBpZiBub3QsIHNlZTxicj4NCiZndDsgJmd0
O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKyAqICZsdDs8YSBocmVmPSJodHRwOi8v
d3d3LmdudS5vcmcvbGljZW5zZXMvbGdwbC0yLjEuaHRtbCI+aHR0cDovL3d3dy5nbnUub3JnL2xp
Y2Vuc2VzL2xncGwtMi4xLmh0bWw8L2E+Jmd0Ozxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgKyAqLzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgKzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgKyNpZm5kZWYgUUVNVV9BVlJfQ1BVX0g8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCsjZGVmaW5lIFFFTVVfQVZSX0NQVV9IPGJyPg0KJmd0OyAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqArI2luY2x1ZGUgJnF1b3Q7Y3B1LXFvbS5oJnF1b3Q7PGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArI2luY2x1ZGUgJnF1b3Q7
ZXhlYy9jcHUtZGVmcy5oJnF1b3Q7PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqArPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqArI2RlZmluZSBUQ0dfR1VFU1RfREVGQVVMVF9NTyAwPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArI2RlZmluZSBBVlJfQ1BVX1RZUEVfU1VGRklYICZxdW90
Oy0mcXVvdDsgVFlQRV9BVlJfQ1BVPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqArI2RlZmluZSBBVlJfQ1BVX1RZUEVfTkFNRShuYW1lKSAobmFtZTxicj4NCiZn
dDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgQVZSX0NQVV9UWVBFX1NVRkZJ
WCk8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsjZGVmaW5l
IENQVV9SRVNPTFZJTkdfVFlQRSBUWVBFX0FWUl9DUFU8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCsvKjxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgKyAqIEFWUiBoYXMgdHdvIG1lbW9yeSBzcGFjZXMsIGRhdGEgJmFtcDsgY29kZS48YnI+
DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsgKiBlLmcuIGJvdGgg
aGF2ZSAwIGFkZHJlc3M8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCsgKiBTVC9MRCBpbnN0cnVjdGlvbnMgYWNjZXNzIGRhdGEgc3BhY2U8YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsgKiBMUE0vU1BNIGFuZCBpbnN0cnVj
dGlvbiBmZXRjaGluZyBhY2Nlc3MgY29kZTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgbWVtb3J5IHNwYWNlPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqArICovPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqArI2RlZmluZSBNTVVfQ09ERV9JRFggMDxicj4NCiZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKyNkZWZpbmUgTU1VX0RBVEFfSURYIDE8YnI+DQomZ3Q7
ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCs8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsjZGVmaW5lIEVYQ1BfUkVTRVQgMTxicj4NCiZn
dDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKyNkZWZpbmUgRVhDUF9JTlQo
bikgKEVYQ1BfUkVTRVQgKyAobikgKyAxKTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgKzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgKy8qIE51bWJlciBvZiBDUFUgcmVnaXN0ZXJzICovPGJyPg0KJmd0OyAmZ3Q7wqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArI2RlZmluZSBOVU1CRVJfT0ZfQ1BVX1JFR0lTVEVS
UyAzMjxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKy8qIE51
bWJlciBvZiBJTyByZWdpc3RlcnMgYWNjZXNzaWJsZSBieSBsZC9zdC9pbi9vdXQgKi88YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsjZGVmaW5lIE5VTUJFUl9P
Rl9JT19SRUdJU1RFUlMgNjQ8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsv
Kjxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKyAqIE9mZnNl
dHMgb2YgQVZSIG1lbW9yeSByZWdpb25zIGluIGhvc3QgbWVtb3J5IHNwYWNlLjxicj4NCiZndDsg
Jmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKyAqPGJyPg0KJmd0OyAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArICogVGhpcyBpcyBuZWVkZWQgYmVjYXVzZSB0
aGUgQVZSIGhhcyBzZXBhcmF0ZSBjb2RlPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqBhbmQgZGF0YSBhZGRyZXNzPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqAgwqArICogc3BhY2VzIHRoYXQgYm90aCBoYXZlIHN0YXJ0IGZyb20g
emVybyBidXQgaGF2ZTxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgdG8gZ28gc29tZXdoZXJlIGluPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqArICogaG9zdCBtZW1vcnkuPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgwqArICo8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCsgKiBJdCYjMzk7cyBhbHNvIHVzZWZ1bCB0byBrbm93IHdoZXJlIHNvbWUgdGhp
bmdzIGFyZSw8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoGxp
a2UgdGhlIElPIHJlZ2lzdGVycy48YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCsgKi88YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCsvKiBGbGFzaCBwcm9ncmFtIG1lbW9yeSAqLzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgKyNkZWZpbmUgT0ZGU0VUX0NPREUgMHgwMDAwMDAwMDxicj4N
CiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgKy8qIENQVSByZWdpc3Rl
cnMsIElPIHJlZ2lzdGVycywgYW5kIFNSQU0gKi88YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCsjZGVmaW5lIE9GRlNFVF9EQVRBIDB4MDA4MDAwMDA8YnI+DQom
Z3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsvKiBDUFUgcmVnaXN0ZXJz
IHNwZWNpZmljYWxseSwgdGhlc2UgYXJlIG1hcHBlZCBhdDxicj4NCiZndDsgJmd0O8KgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgdGhlIHN0YXJ0IG9mIGRhdGEgKi88YnI+DQomZ3Q7ICZn
dDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCsjZGVmaW5lIE9GRlNFVF9DUFVfUkVH
SVNURVJTIE9GRlNFVF9EQVRBPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqArLyo8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDC
oCsgKiBJTyByZWdpc3RlcnMsIGluY2x1ZGluZyBzdGF0dXMgcmVnaXN0ZXIsIHN0YWNrPGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqBwb2ludGVyLCBhbmQgbWVt
b3J5PGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArICogbWFw
cGVkIHBlcmlwaGVyYWxzLCBtYXBwZWQganVzdCBhZnRlciBDUFUgcmVnaXN0ZXJzPGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArICovPGJyPg0KJmd0OyAmZ3Q7
wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqArI2RlZmluZSBPRkZTRVRfSU9fUkVHSVNU
RVJTIChPRkZTRVRfREFUQSArPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBOVU1CRVJfT0ZfQ1BVX1JFR0lTVEVSUyk8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCsjZGVmaW5lIEVGX0FWUl9NQUNIIDB4N0Y8YnI+DQomZ3Q7ICZndDvCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCs8YnI+DQomZ3Q7ICZndDvCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCsjZW5kaWYgLyogIWRlZmluZWQgKFFFTVVfQVZSX0NQVV9IKSAq
Lzxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgLS0gPGJyPg0K
Jmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAyLjcuNDxicj4NCiZndDsg
Jmd0OyA8YnI+DQomZ3Q7ICZndDsgPGJyPg0KJmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0O8KgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgLS0gPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqBCZXN0IFJlZ2FyZHMsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqBNaWNoYWVsIFJvbG5pazxicj4NCiZndDsgJmd0OyA8YnI+DQomZ3Q7ICZndDsgPGJyPg0K
Jmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0O8KgIMKgIMKgIMKgIMKgIMKgIMKgLS0gPGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqAgwqAgwqAgwqAgwqBCZXN0IFJlZ2FyZHMsPGJyPg0KJmd0OyAmZ3Q7wqAg
wqAgwqAgwqAgwqAgwqAgwqBNaWNoYWVsIFJvbG5pazxicj4NCiZndDsgJmd0OyA8YnI+DQomZ3Q7
ICZndDsgPGJyPg0KJmd0OyAmZ3Q7IDxicj4NCiZndDsgJmd0O8KgIMKgIMKgLS0gPGJyPg0KJmd0
OyAmZ3Q7wqAgwqAgwqBCZXN0IFJlZ2FyZHMsPGJyPg0KJmd0OyAmZ3Q7wqAgwqAgwqBNaWNoYWVs
IFJvbG5pazxicj4NCiZndDsgJmd0OyA8YnI+DQomZ3Q7PGJyPg0KPC9wPg0K
--0000000000009b2d40059d448859--

