Return-Path: <SRS0=bTwh=ZU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10419C432C0
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 12:04:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CEB6F2176D
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2019 12:04:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="X03JpaMU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CEB6F2176D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iaIWj-0002tw-TS
	for qemu-devel@archiver.kernel.org; Thu, 28 Nov 2019 07:04:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55703)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1iaI65-0006dn-Et
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:36:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1iaI61-00027Y-Pw
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:36:31 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42815
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1iaI61-0001x4-FC
 for qemu-devel@nongnu.org; Thu, 28 Nov 2019 06:36:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1574940987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SBA+Y5IMo3FuK6mTgARuQfkJj5mKM3LT8f4XWzeTp5w=;
 b=X03JpaMU6orunFgj1X/6tnt+7qZT3Z82KyNfRHGhcPf+eYIzkcxxhAgbSyADwiklqLZmv8
 yYtttAQ9qicn77dEr37SqLbex/6dMeXDmT0NM9cSQrFxyy/a316k55F0PFfL7MpIGtRsPg
 TZnE3zFSgA9u4wxHYiSjVZKhYrhxMHU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-159-x7ggK8B6PHiyQueOIj1yMA-1; Thu, 28 Nov 2019 06:36:24 -0500
Received: by mail-wr1-f71.google.com with SMTP id c6so13648791wrm.18
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2019 03:36:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vAXoxG/hPH26hxWqwi0YG+AgRN0sCIrtZCnFIU7bVn4=;
 b=JT/nCRP5hUEaFVYOKNcIzs71Q9cQKgRPilw2kubaySc+kFHV8Z7VC1GJ009blJBGOZ
 tip9WR/LLUViw2bLJZ4fJsngQ4WOS0ryDWzoyftf8YfglyEn6mVV9hRkGihQcgPM+WY4
 V/iIukUDVCaFMCh8h+yV0J8MhFG6wnZAW6I6YfWO2gaKzLnPYFaCJNmmiwM2EF0bFEYG
 HhqM8hI0NrF4yum6NeqAg6Oc6Mfbf+IIxJKQuToa+KdjAGXphA/+an3bC29uiKTFMe3R
 oJE1tQO+JosWLpFTjPfMoAdmADWAu+hvHFfVpENfvISx4ORCzuBp+IrwToFzbZwaoV58
 0Q6w==
X-Gm-Message-State: APjAAAXlP6sqakcA/gcxkz/b5Ty+uFaBL/pGBuVSQtAzM+CTraOtpecf
 T3ecA6chvGzxSRkI383/tYe37iqvRVP3Upd2hmBCYMUuVXCczZ8rj8Tyv06DN7BStpRNRoSe1RZ
 zY0/8JWH/w7obVoI=
X-Received: by 2002:adf:f60a:: with SMTP id t10mr48021365wrp.29.1574940982867; 
 Thu, 28 Nov 2019 03:36:22 -0800 (PST)
X-Google-Smtp-Source: APXvYqyNVN59Eh2TVgmCfPDoc/HtWnAz9aI1/W+G/DhQ/3Zi1NYh4vKKMohC7DerYRfEJdwFf6C3xQ==
X-Received: by 2002:adf:f60a:: with SMTP id t10mr48021332wrp.29.1574940982575; 
 Thu, 28 Nov 2019 03:36:22 -0800 (PST)
Received: from [192.168.1.35] (182.red-88-21-103.staticip.rima-tde.net.
 [88.21.103.182])
 by smtp.gmail.com with ESMTPSA id o21sm9719652wmc.17.2019.11.28.03.36.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 28 Nov 2019 03:36:22 -0800 (PST)
Subject: Re: [RFC PATCH 06/10] hw/avr: Add ATmega microcontrollers
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 Richard Henderson <richard.henderson@linaro.org>
References: <20191128015030.27543-1-f4bug@amsat.org>
 <20191128015030.27543-7-f4bug@amsat.org>
 <CAL1e-=i=1zhx3q4xzh7oPzXLWAHwtEkUVTSHKqv5yy9BBRrVKw@mail.gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <d9590609-9bcb-41da-cb2d-a7e373ca3909@redhat.com>
Date: Thu, 28 Nov 2019 12:36:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <CAL1e-=i=1zhx3q4xzh7oPzXLWAHwtEkUVTSHKqv5yy9BBRrVKw@mail.gmail.com>
Content-Language: en-US
X-MC-Unique: x7ggK8B6PHiyQueOIj1yMA-1
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
Cc: Sarah Harris <S.E.Harris@kent.ac.uk>, Michael Rolnik <mrolnik@gmail.com>,
 Thomas Huth <huth@tuxfamily.org>, Joaquin de Andres <me@xcancerberox.com.ar>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>,
 Pavel Dovgalyuk <dovgaluk@ispras.ru>, Paolo Bonzini <pbonzini@redhat.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Aleksandar, Richard.

On 11/28/19 10:28 AM, Aleksandar Markovic wrote:
> On Thursday, November 28, 2019, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.=
org=20
> <mailto:f4bug@amsat.org>> wrote:
>=20
>     Add famous ATmega MCUs:
>=20
>     - middle range: ATmega168 and ATmega328
>     - high range: ATmega1280 and ATmega2560
>=20
>     Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org
>     <mailto:f4bug@amsat.org>>
>     ---
>=20
>=20
> Philippe, hi.
>=20
> Thank you for the impetus you give us all.
>=20
> However, is this the right direction?

