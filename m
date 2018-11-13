Received: from eggs.gnu.org ([2001:4830:134:3::10]:57957)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMdDh-0003DU-RK
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:15:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1gMd6q-0005ap-Hg
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:08:21 -0500
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:41634)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1gMd6q-0005aP-2m
	for qemu-devel@nongnu.org; Tue, 13 Nov 2018 13:08:20 -0500
Received: by mail-oi1-x242.google.com with SMTP id g188-v6so11145984oif.8
	for <qemu-devel@nongnu.org>; Tue, 13 Nov 2018 10:08:20 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <37b5f17e-50cd-6980-2d42-4e7f4ede2597@redhat.com>
References: <20181113165247.4806-1-sameo@linux.intel.com>
	<20181113165247.4806-3-sameo@linux.intel.com>
	<CAFEAcA-R51dyV7gtS+q-eLNn5LBJbSMKtQu4-N3p0c4mJrU8DA@mail.gmail.com>
	<37b5f17e-50cd-6980-2d42-4e7f4ede2597@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 13 Nov 2018 18:07:58 +0000
Message-ID: <CAFEAcA_O5x3QuTnKkupur=iwQaEg-i1z2mWoNCiZt_zM5xi-XA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 02/13] target: arm: Remove unused headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>
Cc: Samuel Ortiz <sameo@linux.intel.com>, QEMU Developers <qemu-devel@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>

On 13 November 2018 at 18:02, Philippe Mathieu-Daud=C3=A9 <philmd@redhat.co=
m> wrote:
> On 13/11/18 18:01, Peter Maydell wrote:
>>
>> On 13 November 2018 at 16:52, Samuel Ortiz <sameo@linux.intel.com> wrote=
:

>>> --- a/target/arm/helper.c
>>> +++ b/target/arm/helper.c
>>> @@ -12,13 +12,10 @@
>>>   #include "internals.h"
>>>   #include "exec/gdbstub.h"
>>>   #include "exec/helper-proto.h"
>>> -#include "qemu/host-utils.h"
>>
>>
>> This is for muldiv64().
>
>
> But it is already included by "cpu.h" -> "exec/cpu-defs.h"

> So they are not "unused" but "unnecessary".
>
> I thought this would be better to clean this once, before Samuel split.

Generally I think that if a .c file directly uses function X declared in
header Y it should #include Y, even if it happens that it already includes
other header Z that includes Y. Otherwise if we refactor Z later such
that it no longer needs to include Y, it will break compilation of the .c
file. (That is, Z including Y is a detail of the implementation of Z,
not a guarantee made by Z to its users.)

The exception here is where the header guarantees that it's going
to include certain other things (which is the case for eg our osdep.h).

thanks
-- PMM
