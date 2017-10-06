Received: from eggs.gnu.org ([2001:4830:134:3::10]:48978)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0N58-0006Ol-V5
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:30:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0N57-0002fy-Ss
	for qemu-devel@nongnu.org; Fri, 06 Oct 2017 03:30:02 -0400
Date: Fri, 6 Oct 2017 15:43:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006044333.GU3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-17-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="XUmrTyVHrg2/ImRG"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-17-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 16/23] ppc: spapr: use cpu model names as
 tcg defaults instead of aliases
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--XUmrTyVHrg2/ImRG
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 05, 2017 at 06:24:43PM +0200, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/spapr.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index ad7afd6..0661dba 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3603,7 +3603,7 @@ static void spapr_machine_class_init(ObjectClass *o=
c, void *data)
>      hc->unplug_request =3D spapr_machine_device_unplug_request;
> =20
>      smc->dr_lmb_enabled =3D true;
> -    smc->tcg_default_cpu =3D "POWER8";
> +    smc->tcg_default_cpu =3D "power8_v2.0";
>      mc->has_hotpluggable_cpus =3D true;
>      smc->resize_hpt_default =3D SPAPR_RESIZE_HPT_ENABLED;
>      fwc->get_dev_path =3D spapr_get_fw_dev_path;
> @@ -3849,7 +3849,7 @@ static void spapr_machine_2_7_class_options(Machine=
Class *mc)
>      sPAPRMachineClass *smc =3D SPAPR_MACHINE_CLASS(mc);
> =20
>      spapr_machine_2_8_class_options(mc);
> -    smc->tcg_default_cpu =3D "POWER7";
> +    smc->tcg_default_cpu =3D "power7_v2.3";
>      SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_7);
>      smc->phb_placement =3D phb_placement_2_7;
>  }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--XUmrTyVHrg2/ImRG
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnXCfUACgkQbDjKyiDZ
s5JZaxAAhgok3mUSy3XLuzEUtHukeWMH++hx4ndElx0wHbl1+xf8A0woR8XTL+sk
93hxKcJsO/E/6pykssFxqUxBfsebBdLC6yqMq0lrikZrP98c+RKDknLhlcoJKDkv
Os/M4tBa1eYTy565nA4iQMbiQblpKg6RB85PtS13E6zHUmILgY7qZUXn3FFN9+v9
UboI6b2BYOs8Gn/v/nVEbjnGy+dSjaAtdGtrp1LJ6WbgdgcZK6OTHNqOywp4bS3h
DsFHt3U8/izhJVtIcBVsQIZYdmovApsvYW+kjGXuZoKVUAm+qx8U3BTj1rHe0gyC
NKFM/4+abrELVw1NMVY0MV3FCMertB2tId5nqnLiMp9NMG0s1bE7EgTPY8VMu/IW
sM0Ii14KImzFR8Hr9XQs6KO9N64ugwFc0euSQY9f2bbIzIly+i/YPGwapMNc+lRh
ZvqGrvnb+NJequUnYaTYk7AWk+DAau0UA5xnI+YGXBv+XDYTuJVSEOBqG9HGlUWl
yVkCfohpcriAHJkK1gN/p+LiFATVucVwEDQPaL+Etrl+p72BhGsluZEmWf4n2e8k
NdTNRo6BnlpRcks8uCys/8YMChRw7GiObp03Hth6FpoI+za/DfoWgXZfc8R0Wc7Z
/yrIW2udYXnfuzlFAQW9+CVF+/2/vbayDGC9CWl6Ol+cFljYCKM=
=sBHt
-----END PGP SIGNATURE-----

--XUmrTyVHrg2/ImRG--