I am not the maintainer who will merge the AVR port, so I'm not an=20
authoritative figure. I simply wanted to help Michael and Joaquin, so=20
spent 6h of my personal time here.

> Let's analyse some bits and pieces.
>=20
> Starting from the commit message, the word "famous" is used, but I=20
> really don't see enumerated CPUs/MCUs are any special in Atmel lineup.=20
> Other than we often used the doc describing them=C2=A0(cited several time=
s in=20
> our discussions)=C2=A0as=C2=A0our reference, but that=C2=A0doesn't make t=
hem "famous".=20
> Ofcourse, there other docs for other Atmel CPUs/MCUs, of at lest=20
> equivalent significance. For example, "tiny" ones are at least as famous=
=20
> as "mega" ones.

As noted in the cover, this is sent as RFC and I was quite tired when=20
posting so the documentation is rather scarce, but the patches were=20
targeted at Michael/Joaquin as example how they could properly add AVR=20
machines.

> Then, you introduce the term MCU, without proper discussion with others=
=20
> on terminology. In parlance of QEMU, ATmega168 at al. are CPUs (we all=20
> know and assume that that are some peripherals in it). I am not against=
=20
> using the term MCU, but let's first sync up on that.
>=20
> The added terminology trouble is that MCUs, as you defined them, have in=
=20
> array atmega_mcu[] a field called "cpu_type" - why is that field not=20
> called "mcu_type"? *Very* confusing for any future reader. And then,=20
> similar terminology conundrum continues with macro AVR_CPU_TYPE_NAME().
>=20
> All of the above is far less important than this question: What are we=20
> achieving with proposed CPU/MCU definitions? I certainly see the value=20
> of fitting the complex variety of AVR CPUs/MCUs into QEMU object model.=
=20
> No question about that. However, is this the right moment to do it?=20
> There are still some unresolved architectural problems with peripheral=20
> definitions, as I noted in yhe comment to Michael's last cover letter.=20
> This patch does not solve them. It just assumes everything is ready with=
=20
> peripherals, let's build CPUs/MCUs. The machines based on proposed=20
> CPUs/MCUs are not more real that machine based on Michael's "sample"=20
> machine. At least Michal says "this is not a real machine". If we used=20
> proposed CPUs/MCUs from this patch, the resulting machine is as "paper"=
=20
> machine as yhe "sample" machine. We would just live in a la-la lend of=20
> thinking: "wow, we model real hardware now".
>=20
> I would rather accept into QEMU a series admitting we are still far from=
=20
> modelling real machine or CPU/MCU, than a series that gives an illusion=
=20
> that we are modelling real machine or CPU/MCU.

These patches try to do the same as the 'sample' machine modeled by=20
Michael, but reordered in a different way.
The only documentation was "The CPU is an approximation of an=20
ATmega2560" so I assumed he could be using the Arduino MEGA2560 board=20
which matches. I used the same peripherals that Michael used, simply=20
presented a more QEMU-up-to-date way.

> As far as utility of this patch for Michael's series, it looks to me=20
> they add more headake than help (not saying that the help is not=20
> present) to Michael. He would have anotter abstraction layer to think=20
> of, at the moment he desperately needs (in my opinion) to focus on=20
> providing the as solid as possible, and as complete as possinle=20
> foundations. This patch looks like building castles in the air. Again, I=
=20
> am not claiming that the patch is not helpful at all.
>=20
> In summary, I think that this patch is premature.

If we merge the 'sample' board, the deprecation process will take at=20
least 8 months, hoping no-one start to hack it.

So to save time, we can merge the architectural part (target/avr) of=20
Michael work, without the hardware part (hw/avr).

Michael/Sarah can still test their 'instruction-tests' [*] suite using=20
the 'none' machine.

See this example which creates a testing machine with a AVR3 core and=20
1MB of RAM mapped at 0x0000:

$ avr-softmmu/qemu-system-avr -M none -cpu avr3-avr-cpu -m 1 -S -monitor=20
stdio
QEMU 4.1.93 monitor - type 'help' for more information
(qemu) info mtree
address-space: cpu-memory-0
   0000000000000000-ffffffffffffffff (prio 0, i/o): system
     0000000000000000-00000000000fffff (prio 0, ram): ram

(qemu) info qom-tree
/machine (none-machine)
   /unattached (container)
     /ram[0] (qemu:memory-region)
     /sysbus (System)
     /system[0] (qemu:memory-region)
     /io[0] (qemu:memory-region)
     /device[0] (avr3-avr-cpu)
     [...]

They won't be able to run the FreeRTOS test suite [*] until we find a=20
consensus with the AVR hardware/boards.

This seems the clever outcome, so the AVR architectural part get merged=20
as soon as 5.0 opens, and we have time to improve the hardware part.
And Michael won't have to repost his series until v42 :)

Richard, you seem to be the de-facto maintainer, is that correct?
If you agree with my suggestion, I can prepare a v38 based on Michael's=20
last series, sanitized and without the HW part, so it you can queue it=20
for avr-next.

[*] https://github.com/seharris/qemu-avr-tests


