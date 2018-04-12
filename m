Received: from eggs.gnu.org ([2001:4830:134:3::10]:53123)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f6cTP-0001oU-2x
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 09:41:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1f6cTL-0005e2-TJ
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 09:41:11 -0400
Received: from mail-wr0-x236.google.com ([2a00:1450:400c:c0c::236]:44888)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1f6cTL-0005db-LD
	for qemu-devel@nongnu.org; Thu, 12 Apr 2018 09:41:07 -0400
Received: by mail-wr0-x236.google.com with SMTP id u46so5171471wrc.11
	for <qemu-devel@nongnu.org>; Thu, 12 Apr 2018 06:41:07 -0700 (PDT)
References: <152215564388.18893.1601223531883570946.malonedeb@chaenomeles.canonical.com>
	<152339082825.12513.17266713653673903879.malone@wampee.canonical.com>
	<924dbc89-fb1c-720d-9091-a5f5c16df4b9@mail.uni-paderborn.de>
	<87woxe3t2t.fsf@linaro.org>
	<a8872e48-4dea-9394-3974-eb067df252d7@mail.uni-paderborn.de>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <a8872e48-4dea-9394-3974-eb067df252d7@mail.uni-paderborn.de>
Date: Thu, 12 Apr 2018 14:41:05 +0100
Message-ID: <87lgdsmtji.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Bug 1759264] Re: fpu/softfloat:
 round_to_int_and_pack refactor broke TriCore ftoi insns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Bug 1759264 <1759264@bugs.launchpad.net>
Cc: qemu-devel@nongnu.org


Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:

> On 04/11/2018 01:01 PM, Alex Benn=C3=A9e wrote:
>> Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:
>>
>>> On 04/10/2018 10:07 PM, Alex Benn=C3=A9e wrote:
>>>> Yeah it looks like it was missed, the round_to_uint code does it.
>>>>
>>>> Do you have a test case I can verify?
>>>>
>>>
>>> For the NaN input 0xffffffff the expected result for the flags is that
>>> flag_invalid is raised.
>>>
>>> I can provide you with some TriCore asm, but it is a bit of pain to get
>>> the gnu assembler to build, since the public version is a decade old.
>>
>> I'll trust you if you send me a static binary for this particular
>> verification ;-)
>
> I set up a github repo with working binutils and the corresponding
> testcase:
>
> https://github.com/bkoppelmann/tricore-fpu
>
> The one caveat is, that we cannot produce any binaries with the TriCore
> ISA > 1.3.
>
> In this testcase the last ftoi instruction is supposed to raise the
> invalid flag and return 0 since the input was NaN. We did that by only
> checking for NaN if any flag was raised after ftoi, then do the NaN
> check, and if positive, return 0.

Well it builds and I get an fpu-test.elf but I'm a bit stuck on how to
run it. What are the runes for launching the test?

>
> Cheers,
> Bastian


--
Alex Benn=C3=A9e
