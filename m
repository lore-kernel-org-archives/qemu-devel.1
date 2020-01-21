Return-Path: <SRS0=2jXw=3K=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A01C2D0CE
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 21:24:31 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 78345217F4
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jan 2020 21:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 78345217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:32884 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iu10g-00033y-LJ
	for qemu-devel@archiver.kernel.org; Tue, 21 Jan 2020 16:24:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:46802)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iu106-0002ee-VW
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:23:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iu105-0000BM-El
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:23:54 -0500
Received: from mail-yw1-f66.google.com ([209.85.161.66]:45491)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iu105-0000BB-AY
 for qemu-devel@nongnu.org; Tue, 21 Jan 2020 16:23:53 -0500
Received: by mail-yw1-f66.google.com with SMTP id d7so2156024ywl.12
 for <qemu-devel@nongnu.org>; Tue, 21 Jan 2020 13:23:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=xPCbvhJcxvA9aZpx2BH9+9O2MDqrAjr5JjYepQ5Toes=;
 b=ao9MSTckV+qZepTIP2bbeNV2vZTv5yl1GHYrHcPhXGwrCZDKhi2EDb6A1tFZ1fmVzT
 G7To20QMu5WAnM09GNAX9gm7fD4tKDs5eqVwQin3igqHe9MvijUIjXYLSNdMjh8aue0h
 WXEdxklB+YPZ7sWDnBM7a8QjZivmSjy3DnZEGMyTIdvfp5me8WM9qfJ6r+NYCFutsj5+
 mcbCqI9ZNxzCJmH22PtO4CIPozrbEu3yCFd+1tLkttThkgcpCNwhDvTjKAhILhsj5IxE
 gTAukg+0OuLgfnCRGlHep99feRKQXNZKxWQ6anFimORgdP9YztgQDr5okPwr14AYOBVv
 VSdA==
X-Gm-Message-State: APjAAAVy704RZFITJfhwok2wgJEA9L7Rmm5Xu3+ldVJdSnNSu5eY9Z3h
 6K9gUhKI3Fi/33TU84Lm0ZJ1BmQfG+3Dyhm0/n0=
X-Google-Smtp-Source: APXvYqx5fLswqjgm3ZsKbvZpze7w6VhIkjvSkd/dRoKxAg/mnRTRp1pEjVvHbdFKOVr6AEvt8YjATzxW/p2KqxWsfJo=
X-Received: by 2002:a81:69c5:: with SMTP id e188mr4836186ywc.443.1579641832515; 
 Tue, 21 Jan 2020 13:23:52 -0800 (PST)
MIME-Version: 1.0
References: <20200120220107.17825-1-f4bug@amsat.org>
 <CAK4993jBdx4WniPqLs2YLUnv5rXhGL2SC9bjbjeVmO5bvkRgoQ@mail.gmail.com>
In-Reply-To: <CAK4993jBdx4WniPqLs2YLUnv5rXhGL2SC9bjbjeVmO5bvkRgoQ@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 21 Jan 2020 22:23:40 +0100
Message-ID: <CAAdtpL5FdzYga1sA+nsN4+JP2QMO5NMRDtdcJ0v1prHgjxZ+QQ@mail.gmail.com>
Subject: Re: [PATCH v4 00/18] hw/avr: Introduce few Arduino boards
To: Michael Rolnik <mrolnik@gmail.com>,
 Peter Maydell <peter.maydell@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.66
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
 QEMU Developers <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jan 21, 2020 at 8:26 PM Michael Rolnik <mrolnik@gmail.com> wrote:
>
> Hi Philippe.
>
> 1. I cannot access https://gitlab.com/philmd/qemu/commits/arduino-v4

Oops I pushed to GitHub instead =3D) Now it is on GitLab too.

> 2. I merged your series into my workspace using patchwork
> 3. I payed attention that that you don't use automatic CPU detection (as =
suggested by Aleksandar) by reading elf.

I see, I based my work on your v38, and missed the later changes:

changes since v38
-  fix elf loader function bug introduced by prev version

And probably:

changes since v39
-  add frequency parameter to AVR timer

I'll look at Aleksandar suggestion and your last your changes, and update.

> 4. There is difference between -bios and -kernel (arduino boars crash whe=
n -bios is used, but this seems because I run avr6 on avr5 CPU). I would be=
 happy if you explained what is the difference between these two arguments.

qemu man page is not very helpful...

       -bios file
           Set the filename for the BIOS.

       -kernel bzImage
           Use bzImage as kernel image. The kernel can be either a
Linux kernel or in multiboot format.

Paolo, Peter, do you have a simple explanation?

