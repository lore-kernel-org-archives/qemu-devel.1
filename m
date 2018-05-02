Received: from eggs.gnu.org ([2001:4830:134:3::10]:47344)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDoHq-0002BK-FS
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:42:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kbastian@mail.uni-paderborn.de>) id 1fDoHl-0006AP-GX
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:42:58 -0400
Received: from mail.uni-paderborn.de ([131.234.142.9]:48718)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kbastian@mail.uni-paderborn.de>)
	id 1fDoHk-000692-R6
	for qemu-devel@nongnu.org; Wed, 02 May 2018 05:42:53 -0400
From: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
References: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
	<20180501142222.19154-3-kbastian@mail.uni-paderborn.de>
	<87efiv9yge.fsf@linaro.org>
	<f24f7977-cd8b-f502-e3f1-2ae6b0f422d8@mail.uni-paderborn.de>
Message-ID: <583cb654-2e10-14e2-faed-36c52a2f306a@mail.uni-paderborn.de>
Date: Wed, 2 May 2018 11:42:50 +0200
MIME-Version: 1.0
In-Reply-To: <f24f7977-cd8b-f502-e3f1-2ae6b0f422d8@mail.uni-paderborn.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC PATCH 02/12] tests/tcg/tricore: Add build
 infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>

On 05/01/2018 06:48 PM, Bastian Koppelmann wrote:
> Hi Alex,
> 
> On 05/01/2018 05:40 PM, Alex Bennée wrote:
>> Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:
>>
>>> this includes the Makefile and linker script to build all the tests.
>>>
>>> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>>> ---
>>>   tests/tcg/tricore/Makefile | 30 +++++++++++++++++++++++
>>>   tests/tcg/tricore/link.ld  | 60 ++++++++++++++++++++++++++++++++++++++++++++++
>>>   2 files changed, 90 insertions(+)
>>>   create mode 100644 tests/tcg/tricore/Makefile
>>>   create mode 100644 tests/tcg/tricore/link.ld
>>>
>>> diff --git a/tests/tcg/tricore/Makefile b/tests/tcg/tricore/Makefile
>>> new file mode 100644
>>> index 0000000000..8c168d1062
>>> --- /dev/null
>>> +++ b/tests/tcg/tricore/Makefile
>>> @@ -0,0 +1,30 @@
>>> +AS := tricore-as
>>> +LD := tricore-ld
>> Where do these come from? Ideally we'd get these in a docker container
>> like the rest. It would actually be easier to use tricore-gcc if it
>> exists because at the moment my docker series only exposes a C compiler
>> to the make system.
> 
> I don't have access to gcc unfortunately. The only thing I can provide is the
> patched binutils (https://github.com/bkoppelmann/tricore-binutils).
> 
> Can you give me a pointer regarding your docker images?
> 
> Cheers,
> Bastian

Sorry Alex for taking this off list. I was at a new machine...

Cheers,
Bastian
