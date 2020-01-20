Return-Path: <SRS0=XqMt=3J=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45D67C32771
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:31:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11C092253D
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jan 2020 23:31:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11C092253D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45660 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1itgWI-0001YM-7R
	for qemu-devel@archiver.kernel.org; Mon, 20 Jan 2020 18:31:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgVL-00017U-Gs
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:30:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgVH-0007c4-Fu
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:30:46 -0500
Received: from mail-yb1-f195.google.com ([209.85.219.195]:44555)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1itgVH-0007bs-C4
 for qemu-devel@nongnu.org; Mon, 20 Jan 2020 18:30:43 -0500
Received: by mail-yb1-f195.google.com with SMTP id f136so521336ybg.11
 for <qemu-devel@nongnu.org>; Mon, 20 Jan 2020 15:30:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=T9WPbSUGo0ucWw1vdWmjBcneSahwc874PC26phNlz5E=;
 b=Bw05z8zJtRA/vGTXjewLGg16Y0NeGLB9kO9npoLDdxpvmbRsVaSKA0ARz9NsTN/DFC
 0zehkC8YL9JYGBTWaDY5tMHWPmYd9FdbuEdun3Nl3a3Dc2PbCDccCISCBMSgoogZwy5z
 0+5UIPTSw812xFSK3yslvAKWdBXtNF/V461MlVgmCraywIgwgQMDLnPwd8qqHRvPb4AY
 NVVkljN9KI6DXnvV9BjxPXK1QqL5SE22dnMNcMa+VDu3Aypr8cFWqt8IJfDbl/IAxxyT
 6Xkkxrp7onbG9QOKVTDd0fFYF6xjBnlezC4wLLu3bE3WpZrxPBVvsV8JPjWjl+2tmrTb
 cxhw==
X-Gm-Message-State: APjAAAUN/ND4Ewrq+D/Cfm4wA9CwVa8gSD/jHetydI9sykJqutx3RW/d
 obqc8COqDa4AkLRflIdH9dx34XKIuJx6LvzCTOGn5mgq
X-Google-Smtp-Source: APXvYqxYch6V354sGc1W0R8kPOnS9PG4LVJdwnIyayFNUnbmo5nQ82ZqDUhGCmz127CCGhkVL4iOX6An89xVnchfVFU=
X-Received: by 2002:a25:e696:: with SMTP id d144mr1614964ybh.316.1579563042401; 
 Mon, 20 Jan 2020 15:30:42 -0800 (PST)
MIME-Version: 1.0
References: <20200120220107.17825-1-f4bug@amsat.org>
In-Reply-To: <20200120220107.17825-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Date: Tue, 21 Jan 2020 00:30:31 +0100
Message-ID: <CAAdtpL4sB0gDPUAs-4kgLcwj7ydyziVjvuzLToq30o3cqH9H9Q@mail.gmail.com>
Subject: Re: [PATCH v4 00/18] hw/avr: Introduce few Arduino boards
To: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.219.195
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jan 20, 2020 at 11:01 PM Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.o=
rg> wrote:
>
> Hi,
>
> This series add the arduino boards, aiming at removing the
> 'sample' board that doesn't follow any specification.
>
> Since v3:
> - Rebased on Michael's v41
> - Drop 'extram' unused field (Igor)
> - Renamed devices AVR -> Atmel (Aleksandar)
>   (I haven't renamed structure names to ease review)
>
> Since v2:
> - rebased on Michael's v40
>
> Since v1:
> - Addressed Igor comments
> - Addressed Aleksandar comments
> - Fixed UART issue (was due to IRQ shifted by 2 in CPU)
>
> Since Michael's work is not yet merged, Various of my patches
> - which are trivials or simple renames - could be squashed
> directly on his patches, if we ever care.
> [I believe sending this patches is easier/quicker than keeping
> asking Michael to respin his series infinitely].
>
> Michael, do you mind testing it? The full series is available
> here: https://gitlab.com/philmd/qemu/commits/arduino-v4
>
> Regards,
>
> Phil.
>
> Obsoletes: <20191229224505.24466-1-f4bug@amsat.org>

Argh the correct tag is:
Supersedes: <20191229224505.24466-1-f4bug@amsat.org>

Paolo: will this work? (replying to the cover)

> Based-on: <20200118191416.19934-1-mrolnik@gmail.com>
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg671707.html
>
> Philippe Mathieu-Daud=C3=A9 (18):
>   MAINTAINERS: Move machine test to the machine section (not ARCH one)
>   MAINTAINERS: Move the AVR machines in new section (not within ARM)
>   tests/acceptance: Do not set the machine type manually
>   tests/acceptance: Keep multilines comment consistent with other tests
>   hw/char/avr: Reduce USART I/O size
>   hw/timer/avr_timer16: Rename memory region debugging name
>   hw/misc/avr_mask: Remove unused include
>   hw/avr/Makefile: Use CONFIG_AVR_SAMPLE variable
>   hw/char: Rename avr_usart -> atmel_usart
>   hw/timer: Rename avr_timer16 -> atmel_timer16
>   hw/misc: Rename avr_mask -> atmel_power
>   hw/avr: Introduce ATMEL_ATMEGA_MCU config
>   hw/avr: Add some ATmega microcontrollers
>   hw/avr: Add some Arduino boards
>   tests/boot-serial-test: Test some Arduino boards (AVR based)
>   tests/acceptance: Test the Arduino MEGA2560 board
>   hw/avr: Remove the unrealistic AVR 'sample' board
>   .travis.yml: Run the AVR acceptance tests

