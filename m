Received: from eggs.gnu.org ([2001:4830:134:3::10]:44620)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctJUd-0001jk-H7
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:42:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1ctJUc-0008UA-QP
	for qemu-devel@nongnu.org; Wed, 29 Mar 2017 15:42:55 -0400
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
	<1490805920-17029-7-git-send-email-armbru@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <dbf432c4-405c-9197-3795-8f2600edaf38@redhat.com>
Date: Wed, 29 Mar 2017 21:42:44 +0200
MIME-Version: 1.0
In-Reply-To: <1490805920-17029-7-git-send-email-armbru@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="am9LrwvnP2FNxWVdP7TtX2jjDtngRh9KQ"
Subject: Re: [Qemu-devel] [for-2.9 6/8] qapi-schema: SocketAddressFlat
 variants 'vsock' and 'fd'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp, namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com, pbonzini@redhat.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--am9LrwvnP2FNxWVdP7TtX2jjDtngRh9KQ
From: Max Reitz <mreitz@redhat.com>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, mitake.hitoshi@lab.ntt.co.jp,
 namei.unix@gmail.com, jcody@redhat.com, kwolf@redhat.com, eblake@redhat.com,
 pbonzini@redhat.com
Message-ID: <dbf432c4-405c-9197-3795-8f2600edaf38@redhat.com>
Subject: Re: [for-2.9 6/8] qapi-schema: SocketAddressFlat variants 'vsock' and
 'fd'
References: <1490805920-17029-1-git-send-email-armbru@redhat.com>
 <1490805920-17029-7-git-send-email-armbru@redhat.com>
In-Reply-To: <1490805920-17029-7-git-send-email-armbru@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 29.03.2017 18:45, Markus Armbruster wrote:
> Note that the new variants are impossible in qemu_gluster_glfs_init(),
> because the gconf->server can only come from qemu_gluster_parse_uri()
> or qemu_gluster_parse_json(), and neither can create anything but
> 'tcp' or 'unix'.

s/tcp/inet/

> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  block/gluster.c  |  2 ++
>  qapi-schema.json | 19 ++++++++-----------
>  2 files changed, 10 insertions(+), 11 deletions(-)
>=20

Reviewed-by: Max Reitz <mreitz@redhat.com>


--am9LrwvnP2FNxWVdP7TtX2jjDtngRh9KQ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAljcDjQSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AHNEIAILlXJWM29Kb9TbtC2EGkM7Q8iFbks/q
DmPl2Gy4WRYqEAzh2XClU2Mk4i2uDmOKMVbN34JSXHm66ESA8fb/ryD2hz8LhiqQ
ljcFFlALJtJDO2DGe0Vn5jaMdNyZwQyzv7JSmTRUB//40KODKl39uGDaN92G2Twd
hsGZq7WvVAzeTbWhr//onJjeDI6TFIi2ytdrvLLGoWoPZpak2e1BuFdjc9tO0A2y
HTKHguKlhQCtwUScvQ/y9gf3kMS+NjyuYNLqjOT6aiJDY4wwNxv99x2G9ogteTun
FoH4wgQ1IOBoRvLagi4E+CX3H41liTi0xz+SeFHFqP5Kk3Vlbb0Mdvg=
=ORh0
-----END PGP SIGNATURE-----

--am9LrwvnP2FNxWVdP7TtX2jjDtngRh9KQ--
