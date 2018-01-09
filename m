Received: from eggs.gnu.org ([2001:4830:134:3::10]:40471)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYukI-0006UO-46
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:19:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eYukH-000514-5O
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:19:18 -0500
Received: from mail-ot0-x241.google.com ([2607:f8b0:4003:c0f::241]:43004)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eYukH-00050g-04
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 09:19:17 -0500
Received: by mail-ot0-x241.google.com with SMTP id a7so1291073otd.9
	for <qemu-devel@nongnu.org>; Tue, 09 Jan 2018 06:19:16 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1c99d190-5154-556f-caaf-5abcf4341f96@linaro.org>
References: <1511890447-13601-1-git-send-email-peter.maydell@linaro.org>
	<1c99d190-5154-556f-caaf-5abcf4341f96@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 9 Jan 2018 14:18:55 +0000
Message-ID: <CAFEAcA-UKGsy=xQKyd8kBCUj06sAcPXdy2H2mU-ukzNoh_Tk6g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] linux-user/arm/nwfpe: Check coprocessor
 number for FPA emulation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>, =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, Riku Voipio <riku.voipio@iki.fi>, Laurent Vivier <laurent@vivier.eu>

On 29 November 2017 at 09:30, Richard Henderson
<richard.henderson@linaro.org> wrote:
> On 11/28/2017 05:34 PM, Peter Maydell wrote:
>> Our copy of the nwfpe code for emulating of the old FPA11 floating
>> point unit doesn't check the coprocessor number in the instruction
>> when it emulates it.  This means that we might treat some
>> instructions which should really UNDEF as being FPA11 instructions by
>> accident.
>>
>> The kernel's copy of the nwfpe code doesn't make this error; I suspect
>> the bug was noticed and fixed as part of the process of mainlining
>> the nwfpe code more than a decade ago.
>>
>> Add a check that the coprocessor number (which is always in bits
>> [11:8] of the instruction) is either 1 or 2, which is where the
>> FPA11 lives.
>>
>> Reported-by: Richard Henderson <richard.henderson@linaro.org>
>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>> ---
>> Tested with a chroot of arm debian lenny, which is the last one that
>> still used the calling convention that mandated use of the old FPA11 FPU
>> and thus needs nwfpe emulation.
>> ---
>>  linux-user/arm/nwfpe/fpa11.c | 9 +++++++++
>>  1 file changed, 9 insertions(+)
>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

Thanks; applied to target-arm.next (since it's as much an arm patch
as a linux-user one).

-- PMM
