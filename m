Received: from eggs.gnu.org ([2001:4830:134:3::10]:59112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cyfXx-0000W4-PJ
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:16:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cyfXw-0003ZU-Te
	for qemu-devel@nongnu.org; Thu, 13 Apr 2017 10:16:29 -0400
Date: Thu, 13 Apr 2017 15:16:17 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170413141617.GD13387@stefanha-x1.localdomain>
References: <1492050868-16200-1-git-send-email-lidongchen@tencent.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/unnNtmY43mpUSKx"
Content-Disposition: inline
In-Reply-To: <1492050868-16200-1-git-send-email-lidongchen@tencent.com>
Subject: Re: [Qemu-devel] [PATCH v6] migration/block: use blk_pwrite_zeroes
 for each zero cluster
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jemmy858585@gmail.com
Cc: qemu-devel@nongnu.org, famz@redhat.com, quintela@redhat.com, dgilbert@redhat.com, qemu-block@nongnu.org, Lidong Chen <lidongchen@tencent.com>


--/unnNtmY43mpUSKx
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 13, 2017 at 10:34:28AM +0800, jemmy858585@gmail.com wrote:
> From: Lidong Chen <lidongchen@tencent.com>
>=20
> BLOCK_SIZE is (1 << 20), qcow2 cluster size is 65536 by default,
> this may cause the qcow2 file size to be bigger after migration.
> This patch checks each cluster, using blk_pwrite_zeroes for each
> zero cluster.
>=20
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
> Signed-off-by: Lidong Chen <lidongchen@tencent.com>
> ---
> v6 changelog:
> Fix up some grammar in the comment.
> ---
>  migration/block.c | 35 +++++++++++++++++++++++++++++++++--
>  1 file changed, 33 insertions(+), 2 deletions(-)

I fixed the following gcc warning when merging the patch:

  migration/block.c:958:25: error: =E2=80=98cluster_size=E2=80=99 may be us=
ed uninitialized in this function [-Werror=3Dmaybe-uninitialized]
                            buffer_is_zero(cur_buf, cluster_size)) {

Thanks, applied to my block-next tree:
https://github.com/stefanha/qemu/commits/block-next

Stefan

--/unnNtmY43mpUSKx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJY74gxAAoJEJykq7OBq3PIoKwH/3aSGHa6lizxsPx2tEX2CfdQ
Vx/Xlx+x0LteLMuwkJeBLqFgPkq5r3+pY2DTNutxQtoBzPfpuG46n0G4NHcpOOiI
mTeNLvY+IwbMz5XR3gdhs0ZCa195AQ+bSR2frUYaL7HRlyvz67JspELSRjrdmf5M
yM3Qlfc9MSl0o2qVc2Q+H21S6Ys/nf06+h+ViZaJgqFZq/Cu/F2IKtkysx0ChZrx
k+PoFs9uwALOiWbysFss7uTYAK/iGsqS2i+PN+w6E0tN9JdzRjLqdJxWawfLB6Qv
d/qQEEEgNeZohQX9IrhFmTEzxjH9nGTMD24aRUL9ylShKsZ8/5sqA9DTOj5wPTs=
=DSRp
-----END PGP SIGNATURE-----

--/unnNtmY43mpUSKx--
