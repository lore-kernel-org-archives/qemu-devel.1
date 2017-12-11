Received: from eggs.gnu.org ([2001:4830:134:3::10]:47945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eORx0-0001KU-KX
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 12:33:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eORwz-00012N-Lq
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 12:33:10 -0500
Received: from mail-ot0-x243.google.com ([2607:f8b0:4003:c0f::243]:38970)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eORwz-00011a-HU
	for qemu-devel@nongnu.org; Mon, 11 Dec 2017 12:33:09 -0500
Received: by mail-ot0-x243.google.com with SMTP id v21so15415127oth.6
	for <qemu-devel@nongnu.org>; Mon, 11 Dec 2017 09:33:09 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <db0d2fd0-ae95-b9f8-47a7-d273306a2432@twiddle.net>
References: <1513006964-3371-1-git-send-email-peter.maydell@linaro.org>
	<db0d2fd0-ae95-b9f8-47a7-d273306a2432@twiddle.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 11 Dec 2017 17:32:48 +0000
Message-ID: <CAFEAcA_ezdp_ygjT2r9P7niSnOqRxAMUJ+vhaMk4HJTSrEjrJQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH for-2.11?] target/arm: Generate UNDEF for
 32-bit Thumb2 insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <rth@twiddle.net>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, "Emilio G . Cota" <cota@braap.org>, Michael Roth <mdroth@linux.vnet.ibm.com>

On 11 December 2017 at 17:00, Richard Henderson <rth@twiddle.net> wrote:
> On 12/11/2017 07:42 AM, Peter Maydell wrote:
>> The refactoring of commit 296e5a0a6c3935 has a nasty bug:
>> it accidentally dropped the generation of code to raise
>> the UNDEF exception when disas_thumb2_insn() returns nonzero.
>> This means that 32-bit Thumb2 instruction patterns that
>> ought to UNDEF just act like nops instead. This is likely
>> to break any number of things, including the kernel's "disable
>> the FPU and use the UNDEF exception to identify when to turn
>> it back on again" trick.
>>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> This is the smallest possible fix that will correct the
>> bug, for possible inclusion in 2.11; for 2.12 we should
>> fix the asymmetry where disas_thumb() generates its own
>> exception-raising code but disas_thumb2() wants the caller
>> to do it. (This asymmetry is why we didn't notice the
>> problem in code review.)
>>
>> I'm not sure whether this should go into 2.11 or not --
>> this time last week it would have been an easy "yes".
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks. I think I have come down on the side of putting this into
2.11, so rolling an rc5 today, and delaying the final release
a day to Wednesday.

thanks
-- PMM
