Received: from eggs.gnu.org ([2001:4830:134:3::10]:51375)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fa0cL-0002mA-Sb
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:19:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fa0cG-0004EL-Vg
	for qemu-devel@nongnu.org; Mon, 02 Jul 2018 11:19:53 -0400
Date: Mon, 2 Jul 2018 16:19:45 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180702151945.GK2155@stefanha-x1.localdomain>
References: <20180702025836.20957-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HTLCc13+3hfAZ6SL"
Content-Disposition: inline
In-Reply-To: <20180702025836.20957-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 0/4] block: Trivial fixes in
 offloading code
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>


--HTLCc13+3hfAZ6SL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 02, 2018 at 10:58:32AM +0800, Fam Zheng wrote:
> These are the low priority ones spotted by Kevin and Max last week.
>=20
> Fam Zheng (4):
>   qcow2: Drop unused cluster_data
>   file-posix: Fix fd_open check in raw_co_copy_range_to
>   qcow2: Drop unreachable break
>   raw: Drop superfluous semicolon
>=20
>  block/file-posix.c | 2 +-
>  block/qcow2.c      | 3 ---
>  block/raw-format.c | 2 +-
>  3 files changed, 2 insertions(+), 5 deletions(-)
>=20
> --=20
> 2.17.1
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--HTLCc13+3hfAZ6SL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbOkKRAAoJEJykq7OBq3PIW0oIAMGVaDQjzfsPmWVxaJvWp1Bj
pDX5khnIZJZBGDMEQkhyb4byshPt0BsiDCSGkQjeHTKUm+K0bvNgqlP/9j2dgGi5
JLFWxpGT4ga13j9GBXSbJ/NViMSiYpeu1klK8ZCdSu7iGyC5KcAyOooZ5iIl5794
7GPXBDWRFxaoUvK5AF6vZdQAk2Iqpt10K1u5J1oZQNG+r6fQRbFKIA59ftHK6q0c
P8lh62kvFCXOBX1ca+XVhwKjsH3HmnY8F6hZp849iJich5wsunssVC+WKAWJ+XMn
B4jvWdy6GbArUvcKyIK8pp0S0Gym29mwOY83c+jqm4323i0gJzv0mAdqICl26MA=
=+2hs
-----END PGP SIGNATURE-----

--HTLCc13+3hfAZ6SL--
