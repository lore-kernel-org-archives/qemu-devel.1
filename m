Received: from eggs.gnu.org ([209.51.188.92]:54624)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1grP1q-0005yL-Ee
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:22:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1grP1m-00029F-KD
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:22:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46190)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1grP1m-00028h-84
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 10:22:18 -0500
References: <20190206105339.32664-1-david@redhat.com>
	<87ef8lneja.fsf@zen.linaroharston>
From: David Hildenbrand <david@redhat.com>
Message-ID: <2f4bfa41-09d6-5103-5c69-9bb8912f5c58@redhat.com>
Date: Wed, 6 Feb 2019 16:22:14 +0100
MIME-Version: 1.0
In-Reply-To: <87ef8lneja.fsf@zen.linaroharston>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v1] softfloat: Implement float128_to_uint32
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>, Peter Maydell <peter.maydell@linaro.org>, Aurelien Jarno <aurelien@aurel32.net>

On 06.02.19 16:12, Alex Benn=C3=A9e wrote:
>=20
> David Hildenbrand <david@redhat.com> writes:
>=20
>> Handling it just like float128_to_uint32_round_to_zero, that hopefully
>> is free of bugs :)
>>
>> Documentation basically copied from float128_to_uint64
>=20
> Queued to fpu/next, thanks.
>=20
> BTW to test:
>=20
> tests/fp: add wrapping for f128_to_ui32
>=20
> Needed to test: softfloat: add float128_is_{normal,denormal}

Thanks, was that supposed to be "softfloat: Implement float128_to_uint32"=
 ?

>=20
> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>=20
> 2 files changed, 3 insertions(+), 1 deletion(-)
> tests/fp/fp-test.c  | 3 ++-
> tests/fp/wrap.inc.c | 1 +
>=20
> modified   tests/fp/fp-test.c
> @@ -622,7 +622,8 @@ static void do_testfloat(int op, int rmode, bool ex=
act)
>          test_ab_extF80_z_bool(true_ab_extF80M_z_bool, subj_ab_extF80M_=
z_bool);
>          break;
>      case F128_TO_UI32:
> -        not_implemented();
> +        test_a_f128_z_ui32_rx(slow_f128M_to_ui32, qemu_f128M_to_ui32, =
rmode,
> +                              exact);
>          break;
>      case F128_TO_UI64:
>          test_a_f128_z_ui64_rx(slow_f128M_to_ui64, qemu_f128M_to_ui64, =
rmode,
> modified   tests/fp/wrap.inc.c
> @@ -367,6 +367,7 @@ WRAP_80_TO_INT_MINMAG(qemu_extF80M_to_i64_r_minMag,
>  WRAP_128_TO_INT(qemu_f128M_to_i32, float128_to_int32, int_fast32_t)
>  WRAP_128_TO_INT(qemu_f128M_to_i64, float128_to_int64, int_fast64_t)
>=20
> +WRAP_128_TO_INT(qemu_f128M_to_ui32, float128_to_uint32, uint_fast32_t)
>  WRAP_128_TO_INT(qemu_f128M_to_ui64, float128_to_uint64, uint_fast64_t)
>  #undef WRAP_128_TO_INT
>=20
> --
> Alex Benn=C3=A9e
>=20


--=20

Thanks,

David / dhildenb
