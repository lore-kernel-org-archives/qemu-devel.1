Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D154C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:40:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 35696216F4
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 13:40:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NMiahQ4z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 35696216F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49204 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaK1X-00084G-Ci
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 08:39:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58829)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iaJwd-0006Qz-04
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:34:59 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iaJwT-0008M9-Sn
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:34:47 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:51269
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iaJwT-00088J-O5
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 08:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574948082;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZO2Dw0t0zi6SR0zd4mQbyvg5i/DVs5RZ2pJJpC9k7+k=;
 b=NMiahQ4zjSFpylcRsqGILrU0H5u/hrXab75Kgoa1yOon6oIeVMjZ9REdqYg90AOoe7ud0J
 ppXN45GhfDrb7AA/RGLZr7sEOb4lB1E9NJkZHhDqLr2nWTQ0FFctOaG9uZa5qrJqWnfwr8
 86DbOMwDI8Sl1LOvRsFExMqD9NFx7bk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-41-aaf6jUEmOr2EEZtL_icT6A-1; Thu, 28 Nov 2019 08:34:39 -0500
Received: by mail-wm1-f72.google.com with SMTP id f21so3574589wmh.5
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 05:34:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=MMzy69vbetwU0OWXEWvUv3k1KDU59ff61C1hMDD74+M=;
 b=kQjKSS8sRBwyKdPgS7S1HCTB5sTzs8J6ChNfjkAdkNrHc29SvxpzliZQnBsPHDQP0Z
 2pvWwAEcW/7+yzCfVCbTeo29k45HqSNkG/FeaNg3GNwcj+eITzZncn2x59/rl3nKLJ60
 pqaES76gEK1rc9qUr5g9Qj9NjsKt6hS9nxn/dYBnn5DhOYIOxkC6nUgmYw6xrnJLoHso
 e3SnD+e2DylKjJk0BKWCRvrQeTWhndlmZNtnnr/Mq+11FrAXTl62Cjsq+/fyYJIY38eg
 xjcr/p24H90TIJDozwQnU/EQbCPNpO4EN1cza5f5V9yZZQ0CeVXABguwy16cqbD6u0JQ
 CXeQ==
X-Gm-Message-State: APjAAAXyN88qww3lwpu2dYlbUH4ud8vXjqMoeGTe0TUWdtGVgyyXntAE
 TQZ8vluL1fPddGKskziniergN6rb5n0439mZ7jJOlt+a+/YGothiMaA1FN3EavYtatYV24Cj0bu
 wXaxTeYIq5T6tuNA=
X-Received: by 2002:a7b:cf0e:: with SMTP id l14mr9060214wmg.23.1574948078350; 
 Thu, 28 Nov 2019 05:34:38 -0800 (PST)
X-Google-Smtp-Source: APXvYqyaUPYO49izGx0HEtw+d670oADlEs67m8IyR0z5isR+bHa5d9i8CU1plhoXJuvVzdYv9Cr+wQ==
X-Received: by 2002:a7b:cf0e:: with SMTP id l14mr9060181wmg.23.1574948078039; 
 Thu, 28 Nov 2019 05:34:38 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id x8sm23179720wrm.7.2019.11.28.05.34.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2019 05:34:37 -0800 (PST)
Subject: Re: [PATCH v37 00/17] QEMU AVR 8 bit cores
To: Michael Rolnik <mrolnik@gmail.com>,
 Aleksandar Markovic <aleksandar.m.mail@gmail.com>
References: <20191127175257.23480-1-mrolnik@gmail.com>
 <CAL1e-=isp_-zF71STK-v5D8r5sGYiZbRFmSzjfQtR2FC5YknHQ@mail.gmail.com>
 <CAK4993iniaLhSYCe9hfuNpujpEdqPtZqqsJirBwYG9HqUVx6dA@mail.gmail.com>
 <CAL1e-=h+ZHM9qOOMj2KASuN2J4rSYcn1KP1hOzTWp+EpBY3=5A@mail.gmail.com>
 <CAK4993jDe+c7XsNn=fBwMu6TLuF8KgxNvUziXkwAUuOVArjrsA@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <5a784557-f322-dc3a-4ff1-a7d9a0409448@redhat.com>
Date: Thu, 28 Nov 2019 14:34:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAK4993jDe+c7XsNn=fBwMu6TLuF8KgxNvUziXkwAUuOVArjrsA@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: aaf6jUEmOr2EEZtL_icT6A-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 207.211.31.81
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
Cc: Thomas Huth <thuth@redhat.com>, Joaquin de Andres <me@xcancerberox.com.ar>,
 Richard Henderson <richard.henderson@linaro.org>,
 Sarah Harris <S.E.Harris@kent.ac.uk>, QEMU Developers <qemu-devel@nongnu.org>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/28/19 2:25 PM, Michael Rolnik wrote:
