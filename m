Received: from eggs.gnu.org ([2001:4830:134:3::10]:48843)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgr9T-0006OV-VG
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:01:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1cgr9O-0000HS-CR
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:01:36 -0500
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:35464)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1cgr9O-0000HK-6d
	for qemu-devel@nongnu.org; Thu, 23 Feb 2017 06:01:30 -0500
Received: by mail-wm0-x243.google.com with SMTP id u63so2082058wmu.2
	for <qemu-devel@nongnu.org>; Thu, 23 Feb 2017 03:01:30 -0800 (PST)
Date: Thu, 23 Feb 2017 11:01:27 +0000
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170223110127.GC30636@stefanha-x1.localdomain>
References: <148760155821.31154.13876757160410915057.stgit@bahia.lan>
	<148760158296.31154.15839087799468303034.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bKyqfOwhbdpXa4YI"
Content-Disposition: inline
In-Reply-To: <148760158296.31154.15839087799468303034.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH 03/29] 9pfs: remove side-effects in
 local_open() and local_opendir()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, Jann Horn <jannh@google.com>, Prasad J Pandit <prasad@redhat.com>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, Stefan Hajnoczi <stefanha@redhat.com>


--bKyqfOwhbdpXa4YI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 20, 2017 at 03:39:42PM +0100, Greg Kurz wrote:
> If these functions fail, they should not change *fs. Let's use local
> variables to fix this.
>=20
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  hw/9pfs/9p-local.c |   13 ++++++++++---
>  1 file changed, 10 insertions(+), 3 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--bKyqfOwhbdpXa4YI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYrsEHAAoJEJykq7OBq3PI704IAJQpjvMr0pUl6EFiZJ7BXAix
knUTgDHocXQMuhwWkQOuGKnxYbPXvPjbNeNXsQ3sJxIlvtIzmGIJiJQgorhCYKzU
h62ErxMBQltMcmDvAYIZDZW/xDoGRzx5KeMnLzONMi7dEBKebVMGNtujoLGMfk1+
oFjfGwn4wBa+oytAkwLhEFDR9ZCg6BIRm0HCsnczgcrBgvdkNIZBPRGYC2sG9fuc
+CjkT/aznS2zll6S8UsqPOIhO29sD3pSSoXBLJaZ7v7p3WcL90261LYUGUkxe5S9
94UCi8npnR3u+Tcp+aADLxRxCYGqv+2BrNanCDY3jmhXVHlbDqbDnaG1oh+t6IA=
=LJrl
-----END PGP SIGNATURE-----

--bKyqfOwhbdpXa4YI--
