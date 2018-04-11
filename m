Received: from eggs.gnu.org ([2001:4830:134:3::10]:59959)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f6Djs-0002kk-G0
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 07:16:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1f6Djp-0005sn-AF
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 07:16:32 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:51186)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1f6Djo-0005q8-Rk
	for qemu-devel@nongnu.org; Wed, 11 Apr 2018 07:16:29 -0400
References: <152215564388.18893.1601223531883570946.malonedeb@chaenomeles.canonical.com>
	<152339082825.12513.17266713653673903879.malone@wampee.canonical.com>
	<924dbc89-fb1c-720d-9091-a5f5c16df4b9@mail.uni-paderborn.de>
	<87woxe3t2t.fsf@linaro.org>
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Message-ID: <20fc82c8-85d5-7fdf-947d-0907d665161f@mail.uni-paderborn.de>
Date: Wed, 11 Apr 2018 13:16:27 +0200
MIME-Version: 1.0
In-Reply-To: <87woxe3t2t.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: Bug 1759264 <1759264@bugs.launchpad.net>, qemu-devel@nongnu.org

On 04/11/2018 01:01 PM, Alex Bennée wrote:
> 
> Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:
> 
>> On 04/10/2018 10:07 PM, Alex Bennée wrote:
>>> Yeah it looks like it was missed, the round_to_uint code does it.
>>>
>>> Do you have a test case I can verify?
>>>
>>
>> For the NaN input 0xffffffff the expected result for the flags is that
>> flag_invalid is raised.
>>
>> I can provide you with some TriCore asm, but it is a bit of pain to get
>> the gnu assembler to build, since the public version is a decade old.
> 
> I'll trust you if you send me a static binary for this particular
> verification ;-)
> 
> It would be nice to TriCore tests building in tests/tcg/ but I guess we
> need an up to date cross compile environment somewhere.

That is the problem. There is a gcc/binutils port done by some german
company. And it's not easy to get the source. The one they provide is
pretty old and needs some patching to get in building on modern
machines. Right now I'm trying to set up a test environment.

Cheers,
Bastian
