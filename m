Received: from eggs.gnu.org ([2001:4830:134:3::10]:37384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1eRvqf-0007ku-Ry
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:05:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <th.huth@gmail.com>) id 1eRvqc-0000PK-ID
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:05:01 -0500
Received: from mail-wm0-f48.google.com ([74.125.82.48]:36184)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <th.huth@gmail.com>) id 1eRvqc-0000P1-Bn
	for qemu-devel@nongnu.org; Thu, 21 Dec 2017 03:04:58 -0500
Received: by mail-wm0-f48.google.com with SMTP id b76so14137772wmg.1
	for <qemu-devel@nongnu.org>; Thu, 21 Dec 2017 00:04:58 -0800 (PST)
Received: from [192.168.8.100] (x2f7f4db.dyn.telefonica.de. [2.247.244.219])
	by smtp.gmail.com with ESMTPSA id
	c33sm15876512edd.36.2017.12.21.00.04.54 for <qemu-devel@nongnu.org>
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 21 Dec 2017 00:04:55 -0800 (PST)
References: <20171220203528.21334-1-laurent@vivier.eu>
	<20171220222219.7cdf2a57@thl530>
	<15fae875-6eb3-252f-7c98-0e6755afea54@vivier.eu>
From: Thomas Huth <huth@tuxfamily.org>
Message-ID: <2cc84400-93be-4dbb-0103-ffef42917bd2@tuxfamily.org>
Date: Thu, 21 Dec 2017 09:04:53 +0100
MIME-Version: 1.0
In-Reply-To: <15fae875-6eb3-252f-7c98-0e6755afea54@vivier.eu>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] target/m68k: add monitor.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org

On 21.12.2017 08:56, Laurent Vivier wrote:
> Le 20/12/2017 à 22:22, Thomas Huth a écrit :
>> Am Wed, 20 Dec 2017 21:35:28 +0100
>> schrieb Laurent Vivier <laurent@vivier.eu>:
>>
>>> This allows to use registers content in the monitor.
>>>
>>> Example:
>>>
>>>  BEFORE:
>>>   (qemu) print $d0
>>>   unknown register
>>>
>>>  AFTER:
>>>   (qemu) print $d0
>>>   0
>>>   (qemu) print $sr
>>>   0x2000
>>>   (qemu) x/10i $pc
>>>   0x40010a2a:  movew %sr,%d0
>>>   0x40010a2c:  oril #1792,%d0
>>>   0x40010a32:  movew %d0,%sr
>>>   0x40010a34:  movel %a0@,%d0
>>>   0x40010a36:  btst #3,%d0
>>>   0x40010a3a:  beqs 0x40010a26
>>>   0x40010a3c:  movew %sr,%d0
>>>   0x40010a3e:  andil #63743,%d0
>>>   0x40010a44:  movew %d0,%sr
>>>   0x40010a46:  rts
>>>
>>> Signed-off-by: Laurent Vivier <laurent@vivier.eu>
>>> ---
>>>  target/m68k/Makefile.objs |  1 +
>>>  target/m68k/monitor.c     | 55
>>> +++++++++++++++++++++++++++++++++++++++++++++++ 2 files changed, 56
>>> insertions(+) create mode 100644 target/m68k/monitor.c
>>>
>>> diff --git a/target/m68k/Makefile.objs b/target/m68k/Makefile.objs
>>> index 39141ab93d..d143f20270 100644
>>> --- a/target/m68k/Makefile.objs
>>> +++ b/target/m68k/Makefile.objs
>>> @@ -1,3 +1,4 @@
>>>  obj-y += m68k-semi.o
>>>  obj-y += translate.o op_helper.o helper.o cpu.o fpu_helper.o
>>>  obj-y += gdbstub.o
>>> +obj-$(CONFIG_SOFTMMU) += monitor.o
>>> diff --git a/target/m68k/monitor.c b/target/m68k/monitor.c
>>> new file mode 100644
>>> index 0000000000..03d037ccab
>>> --- /dev/null
>>> +++ b/target/m68k/monitor.c
>>> @@ -0,0 +1,55 @@
>>> +/*
>>> + * QEMU monitor
>>> + *
>>> + * Copyright (c) 2003-2004 Fabrice Bellard
>>
>> Why this copyright line (and the non-GPL license code)?
> 
> I don't know. I've checked all the others monitor.c and they have the
> same header. An y suggestions?

Put at least your name in there - Fabrice did not write the new
monitor.c, but it was you instead!

Concerning the license text, this seems to be the MIT license. I guess
that's OK, just wanted to make you aware of it to consider whether you
rather want to use GPL instead or not.

 Thomas
