Received: from eggs.gnu.org ([2001:4830:134:3::10]:37831)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXUeN-0005vj-0v
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:15:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXUeJ-0002L1-0q
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:15:18 -0500
Received: from mail-qk0-x242.google.com ([2607:f8b0:400d:c09::242]:39188)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eXUeI-0002KS-Rk
	for qemu-devel@nongnu.org; Fri, 05 Jan 2018 11:15:14 -0500
Received: by mail-qk0-x242.google.com with SMTP id r8so2201646qke.6
	for <qemu-devel@nongnu.org>; Fri, 05 Jan 2018 08:15:14 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20171211125705.16120-1-alex.bennee@linaro.org>
	<20171211125705.16120-5-alex.bennee@linaro.org>
	<c17e6c00-0a9f-054a-88c4-5868081daccf@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <7c848bb5-7439-da58-69db-6908d44aeea8@amsat.org>
Date: Fri, 5 Jan 2018 13:15:03 -0300
MIME-Version: 1.0
In-Reply-To: <c17e6c00-0a9f-054a-88c4-5868081daccf@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="pKZvrQMIhRcdIN8BeYSRSeYciFWpCtaZ0"
Subject: Re: [Qemu-devel] [PATCH v1 04/19] include/fpu/softfloat: implement
 float16_set_sign helper
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Richard Henderson <richard.henderson@linaro.org>, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com, andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com, qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>, Alistair Francis <alistair.francis@xilinx.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pKZvrQMIhRcdIN8BeYSRSeYciFWpCtaZ0
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Peter Crosthwaite <crosthwaite.peter@gmail.com>
Cc: peter.maydell@linaro.org, laurent@vivier.eu, bharata@linux.vnet.ibm.com,
 andrew@andrewdutcher.com, aleksandar.markovic@imgtec.com,
 qemu-devel@nongnu.org, Aurelien Jarno <aurelien@aurel32.net>,
 Alistair Francis <alistair.francis@xilinx.com>
Message-ID: <7c848bb5-7439-da58-69db-6908d44aeea8@amsat.org>
Subject: Re: [Qemu-devel] [PATCH v1 04/19] include/fpu/softfloat: implement
 float16_set_sign helper
References: <20171211125705.16120-1-alex.bennee@linaro.org>
 <20171211125705.16120-5-alex.bennee@linaro.org>
 <c17e6c00-0a9f-054a-88c4-5868081daccf@linaro.org>
In-Reply-To: <c17e6c00-0a9f-054a-88c4-5868081daccf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/18/2017 06:44 PM, Richard Henderson wrote:
> On 12/11/2017 04:56 AM, Alex Benn=C3=A9e wrote:
>> +static inline float16 float16_set_sign(float16 a, int sign)
>> +{
>> +    return make_float16((float16_val(a) & 0x7fff) | (sign << 15));
>> +}
>> +
>=20
> 1) Do we use this anywhere?
>=20
> 2) While this is probably in line with the other implementations,
> but going to a more qemu-ish style this should use deposit32.

Yes, it is easier to read while reviewing (no mask or shift), so safer.

That's probably why I'm becoming addict of the "hw/registerfields.h"
API... :)


--pKZvrQMIhRcdIN8BeYSRSeYciFWpCtaZ0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpPpIcACgkQ4+MsLN6t
wN7S5w//ZInk2+0dmT2HoP9ESXTGwo/3Hv7yrTor5dju2ckZOHh2LcwOSczzglpm
yymMVTmNtQEnFgQmzVaXzH8foCF5Kc2xbiQGAERETJcFi7C6jS6L4QG1WCGVWIpY
OtomIslwG4VkXUP62/Q/UsGcQbiHdVv9JKbFtnw7gVxgxFEHTqkbF9cmprGK2Ka6
nLbUZY6sR6YL/Njg87WtFPdUyyzwHoxZBXZK9qy00vrjKI9Wgi9BaJUnmMzCyr0Z
cJoOWUOZU/3PRu1eKbgfcq4fnaLu8igQR6dxL6oNfeNK/fr18SkU05ZjkfxiCMLk
SYzVHu0Bg7Zr829KEbK3Uch4DCUz00CEusA5xMYFTm5NpiEtUc5o361pXkH8m6+/
+NtO0KLzw2zTxRUkCDxfIm6vJ3csFhCabOfUk3FviV8Te9irhhMVNWCc8TOMotOY
QZ1QE23MZLdlmlcpl2opO1nSV7dJo+qpUGFrfAYkcKloAPt3rBtGTKqubZ/EpYbV
Ca/NxObrqohQmZi5EjQY5RzeeHUSWlPQav8Pl04Jf4+WNrCdnfe5ckR1q/4uO4L4
k395TCmqFpyaUeNO44nYZuZU01RLUNM28HUKiIHJdYrgW8TCoctH/iatH78kFDJB
7f66qHIYdRZA60DFqIFpt8khr2FGfckwnRna3+Vdn97LtLtSXsw=
=Gw8Z
-----END PGP SIGNATURE-----

--pKZvrQMIhRcdIN8BeYSRSeYciFWpCtaZ0--
