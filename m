Received: from eggs.gnu.org ([2001:4830:134:3::10]:50138)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cwO0p-0005Xz-MV
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:08:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiahuanzhang90@gmail.com>) id 1cwO0o-0001VC-Fw
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:08:51 -0400
Received: from mail-qt0-x242.google.com ([2607:f8b0:400d:c0d::242]:36370)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <jiahuanzhang90@gmail.com>)
	id 1cwO0o-0001UR-9Z
	for qemu-devel@nongnu.org; Fri, 07 Apr 2017 03:08:50 -0400
Received: by mail-qt0-x242.google.com with SMTP id v3so333356qtd.3
	for <qemu-devel@nongnu.org>; Fri, 07 Apr 2017 00:08:50 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CAJy91CaTPoUVHYSKAqM=svr3E=JPr-3pYYGRW72Fr-XuS0RTNQ@mail.gmail.com>
References: <mailman.167.1491494426.906.qemu-devel@nongnu.org>
	<3F8ADDFA-7686-416B-A63A-4C59EC99DDC6@gmail.com>
	<CAJy91CaTPoUVHYSKAqM=svr3E=JPr-3pYYGRW72Fr-XuS0RTNQ@mail.gmail.com>
From: Jiahuan Zhang <jiahuanzhang90@gmail.com>
Date: Fri, 7 Apr 2017 09:08:49 +0200
Message-ID: <CAJy91CbmDWrRCmA8gbgYBNXx0NNeZBSXSd19J+MNUYzLMrLCwQ@mail.gmail.com>
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

On 7 April 2017 at 08:26, Jiahuan Zhang <jiahuanzhang90@gmail.com> wrote:

> On 6 April 2017 at 19:58, G 3 <programmingkidx@gmail.com> wrote:
>
>>
>> On Apr 6, 2017, at 12:00 PM, qemu-devel-request@nongnu.org wrote:
>>
>> Dear QEMU developers,
>>>
>>> I need multiple ARM-based hardware emulation runing simultaneously in one
>>> PC.
>>> I wander if QEMU is capble to run two system emulation at the same time.
>>> Or I have to use two QEMU for two system emulation
>>>
>>> If the former is possible, where can i find some docs about it? I have
>>> searched two days, the result is not positive.
>>>
>>> Please help. Thanks in advance.
>>>
>>> Best regards,
>>> Jiahuan
>>>
>>
>> My vote goes to running multiple instances of QEMU at the same time. It
>> is easy to do and works.
>>
>
Just done a try. Multiple system emulation can be done by running multiple
instances of QEMU. You are right! Thanks.

>
> As for as I know, "running multiple instances of QEMU at the same time"
> is feasible for user-mode emulation, namely emulting CPU, according to
> https://en.wikipedia.org/wiki/QEMU.
> Wikipedia says
> "Virtualization solutions that use QEMU are able to execute multiple
> virtual CPUs in parallel. QEMU is also able to run multiple threads in
> user-mode emulation mode.
>
> For full system emulation, QEMU uses a single thread to emulate all the
> virtual CPUs and hardware. "
> However, what I need is system emulation, an ARM processor with various
> periphrals.
>
> I think Peter is right.
>
>
