Received: from eggs.gnu.org ([2001:4830:134:3::10]:38413)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRnGs-0005vF-4s
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:50:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1cRnGr-0007IN-BC
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:50:58 -0500
Received: from mail-ua0-x229.google.com ([2607:f8b0:400c:c08::229]:33590)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1cRnGr-0007GP-0R
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 16:50:57 -0500
Received: by mail-ua0-x229.google.com with SMTP id i68so24322481uad.0
	for <qemu-devel@nongnu.org>; Thu, 12 Jan 2017 13:50:56 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20170112204109.GY9606@toto>
References: <1484073849-32666-1-git-send-email-peter.maydell@linaro.org>
	<1484073849-32666-2-git-send-email-peter.maydell@linaro.org>
	<20170112204109.GY9606@toto>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Jan 2017 21:50:35 +0000
Message-ID: <CAFEAcA9RZTXZPeYwPvwgEG3cWA+h_ev4LesxCdO+YkncdsfLiw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Subject: Re: [Qemu-devel] [PATCH 1/3] target/arm: A32,
 T32: Create Instruction Syndromes for Data Aborts
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 12 January 2017 at 20:41, Edgar E. Iglesias <edgar.iglesias@gmail.com> wrote:
> On Tue, Jan 10, 2017 at 06:44:07PM +0000, Peter Maydell wrote:
>> Add support for generating the ISS (Instruction Specific Syndrome)
>> for Data Abort exceptions taken from AArch32. These syndromes are
>> used by hypervisors for example to trap and emulate memory accesses.
>>
>> This is the equivalent for AArch32 guests of the work done for AArch64
>> guests in commit aaa1f954d4cab243.
>
> Hi,
>
> I haven't checked the the details but I think the structure looks good.
> The patch is a large and has a few things that I think could be broken
> out into separate patches (or dropped).
>
> For example these kind of refactoring could be a separate patch:
>> +                bool pbit = insn & (1 << 24);
> ...
>> -                if (insn & (1 << 24))
>> +                if (pbit) {

That one should be the only refactoring, but yeah I can split it out.

>
> There's also a few whitespace changes that could be broken out or dropped..

Oops; I'll get rid of those.

thanks
-- PMM