> 5. make check-acceptance pass correctly
> 6. make check-qtest-avr pass correctly
>
>
> On Tue, Jan 21, 2020 at 12:01 AM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat=
.org> wrote:
>>
>> Hi,
>>
>> This series add the arduino boards, aiming at removing the
>> 'sample' board that doesn't follow any specification.
>>
>> Since v3:
>> - Rebased on Michael's v41
>> - Drop 'extram' unused field (Igor)
>> - Renamed devices AVR -> Atmel (Aleksandar)
>>   (I haven't renamed structure names to ease review)
>>
>> Since v2:
>> - rebased on Michael's v40
>>
>> Since v1:
>> - Addressed Igor comments
>> - Addressed Aleksandar comments
>> - Fixed UART issue (was due to IRQ shifted by 2 in CPU)
>>
>> Since Michael's work is not yet merged, Various of my patches
>> - which are trivials or simple renames - could be squashed
>> directly on his patches, if we ever care.
>> [I believe sending this patches is easier/quicker than keeping
>> asking Michael to respin his series infinitely].
>>
>> Michael, do you mind testing it? The full series is available
>> here: https://gitlab.com/philmd/qemu/commits/arduino-v4
>>
>> Regards,
>>
>> Phil.
>>
>> Obsoletes: <20191229224505.24466-1-f4bug@amsat.org>
>> Based-on: <20200118191416.19934-1-mrolnik@gmail.com>
>> https://www.mail-archive.com/qemu-devel@nongnu.org/msg671707.html
>>
>> Philippe Mathieu-Daud=C3=A9 (18):
>>   MAINTAINERS: Move machine test to the machine section (not ARCH one)
>>   MAINTAINERS: Move the AVR machines in new section (not within ARM)
>>   tests/acceptance: Do not set the machine type manually
>>   tests/acceptance: Keep multilines comment consistent with other tests
>>   hw/char/avr: Reduce USART I/O size
>>   hw/timer/avr_timer16: Rename memory region debugging name
>>   hw/misc/avr_mask: Remove unused include
>>   hw/avr/Makefile: Use CONFIG_AVR_SAMPLE variable
>>   hw/char: Rename avr_usart -> atmel_usart
>>   hw/timer: Rename avr_timer16 -> atmel_timer16
>>   hw/misc: Rename avr_mask -> atmel_power
>>   hw/avr: Introduce ATMEL_ATMEGA_MCU config
>>   hw/avr: Add some ATmega microcontrollers
>>   hw/avr: Add some Arduino boards
>>   tests/boot-serial-test: Test some Arduino boards (AVR based)
>>   tests/acceptance: Test the Arduino MEGA2560 board
>>   hw/avr: Remove the unrealistic AVR 'sample' board
>>   .travis.yml: Run the AVR acceptance tests
>>
>>  default-configs/avr-softmmu.mak               |   2 +-
>>  hw/avr/atmel_atmega.h                         |  48 ++
>>  .../hw/char/{avr_usart.h =3D> atmel_usart.h}    |  10 +-
>>  include/hw/misc/{avr_mask.h =3D> atmel_power.h} |  11 +-
>>  .../timer/{avr_timer16.h =3D> atmel_timer16.h}  |  10 +-
>>  hw/avr/arduino.c                              | 175 +++++++
>>  hw/avr/atmel_atmega.c                         | 464 ++++++++++++++++++
>>  hw/avr/sample.c                               | 295 -----------
>>  hw/char/{avr_usart.c =3D> atmel_usart.c}        |   6 +-
>>  hw/misc/{avr_mask.c =3D> atmel_power.c}         |   4 +-
>>  hw/timer/{avr_timer16.c =3D> atmel_timer16.c}   |  10 +-
>>  tests/qtest/boot-serial-test.c                |   3 +-
>>  .travis.yml                                   |   2 +-
>>  MAINTAINERS                                   |  29 +-
>>  hw/avr/Kconfig                                |  11 +-
>>  hw/avr/Makefile.objs                          |   3 +-
>>  hw/char/Kconfig                               |   2 +-
>>  hw/char/Makefile.objs                         |   2 +-
>>  hw/misc/Kconfig                               |   2 +-
>>  hw/misc/Makefile.objs                         |   2 +-
>>  hw/timer/Kconfig                              |   2 +-
>>  hw/timer/Makefile.objs                        |   2 +-
>>  tests/acceptance/machine_avr6.py              |  11 +-
>>  23 files changed, 751 insertions(+), 355 deletions(-)
>>  create mode 100644 hw/avr/atmel_atmega.h
>>  rename include/hw/char/{avr_usart.h =3D> atmel_usart.h} (93%)
>>  rename include/hw/misc/{avr_mask.h =3D> atmel_power.h} (89%)
>>  rename include/hw/timer/{avr_timer16.h =3D> atmel_timer16.h} (92%)
>>  create mode 100644 hw/avr/arduino.c
>>  create mode 100644 hw/avr/atmel_atmega.c
>>  delete mode 100644 hw/avr/sample.c
>>  rename hw/char/{avr_usart.c =3D> atmel_usart.c} (99%)
>>  rename hw/misc/{avr_mask.c =3D> atmel_power.c} (97%)
>>  rename hw/timer/{avr_timer16.c =3D> atmel_timer16.c} (98%)
>>
>> --
>> 2.21.1
>>
>
>
> --
> Best Regards,
> Michael Rolnik

