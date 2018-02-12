Received: from eggs.gnu.org ([2001:4830:134:3::10]:48903)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elI0v-0003tV-BP
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:35:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1elI0u-0008Om-It
	for qemu-devel@nongnu.org; Mon, 12 Feb 2018 12:35:37 -0500
References: <20180208192328.16550-1-kwolf@redhat.com>
	<20180208192328.16550-23-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <9fb034c5-6064-29c2-24f0-998d9d6eef9e@redhat.com>
Date: Mon, 12 Feb 2018 18:35:16 +0100
MIME-Version: 1.0
In-Reply-To: <20180208192328.16550-23-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="0wbKZsu2NdwxBy9ltJ5hBwh6HEOP6r8Oo"
Subject: Re: [Qemu-devel] [PATCH 22/27] ssh: Pass BlockdevOptionsSsh to
 connect_to_ssh()
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
--0wbKZsu2NdwxBy9ltJ5hBwh6HEOP6r8Oo
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: pkrempa@redhat.com, eblake@redhat.com, jcody@redhat.com,
 jdurgin@redhat.com, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com,
 qemu-devel@nongnu.org
Message-ID: <9fb034c5-6064-29c2-24f0-998d9d6eef9e@redhat.com>
Subject: Re: [PATCH 22/27] ssh: Pass BlockdevOptionsSsh to connect_to_ssh()
References: <20180208192328.16550-1-kwolf@redhat.com>
 <20180208192328.16550-23-kwolf@redhat.com>
In-Reply-To: <20180208192328.16550-23-kwolf@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 2018-02-08 20:23, Kevin Wolf wrote:
> Move the parsing of the QDict options up to the callers, in preparation=

> for the .bdrv_co_create implementation that directly gets a QAPI type.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/ssh.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--0wbKZsu2NdwxBy9ltJ5hBwh6HEOP6r8Oo
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlqB0FUSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AL7kH/3ysFzcTD6dJayW2sDrbQY7xpYQt8nyX
lPTtRjDh/0eOVGgWBUDtcZFd4lpEftIAuP8GvpGqBWgMYGA0zbEqYYbRTJOGBF1e
0fxzrcbnd80IVJ72iiDDDLYaVTb1kWgqyzGsv6dC9lL9Yw+wdNrTUFSBPwg6yXHq
VzIQifCifN0qzw3X+Ip0jWbL7l1t2B/gTaEcfvUFTZSGDmE5WHGWgsORsvvD6AEZ
zYZAA/GjaBQwb3imNrSxHqHM8bbI2r9ybB8QHxGU9KLtISsPXYbD8jvFHVqOvxW3
/rYjW4pbNZ5HnCB/bVQdXVHJQxP57nhAg9OSQL26Ck8/HrtS2PBJveo=
=l6Zy
-----END PGP SIGNATURE-----

--0wbKZsu2NdwxBy9ltJ5hBwh6HEOP6r8Oo--
