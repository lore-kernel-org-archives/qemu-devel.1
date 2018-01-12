Received: from eggs.gnu.org ([2001:4830:134:3::10]:42901)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZxcO-0002T5-Lo
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:35:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZxcJ-0008L4-M7
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:35:28 -0500
Received: from mail-qk0-x22a.google.com ([2607:f8b0:400d:c09::22a]:34489)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eZxcJ-0008Km-GN
	for qemu-devel@nongnu.org; Fri, 12 Jan 2018 06:35:23 -0500
Received: by mail-qk0-x22a.google.com with SMTP id b76so8269162qkc.1
	for <qemu-devel@nongnu.org>; Fri, 12 Jan 2018 03:35:23 -0800 (PST)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1515755504-21341-1-git-send-email-pbonzini@redhat.com>
	<9da34f89-3866-bbae-636e-bf26a74cc4ff@amsat.org>
	<8ab39ffe-57a3-5b7e-39f8-d6e062f027bf@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <cd78ffcb-6bee-000f-eaae-7982ef897f65@amsat.org>
Date: Fri, 12 Jan 2018 08:35:17 -0300
MIME-Version: 1.0
In-Reply-To: <8ab39ffe-57a3-5b7e-39f8-d6e062f027bf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature";
	boundary="2NLqke8MfhJeuQ9fgGpACHJ6d1Ioeq2Eb"
Subject: Re: [Qemu-devel] [PATCH] docker: change Fedora base image to
 fedora:27
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2NLqke8MfhJeuQ9fgGpACHJ6d1Ioeq2Eb
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?=
 <marcandre.lureau@redhat.com>, Fam Zheng <famz@redhat.com>
Message-ID: <cd78ffcb-6bee-000f-eaae-7982ef897f65@amsat.org>
Subject: Re: [Qemu-devel] [PATCH] docker: change Fedora base image to
 fedora:27
References: <1515755504-21341-1-git-send-email-pbonzini@redhat.com>
 <9da34f89-3866-bbae-636e-bf26a74cc4ff@amsat.org>
 <8ab39ffe-57a3-5b7e-39f8-d6e062f027bf@redhat.com>
In-Reply-To: <8ab39ffe-57a3-5b7e-39f8-d6e062f027bf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

>>> --- a/tests/docker/dockerfiles/fedora.docker
>>> +++ b/tests/docker/dockerfiles/fedora.docker
>>> @@ -1,4 +1,4 @@
>>> -FROM fedora:latest
>>> +FROM fedora:27
>>
>> I'd rather use the deprecation approach like we use for Debian,
>> see tests/docker/dockerfiles/debian.docker.
>>
>> That said, you remind me of a series doing the same for Ubuntu I forgo=
t
>> to send, if you want I can add fedora25 and fedora27 before sending.
>=20
> That's fine by me (but use "fedora" instead of fedora25).

Plan is:

rename fedora -> fedora25
add fedora27
fedora: display a warning and use fedora25 for backward compatibility



--2NLqke8MfhJeuQ9fgGpACHJ6d1Ioeq2Eb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEE+qvnXhKRciHc/Wuy4+MsLN6twN4FAlpYnXUACgkQ4+MsLN6t
wN6OEQ//faNiccfd42XMWy6yvzFD5RzbasUvFjrxKe6DUJhKgwBFhyO0frqdoXv6
9PJuRagG/ZH7dknibCQvjDYEE3C108OFBoKssSq1VjQnWGHoqHO/XK7Bvozo+O6X
di9RUGWBoHCFtYrzHWhtLXgmd4iPPBk2zA7Qlr64/CB8d0CDIMMoDqXQ/5VqxxpM
mc/b72sKdyBsDcXDPqOCu4Lbw/gISvfhVYtESArZVhATQVUiGSDLAKnSIvDkgQrC
JI3pvPm3pf7nbGY7CP1408G4sexEVD2w+C2uFsuJ8VOV1vAPesxyi4e6+ahA3Txw
c39KgDjT8Nog1XZZTLkHzOs2VflcBwgWMTSwiSSfCERZAXVsTdMbcDdvCAivbvtl
bVer5DEb/Ig6pMY3d4ULEcuItl/hAItM0IGp3GD9EeXl5QTyYatOu8JIg26YOEAo
j44aRg//Ti6SfRsqII/HJR06cYhopaRoWuAwDatAtZY8zmrLDGf4uQd2gFbmCGDv
E1/43E4mnl/LgMKSTSkA3W/CNcZflkEDW6OUBJMoCF1YOc9FELeyFQUR4OQ8WkkC
wx2qPrEmU6U9mOlJ5kNy8pY2yK6OkCjmuZQ638USnm2CjHoFjlvpoqchCaMWfWg2
HbZa6T99HSglF2IWr967aLkcycOTp6GZbLqDcLecM9ejEStZ92g=
=rU9e
-----END PGP SIGNATURE-----

--2NLqke8MfhJeuQ9fgGpACHJ6d1Ioeq2Eb--
