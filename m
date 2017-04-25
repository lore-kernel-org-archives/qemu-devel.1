Received: from eggs.gnu.org ([2001:4830:134:3::10]:41924)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d2uD3-0002XR-Rn
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:44:26 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1d2uCz-0002Cv-U7
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:44:25 -0400
Received: from 14.mo5.mail-out.ovh.net ([188.165.51.82]:53021)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1d2uCz-0002Bx-NX
	for qemu-devel@nongnu.org; Tue, 25 Apr 2017 02:44:21 -0400
Received: from player799.ha.ovh.net (b9.ovh.net [213.186.33.59])
	by mo5.mail-out.ovh.net (Postfix) with ESMTP id 7FA25E9388
	for <qemu-devel@nongnu.org>; Tue, 25 Apr 2017 08:44:19 +0200 (CEST)
Date: Tue, 25 Apr 2017 08:44:08 +0200
From: Greg Kurz <groug@kaod.org>
Message-ID: <20170425084408.01948533@bahia>
In-Reply-To: <alpine.DEB.2.10.1704241640160.16723@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1704211258580.18403@sstabellini-ThinkPad-X260>
	<CAFEAcA-F4mKWyknfRWhJfymJxbsYPvWH20CSecTmY8-kq-dipA@mail.gmail.com>
	<alpine.DEB.2.10.1704241423030.16723@sstabellini-ThinkPad-X260>
	<CAFEAcA8CWYCxVauuWSsmuQw4YG1O0DO+rYASm2aVhirp3Z3mZA@mail.gmail.com>
	<alpine.DEB.2.10.1704241640160.16723@sstabellini-ThinkPad-X260>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	boundary="Sig_/eBIIoUBe0nBVapuCh=GxLiV";
	protocol="application/pgp-signature"
Subject: Re: [Qemu-devel] [PULL 0/21] Please pull xen-20170421-tag for 2.10
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefano Stabellini <sstabellini@kernel.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Stefan Hajnoczi <stefanha@gmail.com>, Stefan Hajnoczi <stefanha@redhat.com>, Anthony PERARD <anthony.perard@citrix.com>, xen-devel@lists.xenproject.org, QEMU Developers <qemu-devel@nongnu.org>, "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

--Sig_/eBIIoUBe0nBVapuCh=GxLiV
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

On Mon, 24 Apr 2017 16:44:53 -0700 (PDT)
Stefano Stabellini <sstabellini@kernel.org> wrote:

> On Mon, 24 Apr 2017, Peter Maydell wrote:
> > On 24 April 2017 at 22:25, Stefano Stabellini <sstabellini@kernel.org> =
wrote: =20
> > > diff --git a/hw/9pfs/xen-9pfs.h b/hw/9pfs/xen-9pfs.h
> > > new file mode 100644
> > > index 0000000..18f0ec0
> > > --- /dev/null
> > > +++ b/hw/9pfs/xen-9pfs.h
> > > @@ -0,0 +1,14 @@
> > > +/*
> > > + * Xen 9p backend
> > > + *
> > > + * Copyright Aporeto 2017
> > > + *
> > > + * Authors:
> > > + *  Stefano Stabellini <stefano@aporeto.com>
> > > + *
> > > + */ =20
> >=20
> > Trivial file, but I prefer it if we have a brief license
> > statement in every file, just to be clear (it might
> > accumulate more code later). =20
>=20
> Sure
>=20
> > > +
> > > +#include <xen/io/protocols.h>
> > > +#include "hw/xen/io/ring.h"
> > > +
> > > +DEFINE_XEN_FLEX_RING_AND_INTF(xen_9pfs); =20
> >=20
> > Is it worth a comment to dissuade people from thinking they can
> > inline the file back into xen-9p-backend.c ? =20
>=20
> Thanks for the quick review! Here you go:
>=20
>=20
> diff --git a/hw/9pfs/xen-9p-backend.c b/hw/9pfs/xen-9p-backend.c
> index 7e962aa..9c7f41a 100644
> --- a/hw/9pfs/xen-9p-backend.c
> +++ b/hw/9pfs/xen-9p-backend.c
> @@ -13,12 +13,9 @@
>  #include "hw/hw.h"
>  #include "hw/9pfs/9p.h"
>  #include "hw/xen/xen_backend.h"
> -#include "hw/xen/io/ring.h"
> +#include "hw/9pfs/xen-9pfs.h"
>  #include "qemu/config-file.h"
>  #include "fsdev/qemu-fsdev.h"
> -#include <xen/io/protocols.h>
> -
> -DEFINE_XEN_FLEX_RING_AND_INTF(xen_9pfs);
> =20
>  #define VERSIONS "1"
>  #define MAX_RINGS 8
> diff --git a/hw/9pfs/xen-9pfs.h b/hw/9pfs/xen-9pfs.h
> new file mode 100644
> index 0000000..6e33d77
> --- /dev/null
> +++ b/hw/9pfs/xen-9pfs.h
> @@ -0,0 +1,21 @@
> +/*
> + * Xen 9p backend
> + *
> + * Copyright Aporeto 2017
> + *
> + * Authors:
> + *  Stefano Stabellini <stefano@aporeto.com>
> + *
> + * This work is licensed under the terms of the GNU GPL version 2.

"version 2 or later" maybe ?

> + * See the COPYING file in the top-level directory.
> + *
> + */
> +
> +#include <xen/io/protocols.h>
> +#include "hw/xen/io/ring.h"
> +
> +/*
> + * Do not merge into xen-9p-backend.c: clang doesn't allow unused static
> + * inline functions in c files.
> + */
> +DEFINE_XEN_FLEX_RING_AND_INTF(xen_9pfs);


--Sig_/eBIIoUBe0nBVapuCh=GxLiV
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iEYEARECAAYFAlj+8DgACgkQAvw66wEB28I0igCglZY58K2JXL7NYsLT5IpesXs2
YZUAnjmbqdsZbq+cvr2BWbGEjNmj1O8e
=BB3/
-----END PGP SIGNATURE-----

--Sig_/eBIIoUBe0nBVapuCh=GxLiV--
