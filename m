Received: from eggs.gnu.org ([2001:4830:134:3::10]:58748)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1gWeHQ-0002cu-SA
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:24:41 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <olaf@aepfle.de>) id 1gWeHP-000478-Tt
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:24:40 -0500
Received: from mo6-p00-ob.smtp.rzone.de ([2a01:238:20a:202:5300::10]:36735)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <olaf@aepfle.de>) id 1gWeHP-00044y-CF
	for qemu-devel@nongnu.org; Tue, 11 Dec 2018 04:24:39 -0500
Date: Tue, 11 Dec 2018 10:24:08 +0100
From: Olaf Hering <olaf@aepfle.de>
Message-ID: <20181211092408.GA18447@aepfle.de>
References: <20181026101016.28584-1-olaf@aepfle.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="82I3+IH0IqGh5yIs"
Content-Disposition: inline
In-Reply-To: <20181026101016.28584-1-olaf@aepfle.de>
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH v1] xen: preserve COMPAT in
 CFLAGS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Anthony Perard <anthony.perard@citrix.com>, "open list:X86" <xen-devel@lists.xenproject.org>, Stefano Stabellini <sstabellini@kernel.org>


--82I3+IH0IqGh5yIs
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Ping?


On Fri, Oct 26, Olaf Hering wrote:

> A given Qemu version can not predict what version of Xen it will run on.
> There are some checks in configure to decide what Xen libraries and
> functions are available. How exactly these functions must be accessed
> has to be decided by configure and the user who is compiling Qemu.
> In no way some random header file must override this decision.
>=20
> Remove the breakage introduced by commit 5eeb39c24b, which would always
> hide the libxc interfaces the given version of Qemu knows about.
>=20
> The current symptom of such breakage is a build failure with qemu-2.9
> and older, in combination with Xen 4.12.
>=20
> Fixes: 5eeb39c24b7d4da5d129bfdd9c4fd21cfb3d28d6
> Signed-off-by: Olaf Hering <olaf@aepfle.de>
> ---
>  include/hw/xen/xen_common.h | 9 ---------
>  1 file changed, 9 deletions(-)
>=20
> diff --git a/include/hw/xen/xen_common.h b/include/hw/xen/xen_common.h
> index 5f1402b494..33fa2d3497 100644
> --- a/include/hw/xen/xen_common.h
> +++ b/include/hw/xen/xen_common.h
> @@ -1,15 +1,6 @@
>  #ifndef QEMU_HW_XEN_COMMON_H
>  #define QEMU_HW_XEN_COMMON_H
> =20
> -/*
> - * If we have new enough libxenctrl then we do not want/need these compat
> - * interfaces, despite what the user supplied cflags might say. They
> - * must be undefined before including xenctrl.h
> - */
> -#undef XC_WANT_COMPAT_EVTCHN_API
> -#undef XC_WANT_COMPAT_GNTTAB_API
> -#undef XC_WANT_COMPAT_MAP_FOREIGN_API
> -
>  #include <xenctrl.h>
>  #include <xenstore.h>
>  #include <xen/io/xenbus.h>
>=20
> _______________________________________________
> Xen-devel mailing list
> Xen-devel@lists.xenproject.org
> https://lists.xenproject.org/mailman/listinfo/xen-devel

--82I3+IH0IqGh5yIs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EARECAB0WIQSkRyP6Rn//f03pRUBdQqD6ppg2fgUCXA+CNQAKCRBdQqD6ppg2
fka9AJsGrS4R//U2ZidLGIWIfJ0hKPiQRgCeKO7jAH2uT5roxC7VXY4AI2ZNrBg=
=7f5M
-----END PGP SIGNATURE-----

--82I3+IH0IqGh5yIs--
