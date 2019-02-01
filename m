Received: from eggs.gnu.org ([209.51.188.92]:33480)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpdx1-000106-TB
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:54:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1gpdnS-0006Ub-P6
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:44:15 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55068)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <eblake@redhat.com>) id 1gpdnS-0006Tm-FH
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 13:44:14 -0500
References: <20190123114220.16972-1-alex.bennee@linaro.org>
From: Eric Blake <eblake@redhat.com>
Message-ID: <39aa1e09-ecb9-b795-9ec2-1835a40edd20@redhat.com>
Date: Fri, 1 Feb 2019 12:44:12 -0600
MIME-Version: 1.0
In-Reply-To: <20190123114220.16972-1-alex.bennee@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pzAGQ8GYqhOUcpxyEwR81EewuvSu0Yw2K"
Subject: Re: [Qemu-devel] [PULL v2 00/11] check-softfloat,
 fp-bench and clang compile fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>, peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pzAGQ8GYqhOUcpxyEwR81EewuvSu0Yw2K
From: Eric Blake <eblake@redhat.com>
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 peter.maydell@linaro.org
Cc: qemu-devel@nongnu.org
Message-ID: <39aa1e09-ecb9-b795-9ec2-1835a40edd20@redhat.com>
Subject: Re: [Qemu-devel] [PULL v2 00/11] check-softfloat, fp-bench and clang
 compile fixes
References: <20190123114220.16972-1-alex.bennee@linaro.org>
In-Reply-To: <20190123114220.16972-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/23/19 5:42 AM, Alex Benn=C3=A9e wrote:
> The following changes since commit 952bc8b3c2cbba78261923a1e8ca55cda261=
dee9:
>=20
>   Merge remote-tracking branch 'remotes/ericb/tags/pull-nbd-2019-01-21'=
 into staging (2019-01-22 17:56:21 +0000)
>=20
> are available in the Git repository at:
>=20
>   https://github.com/stsquad/qemu.git tags/pull-fpu-next-230119-2
>=20
> for you to fetch changes up to 7617010250822677348af2bd98f048be10e7f334=
:
>=20
>   tests/Makefile: add check-softfloat rule (2019-01-23 08:30:01 +0000)
>=20
> ----------------------------------------------------------------
> Some more softfloat/fpu fixes
>=20
>    - make check-softfloat
>    - fixes for fp-bench
>    - workaround broken host fma
>    - compile fix for s390x/clang
>    - fixed for bigendian (v2)
>    - minor makefile tweaks (v2)

I think this series is the reason that an in-tree 'make && make check &&
git status' is now showing a bunch of untracked files:

	tests/fp/add.out
	tests/fp/div.out
	tests/fp/eq.out
=2E..

I suggest a followup patch to amend a .gitignore for tests/fp/*.out

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3226
Virtualization:  qemu.org | libvirt.org


--pzAGQ8GYqhOUcpxyEwR81EewuvSu0Yw2K
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlxUk3wACgkQp6FrSiUn
Q2pUWwf/W7l45azzfTLIiK61GtpovoOkAyOzCqYQQjqXCAv1kJUG+VIPE9u21ghI
SNhr6p5Qwpn7OBiRBkaVR70YpzoAEIuzj/156X1CM7PUACjza5LbKajwlsuiSSAd
T2Xqn0T0p7+4BnXrZ2mgHXV9LqrU7qklF9w6/zv1n+73ntWe1OWBQTARVfM7skK1
WERAqiQokPXqG1NlOSn6DIFH1/2ktpLOcn65CzA1TVzkQ76a1ROcPNc5wB4US2nQ
GR9aG27yXNuiZ4Gai9N9LAR5LCwySO5qs9zbVyjmgC6Zbsz4xjA7xVWDP/JGouby
IhfPYEEXDBAWyn63842o3+i890gb9w==
=mmHO
-----END PGP SIGNATURE-----

--pzAGQ8GYqhOUcpxyEwR81EewuvSu0Yw2K--
