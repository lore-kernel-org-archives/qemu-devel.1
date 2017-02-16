Received: from eggs.gnu.org ([2001:4830:134:3::10]:48287)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ceOdU-0006zQ-Rh
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:10:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1ceOdP-0005ig-2r
	for qemu-devel@nongnu.org; Thu, 16 Feb 2017 11:10:24 -0500
Date: Thu, 16 Feb 2017 16:10:07 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170216161007.GB1022@stefanha-x1.localdomain>
References: <20170213181244.16297-1-pbonzini@redhat.com>
	<20170213181244.16297-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="l76fUT7nc3MelDdI"
Content-Disposition: inline
In-Reply-To: <20170213181244.16297-3-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/6] coroutine-lock: add limited spinning
 to CoMutex
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, famz@redhat.com, qemu-block@nongnu.org


--l76fUT7nc3MelDdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 13, 2017 at 07:12:40PM +0100, Paolo Bonzini wrote:
> Running a very small critical section on pthread_mutex_t and CoMutex
> shows that pthread_mutex_t is much faster because it doesn't actually
> go to sleep.  What happens is that the critical section is shorter
> than the latency of entering the kernel and thus FUTEX_WAIT always
> fails.  With CoMutex there is no such latency but you still want to
> avoid wait and wakeup.  So introduce it artificially.
>=20
> This only works with one waiters; because CoMutex is fair, it will
> always have more waits and wakeups than a pthread_mutex_t.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/qemu/coroutine.h   |  5 +++++
>  util/qemu-coroutine-lock.c | 51 ++++++++++++++++++++++++++++++++++++++++=
------
>  util/qemu-coroutine.c      |  2 +-
>  3 files changed, 51 insertions(+), 7 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--l76fUT7nc3MelDdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYpc7fAAoJEJykq7OBq3PIUMsH/R0i8laweMrDOiLLkZQfnN22
+HLhDZgGPNK9DM9r76EXbS57hLxHsuXectTpJsVqkNc/kxOci0iUoNdDOAGGwFqI
nunu1bUBrtCB3c4eMsX+U5T9hd1uEXXmJNV8P2ryaTcR4oFtHAH1DW3mZAOtdhnF
H//w8bvn840ihSd59aWm1sWLnKuwFeJYAE6DwmQplUYU/wfElDi3lxp9rEcTjdkX
jjJraT0Dx3/FIxa6ErIwh+fRdOA3XtOl0lw68zXz3rlfsrMWu90p/YYZx4Xm7N38
XZsr9hqmsHcFy9o/X6ZQBmLjV+wxwE9KEDt3thNfLVLDP2wwD39drGVPV7X/Zfs=
=SaPQ
-----END PGP SIGNATURE-----

--l76fUT7nc3MelDdI--
