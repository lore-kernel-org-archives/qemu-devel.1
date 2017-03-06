Received: from eggs.gnu.org ([2001:4830:134:3::10]:51080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cksNi-0007NW-JZ
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:08:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1cksNf-0002rG-FW
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:08:54 -0500
Received: from mail-wr0-x22b.google.com ([2a00:1450:400c:c0c::22b]:33406)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1cksNf-0002r0-8i
	for qemu-devel@nongnu.org; Mon, 06 Mar 2017 08:08:51 -0500
Received: by mail-wr0-x22b.google.com with SMTP id u48so116150596wrc.0
	for <qemu-devel@nongnu.org>; Mon, 06 Mar 2017 05:08:51 -0800 (PST)
References: <a7977444b25641cc86352a6818a4df3a@EXCHCS32.ornl.gov>
	<d60e33d6-6ef1-c61a-a187-5798e5b36d35@yahoo.fr>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <d60e33d6-6ef1-c61a-a187-5798e5b36d35@yahoo.fr>
Date: Mon, 06 Mar 2017 13:08:56 +0000
Message-ID: <87lgsiimc7.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] -rtc clock=vm with -icount 1,
 sleep=off introduces unexpected delays in device interactions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?utf-8?B?RnLDqWTDqXJpYw==?= Konrad <konrad.frederic@yahoo.fr>
Cc: "Nutaro, James J." <nutarojj@ornl.gov>, "'qemu-devel@nongnu.org'" <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>


Frédéric Konrad <konrad.frederic@yahoo.fr> writes:

> Hi Jim,
>
> I think Alex and Paolo worked on an mttcg/icount issue.
> Not sure if its related or not.

If you are running a tree post-MTTCG merge you will need to add Paolo's
patches:

  Subject: [PATCH 0/6] tcg: fix icount super slowdown
  Date: Fri,  3 Mar 2017 14:11:08 +0100
  Message-Id: <20170303131113.25898-1-pbonzini@redhat.com>

>
> Fred
>
> On 03/03/2017 08:38 PM, Nutaro, James J. wrote:
>> My original problem seems to stem from something that changed in the way that device emulation and instruction execution interact (I'm guessing). To reproduce the issue, I started a linux image with
>>
>> qemu-system-i386 -rtc clock=vm -monitor none -icount 1,sleep=off jack.img
>>
>> After booting, I run
>>
>> ping localhost
>>
>> The first round trip time reports look reasonable, being in the millisecond to sub-millisecond range. These occur while the emulator is running slower than real time.
>>
>> After a bit, the emulator speeds up (skipping over idle periods during I/O?) and the round trip times jump to hundreds of milliseconds, which I had not expected.
>>
>> If you want to try this experiment yourself, you can get the disk image that I used from here:
>>
>> http://www.ornl.gov/~1qn/qemu-images/jack.img
>>
>>
>> Jim
>>


--
Alex Bennée
