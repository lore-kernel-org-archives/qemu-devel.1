Received: from eggs.gnu.org ([2001:4830:134:3::10]:35899)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chGQU-0004jW-5K
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:00:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mreitz@redhat.com>) id 1chGQT-00083y-Bw
	for qemu-devel@nongnu.org; Fri, 24 Feb 2017 09:00:50 -0500
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
	<1487689130-30373-35-git-send-email-kwolf@redhat.com>
From: Max Reitz <mreitz@redhat.com>
Message-ID: <851720eb-5be2-f24e-fe30-001e309982cd@redhat.com>
Date: Fri, 24 Feb 2017 15:00:38 +0100
MIME-Version: 1.0
In-Reply-To: <1487689130-30373-35-git-send-email-kwolf@redhat.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="MltqtN04wJfWiAxC5EV9j7DRsAkfpJRe4"
Subject: Re: [Qemu-devel] [PATCH 34/54] block: Add BdrvChildRole.stay_at_node
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
--MltqtN04wJfWiAxC5EV9j7DRsAkfpJRe4
From: Max Reitz <mreitz@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org
Cc: jcody@redhat.com, famz@redhat.com, qemu-devel@nongnu.org
Message-ID: <851720eb-5be2-f24e-fe30-001e309982cd@redhat.com>
Subject: Re: [PATCH 34/54] block: Add BdrvChildRole.stay_at_node
References: <1487689130-30373-1-git-send-email-kwolf@redhat.com>
 <1487689130-30373-35-git-send-email-kwolf@redhat.com>
In-Reply-To: <1487689130-30373-35-git-send-email-kwolf@redhat.com>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable

On 21.02.2017 15:58, Kevin Wolf wrote:
> When the parents' child links are updated in bdrv_append() or
> bdrv_replace_in_backing_chain(), this should affect all child links of
> BlockBackends or other nodes, but not on child links held for other
> purposes (like for setting permissions). This patch allows to control
> the behaviour per BdrvChildRole.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block.c                   | 3 +++
>  include/block/block_int.h | 4 ++++
>  2 files changed, 7 insertions(+)

Reviewed-by: Max Reitz <mreitz@redhat.com>


--MltqtN04wJfWiAxC5EV9j7DRsAkfpJRe4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQFGBAEBCAAwFiEEkb62CjDbPohX0Rgp9AfbAGHVz0AFAliwPIYSHG1yZWl0ekBy
ZWRoYXQuY29tAAoJEPQH2wBh1c9AYQIH/056JxJeSzP/Xgle86Sp/euHVUG5XnJw
Yu7jIBzyeDHsNv+5DHkpGxyU3zI64VuO+LiuMwhkU2crAuNGqwaHhDiIEpHSOBre
IV77OwTqH+edbvX0bvz19mXgon8ykXqFAv6z63iIvSiAWgfp4JgeDltoJIdV7HAc
vQ6bO592zfx2/LO2ldu45pu1uUQCPW6qjL/DWlKW83P/EvQthI181GSKtXmAAxYz
LJCgmf06nY+21RLGU+1apGvatMnbdxzn5WcFeHcxz2UzyMHnGzQqZ+MexHGrJe6x
1skgEtJl2aWQRiDwf+XDdFdIddHHLKCci5MMZa9lUZSz/tNdjCAi0BY=
=th12
-----END PGP SIGNATURE-----

--MltqtN04wJfWiAxC5EV9j7DRsAkfpJRe4--
