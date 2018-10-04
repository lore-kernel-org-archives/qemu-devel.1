Received: from eggs.gnu.org ([2001:4830:134:3::10]:58934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g85mx-0007cj-39
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:43:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1g85ms-0003Np-Ju
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:43:43 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:43068)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1g85mo-0003BN-QB
	for qemu-devel@nongnu.org; Thu, 04 Oct 2018 11:43:37 -0400
Received: by mail-wr1-x444.google.com with SMTP id n1-v6so10452148wrt.10
	for <qemu-devel@nongnu.org>; Thu, 04 Oct 2018 08:43:25 -0700 (PDT)
References: <20181003180711.19335-1-richard.henderson@linaro.org>
	<871s96rs4s.fsf@linaro.org> <20181004145525.GA9715@flamenco>
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
In-reply-to: <20181004145525.GA9715@flamenco>
Date: Thu, 04 Oct 2018 16:43:23 +0100
Message-ID: <87pnwpra3o.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 0/4] softfloat: Fix division
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Emilio G. Cota" <cota@braap.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org


Emilio G. Cota <cota@braap.org> writes:

> On Thu, Oct 04, 2018 at 10:13:55 +0100, Alex Benn=C3=A9e wrote:
>>
>> Richard Henderson <richard.henderson@linaro.org> writes:
>>
>> > Changes from v1:
>> >   * Preserve udiv_qrnnd as a separate division primitive that
>> >     could be used as a building block for float128 division.
>> >   * Include asm fragments for x86_64, s390x, and ppc64.
>>
>> It passes my fops fdiv_double test but Emilio's test is reporting:
>>
>>   Errors found in f64_div, rounding near_even:
>>   +252.7FFFFFFFFFF80  +001.FFFFFFFFFFFFE
>>           =3D> +64F.7FFFFFFFFFF82 ....x  expected +64F.7FFFFFFFFFF81 ...=
.x
>
> Did you rebuild the test program? v2 passes all f64_div tests for me.
>
> Tested-by: Emilio G. Cota <cota@braap.org>
> for patches 1 and 2.

Hmm I did:

  make clean
  make

in the tests/fp dir multiple times while going through before/after fix
scenarios. And now of course it works....

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
Tested-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>


>
> Thanks,
>
> 		E.


--
Alex Benn=C3=A9e
