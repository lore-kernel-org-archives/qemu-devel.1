Received: from eggs.gnu.org ([2001:4830:134:3::10]:40825)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGhZI-000824-Il
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:08:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1fGhZH-0007jz-PP
	for qemu-devel@nongnu.org; Thu, 10 May 2018 05:08:56 -0400
Date: Thu, 10 May 2018 10:08:49 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180510090849.GK1296@stefanha-x1.localdomain>
References: <20180509145815.3330-1-famz@redhat.com>
	<20180509145815.3330-10-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="uuKVzAmB+c+zQlhu"
Content-Disposition: inline
In-Reply-To: <20180509145815.3330-10-famz@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 9/9] qemu-img: Convert with copy
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
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Ronnie Sahlberg <ronniesahlberg@gmail.com>, qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Peter Lieven <pl@kamp.de>, Max Reitz <mreitz@redhat.com>


--uuKVzAmB+c+zQlhu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, May 09, 2018 at 10:58:15PM +0800, Fam Zheng wrote:
> The new blk_co_copy_range interface offers a more efficient way in the
> case of network based storage. Make use of it to allow faster convert
> operation.
>=20
> Since copy offloading cannot do zero detection ('-S') and compression
> (-c), only try it when these options are not used.
>=20
> Update 178.out.qcow2 as we are now a little more efficient on the actual
> file size.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
> ---
>  qemu-img.c                       | 50 ++++++++++++++++++++++++++++++++++=
++++--
>  tests/qemu-iotests/178.out.qcow2 |  8 +++----
>  2 files changed, 52 insertions(+), 6 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--uuKVzAmB+c+zQlhu
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa9AwhAAoJEJykq7OBq3PIEGMH/0ssFebM+YGD4innlA3f9YNd
ieuzdXeaZFLj4O25xMpO23wKHhGwn6sDQntbmm14G8Zi0tH58569L4AUQqJK5GR7
USYwKsGeCet4UWatWyQQeLc6/XWC+mpCSUpodKL/JK9wBJ+QtcyxpiN+l3qH0/EQ
jnnA67Am44vIrEloL8wprI9oJDQeug7Y8981tRWNJrqCGUBVerF1+8aPg5JnXNtW
z5Soujj7vP4w5DUDBEBoZ7kkXfSz9K9aEzQYIjkbqTfFna6JkJoSMDeleiOIIRK6
Ax58c1M6HZQKNJiyb88K+35Wsxms8is4dYV44oav24UD5rScANp2aV/plN47SYA=
=nBe5
-----END PGP SIGNATURE-----

--uuKVzAmB+c+zQlhu--
