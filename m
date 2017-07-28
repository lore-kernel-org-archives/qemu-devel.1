Received: from eggs.gnu.org ([2001:4830:134:3::10]:38909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1db0qx-0001gZ-HC
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:42:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1db0qw-0004IB-GO
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:42:35 -0400
Received: from mail-wr0-x22d.google.com ([2a00:1450:400c:c0c::22d]:35360)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1db0qw-0004Hb-A2
	for qemu-devel@nongnu.org; Fri, 28 Jul 2017 04:42:34 -0400
Received: by mail-wr0-x22d.google.com with SMTP id k71so98812048wrc.2
	for <qemu-devel@nongnu.org>; Fri, 28 Jul 2017 01:42:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <122bfaa5-7192-056b-541c-b5f37f871bfc@amsat.org>
References: <1501153150-19984-1-git-send-email-peter.maydell@linaro.org>
	<1501153150-19984-4-git-send-email-peter.maydell@linaro.org>
	<5aff6da7-4ad1-64af-6445-98b8d7520b4c@amsat.org>
	<122bfaa5-7192-056b-541c-b5f37f871bfc@amsat.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 28 Jul 2017 09:42:12 +0100
Message-ID: <CAFEAcA-D4puOE5qPOGEd9mEdQFVqpA16997ZmHf4C5Nq_gEnAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH for-2.10 3/5] target/arm: Rename
 cp15.c6_rgnr to pmsav7.rnr
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <f4bug@amsat.org>
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>, "patches@linaro.org" <patches@linaro.org>

On 27 July 2017 at 23:58, Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wro=
te:
> On 07/27/2017 07:43 PM, Philippe Mathieu-Daud=C3=A9 wrote:
>>
>> On 07/27/2017 07:59 AM, Peter Maydell wrote:
>
> [...]
>>>
>>> -    u32p +=3D env->cp15.c6_rgnr;
>>> +    u32p +=3D env->pmsav7.rnr;
>>>       tlb_flush(CPU(cpu)); /* Mappings may have changed - purge! */
>>>       *u32p =3D value;
>>>   }
>>> @@ -2447,7 +2447,7 @@ static const ARMCPRegInfo pmsav7_cp_reginfo[] =3D=
 {
>>>         .readfn =3D pmsav7_read, .writefn =3D pmsav7_write, .resetfn =
=3D
>>> pmsav7_reset },
>>>       { .name =3D "RGNR", .cp =3D 15, .crn =3D 6, .opc1 =3D 0, .crm =3D=
 2, .opc2 =3D
>>> 0,
>>
>>
>> "RGNR" -> "RNR"
>
>
> Ah "RGNR" for -R and "RNR" for -M hmmm... still better keep the name
> matching the field, "rnr".

It's a bit awkward, yes -- we're going to get a mismatch one way
or the other.

In this patch I wanted only to change the field name, not
anything else (it's already a bit borderline for 2.10).

thanks
-- PMM
