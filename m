Received: from eggs.gnu.org ([2001:4830:134:3::10]:49271)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1er1ql-0008A3-C4
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:32:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1er1qg-0001PJ-Qs
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:32:50 -0500
Received: from mail-wm0-x230.google.com ([2a00:1450:400c:c09::230]:55084)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1er1qg-0001Os-KT
	for qemu-devel@nongnu.org; Wed, 28 Feb 2018 08:32:46 -0500
Received: by mail-wm0-x230.google.com with SMTP id z81so4989652wmb.4
	for <qemu-devel@nongnu.org>; Wed, 28 Feb 2018 05:32:46 -0800 (PST)
References: <20180227143852.11175-1-alex.bennee@linaro.org>
	<CAFEAcA8LEG=bzXrj3etTdf_q3-AcMVfCCqSGQ2OkXUPGBHkMBQ@mail.gmail.com>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <CAFEAcA8LEG=bzXrj3etTdf_q3-AcMVfCCqSGQ2OkXUPGBHkMBQ@mail.gmail.com>
Date: Wed, 28 Feb 2018 13:32:43 +0000
Message-ID: <87woyxutms.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v4 00/31] Add ARMv8.2
 half-precision functions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, Richard Henderson <richard.henderson@linaro.org>, QEMU Developers <qemu-devel@nongnu.org>


Peter Maydell <peter.maydell@linaro.org> writes:

> On 27 February 2018 at 14:38, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>> A few minor fixes and a chunk of Richard's r-b tags. Now all that is
>> left is:
>>
>>   patch 0014/arm translate a64 add FP16 FMULX MLS FMLA to simd.patch nee=
ds review
>>
>> Otherwise see comments bellow --- for other changes
>>
>
> Thanks -- applied to target-arm.next. Some caveats:
>
> (1) we can fix the nit RTH noted about FMULX later
>
> (2) I notice that there's no patch here that adds the linux-user/elfload.c
> code to set a hwcap for the guest program to indicate FP16 presence.
> Presumably there is such a hwcap?

I'd missed it as risu doesn't need it. I see rth has sent a patch so
I'll read up on it and see if I can extend vector-benchmark to use it to
detect FP16.

>
> (3) Is this complete fp16 support or are there still more pieces to come?
> I'm assuming it's all done...

All AArch64 is done. I'm not sure how much AArch32 is needed for SVE
support. The ARM ARM says "When this feature is implemented it is
implemented in both Advanced SIMD and floating-point, and in AArch64 and
AArch32 states." but I think it is legal to have a 64 bit only CPU
without AArch32?

Unfortunately the magic I used to extract all the AArch64 HP
instructions from the ASL doesn't work on the AArch32 definitions which
put important differentiating notes in different places.

Once I've got the list I'll document it so we don't forget...

>
> (4) I've split the "add new ARM_V8_FP16 feature bit to the enum"
> and "enable the feature on the 'any' CPU" parts of patch 2, so
> we can do the latter at the end. If there is still missing parts
> to fp16 then we can drop the enable-feature half of that
> for the moment.

I guess that depends on if we model any AArch64 only CPUs?

>
> thanks
> -- PMM


--
Alex Benn=C3=A9e
