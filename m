Received: from eggs.gnu.org ([2001:4830:134:3::10]:50340)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cEglG-00086Z-Lb
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:16:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <rth7680@gmail.com>) id 1cEglD-0007ab-H5
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:16:10 -0500
Received: from mail-qk0-f193.google.com ([209.85.220.193]:35702)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <rth7680@gmail.com>) id 1cEglD-0007aL-B5
	for qemu-devel@nongnu.org; Wed, 07 Dec 2016 13:16:07 -0500
Received: by mail-qk0-f193.google.com with SMTP id n204so49358482qke.2
	for <qemu-devel@nongnu.org>; Wed, 07 Dec 2016 10:16:07 -0800 (PST)
Sender: Richard Henderson <rth7680@gmail.com>
References: <20161207180727.6286-1-rth@twiddle.net>
	<20161207180727.6286-2-rth@twiddle.net>
	<CAFEAcA_7kvm41Q-hzWW04ujk+y4jAekhoG9A4yYFSdaoDOgpHw@mail.gmail.com>
From: Richard Henderson <rth@twiddle.net>
Message-ID: <691e8220-de86-2319-7b9c-5cfe6198e26d@twiddle.net>
Date: Wed, 7 Dec 2016 10:15:02 -0800
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_7kvm41Q-hzWW04ujk+y4jAekhoG9A4yYFSdaoDOgpHw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/2] tcg/aarch64: Fix addsub2 for 0+C
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>

On 12/07/2016 10:10 AM, Peter Maydell wrote:
> On 7 December 2016 at 18:07, Richard Henderson <rth@twiddle.net> wrote:
>> When al == xzr, we cannot use addi/subi because that encodes xsp.
>> Force a zero into the temp register for that (rare) case.
> 
> Incidentally I was slightly surprised that the optimisation
> pass didn't turn "add2 rlo, rhi, 0, 0, 0, 0" into moves of 0
> into rlo and rhi. Constant shifts of xzr in the guest don't
> seem worth spending much effort on optimising though :-)

Until this last release cycle, we couldn't insert opcodes into the instruction
stream during optimization.  Thus we were very restricted in what we could do
when wanting to assign simpler values to two different outputs.

I'll bet addition of 0 + non-constant come up semi-regularly for 32-bit hosts
and 64-bit guests.  I'll see about better simplification of double-word
arithmetic for the next cycle.


r~
