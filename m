Received: from eggs.gnu.org ([2001:4830:134:3::10]:33972)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fUubd-0002zP-Sj
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:54:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@gmail.com>) id 1fUuba-000741-Si
	for qemu-devel@nongnu.org; Mon, 18 Jun 2018 09:54:05 -0400
Date: Mon, 18 Jun 2018 14:53:59 +0100
From: Stefan Hajnoczi <stefanha@gmail.com>
Message-ID: <20180618135359.GA29670@stefanha-x1.localdomain>
References: <20180614164431.29305-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="1yeeQ81UyVL57Vl7"
Content-Disposition: inline
In-Reply-To: <20180614164431.29305-1-stefanha@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] compiler: add a sizeof_field() macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, xen-devel@lists.xenproject.org, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org


--1yeeQ81UyVL57Vl7
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 14, 2018 at 05:44:31PM +0100, Stefan Hajnoczi wrote:
> Determining the size of a field is useful when you don't have a struct
> variable handy.  Open-coding this is ugly.
>=20
> This patch adds the sizeof_field() macro, which is similar to
> typeof_field().  Existing instances are updated to use the macro.
>=20
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  include/hw/xen/io/ring.h      |  2 +-
>  include/qemu/compiler.h       |  2 ++
>  accel/tcg/translate-all.c     |  2 +-
>  hw/display/xenfb.c            |  4 ++--
>  hw/net/rocker/rocker_of_dpa.c |  2 +-
>  hw/net/virtio-net.c           |  2 +-
>  target/i386/kvm.c             |  2 +-
>  target/ppc/arch_dump.c        | 10 +++++-----
>  target/s390x/arch_dump.c      | 20 ++++++++++----------
>  9 files changed, 24 insertions(+), 22 deletions(-)

Thanks, applied to my block tree:
https://github.com/stefanha/qemu/commits/block

Stefan

--1yeeQ81UyVL57Vl7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJbJ7l3AAoJEJykq7OBq3PIQesH/j+BYQL0WSDN933cos7cjyP4
AlONbcdVAyhuh/it2FCS0idLKgTKkeY7Wuh7GJajQGRJOa41ZBfhCyAj4zOnwcyU
/00uHwE6qtycVxVfaxsx5s03QLRSP5ogZR+RMWBWpgX75pmg7/ZD1D8Z2YR4+TTE
fVCz6Y4WJ0mVEfI6fjqbfK/FV/a4unC9IfngXWFi/Q4d9PXJpN4IvRGxf8Hu9HIM
bWv2Z4V2u0/R7J48+Y/VmPf9/YYq8efWz+X3U7MlVG6NjUAC6ZHs3BONPg6xZZxU
/5UjIMZ4V9Fxka7NHuqJNnoBWyG3cnYUYGuBx72B0l0DgpX4Vpyae2fgKkoLVKU=
=QGc6
-----END PGP SIGNATURE-----

--1yeeQ81UyVL57Vl7--
