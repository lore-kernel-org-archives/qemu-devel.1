Received: from eggs.gnu.org ([2001:4830:134:3::10]:52470)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cikcD-0005x6-TP
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:27:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <eblake@redhat.com>) id 1cikc9-0007sK-UL
	for qemu-devel@nongnu.org; Tue, 28 Feb 2017 11:27:05 -0500
References: <20170228161553.28142-1-jcody@redhat.com>
	<20170228161553.28142-6-jcody@redhat.com>
From: Eric Blake <eblake@redhat.com>
Message-ID: <d24c1aa4-c433-feab-38cf-1e1a82a7a1e8@redhat.com>
Date: Tue, 28 Feb 2017 10:26:49 -0600
MIME-Version: 1.0
In-Reply-To: <20170228161553.28142-6-jcody@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="tGgVQmswfOcLBEw9P71GCgs7uJegTVq2q"
Subject: Re: [Qemu-devel] [PULL 5/5] block/rbd: add support for 'mon_host',
 'auth_supported' via QAPI
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--tGgVQmswfOcLBEw9P71GCgs7uJegTVq2q
From: Eric Blake <eblake@redhat.com>
To: Jeff Cody <jcody@redhat.com>, qemu-block@nongnu.org
Cc: peter.maydell@linaro.org, qemu-devel@nongnu.org
Message-ID: <d24c1aa4-c433-feab-38cf-1e1a82a7a1e8@redhat.com>
Subject: Re: [Qemu-devel] [PULL 5/5] block/rbd: add support for 'mon_host',
 'auth_supported' via QAPI
References: <20170228161553.28142-1-jcody@redhat.com>
 <20170228161553.28142-6-jcody@redhat.com>
In-Reply-To: <20170228161553.28142-6-jcody@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 02/28/2017 10:15 AM, Jeff Cody wrote:
> This adds support for three additional options that may be specified
> by QAPI in blockdev-add:
>=20
>     server: host, port
>     auth method: either 'cephx' or 'none'
>=20
> The "server" and "auth-supported" QAPI parameters are arrays.  To confo=
rm
> with the rados API, the array items are join as a single string with a =
';'
> character as a delimiter when setting the configuration values.
>=20
> Reviewed-by: Markus Armbruster <armbru@redhat.com>

What happened to Signed-off-by? You'll have to resubmit the pull request

> ---
>  block/rbd.c          | 134 +++++++++++++++++++++++++++++++++++++++++++=
++++++++
>  qapi/block-core.json |  29 +++++++++++
>  2 files changed, 163 insertions(+)
>=20


--=20
Eric Blake   eblake redhat com    +1-919-301-3266
Libvirt virtualization library http://libvirt.org


--tGgVQmswfOcLBEw9P71GCgs7uJegTVq2q
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iQEcBAEBCAAGBQJYtaTJAAoJEKeha0olJ0NqvToH+wVbAnPFqWG8etjRFugfXgbM
AlujfvY10P+C5coIZlv7dy57gX92Mx+xR70E9kfhTmu0WIXCsqpg/sTrqhQ1RJsu
X1PZctUiTLd17z4ct2ZsnIriYgXv/H6Znz2WA624GqQe2Cq0o7NxPMoXXnQ58I9x
Wm+iDjQ9SVPWUNPMreln1cDyoCCwexO4UyG3ckXT1w0WuIwElHBM/qRmvPzMEdRB
Zawo997yzFFBHOkN7KRu9F/jN9Bsl3YKi9RXGl6OGPV/Pauyg4z6NfYeR8qvi3jo
PLxfj3NpvxrzkzniOkXqgfzzLPdvQsE3SaFGQWTo6Jy/uRoqh1FkvpjiLdD+MwQ=
=TCgc
-----END PGP SIGNATURE-----

--tGgVQmswfOcLBEw9P71GCgs7uJegTVq2q--
