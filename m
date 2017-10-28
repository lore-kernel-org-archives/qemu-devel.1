Received: from eggs.gnu.org ([2001:4830:134:3::10]:45920)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8K0b-0004ld-Cm
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 01:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1e8K0Z-0000ld-JH
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 01:50:13 -0400
Received: from mx1.redhat.com ([209.132.183.28]:43130)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1e8K0Z-0000kw-A2
	for qemu-devel@nongnu.org; Sat, 28 Oct 2017 01:50:11 -0400
References: <20171027131412.18830-1-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <2e4935ec-febf-6c13-9856-999f3db64bc2@redhat.com>
Date: Sat, 28 Oct 2017 07:34:40 +0200
MIME-Version: 1.0
In-Reply-To: <20171027131412.18830-1-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2MhpOxkVT0dCDWEtQBpoTOjTouka4DvnO"
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Various improvements to submodule
 handling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, Peter Maydell <peter.maydell@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2MhpOxkVT0dCDWEtQBpoTOjTouka4DvnO
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2e4935ec-febf-6c13-9856-999f3db64bc2@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 0/4] Various improvements to submodule
 handling
References: <20171027131412.18830-1-berrange@redhat.com>
In-Reply-To: <20171027131412.18830-1-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 10/27/2017 03:14 PM, Daniel P. Berrange wrote:
> I've sent a variety of improvements to submodule handling as separate p=
atches
> and its getting slightly confusing. So here is a series with all patche=
s added
> together. I've also included a fix that helps us go backwards in time a=
cross
> the introduction of a submodule.
>=20
> Daniel P. Berrange (4):
>   build: allow setting a custom GIT binary for transparent proxying
>   build: don't create temporary files in source dir
>   build: allow automatic git submodule updates to be disabled
>   build: don't fail if given a git submodule which does not exist

I have some minor comments on a couple of individual patches, but for
the series:
Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
>  Makefile                 | 15 ++++++++++--
>  configure                | 14 +++++++++++-
>  scripts/git-submodule.sh | 59 ++++++++++++++++++++++++++++++++++++++++=
--------
>  3 files changed, 76 insertions(+), 12 deletions(-)
>=20

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2MhpOxkVT0dCDWEtQBpoTOjTouka4DvnO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAln0FvAACgkQp6FrSiUn
Q2q3Iwf+Lo/OyaLwfAPwhWUKDnNz11qW0zs5IOYP3iHlm2B+ozQmbKhknnaaw5LQ
pTnieAiIODsU0KhoEk9ktSwguMGdTzv6PIxD/u6rcfxC8PhC9getPK7i1MyDPIvn
nvCfyuGGUEBqwa5BmH7wSRHqHDmGTqmua1kwKp420Tp++MMQkfEHkuF9UfwiU8oG
G/HgxT1l7pdieFqSlG8gQQPBHL3gEJie6rVrTTFI2z38qDFMeGIHvjEOyL2bwkyR
0LO+3QTSuMRZTECZ8d10Qiz4tpV68gzk84A79M/wcCOnDeDE2NYV3mhMpTBeZOue
CvzjaXq3SW4bXuOS2hOAaVNvhb/I2w==
=s2Gt
-----END PGP SIGNATURE-----

--2MhpOxkVT0dCDWEtQBpoTOjTouka4DvnO--
