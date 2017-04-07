Received: from eggs.gnu.org ([2001:4830:134:3::10]:40508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cwNMH-0002ha-8c
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:26:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cwNMG-0001lv-9S
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:26:57 -0400
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:34475)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1cwNMG-0001lJ-51
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 02:26:56 -0400
Received: by mail-qk0-x242.google.com with SMTP id p68so8916549qke.1
	for <qemu-devel@nongnu.org>; Thu, 06 Apr 2017 23:26:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <3F8ADDFA-7686-416B-A63A-4C59EC99DDC6@gmail.com>
References: <mailman.167.1491494426.906.qemu-devel@nongnu.org>
	<3F8ADDFA-7686-416B-A63A-4C59EC99DDC6@gmail.com>
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Fri, 7 Apr 2017 08:26:55 +0200
Message-ID: <CAJy91CaTPoUVHYSKAqM=svr3E=JPr-3pYYGRW72Fr-XuS0RTNQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] is qemu able to run multiple system emulation
 simultaneously
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: G 3 <programmingkidx@gmail.com>
Cc: qemu-devel qemu-devel <qemu-devel@nongnu.org>

On 6 April 2017 at 19:58, G 3 <programmingkidx@gmail.com> wrote:

>
> On Apr 6, 2017, at 12:00 PM, qemu-devel-request@nongnu.org wrote:
>
> Dear QEMU developers,
>>
>> I need multiple ARM-based hardware emulation runing simultaneously in one
>> PC.
>> I wander if QEMU is capble to run two system emulation at the same time.
>> Or I have to use two QEMU for two system emulation
>>
>> If the former is possible, where can i find some docs about it? I have
>> searched two days, the result is not positive.
>>
>> Please help. Thanks in advance.
>>
>> Best regards,
>> Jiahuan
>>
>
> My vote goes to running multiple instances of QEMU at the same time. It is
> easy to do and works.
>

As for as I know, "running multiple instances of QEMU at the same time" is
feasible for user-mode emulation, namely emulting CPU, according to
https://en.wikipedia.org/wiki/QEMU.
Wikipedia says
"Virtualization solutions that use QEMU are able to execute multiple
virtual CPUs in parallel. QEMU is also able to run multiple threads in
user-mode emulation mode.

For full system emulation, QEMU uses a single thread to emulate all the
virtual CPUs and hardware. "
However, what I need is system emulation, an ARM processor with various
periphrals.

I think Peter is right.
