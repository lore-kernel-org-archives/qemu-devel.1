Received: from eggs.gnu.org ([209.51.188.92]:55657)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gm1FT-0005Fu-5E
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:58:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1gm1FR-0003Hn-1L
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:58:11 -0500
Received: from mx1.redhat.com ([209.132.183.28]:15453)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1gm1FO-0003Du-Bk
	for qemu-devel@nongnu.org; Tue, 22 Jan 2019 13:58:07 -0500
Date: Tue, 22 Jan 2019 16:30:47 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20190122163047.GE23035@stefanha-x1.localdomain>
References: <20190122121048.76469-1-sgarzare@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="10jrOL3x2xqLmOsH"
Content-Disposition: inline
In-Reply-To: <20190122121048.76469-1-sgarzare@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/i386/pc: enable PVH only for machine
 type >= 4.0
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: qemu-devel@nongnu.org, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Liam Merwick <liam.merwick@oracle.com>, Richard Henderson <rth@twiddle.net>, "Michael S. Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>


--10jrOL3x2xqLmOsH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 22, 2019 at 01:10:48PM +0100, Stefano Garzarella wrote:
> In order to avoid migration issues, we enable PVH only for
> machine type >=3D 4.0
>=20
> Suggested-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> ---
> Based-on: <1548093980-43088-1-git-send-email-pbonzini@redhat.com>
>=20
>  hw/i386/pc.c         | 4 +++-
>  hw/i386/pc_piix.c    | 3 +++
>  hw/i386/pc_q35.c     | 3 +++
>  include/hw/i386/pc.h | 3 +++
>  4 files changed, 12 insertions(+), 1 deletion(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--10jrOL3x2xqLmOsH
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJcR0U3AAoJEJykq7OBq3PIy7gIAJcD+15yFhtW/N9sLjsh+RpV
4yjvnLLWgE1EbZI5A8fLXq2XqOgwJebdv0VysOuoxAVkY2IRremWIVp+fOX84FIa
y7mFxa/gKP7Z9/Dy1HK1Blmv53Ky4SMpeg2lER3r5sr6P4lidxBJYsqGVz0ripSO
DakO00DtHGSkX00P79w11TUB9LPP7s6Knvq+DiLEdSweuRjr05bvwBwR3lgo9lWI
p5V/ktJmE9GSOK01KiRLa+Y2w/3qXkNFJJbP388BWhc98suC9QniQKaJ4tRNQAuq
elaBnXA5F8beBQ02BD6bs17U0EstP0SUemtaaw8c9F8JC+Cj67NIvWxom+PXJJc=
=DET2
-----END PGP SIGNATURE-----

--10jrOL3x2xqLmOsH--
