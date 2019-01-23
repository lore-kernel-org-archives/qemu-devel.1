Received: from eggs.gnu.org ([209.51.188.92]:47449)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gmJm6-0006i4-EX
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:45:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gmJm5-0007d0-DD
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:45:06 -0500
Received: from mout.gmx.net ([212.227.15.19]:40149)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gmJm4-0007be-Tq
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 09:45:05 -0500
References: <20190123080005.31078-5-kraxel@redhat.com>
	<484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
	<20190123093657.GC27270@redhat.com>
	<d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
	<20190123101238.GD27270@redhat.com>
	<379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
	<CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
	<52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
	<20190123122015.uvyqe4vsxhhgugz7@sirius.home.kraxel.org>
	<da0587e0-44a2-a0f8-3df4-628973db42fd@gmx.com>
	<20190123135903.v2jjfpsp5pqitva4@sirius.home.kraxel.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <dba3d252-f713-d3ac-d8c4-83d7c5f8497a@gmx.com>
Date: Wed, 23 Jan 2019 15:45:29 +0100
MIME-Version: 1.0
In-Reply-To: <20190123135903.v2jjfpsp5pqitva4@sirius.home.kraxel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="g7JkaUXcNlIVZ0JzU3hv3n4iFRuR6McQ3"
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Brad Smith <brad@comstyle.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g7JkaUXcNlIVZ0JzU3hv3n4iFRuR6McQ3
From: Kamil Rytarowski <n54@gmx.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski
 <kamil@netbsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>, Brad Smith <brad@comstyle.com>
Message-ID: <dba3d252-f713-d3ac-d8c4-83d7c5f8497a@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
References: <20190123080005.31078-5-kraxel@redhat.com>
 <484e921f-7cee-755d-12a9-02e8bf182fa4@redhat.com>
 <20190123093657.GC27270@redhat.com>
 <d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
 <20190123101238.GD27270@redhat.com>
 <379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
 <CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
 <52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
 <20190123122015.uvyqe4vsxhhgugz7@sirius.home.kraxel.org>
 <da0587e0-44a2-a0f8-3df4-628973db42fd@gmx.com>
 <20190123135903.v2jjfpsp5pqitva4@sirius.home.kraxel.org>
In-Reply-To: <20190123135903.v2jjfpsp5pqitva4@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.01.2019 14:59, Gerd Hoffmann wrote:
>   Hi,
>=20
>>> What is the native sound interface for openbsd btw?  oss doesn't
>>> compile (missing sys/soundcard.h header).
>>
>> OpenBSD uses sndio, a similar audio daemon to pulseaudio and it's
>> enforced for all [well integrated] audio applications.
>=20
> Hmm.  Yet another audio daemon.  /me wonders why people keep reinventin=
g
> the wheel.
>=20

This is rather more complex. OpenBSD struggles to remove all !sndio
solutions, with a good record track of applications switched to it.

There is also support for other BSDs and Linux in sndio so it is a
viable piece of software to be adopted more widely.

>> SDL is an optional intermediate layer kept for practical/compatibility=

>> purposes, but all software shall use sndio natively.
>=20
> Is pulseaudio supported?  The package is at least in the package
> collection.  If so, then we can choose between pulse and sdl as middle
> man, due to the lack of a sndio backend.  Which of the two should be
> preferred?
>=20

I cannot speak definitely for OpenBSD, as I've never installed it
myself. I guess that pulseaudio is more unwanted and not expected at all
as a supported backed.

> cheers,
>   Gerd
>=20



--g7JkaUXcNlIVZ0JzU3hv3n4iFRuR6McQ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxIfgkMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZsMXkP/A1gmydjVTORgnMZCzFEIy6mxhuhyWWnVV5sCIbR
zCg9+qVyXsNkVgQUC32D/sOlDtHf+6N6U4U63bcZwDEsQHixWxYET0he0q915dRg
nxy649Qd63gpuYs7wus0P1NLbitX1e2ZnFrzCm4uBI2GfFjUkS/wFQSxa5XcY0kT
JnHHftKcbtpJXBdQcycnkHPSDHpiCzUp27GKih7idNdIbTmwbcoQSlePV52wXCjS
rSfCG+GEH+iHclIM3BBeXBk8FW0jcFWTUcN3cH9S5lqyao06kfeOA2a1WBkaD1mF
Ndw4aE7NSIrf9jRRtw5AR+3W9lQCHyJqX1Qn2px6iB5mCHVbuQBm+v+XEZ5NLMsM
jHBXFtRM7oud1geEHDdU/NOouAzTw+vJU3i56oesHbvhlCXoBvwlTe+JC45/LDkI
mjEJaXGcUe7sB062zWHtKAq5FktMOrPsBwo8YA7KdrJqyo1xCit0HTcZyT1PW4r6
s3qN54DXJUX07eJ5+hpUKw6h3iZD5MCogMpd8vCZuaC5Ou2k5pa5MzOahRbUaupL
szPGe7wNgNwjgqovkGsf6yZD9ltm8FQ4ZX2MTZWsk5FdX/xPhTw9dgHRp88s+HwA
8kGwPh0oat116LYqV5G+1O6jP+itXbD3jF/EqJcNzgQqyJnWN8Jq+yggKK3FujsV
G4n5
=dIuR
-----END PGP SIGNATURE-----

--g7JkaUXcNlIVZ0JzU3hv3n4iFRuR6McQ3--
