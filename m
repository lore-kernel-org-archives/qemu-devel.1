Received: from eggs.gnu.org ([2001:4830:134:3::10]:50205)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQuII-0002zq-3Z
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:45:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fQuIE-0008Dm-9F
	for qemu-devel@nongnu.org; Thu, 07 Jun 2018 08:45:34 -0400
Date: Thu, 7 Jun 2018 13:45:27 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180607124527.GK19032@stefanha-x1.localdomain>
References: <20180605140631.4696-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="5dNcufZ4prhark0F"
Content-Disposition: inline
In-Reply-To: <20180605140631.4696-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 0/2] backup: Use copy offloading
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>


--5dNcufZ4prhark0F
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 05, 2018 at 10:06:29PM +0800, Fam Zheng wrote:
> Based-on: <20180529055959.32002-1-famz@redhat.com>
> ([PATCH v7 00/10] qemu-img convert with copy offloading)
>=20
> This enhances the backup job to make use of the copy offloading API. It
> eliminates the necessity to use the bounce buffer as well as speeding up =
the
> copy operation when the backend supports it.
>=20
> v3: Don't forget coroutine_fn. [Stefan]
>     Don't reset job->use_copy_range redundantly. [Stefan]
>=20
> v2: Use helper functions. [Stefan]
>=20
> Fam Zheng (2):
>   block: Honour BDRV_REQ_NO_SERIALISING in copy range
>   backup: Use copy offloading
>=20
>  block/backup.c        | 150 ++++++++++++++++++++++++++++++------------
>  block/io.c            |   6 +-
>  block/trace-events    |   1 +
>  include/block/block.h |   5 +-
>  4 files changed, 117 insertions(+), 45 deletions(-)
>=20
> --=20
> 2.17.0
>=20
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--5dNcufZ4prhark0F
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbGSjnAAoJEJykq7OBq3PIidMIAI9fM17e/AK7DMjAvNqyA6l0
KaJv4R8zi0Pva8ZEsplAKmZ4pko312GXCH0j0qZ5wn+PIdtczfH1reej8Wa2uBdO
2gPXPjLBbGVhuN4AkBfnjQh35rNvVdNhU1p5LjQfpmqEWPm+tT8qQZetqz7OuP8N
fePTIgCFzFejDnoMKLJxPwQv8O1pDhZWzKR2Wc5hnVIKgZBZo6C8pI0v9TvcenwE
sjDjdJISprnCnlPtoJgdLxCJr7n9tkr05iq6igRU7OzObPtiVEidUZCEm4Yx+q2L
g8bbSmlJnCddjXEGMDiA5LaBveSQ4bNl2XQ+yMMXUHfWRTcaq1b/WgBZ7WkJUGk=
=YOYu
-----END PGP SIGNATURE-----

--5dNcufZ4prhark0F--
