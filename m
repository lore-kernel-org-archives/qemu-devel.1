Received: from eggs.gnu.org ([2001:4830:134:3::10]:48151)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQcx6-0002lY-Ua
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:37:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stefanha@redhat.com>) id 1cQcx3-0002Nd-Os
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:37:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43890)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <stefanha@redhat.com>) id 1cQcx3-0002N9-Ia
	for qemu-devel@nongnu.org; Mon, 09 Jan 2017 11:37:41 -0500
Date: Mon, 9 Jan 2017 16:17:02 +0000
From: Stefan Hajnoczi <stefanha@redhat.com>
Message-ID: <20170109161702.GH30228@stefanha-x1.localdomain>
References: <148278447806.8988.12706825771606357198.stgit@fimbulvetr.bsc.es>
	<148278451049.8988.5349519787388002909.stgit@fimbulvetr.bsc.es>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="it/zdz3K1bH9Y8/E"
Content-Disposition: inline
In-Reply-To: <148278451049.8988.5349519787388002909.stgit@fimbulvetr.bsc.es>
Subject: Re: [Qemu-devel] [PATCH v4 6/6] hypertrace: Add guest-side Linux
 module
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Llu=EDs?= Vilanova <vilanova@ac.upc.edu>
Cc: qemu-devel@nongnu.org, Daniel P Berrange <berrange@redhat.com>, Luiz Capitulino <lcapitulino@redhat.com>, Eric Blake <eblake@redhat.com>


--it/zdz3K1bH9Y8/E
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 26, 2016 at 09:35:10PM +0100, Llu=EDs Vilanova wrote:
> Provides guest Linux kernel module "qemu-hypertrace.ko" to abstract
> access to the hypertrace channel.
>=20
> Signed-off-by: Llu=EDs Vilanova <vilanova@ac.upc.edu>
> ---
>  Makefile                                           |    4 -
>  configure                                          |    4 +
>  hypertrace/guest/linux-module/Kbuild.in            |    7 +
>  hypertrace/guest/linux-module/Makefile             |   23 +++
>  .../include/linux/qemu-hypertrace-internal.h       |   46 ++++++
>  .../linux-module/include/linux/qemu-hypertrace.h   |   73 ++++++++++
>  hypertrace/guest/linux-module/qemu-hypertrace.c    |  149 ++++++++++++++=
++++++
>  7 files changed, 305 insertions(+), 1 deletion(-)
>  create mode 100644 hypertrace/guest/linux-module/Kbuild.in
>  create mode 100644 hypertrace/guest/linux-module/Makefile
>  create mode 100644 hypertrace/guest/linux-module/include/linux/qemu-hype=
rtrace-internal.h
>  create mode 100644 hypertrace/guest/linux-module/include/linux/qemu-hype=
rtrace.h
>  create mode 100644 hypertrace/guest/linux-module/qemu-hypertrace.c

This should be submitted to Linux, the module cannot live in the QEMU
tree (we don't carry out-of-tree kernel modules).

--it/zdz3K1bH9Y8/E
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBAgAGBQJYc7d+AAoJEJykq7OBq3PIRIUIAKpxDSz1ZrhDTZg8mhbU/Gpb
DvVtG2CkA1GLC1e3wDNOvlXYr5Gm2CgESpwetFGu1EwmIkf/UmJZ9fth8qgQNnp2
IbHfxwZqyMshMb6oAY09mcXJbcL1w52ia3A6Up7OpJ1wvdDPzkFtfOQdaTVkLOuN
r4jWpKJxu+fBL/AXiYaKGcL+7W0wn3/Vb/ZEvp8gX74G1ylL4RNKLJBqQUpIES8D
wGrRKJIqgDEPvhQ2NcHIk9l6EkbTfKOWWSEjZxBuTMb7y3t5Ety+Re93ykO+tkus
FB4wWwFsjNHENXaSc/S7rz3g0kHV60+7iv47IUfYAdBZ8bzq74JufbUcbd3h9PI=
=WNw9
-----END PGP SIGNATURE-----

--it/zdz3K1bH9Y8/E--
