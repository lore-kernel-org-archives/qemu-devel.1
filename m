Received: from eggs.gnu.org ([2001:4830:134:3::10]:33447)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnmst-0000BX-9G
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:25:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dnmso-0000sD-FR
	for qemu-devel@nongnu.org; Fri, 01 Sep 2017 10:25:23 -0400
References: <20170901105434.3288-1-berrange@redhat.com>
	<20170901105434.3288-3-berrange@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <34c1bda5-90bb-a79a-8cf3-c680ea05ed6c@redhat.com>
Date: Fri, 1 Sep 2017 09:25:04 -0500
MIME-Version: 1.0
In-Reply-To: <20170901105434.3288-3-berrange@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="2Oxkn1uxG2drr2qrS3FmwdSXX3FQXWluE"
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: blacklist 194 with the luks
 driver
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--2Oxkn1uxG2drr2qrS3FmwdSXX3FQXWluE
From: Eric Blake <eblake@redhat.com>
To: "Daniel P. Berrange" <berrange@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fam Zheng <famz@redhat.com>
Message-ID: <34c1bda5-90bb-a79a-8cf3-c680ea05ed6c@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] iotests: blacklist 194 with the luks
 driver
References: <20170901105434.3288-1-berrange@redhat.com>
 <20170901105434.3288-3-berrange@redhat.com>
In-Reply-To: <20170901105434.3288-3-berrange@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 09/01/2017 05:54 AM, Daniel P. Berrange wrote:
> The 194 test has alot of code that assumes a simple image file. Rewriti=
ng

s/alot/a lot/

> this to work with luks is possible, but non-trivial, so blacklist the
> luks format for now.
>=20
> Signed-off-by: Daniel P. Berrange <berrange@redhat.com>
> ---
>  tests/qemu-iotests/194        | 1 +
>  tests/qemu-iotests/iotests.py | 4 +++-
>  2 files changed, 4 insertions(+), 1 deletion(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--2Oxkn1uxG2drr2qrS3FmwdSXX3FQXWluE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmpbcAACgkQp6FrSiUn
Q2rNbwf8CnzCSxNMMMe3aF1dTFWITGDQkVt5e7OlPIv/XOpMCdg2g4SQtm1BXomw
H/8/kbcXKcbH87dXva/YiCEc7m1nKksUbYimqznXlYPdmuhz30y1ZduCaGrRwfLe
k+mHX8olp1M9Tv8AnCwEvwrVKQ3JW9ZajJhwXC+1DS1gxL1R7HTIFHFSBNu6vWh0
7hPWlyk160e/ExXnnkedbMZ5/yHaUKKnR31p0HxUj/ZH440+cig5lmnXUaRi2u1j
mIa+DZ4Xwc8vGfT0YQgNVJx6iO0xvrVXO/ZqWKEW1XP/0GQdweZT3WdJ1qr0ezu2
uCETl+kFOvn7mzFVqTa49lKq5EZUWA==
=zEwv
-----END PGP SIGNATURE-----

--2Oxkn1uxG2drr2qrS3FmwdSXX3FQXWluE--
