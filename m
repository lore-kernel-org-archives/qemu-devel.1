Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 510A1C76190
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:51:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 15AF821901
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 14:51:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 15AF821901
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kent.ac.uk
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40794 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr1Z3-0004Tz-QT
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 10:51:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56902)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <S.E.Harris@kent.ac.uk>) id 1hr1Yg-0003hE-7g
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:50:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <S.E.Harris@kent.ac.uk>) id 1hr1Yc-0007uZ-Fx
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:50:58 -0400
Received: from mx0.kent.ac.uk ([129.12.21.32]:58393)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <S.E.Harris@kent.ac.uk>)
 id 1hr1Ya-0007ps-C7
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 10:50:54 -0400
Received: from edueda7.kent.ac.uk ([129.12.237.167] helo=cadance)
 by mx0.kent.ac.uk with esmtpsa (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256)
 (Exim 4.92) (envelope-from <S.E.Harris@kent.ac.uk>)
 id 1hr1YV-000MNY-CP; Fri, 26 Jul 2019 15:50:47 +0100
Date: Fri, 26 Jul 2019 15:53:02 +0100
From: Sarah Harris <S.E.Harris@kent.ac.uk>
To: Michael Rolnik <mrolnik@gmail.com>
Message-Id: <20190726155302.acca1173b146bb7e7f471fdc@kent.ac.uk>
In-Reply-To: <CAK4993g3sX5QEq-qXg_1s9+us3pBW5RDYFnLLiJe7=2OUxpjtQ@mail.gmail.com>
References: <20190719082647.18113-1-mrolnik@gmail.com>
 <20190719082647.18113-6-mrolnik@gmail.com>
 <000c01d542cf$d8476a00$88d63e00$@ru>
 <CAK4993g3sX5QEq-qXg_1s9+us3pBW5RDYFnLLiJe7=2OUxpjtQ@mail.gmail.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.32; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 129.12.21.32
Subject: Re: [Qemu-devel] [PATCH v27 5/8] target/avr: Add limited support
 for USART and 16 bit timer peripherals
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
Cc: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@redhat.com>,
 Sarah Harris <S.E.Harris@kent.ac.uk>,
 Richard Henderson <richard.henderson@linaro.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Michael and Pavel,

The USART was based on the ATMega2560.
It was designed for testing so its functionality is somewhat limited.

Peripherals seem to vary between AVR chips so the configuration in the 2560 may not match other chips, especially the older ones.
From memory, the only shared registers in the 2560 USART are the PRR's, which we implemented by adding single byte memory regions during board initialisation (so that the memory region wasn't part of any one device).
I expect there are cleaner ways to do it.

Kind regards,
Sarah Harris

On Thu, 25 Jul 2019 20:52:33 +0300
Michael Rolnik <mrolnik@gmail.com> wrote:

> Hi Pavel.
> 
> Please see my answers below.
> 
> On Thu, Jul 25, 2019 at 1:00 PM Pavel Dovgalyuk <dovgaluk@ispras.ru> wrote:
> 
> > > From: Qemu-devel [mailto:qemu-devel-bounces+patchwork-qemu-
> > > devel=patchwork.kernel.org@nongnu.org] On Behalf Of Michael Rolnik
> > > From: Sarah Harris <S.E.Harris@kent.ac.uk>
> > >
> > > These were designed to facilitate testing but should provide enough
> > function to be useful in
> > > other contexts.
> >
> > USART is very useful for testing, but to which model of AVR is belongs?
> > We also started implementation of USART and other devices in our
> > internship program,
> > using prior version of your patches.
> > There were other register addresses for the registers and some of them
> > even intersect
> > making read/write logic more complex (we looked at Atmega8).
> >
> 
> This is a question for Sara as she built it. (I think it was ATmega2560)
> 
> 
> >
> > You also mix the board and the SoC into one file, making hardware-on-chip
> > harder to reuse.
> >
> > I think that the structure can be revised in the following way:
> > Board -> SoC -> Devices
> >
> > Board includes SoC, loads the firmware, and adds some external peripheral
> > devices, if needed.
> >
> > SoC includes embedded peripherals. It dispatches IO memory accesses and
> > passes them
> > to the devices. In this case you can have different register addresses for
> > different SoCs, but
> > the embedded device emulation code can be mostly the same for simple
> > devices like USART.
> >
> > > Only a subset of the functions of each peripheral is implemented, mainly
> > due to the lack of a
> > > standard way to handle electrical connections (like GPIO pins).
> >
> You are right.
> 
> >
> > We did not got too much results, you can check for our changes here:
> > https://github.com/Dovgalyuk/qemu/tree/avr8
> >
> > But we can help you in development of better version of the patches and
> > split the work
> > for making this platform more usable.
> >
> 
> Gladly.
> You are welcome.
> My initial intent was to provide CPU only and I hoped that others will
> model the devices.
> 
> *Richard, Phil & all,*
> what would be the right mechanism / procedure to split the work?
> 
> 
> >
> > Pavel Dovgalyuk
> >
> >
> 
> -- 
> Best Regards,
> Michael Rolnik

