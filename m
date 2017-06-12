Received: from eggs.gnu.org ([2001:4830:134:3::10]:38594)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKPhA-0007rT-8R
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:47:53 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dKPh7-0007Gy-7e
	for qemu-devel@nongnu.org; Mon, 12 Jun 2017 09:47:52 -0400
Date: Mon, 12 Jun 2017 14:47:33 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170612134733.GA17075@stefanha-x1.localdomain>
References: <20170522135704.842-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
In-Reply-To: <20170522135704.842-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v3 0/4] block: fix 'savevm'
 hang with -object iothread
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <famz@redhat.com>, qemu-block@nongnu.org, stefanha@redhat.com


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 22, 2017 at 02:57:00PM +0100, Stefan Hajnoczi wrote:
> v3:
>  * Add missing bdrv_drain_all_end() in error code paths [Kevin]
> v2:
>  * New patch to use bdrv_drain_all_begin/end() in savevm/loadvm [Kevin]
>    (All other patches unchanged)
>=20
> The 'savevm' command hangs when -object iothread is used.  See patches for
> details, but basically the vmstate read/write code didn't conform to the =
latest
> block layer locking rules.
>=20
> Stefan Hajnoczi (4):
>   block: count bdrv_co_rw_vmstate() requests
>   block: use BDRV_POLL_WHILE() in bdrv_rw_vmstate()
>   migration: avoid recursive AioContext locking in save_vmstate()
>   migration: use bdrv_drain_all_begin/end() instead bdrv_drain_all()
>=20
>  block/io.c         | 21 +++++++++++++--------
>  migration/savevm.c | 30 ++++++++++++++++++++++++++----
>  2 files changed, 39 insertions(+), 12 deletions(-)

Ping ^ 2

Stefan

--a8Wt8u1KmwUX3Y2C
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZPpt1AAoJEJykq7OBq3PIymEH/0pYKcsReQoL3D0sbBp1B8Fl
YvPvbOuDp95qTBOFE14zk3BAgvEgeW2HLPCoZEj6B6xipcy3hBF4e2JAkI7WApl7
A8sY3bPl2C+6JdDSuJm31YtHd/+T7QAAqTG7GYSznt10rfwN0ejRLewOePJvof6L
wF7WNm5Wt0eviGimv39/QJ8JKFDI9YZAnl6Ymmpz7BlpMuvmLSc2z5I3T8QLRGk5
zwT4fvTGaYfw9r05sXzejUneacOFKIgzVWbc1PE37OFKAZpLcYT5OCZ2PrEjoW95
BhaRA5itnUsKRZmG4E4W0bpzjLpL2zRHADN1tmk3l/aJnwXHyv7cVxOMgxQs8V4=
=Y9VX
-----END PGP SIGNATURE-----

--a8Wt8u1KmwUX3Y2C--
