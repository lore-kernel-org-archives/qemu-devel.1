Received: from eggs.gnu.org ([2001:4830:134:3::10]:40908)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df1X1-000363-Le
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:14:36 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1df1Wy-00086q-C8
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 06:14:35 -0400
Date: Tue, 8 Aug 2017 11:14:28 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170808101428.GI16801@stefanha-x1.localdomain>
References: <20170804143658.23020-1-famz@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="KrHCbChajFcK0yQE"
Content-Disposition: inline
In-Reply-To: <20170804143658.23020-1-famz@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2] qemu-img: Clarify about
 relative backing file options
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


--KrHCbChajFcK0yQE
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 04, 2017 at 10:36:58PM +0800, Fam Zheng wrote:
> It's not too surprising when a user specifies the backing file relative
> to the current working directory instead of the top layer image. This
> causes error when they differ. Though the error message has enough
> information to infer the fact about the misunderstanding, it is better
> if we document this explicitly, so that users don't have to learn from
> mistakes.
>=20
> Signed-off-by: Fam Zheng <famz@redhat.com>
>=20
> ---
> v2: Improve wording. [Eric]
> ---
>  qemu-img.texi | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--KrHCbChajFcK0yQE
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZiY8EAAoJEJykq7OBq3PIZ0oIAJqADCQJv3Ci+Odga1fFZR1z
ghiEV0xGN1LlOEQnzKp40Fehmw4loDd2GO0TX5WK5OKnYa20YviGnu4rfpuFKmlK
XRN2UZQmOpcFls+xnN2B5EY+sBbkZENBaV0UodDKRpr/ru9FKe2iQDMg+Q5P8ip+
eYyirrHhfhlWEcmHZdLnFf1+SZOJclmabRC6ph6xsReIBf25TRFOw4do9pGUGa27
vlKIR+T6C9lkS/L1GIr4+4/eINlZLSBteIYmUR5GDLK0BfALwu6QiNLzdhfhUoSN
nKodE8fyEB7oxveXTaEJ9Sl4L2ZGnU9ds/O6gc3MDSkOxzP18kGWAB2a/yUIFWI=
=BF75
-----END PGP SIGNATURE-----

--KrHCbChajFcK0yQE--
