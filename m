Received: from eggs.gnu.org ([2001:4830:134:3::10]:53782)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb7c5-0006kP-G0
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:27:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eb7c4-0007ue-Lz
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:27:57 -0500
Received: from mail-ot0-x229.google.com ([2607:f8b0:4003:c0f::229]:37134)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eb7c4-0007uT-FP
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 11:27:56 -0500
Received: by mail-ot0-x229.google.com with SMTP id a24so11096157otd.4
	for <qemu-devel@nongnu.org>; Mon, 15 Jan 2018 08:27:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <6cded669-a2af-cec0-f4c5-028758c48bfa@twiddle.net>
References: <1515562748-32287-1-git-send-email-rth@twiddle.net>
	<CAFEAcA8TxNTjvsqeHss=7BEm6SzwLHZ54UqDmOPMWA5z0oTsUA@mail.gmail.com>
	<6cded669-a2af-cec0-f4c5-028758c48bfa@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jan 2018 16:27:35 +0000
Message-ID: <CAFEAcA-JVbW6uUduFpJ5Yrfq9LcpJ+wiuJfrnK6btwD9+MfbnQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] tcg/arm: Fix double-word comparisons
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, David Gibson <david@gibson.dropbear.id.au>, Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 15 January 2018 at 16:18, Richard Henderson <rth@twiddle.net> wrote:
> On 01/15/2018 06:27 AM, Peter Maydell wrote:
>> The code looks OK to me. I'm guessing the sparc guest failure is
>> just because we now generate more code for some of the comparison
>> cases and that doesn't fit in the buffer...
>
> I don't recall having seen a sparc failure...

See the backtrace in my reply to your tcg pullrequest email :-)

>> We could avoid the annoying "load LE/GE immediates to tempreg"
>> extra code by having tcg_out_cmp2() return a flag to tell
>> the caller which way round to put the conditions for its two
>> conditional ARITH_MOV insns (for setcond2) or which condition
>> to use for the branch (brcond2), right?
>
> Um... we do return a condition.  I must have missed a trick or
> made a mistake somewhere.

Oh, yes, rather than returning "condition and flag to tell caller
to invert it" we could just flip which condition we return,
couldn't we.

thanks
-- PMM