> I don't see why you say that the peripherals are inside the chip, there=
=20
> is CPU within target/avr directory and then there are some=20
> peripherals=C2=A0in hw directory, CPU does not depend on them. what am I =
missing?
>=20
> On Thu, Nov 28, 2019 at 3:22 PM Aleksandar Markovic=20
> <aleksandar.m.mail@gmail.com <mailto:aleksandar.m.mail@gmail.com>> wrote:
>=20
>=20
>=20
>     On Thursday, November 28, 2019, Michael Rolnik <mrolnik@gmail.com
>     <mailto:mrolnik@gmail.com>> wrote:
>=20
>=20
>=20
>         On Wed, Nov 27, 2019 at 11:06 PM Aleksandar Markovic
>         <aleksandar.m.mail@gmail.com
>         <mailto:aleksandar.m.mail@gmail.com>> wrote:
>=20
>             On Wed, Nov 27, 2019 at 6:53 PM Michael Rolnik
>             <mrolnik@gmail.com <mailto:mrolnik@gmail.com>> wrote:
>              >
>              > This series of patches adds 8bit AVR cores to QEMU.
>              > All instruction, except BREAK/DES/SPM/SPMX, are
>             implemented. Not fully tested yet.
>              > However I was able to execute simple code with functions.
>             e.g fibonacci calculation.
>              > This series of patches include a non real, sample board.
>              > No fuses support yet. PC is set to 0 at reset.
>              >
>=20
>             I have a couple of general remarks, so I am responding to
>             the cover
>             letter, not individual patches.
>=20
>             1) The licenses for Sarah devices differ than the rest -
>             shouldn't all
>             licenses be harmonized?
>=20
>         Sarah,
>         do you mind if use the same license I use for my code?
>=20
>=20
>             2) There is an architectural problem with peripherals. It is
>             possible
>             that they evolve over time, so, for example, USART could not
>             be the
>             same for older and newer CPUs (in principle, newer peripheral=
 is
>             expected to be o sort of "superset" of the older). How do
>             you solve
>             that problem? Right now, it may not looks serious to you,
>             but if you
>             don;t think about that right now, from the outset, soon the
>             code will
>             become so entangled, ti woudl be almost very difficult to
>             fix it.
>             Please think about that, how would you solve it, is there a
>             way to
>             pass the information on the currently emulated CPU to the cod=
e
>             covering a peripheral, and provide a different behaviour?
>=20
>         Hi Aleksandar,
>=20
>         Please explain.
>=20
>=20
>     My concern is about peripherals inside the chip, together with the co=
re.
>=20
>     If one models, let's say an external (in the sense, it is a separate
>     chip) ADC (analog-to-digital converter), one looks at specs,
>     implement what is resonable possible in QEMU, plug it in in one of
>     machines thst contains it, and that's it. That ADC remains the same,
>     of course, whatever the surrounding system is.
>=20
>     In AVR case, I think we have a phenomenon likes of which we didn't
>     see before (at least I don't know about). Number of AVR
>     microcontrollers is very large, and both cores and peripherals evolve=
d.
>=20
>     For cores, you handle differences with all these AVR_FEATURE macros,
>     and this seems to be working, no significant objection from my side,
>     and btw that was not an easy task to execute, all admiration from me.
>=20
>     But what about peripherals inside the chip? A peripheral with the
>     same name and the same general area of functionality may be
>     differently specified for microcontrollers from 2010 and 2018. By
>     the difference I don't mean starting address, but the difference in
>     behavior. I don't have time right now to spell many examples, but I
>     read three different specs, and there are differences in USART
>     specifications.
>=20
>     I am not clear what is your envisioned solution for these cases.
>     Would you such close, but not the same, flabors of a peripheral
>     treat as if they are two completely separate cases of a peripheral?
>     Or would you have a single peripheral that would somehow configure
>     itself depending on the core it is attached to?
>=20
>     I hope I was clearer this time.
>=20
>     Aleksandar
>=20
>=20
>=20
>=20
>         I don't see any problem from CPU's perspective.
>         as for the sample board is just a sample, I hope other people
>         will create real models or real hw.
>         there was no way I could provide a CPU alone, that's why there
>         is sample.

If I understand Aleksandar correctly, the naming is incorrect because=20
too generic to AVR family, why Sarah only modeled the Atmel implementation.

Renaming devices such hw/char/avr_usart.c -> hw/char/atmel_usart.c=20
(similarly with the macros) would be enough Aleksandar?


