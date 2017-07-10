Received: from eggs.gnu.org ([2001:4830:134:3::10]:33469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUaxS-00089U-SF
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:50:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1dUaxS-0004x9-1M
	for qemu-devel@nongnu.org; Mon, 10 Jul 2017 11:50:46 -0400
Date: Mon, 10 Jul 2017 16:50:34 +0100
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170710155034.GM14195@stefanha-x1.localdomain>
References: <20170706163828.24082-1-pbonzini@redhat.com>
	<20170706163828.24082-5-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="aiCxlS1GuupXjEh3"
Content-Disposition: inline
In-Reply-To: <20170706163828.24082-5-pbonzini@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 04/11] block: make before-write notifiers
 thread-safe
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


--aiCxlS1GuupXjEh3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 06, 2017 at 06:38:21PM +0200, Paolo Bonzini wrote:
> Reads access the list in RCU style, so be careful to avoid use-after-free
> scenarios in the backup block job.  Apart from this, all that's needed
> is protecting updates with a mutex.
>=20
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  block/backup.c            | 17 +++++++++++++----
>  block/io.c                | 12 ++++++++++++
>  block/write-threshold.c   |  2 +-
>  include/block/block_int.h | 16 ++++++++++++++++
>  4 files changed, 42 insertions(+), 5 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

--aiCxlS1GuupXjEh3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJZY6JKAAoJEJykq7OBq3PIJ2UIALXKOGVrp8IAeQtIiRPlkBhy
QBkxBB1GyOaH8LJI/3+ucHNb0U/gQzwGR1NEyHNobR/RJ+yeuF3O9DnapZEDN9uZ
+o2ayvmbpKqTKa8lYmgRuf6mhhEoyKABiuqosxU5t/kP/QSU5953K55zvrXKvgiY
WMqsuGRI15WwKFY5YqONl+NNsLZNu6jTu54dUsiFKwjdEMqZgXmCFA5lFb94vHzU
7KUUkpFxz+Ev/8lmXmldQkxaAiFLDFRDvL/dWN8Zx1A8Ca7uP+mK5++gEyZ39+ry
vs5FPVvHd4nncGJO6u/qsTo0CQtVW9c6IFNxMsDP9hqmKfiKrNIBkTHuVALVPKQ=
=t0kE
-----END PGP SIGNATURE-----

--aiCxlS1GuupXjEh3--
