Received: from eggs.gnu.org ([2001:4830:134:3::10]:46909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZeVn-0006xd-2q
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:39:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dZeVl-0004vd-Vo
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 10:39:07 -0400
Date: Mon, 24 Jul 2017 15:38:58 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170724143858.GH2784@stefanha-x1.localdomain>
References: <20170714094521.4909-1-el13635@mail.ntua.gr>
	<20170714094521.4909-3-el13635@mail.ntua.gr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="NzX0AQGjRQPusK/O"
Content-Disposition: inline
In-Reply-To: <20170714094521.4909-3-el13635@mail.ntua.gr>
Subject: Re: [Qemu-devel] [PATCH 2/7] block: add aio_context field in
 ThrottleGroupMember
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Manos Pitsidianakis <el13635@mail.ntua.gr>
Cc: qemu-devel <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>


--NzX0AQGjRQPusK/O
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 14, 2017 at 12:45:16PM +0300, Manos Pitsidianakis wrote:
> timer_cb() needs to know about the current Aio context of the throttle
> request that is woken up. In order to make ThrottleGroupMember backend
> agnostic, this information is stored in an aio_context field instead of
> accessing it from BlockBackend.
>=20
> Signed-off-by: Manos Pitsidianakis <el13635@mail.ntua.gr>
> ---
>  block/block-backend.c           | 14 ++++-----
>  block/throttle-groups.c         | 38 ++++++++++++++++---------
>  include/block/throttle-groups.h |  7 ++++-
>  tests/test-throttle.c           | 63 +++++++++++++++++++++--------------=
------
>  4 files changed, 69 insertions(+), 53 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--NzX0AQGjRQPusK/O
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZdgaCAAoJEJykq7OBq3PITF8H/3NOE9OpPF8TiyAjVUBnsLJy
bcwe90V4yTHlSrYdp6qJN6Hr1m/wIC0d3FgzfJnM/npE68SM8XQZo09brKpWjyAs
111+jXwN3BGuMh+24diovW5pNJc6F0ozwRD3E8MEbZMRL9hDoGMbIyOMz2Bl82qA
TzX/FZXqFR9h9AF5f2Z6EqIbX38nlE3GkbHkwu4T4Qipy+1ZHliA60oB3hfvdupk
a9fct12UwtjWPTf42IeRdDB+MlrllyCyg0N4NHgvBC2nroZINlHpNmlPQxR6jSLA
NzTkTWgTwtkXfsNEW3bVQIcKALf4ZiP/+DnXiSQw0YrDdtdIP/nWba+qsAh0gUY=
=dgRy
-----END PGP SIGNATURE-----

--NzX0AQGjRQPusK/O--
