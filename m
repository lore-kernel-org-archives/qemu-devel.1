Received: from eggs.gnu.org ([2001:4830:134:3::10]:37236)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqjVg-0004Pt-Ky
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:57:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peter.maydell@linaro.org>) id 1eqjVg-0006SW-1l
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:57:52 -0500
Received: from mail-ot0-x22f.google.com ([2607:f8b0:4003:c0f::22f]:44862)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
	id 1eqjVf-0006S5-S5
	for qemu-devel@nongnu.org; Tue, 27 Feb 2018 12:57:51 -0500
Received: by mail-ot0-x22f.google.com with SMTP id 79so4587543oth.11
	for <qemu-devel@nongnu.org>; Tue, 27 Feb 2018 09:57:51 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <87zi3uuxpx.fsf@linaro.org>
References: <20180227143852.11175-1-alex.bennee@linaro.org>
	<20180227143852.11175-15-alex.bennee@linaro.org>
	<19852743-3c93-9d0f-5ef6-8bf351a98ce7@linaro.org>
	<87zi3uuxpx.fsf@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 27 Feb 2018 17:57:30 +0000
Message-ID: <CAFEAcA8zVbZkzLtB+L3x9WQ6Sgh+i_gzVxYdaLJfENYDyApAAA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 14/31] arm/translate-a64: add FP16
 FMULX/MLS/FMLA to simd_indexed
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>

On 27 February 2018 at 17:52, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Richard Henderson <richard.henderson@linaro.org> writes:
>
>> On 02/27/2018 06:38 AM, Alex Benn=C3=A9e wrote:
>>> @@ -11244,7 +11245,7 @@ static void disas_simd_indexed(DisasContext *s,=
 uint32_t insn)
>>>          }
>>>          /* fall through */
>>>      case 0x9: /* FMUL, FMULX */
>>> -        if (!extract32(size, 1, 1)) {
>>> +        if (size =3D=3D 1) {
>>>              unallocated_encoding(s);
>>>              return;
>>>          }
>>
>> This is still redundant, since size =3D=3D 1 is handled...
>
> doh!
>
> will fix.

I'd prefer it if you didn't, because I'm in the process of putting
this version of the patchset into target-arm.next...

thanks
-- PMM
