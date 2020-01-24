Return-Path: <SRS0=z9mi=3N=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 868F2C35240
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:34:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5564B2087E
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2020 00:34:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5564B2087E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=mathieu-daude.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iumvd-00059l-IP
	for qemu-devel@archiver.kernel.org; Thu, 23 Jan 2020 19:34:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:42542)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iumv6-0004az-Qy
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:33:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iumv5-0001Et-CK
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:33:56 -0500
Received: from mail-yw1-f65.google.com ([209.85.161.65]:45473)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1iumv5-0001E1-86
 for qemu-devel@nongnu.org; Thu, 23 Jan 2020 19:33:55 -0500
Received: by mail-yw1-f65.google.com with SMTP id d7so88578ywl.12
 for <qemu-devel@nongnu.org>; Thu, 23 Jan 2020 16:33:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=csq0Pv2vuj6zWeE+MzNl+iUhYBov3J50e/hV4Ln33rg=;
 b=s7YMx0sf+9SIdjIZP1Y02LsVLx3O8NwlJMuLA9XP1k9n+8qi2RupXVf1h76r7QaaC1
 92CWW9UStvBiSC6uR9cAppQvsxOWCd5JQHd0bDr7RTLg+b548U836LniWlxNStZNP3X7
 enGlXPjQY+U4K4sUNQGWMJUKCGrwORb0SY1hIuEI2QmuOjAkRzeXARCgexyhuDUNVVDL
 1wdnEWPGpAjZYcx0keXQh5BuDaAwJojViU/9gyJJNyl0VqlAIWDCnR4D8bvCxwG+iFP1
 0mHNioL05o/uGd/TopMJ3TT4F5WuKxt8ryxDcMV7tRIscxO2QAZGZNs6OGMkbFAqN9on
 gESQ==
X-Gm-Message-State: APjAAAW54C0QxUSg1PceJnZD7LRiwUEMH/yN87fIap/oSBChltR8E7xv
 27L5OgTgqKvKulQNEWVtZpsZE9wVF0jyPsNNwBA=
X-Google-Smtp-Source: APXvYqy1sJFut6z7jxiV+jgR2EJT6X5K31Bm7y20hjSJpLkvqIvOlb1yCHy0NXV4jczACwpkudfKkDh3USVlHFSfbrk=
X-Received: by 2002:a81:3ad0:: with SMTP id h199mr266316ywa.37.1579826034556; 
 Thu, 23 Jan 2020 16:33:54 -0800 (PST)
MIME-Version: 1.0
References: <20200123000307.11541-1-richard.henderson@linaro.org>
 <20200123000307.11541-15-richard.henderson@linaro.org>
 <486b80d9-4f11-0888-7327-d6a72f2bb67c@redhat.com>
In-Reply-To: <486b80d9-4f11-0888-7327-d6a72f2bb67c@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philippe@mathieu-daude.net>
Date: Fri, 24 Jan 2020 01:33:43 +0100
Message-ID: <CAAdtpL7RhVnNEwa7g+oq0oZYGvf+2head6FD6n-YQKO5pUKvhw@mail.gmail.com>
Subject: Re: [PATCH rc1 14/24] target/avr: Add section about AVR into QEMU
 documentation
To: Thomas Huth <thuth@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.161.65
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
 Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Igor Mammedov <imammedo@redhat.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, Jan 23, 2020 at 5:57 AM Thomas Huth <thuth@redhat.com> wrote:
> On 23/01/2020 01.02, Richard Henderson wrote:
> > From: Michael Rolnik <mrolnik@gmail.com>
> >
> > Signed-off-by: Michael Rolnik <mrolnik@gmail.com>
> > Message-Id: <20200118191416.19934-16-mrolnik@gmail.com>
> > Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> > ---
> >  qemu-doc.texi | 51 +++++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 51 insertions(+)
> >
> > diff --git a/qemu-doc.texi b/qemu-doc.texi
> > index 39f950471f..515aacfae9 100644
> > --- a/qemu-doc.texi
> > +++ b/qemu-doc.texi
> > @@ -1741,6 +1741,7 @@ differences are mentioned in the following sectio=
ns.
> >  * Microblaze System emulator::
> >  * SH4 System emulator::
> >  * Xtensa System emulator::
> > +* AVR System emulator::
> >  @end menu
> >
> >  @node PowerPC System emulator
> > @@ -2514,6 +2515,56 @@ so should only be used with trusted guest OS.
> >
> >  @c man end
> >
> > +@node AVR System emulator
> > +@section AVR System emulator
> > +@cindex system emulation (AVR)
> > +
> > +Use the executable @file{qemu-system-avr} to emulates a AVR 8 bit base=
d machine having one for the following cores: avr1, avr2, avr25, avr3, avr3=
1, avr35, avr4, avr5, avr51, avr6, avrtiny, xmega2, xmega3, xmega4, xmega5,=
 xmega6 and xmega7.
> > +
> > +As for now it does not support any real MCUs. However, it does support=
 a "sample" board for educational and testing purposes. This "sample" board=
 hosts USART & 16 bit timer devices and it's enought to run FreeRTOS based =
applicaton (like this @url{https://github.com/seharris/qemu-avr-tests/blob/=
master/free-rtos/Demo/AVR_ATMega2560_GCC/demo.elf,,demo})
>
> The "sample" board has been replaced by the boards that Philippe added,
> hasn't it? In that case, the above sentence should be adjusted accordingl=
y.
>
> > +Following are examples of possible usages, assuming program.elf is com=
piled for AVR cpu
> > +@itemize
> > +
> > +@item Continious non interrupted execution
>
> s/Continious/Continuous/
>
> > +@example
> > +qemu-system-avr -kernel program.elf
> > +@end example
> > +
> > +@item Continious non interrupted execution with serial output into tel=
net window
>
> s/Continious/Continuous/
>
> > +@example
> > +qemu-system-avr -kernel program.elf -serial tcp::5678,server,nowait -n=
ographic
> > +@end example
> > +and then in another shell
> > +@example
> > +telent localhost 5678
>
> s/telent/telnet/
>
> > +@end example
> > +
> > +@item Continious non interrupted execution with serial output into std=
out
>
> s/Continious/Continuous/
>
> > +@example
> > +qemu-system-avr -kernel program.elf -serial stdio
> > +@end example
>
> ... and I'm not sure whether we really need multiple examples for
> "-serial" here ... one should be enough, "-serial" is described
> somewhere else in the documentation already.

-kernel isn't supported anyway...

> > +@item Debugging wit GDB debugger
> > +@example
> > +qemu-system-avr -kernel program.elf -s -S
> > +@end example
> > +and then in another shell
> > +@example
> > +avr-gdb program.elf
> > +@end example
> > +and then within GDB shell
> > +@example
> > +target remote :1234
> > +@end example
> > +
> > +@item Print out executed instructions
> > +@example
> > +qemu-system-avr -kernel program.elf -d in_asm
> > +@end example
> > +
> > +@end itemize
> > +
> >  @node QEMU User space emulator
> >  @chapter QEMU User space emulator
>
>  Thomas
>
>

