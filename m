Received: from eggs.gnu.org ([2001:4830:134:3::10]:40571)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fJFSL-0007Fm-5I
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:44:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fJFSK-0005hA-GB
	for qemu-devel@nongnu.org; Thu, 17 May 2018 05:44:17 -0400
Date: Thu, 17 May 2018 10:44:06 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180517094406.GA18718@stefanha-x1.localdomain>
References: <20180511120823.7892-1-famz@redhat.com>
	<20180511120823.7892-2-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Nq2Wo0NMKNjxTN9z"
Content-Disposition: inline
In-Reply-To: <20180511120823.7892-2-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 01/10] block: Introduce API for copy
 offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Peter Lieven <pl@kamp.de>, Kevin Wolf <kwolf@redhat.com>, Max Reitz <mreitz@redhat.com>, eblake@redhat.com


--Nq2Wo0NMKNjxTN9z
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, May 11, 2018 at 08:08:14PM +0800, Fam Zheng wrote:
> Introduce the bdrv_co_copy_range() API for copy offloading.  Block
> drivers implementing this API support efficient copy operations that
> avoid reading each block from the source device and writing it to the
> destination devices.  Examples of copy offload primitives are SCSI
> EXTENDED COPY and Linux copy_file_range(2).
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  block/io.c                | 96 +++++++++++++++++++++++++++++++++++++++++=
++++++
>  include/block/block.h     | 32 ++++++++++++++++
>  include/block/block_int.h | 38 +++++++++++++++++++
>  3 files changed, 166 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Nq2Wo0NMKNjxTN9z
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa/U7lAAoJEJykq7OBq3PIfy4H/iUPPgr5X1ZWbxEamNWQn0Po
/l3Xc+SGHEx6jpast6p75EwsObcuzv5QevmrcTWcjdfImQpGIyGakxYDxs3bq8Of
3wcbz3JzyC45Zkv73tCx/Mo0nS369qTPCUqNwkx1QtzQ8HSbLYe1muUjHXJh3hEc
CGbw5wfyDHzGDAl2DioCz5oYu/s3qAs6EY3NzVjSWszqSzq/xkpa2oWbyq+xbale
LMWV0iA11Nglyh7WrgG794ZbzuLIi5b9Ud2joMU30GL83pErIV7MoxgYLPwp45Qd
wngT5uggUE8NgUGBjQOeV7CFvAkwyWRfvTFhMHGeNask34DVlcJriKWB000knkw=
=eiw+
-----END PGP SIGNATURE-----

--Nq2Wo0NMKNjxTN9z--
