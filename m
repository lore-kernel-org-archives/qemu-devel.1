Received: from eggs.gnu.org ([209.51.188.92]:33170)
	by lists.gnu.org with esmtp (Exim 4.71) (envelope-from <n54@gmx.com>)
	id 1gmKOp-0002Kk-Mq
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:25:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <n54@gmx.com>) id 1gmKOo-0001oU-Mk
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:25:07 -0500
Received: from mout.gmx.net ([212.227.17.21]:50305)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <n54@gmx.com>) id 1gmKOo-0001kz-C6
	for qemu-devel@nongnu.org; Wed, 23 Jan 2019 10:25:06 -0500
References: <20190123093657.GC27270@redhat.com>
	<d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
	<20190123101238.GD27270@redhat.com>
	<379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
	<CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
	<52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
	<20190123122015.uvyqe4vsxhhgugz7@sirius.home.kraxel.org>
	<da0587e0-44a2-a0f8-3df4-628973db42fd@gmx.com>
	<20190123135903.v2jjfpsp5pqitva4@sirius.home.kraxel.org>
	<ddf0684d-37cb-1860-9b73-0b23bd5dbde6@comstyle.com>
	<20190123151257.3bchv7msj754jyt2@sirius.home.kraxel.org>
From: Kamil Rytarowski <n54@gmx.com>
Message-ID: <94b6e045-2348-b64b-048b-e585a236201c@gmx.com>
Date: Wed, 23 Jan 2019 16:20:41 +0100
MIME-Version: 1.0
In-Reply-To: <20190123151257.3bchv7msj754jyt2@sirius.home.kraxel.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="obdNAa8V9o7kFmUri5FmqK3hdFi7Cb9z1"
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
To: Gerd Hoffmann <kraxel@redhat.com>, Brad Smith <brad@comstyle.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski <kamil@netbsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--obdNAa8V9o7kFmUri5FmqK3hdFi7Cb9z1
From: Kamil Rytarowski <n54@gmx.com>
To: Gerd Hoffmann <kraxel@redhat.com>, Brad Smith <brad@comstyle.com>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Kamil Rytarowski
 <kamil@netbsd.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
 <philmd@redhat.com>
Message-ID: <94b6e045-2348-b64b-048b-e585a236201c@gmx.com>
Subject: Re: [Qemu-devel] [PATCH 4/4] [RfC] audio: probe audio drivers by
 default
References: <20190123093657.GC27270@redhat.com>
 <d7c274a7-00ac-d767-69fc-238b88cfd61b@redhat.com>
 <20190123101238.GD27270@redhat.com>
 <379cce5d-71e1-b210-c0de-c0b8a478de3a@gmx.com>
 <CAFEAcA-HOjPGz2U4wXJ_ujbUmHn1V2PohiL8wPkPz8iV6TPSig@mail.gmail.com>
 <52937a07-9462-6910-610c-5b1ee5d2541a@gmx.com>
 <20190123122015.uvyqe4vsxhhgugz7@sirius.home.kraxel.org>
 <da0587e0-44a2-a0f8-3df4-628973db42fd@gmx.com>
 <20190123135903.v2jjfpsp5pqitva4@sirius.home.kraxel.org>
 <ddf0684d-37cb-1860-9b73-0b23bd5dbde6@comstyle.com>
 <20190123151257.3bchv7msj754jyt2@sirius.home.kraxel.org>
In-Reply-To: <20190123151257.3bchv7msj754jyt2@sirius.home.kraxel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 23.01.2019 16:12, Gerd Hoffmann wrote:
> On Wed, Jan 23, 2019 at 09:54:13AM -0500, Brad Smith wrote:
>> On 1/23/2019 8:59 AM, Gerd Hoffmann wrote:
>>
>>>    Hi,
>>>
>>>>> What is the native sound interface for openbsd btw?  oss doesn't
>>>>> compile (missing sys/soundcard.h header).
>>>> OpenBSD uses sndio, a similar audio daemon to pulseaudio and it's
>>>> enforced for all [well integrated] audio applications.
>>> Hmm.  Yet another audio daemon.  /me wonders why people keep reinvent=
ing
>>> the wheel.
>>
>> The wheel wouldn't be reinvented if there were viable options. There w=
ere
>> none.
>=20
> https://xkcd.com/927/
>=20

There is a different context on BSD than on Linux. We can choose one
solution and switch to it literally all the software keeping everything
in a single ports tree.

This is what happened on OpenBSD.

The result is that almost everything uses sndio, and pulseaudio is far
behind in adoption in any distro.

>>>> SDL is an optional intermediate layer kept for practical/compatibili=
ty
>>>> purposes, but all software shall use sndio natively.
>>> Is pulseaudio supported?  The package is at least in the package
>>> collection.  If so, then we can choose between pulse and sdl as middl=
e
>>> man, due to the lack of a sndio backend.  Which of the two should be
>>> preferred?
>>
>> Very much SDL. PulseAudio is avoided like the plague.
>=20
> Ok, so be it.  Lets go with SDL only for openbsd.
>=20

Please skip pulseaudio for NetBSD and FreeBSD too. Even if it works (and
I've contributed NetBSD patches), it's used as a last resort solution.

> cheers,
>   Gerd
>=20
>=20



--obdNAa8V9o7kFmUri5FmqK3hdFi7Cb9z1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJABAEBCAAqFiEELaxVpweEzw+lMDwuS7MI6bAudmwFAlxIhkkMHG41NEBnbXgu
Y29tAAoJEEuzCOmwLnZstT0P/i3hRyDw4P8883MCMz0cLpzL08PgU7Sv4KVLoQEw
k+IZmFrTO/ZJso0mt9jQY3hrMSOE8N4q7KmewUuzOzJpUeMBiRIyT+W4pUrjxTx9
g/1UT721RDgdkYn9Q0Xz58AQCNIgHxnh3Hg3LXctRjOhjigTq9bo6fVnr/YElquC
2d4HvtAdqAKHXJHuAb95esErdciL/dfUdZtBWPHu2/+ez0XcaxiFuRqCvnUKqEef
WUXyIB4K+LLeFq/uqZj1IW68bv2k+5Rt0Voi0SJ4oMsPRoH93nM4gyZ3LNTw70mE
XAZYsIhLsARQuh4/h9YFi55FbjfdHSUjUPIWS02BkwIutxOX1z3+Fzv9FTV+ZTDr
3sqdNxpJwg/CZyLu/rGF7zfMUygyNiSH9Nnr1apFkD69105OcIyyWXoAtQuV2B7H
aEjfiNTZ/9g+gStZ4O8ZhIR57MMv6UfUYu2JKsuHpPdprm2QCKMKaYg6UkoxSwH3
bXjULV4QGnyDz1sIkI9/6S5iYZdSUnebovva8IQJzWFtEfKO1zYJQl//nqoMT8MF
7gSDkQsgTEIhoJ/cc+Qk0KID6QBWNkTi7l4Uqv9Kl2ha1f4ISkHItwP6u4Ds1kFl
uM6PePtfzFgiLyU/tJWbqLSnbgMfbBu3n1yhyifk57N4SLSAweoC5T1bnzj5/vsL
3fv4
=qN6B
-----END PGP SIGNATURE-----

--obdNAa8V9o7kFmUri5FmqK3hdFi7Cb9z1--
