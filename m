Received: from eggs.gnu.org ([2001:4830:134:3::10]:42134)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daEyX-0001jG-BE
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 01:35:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1daEyT-0002Nf-B2
	for qemu-devel@nongnu.org; Wed, 26 Jul 2017 01:35:13 -0400
Date: Wed, 26 Jul 2017 15:28:41 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170726052841.GG8978@umbus.fritz.box>
References: <150100547373.27487.3154210751350595400.stgit@bahia>
	<150100567284.27487.16381745122889215367.stgit@bahia>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="YhYebsMuj/FQeBW/"
Content-Disposition: inline
In-Reply-To: <150100567284.27487.16381745122889215367.stgit@bahia>
Subject: Re: [Qemu-devel] [for-2.11 PATCH 15/26] spapr: add pseries-2.11
 machine type
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, Michael Roth <mdroth@linux.vnet.ibm.com>, qemu-ppc@nongnu.org, Bharata B Rao <bharata@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Daniel Henrique Barboza <danielhb@linux.vnet.ibm.com>


--YhYebsMuj/FQeBW/
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 25, 2017 at 08:01:12PM +0200, Greg Kurz wrote:
> Signed-off-by: Greg Kurz <groug@kaod.org>

Applied to ppc-for-2.11.  Might as well get the new machine type
template ready.

> ---
>  hw/ppc/spapr.c      |   22 ++++++++++++++++++++--
>  include/hw/compat.h |    3 +++
>  2 files changed, 23 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/spapr.c b/hw/ppc/spapr.c
> index 53969315ac24..277daa4f9645 100644
> --- a/hw/ppc/spapr.c
> +++ b/hw/ppc/spapr.c
> @@ -3533,18 +3533,36 @@ static const TypeInfo spapr_machine_info =3D {
>      type_init(spapr_machine_register_##suffix)
> =20
>  /*
> + * pseries-2.11
> + */
> +static void spapr_machine_2_11_instance_options(MachineState *machine)
> +{
> +}
> +
> +static void spapr_machine_2_11_class_options(MachineClass *mc)
> +{
> +    /* Defaults for the latest behaviour inherited from the base class */
> +}
> +
> +DEFINE_SPAPR_MACHINE(2_11, "2.11", true);
> +
> +/*
>   * pseries-2.10
>   */
> +#define SPAPR_COMPAT_2_10                                              \
> +    HW_COMPAT_2_10                                                     \
> +
>  static void spapr_machine_2_10_instance_options(MachineState *machine)
>  {
>  }
> =20
>  static void spapr_machine_2_10_class_options(MachineClass *mc)
>  {
> -    /* Defaults for the latest behaviour inherited from the base class */
> +    spapr_machine_2_11_class_options(mc);
> +    SET_MACHINE_COMPAT(mc, SPAPR_COMPAT_2_10);
>  }
> =20
> -DEFINE_SPAPR_MACHINE(2_10, "2.10", true);
> +DEFINE_SPAPR_MACHINE(2_10, "2.10", false);
> =20
>  /*
>   * pseries-2.9
> diff --git a/include/hw/compat.h b/include/hw/compat.h
> index 08f36004dad7..3e101f8f6783 100644
> --- a/include/hw/compat.h
> +++ b/include/hw/compat.h
> @@ -1,6 +1,9 @@
>  #ifndef HW_COMPAT_H
>  #define HW_COMPAT_H
> =20
> +#define HW_COMPAT_2_10 \
> +    /* empty */
> +
>  #define HW_COMPAT_2_9 \
>      {\
>          .driver   =3D "pci-bridge",\
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--YhYebsMuj/FQeBW/
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAll4KIkACgkQbDjKyiDZ
s5K8XA/7BT/j24e2g9WyoTmROwLoqMP8hOyE1fLCDh5oS7Yo664wg/zRBICdulrd
5h1G/Ix5UUhUHRNFQYEJwkqY+9+QLxGmvJRsOSgysknXuqiQl62f1uXXHU3Fc3/1
HnMIu3mvdfjzygYqun+fdX8YTjR2gCSedTb6ZvHjuYnZ2ytg3lTULLOTRynF6oQz
i+RbcqazDXmP/pqs/ar/GSoRAdMhvuhFuX7+hMFMDADJ5ZhNbPEflxcJBBUenyCW
XHsBFvPRA0kVZ7oxEDgwYEPHysiqyR0zGnQroVTD/cQcVAop/gtvPFYfpfl+SUcL
NQP8xMDyv4Vv2LwaWdKJ7AoAgttVLXAIgxDt9y7zH8NLv5XUvnWf0qcZptOFYsZ8
W0xYQ+VdePYMdusvv7HAVgeOGdXq7oI8hyi5i91/urBXxv3oSgz+uIW/IPiP+uXf
DnlFlc9by4b//QX2LXqR2iiTbxflSTfXcG/yXJMZfww1mCV2VejPSor+JehjGM47
KsN6Y/ws/uqOaG4q3qEBqWXaKMx2Y/weIn2TTyJoW2bXgnrC0xY1VrKAkOofus1R
Lu8PJndhxeyV3kVHY8ahqQIruBSV9mintSmgJ/8eO6S5PDmlfV53ZV+kYPzm97C8
gwuGXMAb1nVFPPQyO2zLVLRbdCm33qHvH+sZsyKMIWXWH6dHzB0=
=SKlw
-----END PGP SIGNATURE-----

--YhYebsMuj/FQeBW/--
