Received: from eggs.gnu.org ([2001:4830:134:3::10]:45772)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkWwb-0005Jh-Ij
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:47:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1dkWwa-0007HD-Lx
	for qemu-devel@nongnu.org; Wed, 23 Aug 2017 10:47:45 -0400
References: <20170823140506.28723-1-stefanha@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <913181d2-3fd3-0e8f-f26d-1ce6ca1425e8@redhat.com>
Date: Wed, 23 Aug 2017 09:47:31 -0500
MIME-Version: 1.0
In-Reply-To: <20170823140506.28723-1-stefanha@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="3rEDNJvWwHElhm5X46FmDQjJjJxR0qkH1"
Subject: Re: [Qemu-devel] [PATCH] qemu-iotests: add 194 non-shared storage
 migration test
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org, Fam Zheng <famz@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--3rEDNJvWwHElhm5X46FmDQjJjJxR0qkH1
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <famz@redhat.com>
Message-ID: <913181d2-3fd3-0e8f-f26d-1ce6ca1425e8@redhat.com>
Subject: Re: [PATCH] qemu-iotests: add 194 non-shared storage migration test
References: <20170823140506.28723-1-stefanha@redhat.com>
In-Reply-To: <20170823140506.28723-1-stefanha@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/23/2017 09:05 AM, Stefan Hajnoczi wrote:
> Non-shared storage migration with NBD and drive-mirror is currently not=

> tested by qemu-iotests.  This test case covers the basic migration
> scenario.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> Based-on: <20170823134242.12080-1-famz@redhat.com>
> ---
>  tests/qemu-iotests/194        | 73 +++++++++++++++++++++++++++++++++++=
++++++++
>  tests/qemu-iotests/194.out    | 13 ++++++++
>  tests/qemu-iotests/group      |  1 +
>  tests/qemu-iotests/iotests.py | 13 ++++++++
>  4 files changed, 100 insertions(+)
>  create mode 100755 tests/qemu-iotests/194
>  create mode 100644 tests/qemu-iotests/194.out

Tested-by: Eric Blake <eblake@redhat.com>

Placing on my queue for a 2.10-rc4 NBD pull request

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--3rEDNJvWwHElhm5X46FmDQjJjJxR0qkH1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmdlYMACgkQp6FrSiUn
Q2qYiQf/WJlpM2E+xIKhcO2j0rotTgotox5PZf70v6Ofu0QUW5teulI9vB3J9KFX
yQLXMfy3iravjlMCo+eOJ0of2TL2jIZT1prmOk0eIMo2VCo44cqCnWJLe8DnTZrP
dBQ5zodSPMUviuX271hYMRwMze6RmTyrP9/v8xCT8rqz2hcrGb4PA2F1SPDfsFpr
hGY0F3dEpi0hf/PgZEz99Tw8WiFicuzwD+oif/g4s6Tmj/N8tUa41X/cmjDij7ZZ
QWTcIlQ85IcOBRQao2jY37Wyb3NrD8DRgBdEgWA87HCXt5tNDDLml199heiCNuCl
wVwLPa0it0xx+80RbyBC3ZixVQmlPw==
=u8ny
-----END PGP SIGNATURE-----

--3rEDNJvWwHElhm5X46FmDQjJjJxR0qkH1--
