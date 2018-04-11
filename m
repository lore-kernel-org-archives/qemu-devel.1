Received: from eggs.gnu.org ([2001:4830:134:3::10]:38888)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f64rJ-0001vU-31
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 21:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1f64rI-0006Q4-6j
	for qemu-devel@nongnu.org; Tue, 10 Apr 2018 21:47:37 -0400
Date: Wed, 11 Apr 2018 09:47:27 +0800
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20180411014727.GC28698@stefanha-x1.localdomain>
References: <20180410085809.13313-1-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="da4uJneut+ArUgXk"
Content-Disposition: inline
In-Reply-To: <20180410085809.13313-1-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [PATCH for-2.12] commit/stream: Reset delay_ns
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org


--da4uJneut+ArUgXk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 10, 2018 at 10:58:09AM +0200, Kevin Wolf wrote:
> Streaming and the commit block job only want to apply throttling when
> they actually copied data instead of skipping it, so they made the
> calculation of delay_ns conditional. However, delay_ns isn't reset when
> skipping some sectors, so instead of not waiting, the old delay is
> applied again.
>=20
> Properly reset delay_ns where needed.
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  block/commit.c | 2 ++
>  block/stream.c | 2 ++
>  2 files changed, 4 insertions(+)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--da4uJneut+ArUgXk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJazWkvAAoJEJykq7OBq3PID/EH/0xgm4fe79XZ15uzUopMfIVP
0RoXUxoI89i0+XZIdBxEx3mWLMZmlv/IDM+l38S7c+bGYmU+s2XDABX7fYRjuhnI
LFqTesIkEmMDGN+ve6oiKPfmV2+N1VlIM7B3c+zUHaPmBB37OHbuwfmEg1x/e4Zc
suIZLoZpjv18q4U2vLxI+N3wZswGReWnXALAEakYgvZ0qUHFWTeIIuzRs7CG8ViO
d1zvO2GGAUsTmll3p1v6g57Gybc4A0oyXqVL6ElO2f5teW4tPYLkcG5mZKfmd0N9
LP8uJ3C/Ugo41yY8x3kgbO/PX8dUKOwds7ABIm/cVGkFwyvEnZNsG0cnqm4/YbU=
=xy5N
-----END PGP SIGNATURE-----

--da4uJneut+ArUgXk--
