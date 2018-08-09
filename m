Received: from eggs.gnu.org ([2001:4830:134:3::10]:36585)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntit-0005XF-Go
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:48:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1fntis-0004kH-LK
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 18:48:03 -0400
References: <20180809223117.7846-1-mreitz@redhat.com>
	<20180809223117.7846-7-mreitz@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <c89a1b04-da17-5bd8-88c9-5f3748f4f97c@redhat.com>
Date: Fri, 10 Aug 2018 00:47:54 +0200
MIME-Version: 1.0
In-Reply-To: <20180809223117.7846-7-mreitz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="xvGhxtnOkcDdVFZeuG4O3hhWWNwjTRYED"
Subject: Re: [Qemu-devel] [PATCH v2 06/11] iotests: Add tests for mirror
 @replaces loops
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--xvGhxtnOkcDdVFZeuG4O3hhWWNwjTRYED
From: Max Reitz <mreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>
Message-ID: <c89a1b04-da17-5bd8-88c9-5f3748f4f97c@redhat.com>
Subject: Re: [PATCH v2 06/11] iotests: Add tests for mirror @replaces loops
References: <20180809223117.7846-1-mreitz@redhat.com>
 <20180809223117.7846-7-mreitz@redhat.com>
In-Reply-To: <20180809223117.7846-7-mreitz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-08-10 00:31, Max Reitz wrote:
> This adds two tests for cases where our old check_to_replace_node()
> function failed to detect that executing this job with these parameters=

> would result in a cyclic graph.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  tests/qemu-iotests/041     | 124 +++++++++++++++++++++++++++++++++++++=

>  tests/qemu-iotests/041.out |   4 +-
>  2 files changed, 126 insertions(+), 2 deletions(-)

Sometimes, I hate myself a little bit.  I totally forgot to run the test
with QED.

So:

> diff --git a/tests/qemu-iotests/041 b/tests/qemu-iotests/041
> index c20ac7da87..186bd0f031 100755
> --- a/tests/qemu-iotests/041
> +++ b/tests/qemu-iotests/041
> @@ -1061,5 +1061,129 @@ class TestOrphanedSource(iotests.QMPTestCase):

[...]

> +                        'driver': 'qcow2',

[...]

> +                            'driver': 'qcow2',

[...]

> +                    'driver': 'qcow2',

Imagine these to be "'driver': iotests.imgfmt".  With that, it passes.
(I won't send a v3 specifically for this, but it will be included in v3.
Eventually.)

Max


--xvGhxtnOkcDdVFZeuG4O3hhWWNwjTRYED
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAltsxJoACgkQ9AfbAGHV
z0BBbgf+Mct6YES3jzafTT1qSXHf+YezBW5v6ODPdOH0j68Yld6MDDtb2Dqg4cTZ
zVvZPFQSDrLjpU/e2Bjo3BnHVaUIVKIiSeDxElRldYYwyMomMFWTAsebXUpNBirE
Logr7ZdgR0emi2xhxFFelE4XNVNtmtT26TQRy2ZmkxeWwAfQktdai2PyeKsHTDyA
FfyxUrH0ftoo2fC5GkSJKgQp3CTm9PDgPvP9VYLGfMSJbWRoVq0UpfafahPFyPcc
F1iJWIL+LGah7bSmhVyC8DHi17SMLN7pNMuKnITQfUCN1Ycu2EO5VDY1aBqxoy+5
rkCcurptFgjvb5ISBIKesobByxT1mA==
=FrBL
-----END PGP SIGNATURE-----

--xvGhxtnOkcDdVFZeuG4O3hhWWNwjTRYED--
