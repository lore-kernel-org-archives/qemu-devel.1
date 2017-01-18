Received: from eggs.gnu.org ([2001:4830:134:3::10]:36222)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTseT-0007ye-JI
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:59:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cTseP-0005cZ-Nx
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:59:57 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cTseP-0005b9-Hu
	for qemu-devel@nongnu.org; Wed, 18 Jan 2017 10:59:53 -0500
Received: from smtp.corp.redhat.com (int-mx16.intmail.prod.int.phx2.redhat.com
	[10.5.11.28])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 6376A2F5F52
	for <qemu-devel@nongnu.org>; Wed, 18 Jan 2017 15:59:53 +0000 (UTC)
Date: Wed, 18 Jan 2017 15:59:50 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170118155950.GO30347@stefanha-x1.localdomain>
References: <20170113131731.1246-1-pbonzini@redhat.com>
	<20170113131731.1246-15-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Sr6hGnsCY8KeifOY"
Content-Disposition: inline
In-Reply-To: <20170113131731.1246-15-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 14/16] aio-posix: partially inline
 aio_dispatch into aio_poll
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


--Sr6hGnsCY8KeifOY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 13, 2017 at 02:17:29PM +0100, Paolo Bonzini wrote:
> This patch prepares for the removal of unnecessary lockcnt inc/dec pairs.
> Extract the dispatching loop for file descriptor handlers into a new
> function aio_dispatch_handlers, and then inline aio_dispatch into
> aio_poll.
>=20
> aio_dispatch can now become void.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  aio-posix.c         | 44 ++++++++++++++------------------------------
>  aio-win32.c         | 13 ++++---------
>  async.c             |  2 +-
>  include/block/aio.h |  6 +-----
>  4 files changed, 20 insertions(+), 45 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--Sr6hGnsCY8KeifOY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYf5D2AAoJEJykq7OBq3PIjUQH/2o+u1p5SQR1apspqkWi9elo
q198KCgqRwV+JclR3OwYiULZJWnxOsdNF5fEQ4Lk+oqKuYmZ3zpjfMB4bqPcfwOK
vay688HLJ2gml/RmXBw+ykzQt/5m2siVxQawXTB7Bmv/OUH+3oXyU/WITUr4d818
fug5GHFpCkC3wX/BcTb/oJD9WSbvmWco/MyRfMRbs5/WAV5z4vonDd/HO51AXYdD
VqE51xBPn+cQUmqE6NkNxyrVhsFUdIxSdQepJFTsWUAiLAYvW3Vm/id2ECOhsSDo
Ua1i555eIHUMLDxt++igKKBD95c+bkjQfq45bQGidFzsdawVszpy5SVmehlJCJI=
=pOP1
-----END PGP SIGNATURE-----

--Sr6hGnsCY8KeifOY--
