Received: from eggs.gnu.org ([209.51.188.92]:43805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gxUHx-0003Rf-7j
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 05:12:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1gxUHw-000319-G6
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 05:12:09 -0500
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:37129)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1gxUHw-0002h8-6j
	for qemu-devel@nongnu.org; Sat, 23 Feb 2019 05:12:08 -0500
Received: by mail-wm1-x343.google.com with SMTP id x10so4013649wmg.2
	for <qemu-devel@nongnu.org>; Sat, 23 Feb 2019 02:11:49 -0800 (PST)
References: <20190222204500.24434-1-alex.bennee@linaro.org>
	<20190222204500.24434-7-alex.bennee@linaro.org>
	<4d4521cb-8ce9-661d-9491-e350b4a6320f@linaro.org>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <4d4521cb-8ce9-661d-9491-e350b4a6320f@linaro.org>
Date: Sat, 23 Feb 2019 10:11:46 +0000
Message-ID: <87pnrig6fx.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1 6/6] softfloat: Support
 float_round_to_odd more places
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, David Hildenbrand <david@redhat.com>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 2/22/19 12:45 PM, Alex Benn=C3=A9e wrote:
>> @@ -3526,6 +3551,8 @@ static float32 roundAndPackFloat32(flag zSign, int=
 zExp, uint32_t zSig,
>>      case float_round_down:
>>          roundIncrement =3D zSign ? 0x7f : 0;
>>          break;
>> +    case float_round_to_odd:
>> +        roundIncrement =3D zSig & 0x80 ? 0 : 0x7f;
>>      default:
>>          abort();
>
> I clearly missed a break here.
>
> Since this didn't kill fp-test, are we missing a float128_to_float32
> test?

Ahh yes missing that:

10:11:17 [alex@zen:~/l/q/b/a/t/fp] fpu/next + ./fp-test f16_to_f32 f64_to_f=
32 f128_to_f32 -r odd
>> Testing f16_to_f32
408 tests total.
408 tests performed.
In 408 tests, no errors found in f16_to_f32.
>> Testing f64_to_f32, rounding odd, tininess before rounding
768 tests total.
768 tests performed.
In 768 tests, no errors found in f64_to_f32, rounding odd, tininess before =
rounding.
>> Testing f64_to_f32, rounding odd, tininess after rounding
768 tests total.
768 tests performed.
In 768 tests, no errors found in f64_to_f32, rounding odd, tininess after r=
ounding.
>> Testing f128_to_f32, rounding odd, tininess before rounding
936 tests total.
fish: =E2=80=9C./fp-test f16_to_f32 f64_to_f32=E2=80=A6=E2=80=9D terminated=
 by signal SIGABRT (Abort)

I'll patch it up and fix.

>
>
> r~


--
Alex Benn=C3=A9e
