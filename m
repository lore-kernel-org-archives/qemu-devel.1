Received: from eggs.gnu.org ([2001:4830:134:3::10]:40530)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWrNF-0003yR-P0
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:19:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1eWrNE-0003gD-HV
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 17:19:01 -0500
References: <20171225025107.23985-1-famz@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <270e884b-9a6a-3902-b9d4-4e4635d73fec@redhat.com>
Date: Wed, 3 Jan 2018 16:18:50 -0600
MIME-Version: 1.0
In-Reply-To: <20171225025107.23985-1-famz@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="pw3MarJnw28eBxwZ8Vg7Uc9CqKmz12Z1e"
Subject: Re: [Qemu-devel] [PATCH v2] iotests: Test creating overlay when
 guest running
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--pw3MarJnw28eBxwZ8Vg7Uc9CqKmz12Z1e
From: Eric Blake <eblake@redhat.com>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>,
 qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>
Message-ID: <270e884b-9a6a-3902-b9d4-4e4635d73fec@redhat.com>
Subject: Re: [PATCH v2] iotests: Test creating overlay when guest running
References: <20171225025107.23985-1-famz@redhat.com>
In-Reply-To: <20171225025107.23985-1-famz@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 12/24/2017 08:51 PM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> ---
>=20
> v2: Actually test the thing. [Kevin]
> ---
>  tests/qemu-iotests/153     | 8 +++++---
>  tests/qemu-iotests/153.out | 7 ++++---
>  2 files changed, 9 insertions(+), 6 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

>=20
> diff --git a/tests/qemu-iotests/153 b/tests/qemu-iotests/153
> index fa25eb24bd..adfd02695b 100755
> --- a/tests/qemu-iotests/153
> +++ b/tests/qemu-iotests/153
> @@ -32,6 +32,7 @@ _cleanup()
>  {
>      _cleanup_test_img
>      rm -f "${TEST_IMG}.base"
> +    rm -f "${TEST_IMG}.overlay"

Trivial conflict with Jeff's work to do per-test temporary directories
in iotests.

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--pw3MarJnw28eBxwZ8Vg7Uc9CqKmz12Z1e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlpNVsoACgkQp6FrSiUn
Q2oZgQf/Ttndk9r+EdzXwv6GVUKrZz1u6CZTCx1Fhbv7hafcZvkqexmy5QMq8f85
YDwMTqZfUuJeInxnepoO52fcPyhi4cxP14x08kturpFspF/KKccr70wcrK0MyFnM
j1t2Buwrrlw6+5/CZ9BAL0Q+uOjlUd4LHNV/s0TjP4Iy/0lcpwu9m/2xhCep2teM
bo+WEoOlxx87k8rL+xWpKc0w72WJbrIfsJENqkdfiI8Xy7A2Rc/VuLuJpRVR2Kwv
QJpJW3hax/f2W8C5tN2nrfd4OKaC59OcVIMGobnA7ZNdnUl2WNaoOw1WyLA3iouj
LxusyNnMENEZMCWWqZcq6YWbBrTe8g==
=alQc
-----END PGP SIGNATURE-----

--pw3MarJnw28eBxwZ8Vg7Uc9CqKmz12Z1e--
