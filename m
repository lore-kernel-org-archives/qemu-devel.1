Return-Path: <SRS0=4+Bn=ZB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,HTML_MESSAGE,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09AD5C17444
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 23:56:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C968120838
	for <qemu-devel@archiver.kernel.org>; Sat,  9 Nov 2019 23:56:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hKUCJaSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C968120838
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iTaaN-0001CP-VI
	for qemu-devel@archiver.kernel.org; Sat, 09 Nov 2019 18:56:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:40670)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iTaZg-0000jG-9V
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 18:55:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <aleksandar.m.mail@gmail.com>) id 1iTaZe-00011n-4W
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 18:55:24 -0500
Received: from mail-oi1-x243.google.com ([2607:f8b0:4864:20::243]:44604)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <aleksandar.m.mail@gmail.com>)
 id 1iTaZZ-0000zk-GS
 for qemu-devel@nongnu.org; Sat, 09 Nov 2019 18:55:18 -0500
Received: by mail-oi1-x243.google.com with SMTP id s71so8479554oih.11
 for <qemu-devel@nongnu.org>; Sat, 09 Nov 2019 15:55:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:in-reply-to:references:from:date:message-id:subject:to
 :cc; bh=5+cflgW1VDrD0Rt9R91ijKfANIrSRCpwf/OjAPqfni4=;
 b=hKUCJaSBs8hPkttnbmA4pku3s/vH8puTVdi2lw+xvlvuuoSVva8yPpEK9A7SW78tum
 4mtJbkQJBUe333Ki1/vBbj/99a5m9nHqTrQThUuA+HHnLBmmC993WDCTOPGgW0B+7FRl
 b4K6mz5KoaQ2LC4kaq+TNfwuCJlt40SGrT/MW9iHwN7TI5/qqzBuPUsltpZ1ZrLwnw9s
 66w634ZM9jdUITiyyCWh/ukkTUU/owVS39nZsGlimQRZjBkdsQcgFwogHlgr/rDnx5bM
 8OFNcMCe27Fst78goypW6Gz1++s/z3Qik33aJ1N2LhaGnSIH3Ze7G8Qb1uNKBaGLWOdc
 2Vwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:in-reply-to:references:from:date
 :message-id:subject:to:cc;
 bh=5+cflgW1VDrD0Rt9R91ijKfANIrSRCpwf/OjAPqfni4=;
 b=cpHl362Q7x3OIKSnGjJOa7t6/JTS8zg0IRZm4ZzQuKwJQZyo8OfQ5o7h9l9z6XHwK9
 tS9KJRHYQMcxK7GdfODBXrnnlrNK5Jdtt30vLhcH3Z/lt7GYoAChSIlgTg9moC9X4Qwj
 BqW2kZFFWtkRXYREye6rMKZSIhuXGIyfqi1WBRLJ4s/8sYA0yUbfeBBUgxt6YODqFzsF
 WQuSF7dL7qb17fTMI2ZKgdsfiw/Zjom95z9USCYu8j5b7pMleuGipVAKeEdGJ4h3SVuC
 x6NUgM4X16mwSLuPxRS0Gqe0aOk6NHu8ENoSqdZDEu+JkC8fvIbVDSkdCY8QuiogdQuZ
 GBGg==
X-Gm-Message-State: APjAAAUttf1S38rm9qoj1Z6lFPUK2ea21y0257LPFC0GtYuO/f4RFJ8N
 KdYgp0+JobdxaALXkqWnd/thfSGxMQ5p9EUCerk=
X-Google-Smtp-Source: APXvYqzB9k+6cXKIfUbfrBdcGC9MZrLMPr8hK8l+TA8Cxaol7emoUA5mZfmLLRJDqtI+kdx3vC/6ng46MzNh6nmDYX8=
X-Received: by 2002:aca:5786:: with SMTP id l128mr3800789oib.53.1573343715581; 
 Sat, 09 Nov 2019 15:55:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a9d:5e89:0:0:0:0:0 with HTTP;
 Sat, 9 Nov 2019 15:55:15 -0800 (PST)
In-Reply-To: <1ec3ea6a-6a75-15eb-086c-d8f5e33bc0dc@cs.utexas.edu>
References: <f5a16b3c-2c17-60e4-e80b-dd20b3c088cc@cs.utexas.edu>
 <CAL1e-=g8c=QJiMm1AvBCNmsTyVWoUAjL0na2HWodHCQPiLdWJw@mail.gmail.com>
 <CAL1e-=j8K+FKj=4pTd8HKkL-D=F+9hY+5bF4ibM8WE+Sp+pk=Q@mail.gmail.com>
 <f300806f-ced2-5926-40ff-4cdd29c5078e@cs.utexas.edu>
 <CAL1e-=hNH6HaKsczgkUdgbt18E2V2Cm6oPhSQewvMKvVTnarbA@mail.gmail.com>
 <1ec3ea6a-6a75-15eb-086c-d8f5e33bc0dc@cs.utexas.edu>
From: Aleksandar Markovic <aleksandar.m.mail@gmail.com>
Date: Sun, 10 Nov 2019 00:55:15 +0100
Message-ID: <CAL1e-=hR6KGRzZ+tz0YnvT2fy1TJ1eP-HHAPAcxBCLQWEgoVGw@mail.gmail.com>
Subject: Looking for issues/features for my first contribution
To: Rajath Shashidhara <rajaths@cs.utexas.edu>
Content-Type: multipart/alternative; boundary="00000000000046e4690596f2a16b"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::243
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
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

--00000000000046e4690596f2a16b
Content-Type: text/plain; charset="UTF-8"

On Saturday, November 9, 2019, Rajath Shashidhara <rajaths@cs.utexas.edu>
wrote:

