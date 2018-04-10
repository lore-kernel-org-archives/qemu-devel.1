Received: from eggs.gnu.org ([2001:4830:134:3::10]:54192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5nru-0005Ub-Lp
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:39:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1f5nro-000072-TF
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:39:06 -0400
Received: from mail-oi0-x22f.google.com ([2607:f8b0:4003:c06::22f]:44512)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1f5nro-00006m-Mu
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 03:39:00 -0400
Received: by mail-oi0-x22f.google.com with SMTP id j143-v6so10214676oih.11
	for <qemu-devel@nongnu.org>; Tue, 10 Apr 2018 00:39:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAHP4M8VSzm4L6oS06J-e93FwjuHM=weJf2MegCaDNH8MPbsqgA@mail.gmail.com>
References: <CAHP4M8VnuS5KijfVw9eDz41KPwaT4rJ+4VEU==EbBgdwgFKJhA@mail.gmail.com>
	<87efjov999.fsf@linaro.org>
	<CAHP4M8W-WuBmJUdb6LGR1t3tPayrnaS+b1ZZ1zew71aM==-imA@mail.gmail.com>
	<87d0z8v78e.fsf@linaro.org>
	<CAHP4M8VSzm4L6oS06J-e93FwjuHM=weJf2MegCaDNH8MPbsqgA@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 10 Apr 2018 08:38:39 +0100
Message-ID: <CAFEAcA91iNyUnahri9EdL7Th1Q9v44765z0OJexxMrNUD_DXEQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [Qemu-arm] Crash when running hello-world
 unikernel for ARM
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ajay Garg <ajaygargnsit@gmail.com>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, rumpkernel-users@freelists.org, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 10 April 2018 at 05:14, Ajay Garg <ajaygargnsit@gmail.com> wrote:
> Thanks Alex for the reply ..
>
>>
>> Can you run under -s -S and gdb step the *guest* and see where it ends
>> up. The above error is usually indicative of the guest going off into
>> the weeds somewhere because the hardware isn't what it expects.
>>
>
> So, after your reply that it might be because of the
> hardware-mismatch, I kinda took a detour, and installed a arm32 "virt"
> machine on qemu on a x86_64 host, as per the steps at
> https://translatedcode.wordpress.com/2016/11/03/installing-debian-on-qemus-32-bit-arm-virt-board/
>
> All went fine, and then I compiled rumprun on this "virt" guest.

The host system hardware doesn't matter (except that if you're
running suitable matching host and guest hardware you might be
able to use hardware acceleration with KVM, but for the moment
I would recommend concentrating on getting it working). What
matters is that the guest software you run must match the
hardware that you are asking QEMU to emulate. (I guess if
rumprun automatically configures itself based on the system
you're compiling it on then you're running a different binary,
but surely it has a setup for manually configuring it when you're
cross-compiling it?)

What hardware (what CPU, board, etc) is this "rumprun" software
expecting to run on?

(The "Trying to execute code outside RAM or ROM at 0x00100000"
symptoms very frequently mean "guest binary was not built
to run on this emulated hardware".)

thanks
-- PMM
