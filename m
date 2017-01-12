Received: from eggs.gnu.org ([2001:4830:134:3::10]:57145)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRfKq-0002Ap-Il
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:22:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cRfKm-0005s4-Kw
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:22:32 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52262)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cRfKm-0005rc-El
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 08:22:28 -0500
Date: Thu, 12 Jan 2017 10:58:54 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170112105854.GE4621@stefanha-x1.localdomain>
References: <20170111094443.2790-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="SNIs70sCzqvszXB4"
Content-Disposition: inline
In-Reply-To: <20170111094443.2790-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] nvdimm acpi: fix g_array_free() with NULL
 pointer
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: imammedo@redhat.com, "Michael S. Tsirkin" <mst@redhat.com>, Xiao Guangrong <guangrong.xiao@linux.intel.com>


--SNIs70sCzqvszXB4
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 11, 2017 at 09:44:43AM +0000, Stefan Hajnoczi wrote:
> Unlike g_free(), g_array_free() does not accept a NULL pointer argument.
> The following error is logged when an nvdimm device is realized:
>=20
>   GLib-CRITICAL **: g_array_free: assertion 'array' failed
>=20
> Cc: Xiao Guangrong <guangrong.xiao@linux.intel.com>
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  hw/acpi/nvdimm.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

NACK

Guangrong pointed out this patch is masking another bug.  There seems to
be a problem with the order in which functions are called when the
device is realized.

--SNIs70sCzqvszXB4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYd2FuAAoJEJykq7OBq3PIr7oIAMKCXcwZIG+eX/6zpbzlhAmp
zUTrt76swf5O82f9zLrXpbLqb8AFxrSrOHgvjFK3u/J4BaUxPlBkdCuwr4OFLQOZ
YKCLuOuqcrTZLk7AhTcIUGha7PloHIMmCsKC0EgDxazM6L/nrwA8lfTwDmVXPxKu
RhZVu6ZiOcJSq/lTuiVszWZSArdJFCdtueXuaQbd6O3i5MzTG8U8fVtP1JS6vqYj
h5QDuHpVHx1FJPat51szQZc1vAF4pHXFQ2d/7CtNenje7suVKmi7friHVUO49eMK
7QDPR1zCei6iZIhOVK4SBVI3grhFvcLRsZeQsCYss1lAuk71FdS8KL9+9NxmI3Y=
=GS1s
-----END PGP SIGNATURE-----

--SNIs70sCzqvszXB4--
