Received: from eggs.gnu.org ([2001:4830:134:3::10]:33492)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fptUU-0005lr-Ld
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 06:57:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1fptUT-0005ae-GP
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 06:57:26 -0400
Received: from mail-oi0-x244.google.com ([2607:f8b0:4003:c06::244]:40415)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1fptUT-0005Sc-4Z
	for qemu-devel@nongnu.org; Wed, 15 Aug 2018 06:57:25 -0400
Received: by mail-oi0-x244.google.com with SMTP id w126-v6so1245633oie.7
	for <qemu-devel@nongnu.org>; Wed, 15 Aug 2018 03:57:24 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <685c5db6-48b6-e103-de94-233602315e2a@sysgo.com>
References: <20180814165419.9116-1-rka@sysgo.com>
	<CAFEAcA8RQ2X83AQOcvg3acJhJ6ioJ7KtJ=V2iFiUmQh4bF_fmA@mail.gmail.com>
	<685c5db6-48b6-e103-de94-233602315e2a@sysgo.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 15 Aug 2018 11:57:03 +0100
Message-ID: <CAFEAcA-sEwv2eKtah9M=McjoqzQWEF4zeDZij0zc7MLYgOu2hg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target/arm: crash on conditional instr in
 it block
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Roman Kapl <roman.kapl@sysgo.com>
Cc: Roman Kapl <rka@sysgo.com>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 15 August 2018 at 09:30, Roman Kapl <roman.kapl@sysgo.com> wrote:
> Hi and thanks for review,
>
> On 08/14/2018 08:12 PM, Peter Maydell wrote:
>>
>> On 14 August 2018 at 17:54, Roman Kapl <rka@sysgo.com> wrote:
>>>
>>> If an instruction is conditional (like CBZ) and it is executed
>>> conditionally
>>> (using the ITx instruction), a jump to undefined label is generated.
>>>
>>> Fix the 'skip on condtion' code to create a new label only if it does not
>>> already exist. Previously multiple labels were created, but only the last
>>> one of
>>> them was set.
>>
>>
>> Hi; thanks for the bug report and the patch.
>>
>> This case (CBZ inside an IT block) is architecturally UNPREDICTABLE,
>> but we certainly shouldn't crash QEMU.
>
>
> Hm... I am not able to find that claim in my ARMv7 reference manual (but I
> am no ARM expert).

v7A Arm ARM DDI0406C.b, section A8.8.29 "CBNZ, CBZ":
pseudocode says "if InITBlock() then UNPREDICTABLE;".

thanks
-- PMM
