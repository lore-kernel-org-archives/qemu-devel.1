Received: from eggs.gnu.org ([2001:4830:134:3::10]:40589)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjkf-0003wH-1R
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cgjkd-0005MT-Je
	for qemu-devel@nongnu.org; Wed, 22 Feb 2017 22:07:28 -0500
Date: Thu, 23 Feb 2017 13:33:28 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170223023328.GZ12577@umbus.fritz.box>
References: <1487252865-12064-1-git-send-email-clg@kaod.org>
	<1487252865-12064-12-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="vM12nk/63StVgfqY"
Content-Disposition: inline
In-Reply-To: <1487252865-12064-12-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH v2 11/22] ppc/xics: remove the XICS list of
 ICS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--vM12nk/63StVgfqY
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 16, 2017 at 02:47:34PM +0100, C=E9dric Le Goater wrote:
> This is not used anymore.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/intc/xics.c        | 8 --------
>  hw/ppc/spapr.c        | 1 -
>  include/hw/ppc/xics.h | 2 --
>  3 files changed, 11 deletions(-)
>=20
> diff --git a/hw/intc/xics.c b/hw/intc/xics.c
> index d679313cd49f..5131587ce088 100644
> --- a/hw/intc/xics.c
> +++ b/hw/intc/xics.c
> @@ -146,13 +146,6 @@ static void xics_common_reset(DeviceState *d)
>      }
>  }
> =20
> -static void xics_common_initfn(Object *obj)
> -{
> -    XICSState *xics =3D XICS_COMMON(obj);
> -
> -    QLIST_INIT(&xics->ics);
> -}
> -
>  static void xics_common_class_init(ObjectClass *oc, void *data)
>  {
>      DeviceClass *dc =3D DEVICE_CLASS(oc);
> @@ -165,7 +158,6 @@ static const TypeInfo xics_common_info =3D {
>      .parent        =3D TYPE_DEVICE,
>      .instance_size =3D sizeof(XICSState),
>      .class_size    =3D sizeof(XICSStateClass),
> -    .instance_init =3D xics_common_initfn,
>      .class_init    =3D xics_common_class_init,
>  };
> =20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index a2a64d7de41d..d1946ebcac69 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -122,7 +122,6 @@ static XICSState *try_create_xics(sPAPRMachineState *=
spapr,
>      if (err) {
>          goto error;
>      }
> -    QLIST_INSERT_HEAD(&xics->ics, spapr->ics, list);
> =20
>      xics->ss =3D g_malloc0(nr_servers * sizeof(ICPState));
>      xics->nr_servers =3D nr_servers;
> diff --git a/include/hw/ppc/xics.h b/include/hw/ppc/xics.h
> index e10426e98e31..c15d8e2a8ae6 100644
> --- a/include/hw/ppc/xics.h
> +++ b/include/hw/ppc/xics.h
> @@ -82,7 +82,6 @@ struct XICSState {
>      /*< public >*/
>      uint32_t nr_servers;
>      ICPState *ss;
> -    QLIST_HEAD(, ICSState) ics;
>  };
> =20
>  #define TYPE_ICP "icp"
> @@ -152,7 +151,6 @@ struct ICSState {
>      qemu_irq *qirqs;
>      ICSIRQState *irqs;
>      XICSState *xics;
> -    QLIST_ENTRY(ICSState) list;
>  };
> =20
>  static inline bool ics_valid_irq(ICSState *ics, uint32_t nr)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--vM12nk/63StVgfqY
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYrkn4AAoJEGw4ysog2bOSb08P/3R7MzPqcgQYGMayYQY44P74
bwjemZDvl/4kMhVBt0ylUoshrFAirI490wiOlj3wNzl5UXkNZLjuDaNKQidjRnFE
NrVG1NkbAQcQKOczO1gmRJFjNlRSKOMw6M4iM12aHYyDVYmBdYMgkr38DYYwrqV7
OZhsUi+WiyE4va5xIJHzH46mrIgxPEW7QnOQzpvB5V711OvWO5/+W5owJOh6AgFr
8W7eOVPil8mMcBQuHn274WWdBKhndl/uLS3u8p/5WNqxx51Z8FUCgjzAu1PTfyXv
zeTMiu9f2u6UEV0SEUiFmEB2Fh75Rw9S9AkiOtV/uz0xI1SmkyR0C6MGm+SLYCpW
DkwGejv5DRA9JsP1QXO+VG24Idj1c2D7lRJdjRiB853qGGKkSFSoLchfQpx2RBCo
qEfYjm27/EpQNCClKxMheMy47osvJIqnwQjkQ9QZKrgmBlWZex6WAUlxwjFVIDzA
yLgANtrvNJGh/45r/tW33hvd6XIL2+nY141oREDkOlkgU/RdyD1wyeRHIR+6YCKB
2ecuBUw51wxKkud5DSGY3XaAJTibIHRgNAe9u/7GzHV+Fg032MOd2Hrd5jw9flEz
W8/4LcAblzlTYwS4zeejt388z5oiKmzNnNpo3dWDq09TrPSNvpxyYPz6jVkWgwdH
oJfHQQyeXHcAaneF7zU1
=BeM4
-----END PGP SIGNATURE-----

--vM12nk/63StVgfqY--
