Received: from eggs.gnu.org ([2001:4830:134:3::10]:60945)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dDAGp-0004EW-Tc
	for qemu-devel@nongnu.org; Tue, 23 May 2017 09:54:45 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1dDAGm-0006ef-0c
	for qemu-devel@nongnu.org; Tue, 23 May 2017 09:54:43 -0400
Received: from mail-wm0-x243.google.com ([2a00:1450:400c:c09::243]:33768)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <stefanha@gmail.com>) id 1dDAGl-0006eY-Qz
	for qemu-devel@nongnu.org; Tue, 23 May 2017 09:54:39 -0400
Received: by mail-wm0-x243.google.com with SMTP id b84so23766653wmh.0
	for <qemu-devel@nongnu.org>; Tue, 23 May 2017 06:54:39 -0700 (PDT)
Date: Tue, 23 May 2017 14:54:36 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20170523135436.GG17369@stefanha-x1.localdomain>
References: <1495507439-1784-1-git-send-email-jasowang@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="JbKQpFqZXJ2T76Sg"
Content-Disposition: inline
In-Reply-To: <1495507439-1784-1-git-send-email-jasowang@redhat.com>
Subject: Re: [Qemu-devel] [PULL 0/9] Net patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, peter.maydell@linaro.org


--JbKQpFqZXJ2T76Sg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, May 23, 2017 at 10:43:50AM +0800, Jason Wang wrote:
> The following changes since commit 56821559f0ba682fe6b367815572e6f974d329=
ab:
>=20
>   Merge remote-tracking branch 'dgilbert/tags/pull-hmp-20170517' into sta=
ging (2017-05-18 13:36:15 +0100)
>=20
> are available in the git repository at:
>=20
>   https://github.com/jasowang/qemu.git tags/net-pull-request
>=20
> for you to fetch changes up to 82342e91b60a4a078811df4e1a545e57abffa11d:
>=20
>   e1000e: Fix ICR "Other" causes clear logic (2017-05-23 10:10:38 +0800)
>=20
> ----------------------------------------------------------------
>=20
> ----------------------------------------------------------------
> Sameeh Jubran (1):
>       e1000e: Fix ICR "Other" causes clear logic
>=20
> Thomas Huth (3):
>       net/tap: Replace tap-haiku.c and tap-aix.c by a generic tap-stub.c
>       net/dump: Issue a warning for the deprecated "-net dump"
>       hmp / net: Mark host_net_add/remove as deprecated
>=20
> Yunjian Wang (1):
>       virtio-net: fix wild pointer when remove virtio-net queues
>=20
> Zhang Chen (4):
>       COLO-compare: Improve tcp compare trace event readability
>       net/filter-mirror.c: Remove duplicate check code.
>       net/filter-mirror.c: Rename filter_mirror_send() and fix codestyle
>       net/filter-rewriter: Remove unused option in filter-rewriter
>=20
>  hmp-commands.hx               |  8 ++--
>  hw/net/e1000e_core.c          | 10 ++++-
>  hw/net/virtio-net.c           |  3 ++
>  net/Makefile.objs             | 15 ++++----
>  net/colo-compare.c            | 33 ++++++++++------
>  net/dump.c                    |  3 ++
>  net/filter-mirror.c           | 35 ++++++++---------
>  net/net.c                     | 13 +++++++
>  net/tap-haiku.c               | 87 -------------------------------------=
------
>  net/{tap-aix.c =3D> tap-stub.c} |  3 +-
>  net/trace-events              |  3 +-
>  qemu-options.hx               |  2 +-
>  12 files changed, 80 insertions(+), 135 deletions(-)
>  delete mode 100644 net/tap-haiku.c
>  rename net/{tap-aix.c =3D> tap-stub.c} (97%)
>=20
>=20

Thanks, applied to my staging tree:
https://github.com/stefanha/qemu/commits/staging

Stefan

--JbKQpFqZXJ2T76Sg
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZJD8cAAoJEJykq7OBq3PI82QH/3qFZiQulMvxv79hYaigFOQe
VPva7B0aWHKdVtqaX5YpmLPnhcMDQWCuQNjwOUP99hH0/KG3WNeBJR6B9bwAqlC3
BJp+xv0rx42akhVuzZv1/1KkjAiqxKESiljbl+ajx1O3EqN+OxU+5FMnnVV5nXan
E5ikAVXveGQcrUTn6USjdWzK4YRAeRx3glpMcebeeXyPnY4Lt2CxjYwLHXo9Q4Z9
fIMA3UXn0lXugM1nh3fUYbOrWR4R+eMovKLe5pgJSjvr8XFo6+ejDMhF0FPr4f5P
WqGT0VeOt4l57RCKQfgjzV+q2kKk+rHIgywi0NIC4aXbz4yWuIuAU6eqGXcfr40=
=tCI8
-----END PGP SIGNATURE-----

--JbKQpFqZXJ2T76Sg--
