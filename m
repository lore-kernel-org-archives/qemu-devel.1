Received: from eggs.gnu.org ([2001:4830:134:3::10]:51719)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9QDy-0007xl-Ar
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:12:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1f9QDx-0004dt-Id
	for qemu-devel@nongnu.org; Fri, 20 Apr 2018 03:12:50 -0400
Date: Fri, 20 Apr 2018 15:12:41 +0800
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180420071241.GD15181@stefanha-x1.localdomain>
References: <20180411163940.2523-1-kwolf@redhat.com>
	<20180411163940.2523-6-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="HWvPVVuAAfuRc6SZ"
Content-Disposition: inline
In-Reply-To: <20180411163940.2523-6-kwolf@redhat.com>
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 05/19] tests/test-bdrv-drain:
 bdrv_drain_all() works in coroutines now
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, famz@redhat.com, qemu-devel@nongnu.org, mreitz@redhat.com, stefanha@redhat.com, pbonzini@redhat.com


--HWvPVVuAAfuRc6SZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Apr 11, 2018 at 06:39:26PM +0200, Kevin Wolf wrote:
> Since we use bdrv_do_drained_begin/end() for bdrv_drain_all_begin/end(),
> coroutine context is automatically left with a BH, preventing the
> deadlocks that made bdrv_drain_all*() unsafe in coroutine context. We
> can consider it compatible now the latest, after having removed the old
> polling code as dead code.
>=20
> Enable the coroutine test cases for bdrv_drain_all().
>=20
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---
>  tests/test-bdrv-drain.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--HWvPVVuAAfuRc6SZ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJa2ZLoAAoJEJykq7OBq3PIxBkH/3ayRlpaKPFfNDHXwju2Z7wX
keacPOEu7vAAZgAo8Xw+/2rfYFzvk/u2TRkFwfQmNxBDsvKcYZIJCTTqMGDpsbb0
+Qbbui7DcFc1QKXgYuyfI353XaVW5Iwyxc+L0bn7SnYtI51ASlK5EoA2lidcdd9K
/KiaTksFqdqJrW1aU3C/o67Ayuugv3K2bhWmnZXXrcVFpoDWHgE+f00LapfUhEkF
OjweTZlCMA5IdqCN/FNl/mfz4L1kpVAsqQYc+oNmvjWzr+kSt855PAzh7olzHeNc
MoOc6IeWU+u6VcxIm8w6yTnckLv1zl7K8n2cwgXJgOj1D7cVttBOP+PXjHktEoI=
=cwM4
-----END PGP SIGNATURE-----

--HWvPVVuAAfuRc6SZ--