>
>
> On 11/9/19 1:46 PM, Aleksandar Markovic wrote:
>
> >
> >
> > Hi, Rajath.
> >
> > No, it doesn't. Linux kernel has a driver for DS3231. Take a closer look.
>
> Kernel driver found here:
> https://elixir.bootlin.com/linux/v5.4-rc6/source/drivers/rtc/rtc-ds3232.c
> did register NVMEM of 236 bytes with the kernel. As long as this NVMEM
> is never accessed, the same driver should work for both DS3231 and DS3232.
>
> Is there any other driver you are referring to ? Please let me know if I
> missed something here.
>
>
The official DS3231 driver is (hidden) in:

https://elixir.bootlin.com/linux/v5.4-rc6/source/drivers/rtc/rtc-ds1307.c

This driver actually supports around 15 RTC chips, and DS3231 among them.
It contains fairly sophisticated "feature control" that enables it to
support multiple RTC chips.



> >
> > But, in any case, you base your QEMU emulation on the *datasheet*.
> >
> > The OS drivers may be helpful, but they are not a reference you base
> > your solution on. The drivers may be obsolete, incorrect, incomplete, or
> > just plain wrong. Additionally, as QEMU, of course, supports emulation
> > of systems running variety of OSs, the existence of the Linux kernel
> > driver is not a necessary condition for QEMU implementation. QEMU
> > emulates many systems that Linux never ran on, and could not be run at
> all.
> >
>
> I was only looking at the Kernel drivers to setup a test framework. I
> plan to test my implementation using a Raspi emulation with qemu,
> configure it with a DS3231 device. After this, I should be able to use
> ioctl() on /dev/rtc to test the functionality:
> https://linux.die.net/man/4/rtc
>
> If you have a better approach to testing, do let me know.
>
>
Your method sounds good to me. Hopefully it won't be too difficult to you
to execute it.

Best wishes,
Aleksandar


> Thanks,
> Rajath Shashidhara
>

--00000000000046e4690596f2a16b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<br><br>On Saturday, November 9, 2019, Rajath Shashidhara &lt;<a href=3D"ma=
ilto:rajaths@cs.utexas.edu" target=3D"_blank">rajaths@cs.utexas.edu</a>&gt;=
 wrote:<br><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;bor=
der-left:1px #ccc solid;padding-left:1ex"><br>
<br>
On 11/9/19 1:46 PM, Aleksandar Markovic wrote:<br>
<br>
&gt; <br>
&gt; <br>
&gt; Hi, Rajath.<br>
&gt; <br>
&gt; No, it doesn&#39;t. Linux kernel has a driver for DS3231. Take a close=
r look.<br>
<br>
Kernel driver found here:<br>
<a href=3D"https://elixir.bootlin.com/linux/v5.4-rc6/source/drivers/rtc/rtc=
-ds3232.c" target=3D"_blank">https://elixir.bootlin.com/lin<wbr>ux/v5.4-rc6=
/source/drivers/rtc<wbr>/rtc-ds3232.c</a><br>
did register NVMEM of 236 bytes with the kernel. As long as this NVMEM<br>
is never accessed, the same driver should work for both DS3231 and DS3232.<=
br>
<br>
Is there any other driver you are referring to ? Please let me know if I<br=
>
missed something here.<br>
<br></blockquote><div><br></div><div>The official DS3231 driver is (hidden)=
 in:</div><div><br></div><div><a href=3D"https://elixir.bootlin.com/linux/v=
5.4-rc6/source/drivers/rtc/rtc-ds1307.c" target=3D"_blank">https://elixir.b=
ootlin.com/<wbr>linux/v5.4-rc6/source/drivers/<wbr>rtc/rtc-ds1307.c</a><br>=
</div><div><br></div><div>This driver actually supports around 15 RTC chips=
, and DS3231 among them. It contains fairly sophisticated &quot;feature con=
trol&quot; that enables it to support multiple RTC chips.</div><div><br></d=
iv><div>=C2=A0</div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0=
 .8ex;border-left:1px #ccc solid;padding-left:1ex">
&gt; <br>
&gt; But, in any case, you base your QEMU emulation on the *datasheet*.<br>
&gt; <br>
&gt; The OS drivers may be helpful, but they are not a reference you base<b=
r>
&gt; your solution on. The drivers may be obsolete, incorrect, incomplete, =
or<br>
&gt; just plain wrong. Additionally, as QEMU, of course, supports emulation=
<br>
&gt; of systems running variety of OSs, the existence of the Linux kernel<b=
r>
&gt; driver is not a necessary condition for QEMU implementation. QEMU<br>
&gt; emulates many systems that Linux never ran on, and could not be run at=
 all.<br>
&gt; <br>
<br>
I was only looking at the Kernel drivers to setup a test framework. I<br>
plan to test my implementation using a Raspi emulation with qemu,<br>
configure it with a DS3231 device. After this, I should be able to use<br>
ioctl() on /dev/rtc to test the functionality:<br>
<a href=3D"https://linux.die.net/man/4/rtc" target=3D"_blank">https://linux=
.die.net/man/4/rt<wbr>c</a><br>
<br>
If you have a better approach to testing, do let me know.<br>
<br></blockquote><div><br></div><div>Your method sounds good to me. Hopeful=
ly it won&#39;t be too difficult to you to execute it.</div><div><br></div>=
<div>Best wishes,</div><div>Aleksandar</div><div>=C2=A0</div><blockquote cl=
ass=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-left:1px #ccc solid;p=
adding-left:1ex">
Thanks,<br>
Rajath Shashidhara<br>
</blockquote>

--00000000000046e4690596f2a16b--

