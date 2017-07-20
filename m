Received: from eggs.gnu.org ([2001:4830:134:3::10]:45680)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dY7QY-00015G-29
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:07:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1dY7QX-0006M1-3i
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:07:22 -0400
Received: from mail-wr0-x229.google.com ([2a00:1450:400c:c0c::229]:35705)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1dY7QW-0006Ld-TT
	for qemu-devel@nongnu.org; Thu, 20 Jul 2017 05:07:21 -0400
Received: by mail-wr0-x229.google.com with SMTP id k71so14544199wrc.2
	for <qemu-devel@nongnu.org>; Thu, 20 Jul 2017 02:07:20 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <e590ae65-f18f-7ced-c141-8833a3df38ca@twiddle.net>
References: <20170719044522.21114-1-rth@twiddle.net>
	<CAFEAcA_rx1UyVBrS1WaE6FZMvQPsb=RJJCZgnfS2AjWR+hsFsg@mail.gmail.com>
	<e590ae65-f18f-7ced-c141-8833a3df38ca@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 20 Jul 2017 10:06:59 +0100
Message-ID: <CAFEAcA8UKme8frW6-4J+CSj8yiBDX4V39GVtQ18i+0QRWJDY3g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PULL 0/8] target/alpha cleanups
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, Paolo Bonzini <pbonzini@redhat.com>

On 19 July 2017 at 22:52, Richard Henderson <rth@twiddle.net> wrote:
> On 07/19/2017 06:57 AM, Peter Maydell wrote:
>>
>> On 19 July 2017 at 05:45, Richard Henderson <rth@twiddle.net> wrote:
>>>
>>> The new title holder for perf top is helper_lookup_tb_ptr.
>>> Those targets that have a complicated cpu_get_tb_cpu_state
>>> function are going to regret that.
>>
>>
>> Yeah, Paolo's pointed out (and had some patches for)
>> ARM's rather complicated cpu_get_tb_cpu_state(). My
>> issue with his suggested fixes was that they were
>> pretty fragile in terms of not having any guarantee
>> that the change always produced the right tb cpu
>> state flags answer...
>
>
> Oh?  I must have missed seeing this one.
> A quick patchwork search doesn't pull it up;
> do either of you have a link?

It was back in September:
https://lists.gnu.org/archive/html/qemu-devel/2016-09/msg03133.html

thanks
-- PMM
