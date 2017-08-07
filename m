Received: from eggs.gnu.org ([2001:4830:134:3::10]:34970)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1degAA-00036b-Cf
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:25:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1degA9-0004uM-51
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 07:25:34 -0400
References: <cover.1502075213.git.jcody@redhat.com>
	<85fe374c783a6d659bc86aa7f15d5f442b9d7a45.1502075213.git.jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <4931a9d1-9eb4-7cc4-899e-4568db123073@redhat.com>
Date: Mon, 7 Aug 2017 06:25:24 -0500
MIME-Version: 1.0
In-Reply-To: <85fe374c783a6d659bc86aa7f15d5f442b9d7a45.1502075213.git.jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="B6pXu0a34w8rKeREH2uh8PrB6xablED5v"
Subject: Re: [Qemu-devel] [PATCH 1/2] block/vhdx: check error return of
 bdrv_getlength()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, qemu-block@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--B6pXu0a34w8rKeREH2uh8PrB6xablED5v
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-devel@nongnu.org
Cc: armbru@redhat.com, qemu-block@nongnu.org
Message-ID: <4931a9d1-9eb4-7cc4-899e-4568db123073@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] block/vhdx: check error return of
 bdrv_getlength()
References: <cover.1502075213.git.jcody@redhat.com>
 <85fe374c783a6d659bc86aa7f15d5f442b9d7a45.1502075213.git.jcody@redhat.com>
In-Reply-To: <85fe374c783a6d659bc86aa7f15d5f442b9d7a45.1502075213.git.jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 08/06/2017 10:08 PM, Jeff Cody wrote:
> Calls to bdrv_getlength() were not checking for error.  In vhdx.c, this=

> can lead to truncating an image file, so it is a definite bug.  In
> vhdx-log.c, the path for improper behavior is less clear, but it is bes=
t
> to check in any case.
>=20
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Jeff Cody <jcody@redhat.com>
> ---
>  block/vhdx-log.c | 20 ++++++++++++++++----
>  block/vhdx.c     |  9 ++++++++-
>  2 files changed, 24 insertions(+), 5 deletions(-)

Reviewed-by: Eric Blake <eblake@redhat.com>

--=20
Eric Blake, Principal Software Engineer
Red Hat, Inc.           +1-919-301-3266
Virtualization:  qemu.org | libvirt.org


--B6pXu0a34w8rKeREH2uh8PrB6xablED5v
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEzBAEBCAAdFiEEccLMIrHEYCkn0vOqp6FrSiUnQ2oFAlmITiQACgkQp6FrSiUn
Q2oLCgf/bawB9ttvAmS1peVSMc3xIV9c2pID175Uw4bZyNkFheIHE9b+8ItiqHcW
BryKj/Em2+x+9Eq9LXBoEeE9EfJjovJQQHfVCm8m9YKmkEEuUHiuVDZYjpAUzZiX
WfobZxwWeaHm1uaAqZBOMaBYp/bVWjYbqn2Bw7RgYBjZ9DC2/GodjPAX/5uKsmCz
ucBuxsU/ImL0hc3T6x8mZpxgLxfa4DuEbqSOkg/yFl9KyTKYcpSRnL63HqJhSwxG
7vvS9D+DQ+wlzYkDdABYjhaXco3CHxbahR44rI3J+FVdSsmRNp3FHqomfdOCY364
8y/1Vr9RBAnue5yeBZQEAR/ymYoerw==
=FMx0
-----END PGP SIGNATURE-----

--B6pXu0a34w8rKeREH2uh8PrB6xablED5v--
