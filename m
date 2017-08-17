Received: from eggs.gnu.org ([2001:4830:134:3::10]:42968)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1diEX9-0002CE-Qj
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:44:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1diEX8-0001Cg-OA
	for qemu-devel@nongnu.org; Thu, 17 Aug 2017 02:43:59 -0400
Date: Thu, 17 Aug 2017 16:26:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170817062656.GG5509@umbus.fritz.box>
References: <1502946910-14580-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="rMWmSaSbD7nr+du9"
Content-Disposition: inline
In-Reply-To: <1502946910-14580-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/spapr_rtc: Mark the RTC device with
 user_creatable = false
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--rMWmSaSbD7nr+du9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 17, 2017 at 07:15:10AM +0200, Thomas Huth wrote:
> QEMU currently aborts unexpectedly when a user tries to do something
> like this:
>=20
> $ qemu-system-ppc64 -nographic -S -nodefaults -monitor stdio
> QEMU 2.9.92 monitor - type 'help' for more information
> (qemu) device_add spapr-rtc,id=3Dspapr-rtc
> (qemu) device_del spapr-rtc
> **
> ERROR:qemu/qdev-monitor.c:872:qdev_unplug: assertion failed: (hotplug_ctr=
l)
> Aborted (core dumped)
>=20
> The RTC device is not meant to be hot-pluggable - it's an internal
> device only and it even should not be possible to create it a
> second time with the "-device" parameter, so let's mark this
> with "user_creatable =3D false".
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-2.10, thanks.

> ---
>  hw/ppc/spapr_rtc.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/ppc/spapr_rtc.c b/hw/ppc/spapr_rtc.c
> index 00a4e4c..9ec3078 100644
> --- a/hw/ppc/spapr_rtc.c
> +++ b/hw/ppc/spapr_rtc.c
> @@ -164,6 +164,8 @@ static void spapr_rtc_class_init(ObjectClass *oc, voi=
d *data)
> =20
>      dc->realize =3D spapr_rtc_realize;
>      dc->vmsd =3D &vmstate_spapr_rtc;
> +    /* Reason: This is an internal device only for handling the hypercal=
ls */
> +    dc->user_creatable =3D false;
> =20
>      spapr_rtas_register(RTAS_GET_TIME_OF_DAY, "get-time-of-day",
>                          rtas_get_time_of_day);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--rMWmSaSbD7nr+du9
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlmVNy4ACgkQbDjKyiDZ
s5Izog/+KM1dMHWgoVnKmOK1YYIxoIEF2lGzMRQEySm87MA88CziVw+rrY5ndS5d
/8siV03K+kRKiAEZ3lz66DDnvOIgqxMv1iLDSuVsgJ4fTy5p9OG8scfkpu+iXwpO
M4iAJbKBb6Y8822KuS3y9trtoTeVa9KE6Nh/lx37NOjrsaQvuGxPZB6O7kfOCdjp
i4D++Qlw66xiUO1YRZR0lf7bUbdrGj0BA2A2dYqeQpDT2K4r48NyXS6sYdOAUGez
XY9/cg2XPI0HAxU/tnLHf2Jo5ybS1T2QLsngxn7VRsFDUsJr1CZS995cMxhlTXBj
N90VFiDptqG17PaYwFqGqEhIelHQ4yR1DRbJFnpWYZUSsqnRSIMQp1BTAksY/+Mi
gRDB2dTMtBRD+XtueQJedJ2Rtxty2YHEYlc7HSEpIgf5+8mEl6V3YKNpmi/G9I0P
1GJS9vbuohLROq2EH02e8UdC7PffsgddSwkLon0E9BPDkTLUpJwFK8a50BvmHYzZ
bcoc/PuekXlxGnaU03/q2sKvjHokZQ08woTqpSH4tYzmcIYByDnpX26PItKvB6Ru
IjeC2yGCKn5+qjTXcmkAwooj+l3tZMbgIjcLkN7We0xgdWKBYFRDxB8nG71fBhSO
J1gj8s2SJbO5VRRBScTQChLI4ftUbl8lWNsPsxQk8gqDVz/cYcc=
=354P
-----END PGP SIGNATURE-----

--rMWmSaSbD7nr+du9--
