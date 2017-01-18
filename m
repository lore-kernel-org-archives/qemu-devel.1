Received: from eggs.gnu.org ([2001:4830:134:3::10]:43577)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTrLL-0001aJ-A1
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:36:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTrLG-0000Ir-Dy
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:36:07 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60380)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cTrLG-0000Ic-7t
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 09:36:02 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 628C31446AE
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 14:36:02 +0000 (UTC)
Date: Wed, 18 Jan 2017 14:35:59 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170118143559.GC30347@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-4-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="O3RTKUHj+75w1tg5"
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-4-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 03/16] test-thread-pool: use generic
 AioContext infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com


--O3RTKUHj+75w1tg5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 02:17:18PM +0100, Paolo Bonzini wrote:
> Once the thread pool starts using aio_co_wake, it will also need
> qemu_get_current_aio_context().  Make test-thread-pool create
> an AioContext with qemu_init_main_loop, so that stubs/iothread.c
> and tests/iothread.c can provide the rest.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  tests/test-thread-pool.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--O3RTKUHj+75w1tg5
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf31PAAoJEJykq7OBq3PImtYH/09B5+uMixj1/7p492zPUk2X
T28HSUXJCyS4ZoKuc2qxUQwKNq/GDyi67QvxhT6nPZ53EtNV+3Hx1+Ian4M9Sxc5
8cNpMU6Mfhn93eqjtah2L9GbvWCJck/4xzi38hWTrwRQppMPaJcsBpJ6fyritLBv
bWgDoGu4Y/GHPc7twm9SVsKKJs/fNhcBeNzVUqwnwJY+xjvuN9Z87RTltYeP6Bey
5ySj4XrLfBWxJ/oEkTKLkp9/MnB9m7NI5fMkwyTYw9nbAFF4sV1Jsuc95CaF2dZC
cNbHmsSp6Fgwml0r2j0dzhVy40nOeZrnJCqISjfNXjEXIbuVzWjRsHUy8QXrkPU=
=dThp
-----END PGP SIGNATURE-----

--O3RTKUHj+75w1tg5--
