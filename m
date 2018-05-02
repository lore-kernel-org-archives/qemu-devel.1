Received: from eggs.gnu.org ([2001:4830:134:3::10]:37472)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDrSA-000359-Jt
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:05:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1fDrS4-0003gr-RH
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:05:50 -0400
Received: from mail-wr0-x230.google.com ([2a00:1450:400c:c0c::230]:35749)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1fDrS4-0003gM-Hp
	for qemu-devel@nongnu.org; Wed, 02 May 2018 09:05:44 -0400
Received: by mail-wr0-x230.google.com with SMTP id i14-v6so10787010wre.2
	for <qemu-devel@nongnu.org>; Wed, 02 May 2018 06:05:44 -0700 (PDT)
References: <20180501142222.19154-1-kbastian@mail.uni-paderborn.de>
	<20180501142222.19154-3-kbastian@mail.uni-paderborn.de>
	<87efiv9yge.fsf@linaro.org>
	<f24f7977-cd8b-f502-e3f1-2ae6b0f422d8@mail.uni-paderborn.de>
	<583cb654-2e10-14e2-faed-36c52a2f306a@mail.uni-paderborn.de>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <583cb654-2e10-14e2-faed-36c52a2f306a@mail.uni-paderborn.de>
Date: Wed, 02 May 2018 14:05:41 +0100
Message-ID: <877eom9pi2.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
To: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Cc: QEMU Developers <qemu-devel@nongnu.org>


Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:

> On 05/01/2018 06:48 PM, Bastian Koppelmann wrote:
>> Hi Alex,
>>
>> On 05/01/2018 05:40 PM, Alex Benn=C3=A9e wrote:
>>> Bastian Koppelmann <kbastian@mail.uni-paderborn.de> writes:
>>>
>>>> this includes the Makefile and linker script to build all the tests.
>>>>
>>>> Signed-off-by: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
>>>> ---
>>>>  tests/tcg/tricore/Makefile | 30 +++++++++++++++++++++++
>>>>  tests/tcg/tricore/link.ld | 60 ++++++++++++++++++++++++++++++++++++++=
++++++++
>>>>  2 files changed, 90 insertions(+)
>>>>  create mode 100644 tests/tcg/tricore/Makefile
>>>>  create mode 100644 tests/tcg/tricore/link.ld
>>>>
>>>> diff --git a/tests/tcg/tricore/Makefile b/tests/tcg/tricore/Makefile
>>>> new file mode 100644
>>>> index 0000000000..8c168d1062
>>>> --- /dev/null
>>>> +++ b/tests/tcg/tricore/Makefile
>>>> @@ -0,0 +1,30 @@
>>>> +AS :=3D tricore-as
>>>> +LD :=3D tricore-ld
>>> Where do these come from? Ideally we'd get these in a docker container
>>> like the rest. It would actually be easier to use tricore-gcc if it
>>> exists because at the moment my docker series only exposes a C compiler
>>> to the make system.
>>
>> I don't have access to gcc unfortunately. The only thing I can provide i=
s the
>> patched binutils (https://github.com/bkoppelmann/tricore-binutils).
>>
>> Can you give me a pointer regarding your docker images?
>>
>> Cheers,
>> Bastian
>
> Sorry Alex for taking this off list. I was at a new machine...

No worries, sorry for being late with the pointer:

  https://lists.gnu.org/archive/html/qemu-devel/2018-04/msg03906.html

My current WIP tree is:

  https://github.com/stsquad/qemu/tree/testing/tcg-tests-revival-v4

although the usual caveats about re-basing apply to that ;-)

--
Alex Benn=C3=A9e
