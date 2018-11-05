Received: from eggs.gnu.org ([2001:4830:134:3::10]:55641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gJi4u-0005yg-OD
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:50:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gJi4k-0008WU-Gz
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:50:13 -0500
Received: from mail-wm1-x341.google.com ([2a00:1450:4864:20::341]:38637)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gJi4i-0008Rz-M0
	for qemu-devel@nongnu.org; Mon, 05 Nov 2018 11:50:05 -0500
Received: by mail-wm1-x341.google.com with SMTP id l2-v6so8771484wmh.3
	for <qemu-devel@nongnu.org>; Mon, 05 Nov 2018 08:50:04 -0800 (PST)
References: <20181016093703.10637-1-peter.maydell@linaro.org>
	<20181016093703.10637-2-peter.maydell@linaro.org>
	<87tvkvebmd.fsf@linaro.org>
	<CAFEAcA8tPHFHFHeB5ty2x6GGgTs6aQG3ckD6NkzOR7OgAX-f9Q@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8tPHFHFHeB5ty2x6GGgTs6aQG3ckD6NkzOR7OgAX-f9Q@mail.gmail.com>
Date: Mon, 05 Nov 2018 16:50:01 +0000
Message-ID: <87r2fzeafa.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 1/2] target/arm: Set S and PTW
 in 64-bit PAR format
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 5 November 2018 at 16:24, Alex Benn=C3=A9e <alex.bennee@linaro.org> wr=
ote:
>>
>> Peter Maydell <peter.maydell@linaro.org> writes:
>>
>>> In do_ats_write() we construct a PAR value based on the result
>>> of the translation.  A comment says "S2WLK and FSTAGE are always
>>> zero, because we don't implement virtualization".
>>> Since we do in fact now implement virtualization, add the missing
>>> code that sets these bits based on the reported ARMMMUFaultInfo.
>>>
>>> (These bits are named PTW and S in ARMv8, so we follow that
>>> convention in the new comments in this patch.)
>>>
>>> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
>>> ---
>>>  target/arm/helper.c | 10 ++++++----
>>>  1 file changed, 6 insertions(+), 4 deletions(-)
>>>
>>> diff --git a/target/arm/helper.c b/target/arm/helper.c
>>> index 43afdd082e1..dc849b09893 100644
>>> --- a/target/arm/helper.c
>>> +++ b/target/arm/helper.c
>>> @@ -2344,10 +2344,12 @@ static uint64_t do_ats_write(CPUARMState *env, =
uint64_t value,
>>>
>>>              par64 |=3D 1; /* F */
>>
>> To aid readability, mainly for those not familiar like me, maybe:
>>
>>   par64 |=3D 1; /* PAR_EL1.F =3D=3D 1, failed translation */
>
> That's in the existing code...

I know, it was just a suggestion to help make it clearer there are two
forms when you are reading the register definition.

--
Alex Benn=C3=A9e
