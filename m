Received: from eggs.gnu.org ([2001:4830:134:3::10]:39038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXjCv-0002pm-0t
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:15:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1dXjCr-0004Iu-L1
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:15:40 -0400
Received: from mx1.redhat.com ([209.132.183.28]:48072)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <thuth@redhat.com>) id 1dXjCr-0004Ig-61
	for qemu-devel@nongnu.org; Wed, 19 Jul 2017 03:15:37 -0400
References: <20170407143847.GM2138@work-vm>
	<1573e08f-9805-eaf4-3fe1-c1172b6ef6e4@amsat.org>
	<1c55bc6d-7ef7-dcf5-81e8-22712f575691@amsat.org>
	<6e4fb953-17b4-a11b-4f98-8ddfd5ff12f8@redhat.com>
	<39dc6b92-dd56-fe33-cd85-92c03d69f133@redhat.com>
	<20170717164641.GA31820@work-vm>
	<a18cd09c-5dbd-525e-c4a6-8286e3ce2333@redhat.com>
	<CAFEAcA9Dc1_1t-N-gYiUsW+FY9-2ZNsKqBFY-WMF9Z-SeXsjiw@mail.gmail.com>
	<f834b5c4-f16c-2099-3018-cd5a2f503ac4@amsat.org>
	<2a198132-689f-9cf2-42da-3b481e49af3a@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <5c29a13f-6a0d-6074-1ac4-e4491a2a0cdc@redhat.com>
Date: Wed, 19 Jul 2017 09:15:29 +0200
MIME-Version: 1.0
In-Reply-To: <2a198132-689f-9cf2-42da-3b481e49af3a@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature";
	boundary="JFWWMqKhUnT0QA7Q2xHt6lW3AIVMn0SE6"
Subject: Re: [Qemu-devel] Hacks for building on gcc 7 / Fedora 26
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eric Blake <eblake@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: QEMU Developers <qemu-devel@nongnu.org>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JFWWMqKhUnT0QA7Q2xHt6lW3AIVMn0SE6
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

On 18.07.2017 17:10, Eric Blake wrote:
> On 07/18/2017 10:04 AM, Philippe Mathieu-Daud=C3=A9 wrote:
>>> We should be consistent -- if we can't trust assert() to
>>> be marked nonreturn, as it seems we can't, then we shouldn't
>>> write new code that assumes it always is, even if today
>>> it doesn't happen to bite us on the compiler/host combinations
>>> we're testing right now.
>>
>> And there is also the problem when you compiles with CPPFLAGS+=3D-DNDE=
BUG
>> some oldschool guys still have in their ~/.cshrc ;)
>=20
> We don't have problems with people defining NDEBUG in their environment=
;
> such people would already hit at least:
>=20
> hw/scsi/mptsas.c:#ifdef NDEBUG
> hw/scsi/mptsas.c:#error building with NDEBUG is not supported
>=20
> (maybe we should hoist that to osdep.h, though)

Yes, please. Not every target is build with CONFIG_MPTSAS_SCSI_PCI so we
should move that to a more central place.

 Thomas




--JFWWMqKhUnT0QA7Q2xHt6lW3AIVMn0SE6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJZbwcRAAoJEC7Z13T+cC21NxgP/2WQ78KjNZXqikW+1bXw/220
s0p+K7MavN+PDsLQ+YVvBMXRz9Hgx27Kk0d77AGofCgvrBwFIBqQNfjXy3zFPJIq
Ny6O65uD0Oxj2uE0qtzZeRbQgkHloOjSh3ED0H0gXtECyj7uYGsOmulO+Oop9hZB
S0tWSttisFYy5I2gJq+PGGuwGj85I0eo/awkZvf6cL+jNo8QJH5B3fLhNMn9iAWu
kMl2gZbjkYPfE/TKB/AwRNmyHgIkjn25+yKPZ8fRUlOJNpK5PFGuRe3OKQvS4Eh+
JOasC/FyVrmndmsuZds/9kZdk3Ti9R75VEupWizUAc6l2gwzVXuPbCvd8eO8UTg3
GFuMpfg3VkL7dOZKbVzguSk1LzrerAwfqRFcYuNfDxIIljC5w1b6NAzn5kFPHSmL
ZDwLJjwoFVvmwAm5fUeuZPkeb6tDQr3ArPWjadPk/cmJtWp/ahc/m0k6KnkjA1am
9pIlbpxaF8agG7Hw1DINZr5oEK6gPDBm9c5ZmcEiazbbg+cznxiFnE/Uv6A2bP00
VidA0MGHHWicrA1HOCO5QHVE8nBym7PTvNRFRi2L0A/e21iy+EV06R5A3KIXXmmy
Z1vU0wBT0ZKocZfqXV8MUXHwF4ioQDbAaF/qR/SnAPD5icKUE4M7j+nmya7Pruid
aSWuDOkpOo6IHUPoOrbc
=1Djy
-----END PGP SIGNATURE-----

--JFWWMqKhUnT0QA7Q2xHt6lW3AIVMn0SE6--
