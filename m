Received: from eggs.gnu.org ([2001:4830:134:3::10]:43488)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chcrg-0002c6-V1
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 08:58:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chcrg-0000GI-56
	for qemu-devel@nongnu.org; Sat, 25 Feb 2017 08:58:25 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-44-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <cbdd7228-8eed-6e3e-112a-b289af9f446d@redhat.com>
Date: Sat, 25 Feb 2017 14:58:15 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-44-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="t4OaofF6u5UaukaeHx23SB1dGne60I2n9"
Subject: Re: [Qemu-devel] [PATCH 43/54] stream: Use real permissions in
 streaming block job
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--t4OaofF6u5UaukaeHx23SB1dGne60I2n9
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <cbdd7228-8eed-6e3e-112a-b289af9f446d@redhat.com>
Subject: Re: [PATCH 43/54] stream: Use real permissions in streaming block job
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-44-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-44-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> The correct permissions are relatively obvious here (and explained in
> code comments). For intermediate streaming, we need to reopen the top
> node read-write before creating the job now because the permissions
> system catches attempts to get the BLK_PERM_WRITE_UNCHANGED permission
> on a read-only node.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/stream.c | 37 +++++++++++++++++++++++++------------
>  1 file changed, 25 insertions(+), 12 deletions(-)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--t4OaofF6u5UaukaeHx23SB1dGne60I2n9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAlixjXcSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9A36EH/jV0qr5oRzERVBpfqwJCWGpQL+fiaPgI
Zob9imJ9BzCz4J4AXZxc71gYWO1w4FvPfWA0wihl2NxSete6tEdgpc7sqqziilvh
DOZmfYiQDnoTJJIBLnP4LDk83wPdyeZILSHoYh+IzJmZaz9AIBo2Tv+eu8t0UO0g
963FoAhg3FQRDU5RZefk3yPCPBsGKefyUzji5NkGyBO07vpKBqdI2GTf+bCLs0Xv
IkevTVGowvXl9LZenTt4xRqKeVdnO6PJ9g/41V6GL6njlNFVZfRe+eO0qKIDBPnw
2vdomaqca20rdJIItAEjdb86q6k4C2nNuujPDZhX0K52p1r0odN+/o0=
=4sSM
-----END PGP SIGNATURE-----

--t4OaofF6u5UaukaeHx23SB1dGne60I2n9--
