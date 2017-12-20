Received: from eggs.gnu.org ([2001:4830:134:3::10]:34284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRguL-0002BP-7J
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:07:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1eRguH-0004pG-Vi
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:07:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44338)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1eRguH-0004oQ-PS
	for qemu-devel@nongnu.org; Wed, 20 Dec 2017 11:07:45 -0500
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
	[10.5.11.11])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id E060D3B73A
	for <qemu-devel@nongnu.org>; Wed, 20 Dec 2017 16:07:44 +0000 (UTC)
Date: Wed, 20 Dec 2017 16:07:41 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20171220160741.GE12566@stefanha-x1.localdomain>
References: <20171219181129.24189-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="AsxXAMtlQ5JHofzM"
Content-Disposition: inline
In-Reply-To: <20171219181129.24189-1-maxime.coquelin@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/3] Vhost: no more leak QEMU virtual
 addresses to user backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, mlureau@redhat.com


--AsxXAMtlQ5JHofzM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 19, 2017 at 07:11:26PM +0100, Maxime Coquelin wrote:
> Before this series, QEMU process virtual addresses are sent to the
> user backend as user addresses.
>=20
> Passing these virtual addresses aren't useful, as the backend doesn't
> direct access to QEMU address space.
>=20
> It does make sense however for kernel backend, which can access QEMU
> address space.
>=20
> This series introduce a new enum set by the backend stating whether it
> prefers using QEMU Virtual addresses or Guest physical addresses as
> User address, and make vhost-user backend to use Guest physical
> addresses.
>=20
> Maxime Coquelin (3):
>   vhost-user: rename VhostUserMemory userspace_addr field to user_addr
>   vhost: introduce backend's user address type
>   vhost-user: no more leak QEMU virtual addresses to user backend
>=20
>  hw/virtio/vhost-backend.c         |  1 +
>  hw/virtio/vhost-user.c            |  6 ++++--
>  hw/virtio/vhost.c                 | 16 ++++++++++++----
>  include/hw/virtio/vhost-backend.h |  6 ++++++
>  4 files changed, 23 insertions(+), 6 deletions(-)
>=20
> --=20
> 2.14.3
>=20

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--AsxXAMtlQ5JHofzM
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJaOorNAAoJEJykq7OBq3PIgPwIAJ9Og5J+O7mtiOwcUtP2DKKv
hElxi5FuxljFkyLbUC7xoPNUFmewBrrcYycWIdCzZFLCcTOKeZVVaGhEJL7vwXgv
GboIj5yhnpI/zP1M7xUwKZWHradeyJODJIyGifS/7vZqW/GkIOTWApB8MZCaatKP
cPVTlk97qXixODHNnvXu/G/mRjHr5PEifCvEDo0ut3Q3X5f6X0vCynKLqX997cdE
Ti/ZqCyqZPwEm+uFMOd+DrOoMFmgljpSLamOWnxnaOMuW8QHUgoX1sm94cMrWUn/
xGJ3FR9fUyirgib3+mvI4ZDmNqETo/Zug3OS5Kopu5EDjvNqkbqQnnYDaOXvjm4=
=nK9x
-----END PGP SIGNATURE-----

--AsxXAMtlQ5JHofzM--
