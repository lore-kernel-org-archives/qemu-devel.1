Received: from eggs.gnu.org ([2001:4830:134:3::10]:33244)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elHjk-0006KN-BE
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:17:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elHjj-0003gq-Jw
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:17:52 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-21-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <fda28df2-28b9-981b-38fd-14211adcf9af@redhat.com>
Date: Mon, 12 Feb 2018 18:17:34 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-21-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="k45a6s3mDKgbiuxYGCxwPrOzikjbzSqMz"
Subject: Re: [Qemu-devel] [PATCH 20/27] ssh: Use QAPI BlockdevOptionsSsh
 object
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com, jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--k45a6s3mDKgbiuxYGCxwPrOzikjbzSqMz
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <fda28df2-28b9-981b-38fd-14211adcf9af@redhat.com>
Subject: Re: [PATCH 20/27] ssh: Use QAPI BlockdevOptionsSsh object
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-21-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-21-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> Create a BlockdevOptionsSsh object in connect_to_ssh() and take the
> options from there. 'host_key_check' is still processed separately
> because it's not in the schema yet.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/ssh.c | 136 +++++++++++++++++++++++++++-------------------------=
--------
>  1 file changed, 61 insertions(+), 75 deletions(-)

You might want to base this patch on Pino's patch to use libssh instead
of libssh2.

Anyway:

Reviewed-by: Max Reitz <mreitz@redhat.com>


--k45a6s3mDKgbiuxYGCxwPrOzikjbzSqMz
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqBzC4SHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A/i8H/AgEMdyEzkVpIc3WCoHI9zpGKkPiu57i
/vt8csIdP1wgrgRwO+UXwlrKJ7Yc/75NPPJj79KGyEOqZQFSoRG0j1SKTU9/ENcg
SjJQ/I93Nw9PSS2ogOxJGRl9CjInTCoaq7aWThq0MrGx7mLR1wzgqbcERfgZEsGt
egoog+8Y8tz6VBZ8iVf0vQtzNOoAf47z2Fo1tWLOqNDvduZwmiOCehyQNmYc4GTW
QvF3j1Ts3JCfKFgdEk2pXX9r5cCVUJK+40I29z8TnRIshTePZbAgU3fmG/9d58F+
SxeLKEAK1LwacahflLtoQJN2VeSbtPGTcWpAuH94JP+121cR+gUEg4E=
=4/kG
-----END PGP SIGNATURE-----

--k45a6s3mDKgbiuxYGCxwPrOzikjbzSqMz--
