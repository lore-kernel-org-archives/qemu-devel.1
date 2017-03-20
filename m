Received: from eggs.gnu.org ([2001:4830:134:3::10]:37018)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpurV-00027v-VH
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:48:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cpurV-0008Hr-8a
	for qemu-devel@nongnu.org; Mon, 20 Mar 2017 06:48:30 -0400
Date: Mon, 20 Mar 2017 10:48:19 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170320104819.GF17887@stefanha-x1.localdomain>
References: <20170313214001.26339-1-mreitz@redhat.com>
	<20170313214045.26857-3-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JSkcQAAxhB1h8DcT"
Content-Disposition: inline
In-Reply-To: <20170313214045.26857-3-mreitz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH for-2.10 05/16]
 block/file-posix: Small fixes in raw_create()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Max Reitz <mreitz@redhat.com>
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org


--JSkcQAAxhB1h8DcT
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 13, 2017 at 10:40:34PM +0100, Max Reitz wrote:
> Variables should be declared at the start of a block, and if a certain
> parameter value is not supported it may be better to return -ENOTSUP
> instead of -EINVAL.
>=20
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/file-posix.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--JSkcQAAxhB1h8DcT
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYz7NzAAoJEJykq7OBq3PIcy4H/2axcwh3gknCxr9Full6lIui
R1+alHWZX+cjx4jjvUKl/sZTM40/Bhxe9asxwd9T6lWuMkqa1wnPzWYv2xCqPoTC
gZHl3ZNt6igO6/3Y9cr+KtiZyDrcvbYgMpaGPAPFHH5PKM7k+Cc3ETFDpY/NcUix
ic4wG/UuNghgtPYXz44z5VLJbS3EPT5HE5F8pm6xTHr/nDd2K8cy+iSpcQb10IeO
juIaAnAgT9ACg0OZndSH2cAdLgGfajA4wuzKB82ncazTM/bFqDme34rrF6obaYvA
O9BbhwR+6DvK45giOOiEWiMSJnVuUrzL5QEun/krs7VmdQuQMRodmst0TjjBmps=
=kzqT
-----END PGP SIGNATURE-----

--JSkcQAAxhB1h8DcT--
