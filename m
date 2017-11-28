Received: from eggs.gnu.org ([2001:4830:134:3::10]:46962)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJXul-0006J2-Os
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 23:54:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eJXui-00040N-N2
	for qemu-devel@nongnu.org; Mon, 27 Nov 2017 23:54:35 -0500
Date: Tue, 28 Nov 2017 15:54:16 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171128045416.GM11775@umbus.fritz.box>
References: <20171125151610.20547-1-ehabkost@redhat.com>
	<20171125151610.20547-4-ehabkost@redhat.com>
	<20171127015209.GB11775@umbus.fritz.box>
	<20171128011243.GE3037@localhost.localdomain>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="N/GrjenRD+RJfyz+"
Content-Disposition: inline
In-Reply-To: <20171128011243.GE3037@localhost.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 3/6] ppc: e500: Allow only supported
 dynamic sysbus devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, jgross@suse.com, Thomas Huth <thuth@redhat.com>, sstabellini@kernel.org, Laszlo Ersek <lersek@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--N/GrjenRD+RJfyz+
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Nov 27, 2017 at 11:12:43PM -0200, Eduardo Habkost wrote:
> On Mon, Nov 27, 2017 at 12:52:09PM +1100, David Gibson wrote:
> > On Sat, Nov 25, 2017 at 01:16:07PM -0200, Eduardo Habkost wrote:
> > > platform_bus_create_devtree() already rejects all dynamic sysbus
> > > devices except TYPE_ETSEC_COMMON, so register it as the only
> > > allowed dynamic sysbus device for the ppce500 machine-type.
> > >=20
> > > Cc: Alexander Graf <agraf@suse.de>
> > > Cc: David Gibson <david@gibson.dropbear.id.au>
> > > Cc: qemu-ppc@nongnu.org
> > > Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>
> >=20
> > Acked-by: David Gibson <david@gibson.dropbear.id.au>
>=20
> Thanks!
>=20
> >=20
> > Do you need me to take this through my tree (for 2.12), or do you have
> > another merge patch in mind?
>=20
> As this patch requires patch 1/6 to be applied first and there
> are patches touching other machines in this series, I can merge
> this through my machine core tree if you don't mind.

Sounds good, thanks.

>=20
> >=20
> > > ---
> > > Changes series v1 -> v2:
> > > * New patch added to series
> > > ---
> > >  hw/ppc/e500plat.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > >=20
> > > diff --git a/hw/ppc/e500plat.c b/hw/ppc/e500plat.c
> > > index 438118c29b..81d03e1038 100644
> > > --- a/hw/ppc/e500plat.c
> > > +++ b/hw/ppc/e500plat.c
> > > @@ -12,6 +12,7 @@
> > >  #include "qemu/osdep.h"
> > >  #include "qemu-common.h"
> > >  #include "e500.h"
> > > +#include "hw/net/fsl_etsec/etsec.h"
> > >  #include "hw/boards.h"
> > >  #include "sysemu/device_tree.h"
> > >  #include "sysemu/kvm.h"
> > > @@ -64,8 +65,7 @@ static void e500plat_machine_init(MachineClass *mc)
> > >      mc->desc =3D "generic paravirt e500 platform";
> > >      mc->init =3D e500plat_init;
> > >      mc->max_cpus =3D 32;
> > > -    /*TODO: allow only sysbus devices that really work with this mac=
hine */
> > > -    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_SYS_BUS_DEVICE);
> > > +    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_ETSEC_COMMON);
> > >      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("e500v2_v30");
> > >  }
> > > =20
> >=20
>=20
>=20
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--N/GrjenRD+RJfyz+
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAloc6/gACgkQbDjKyiDZ
s5J5wQ/+K6k3BvUpJaGyyPBSf0gpzpCZCIx19yDg2no8vnOtZhfLjxNR+HMwohL1
+Hy5gU+Twaisu/sCXcDnvX1enu6vQ0pdz1yenzvKly6BrMhn2oFBNpT7QhMedNYc
4Hc6va0yAy4wAzAgFwVzZkHO7SM6berjUDro18P5Rew75e4mjJFVBaEBQtMhylWb
Eurnv9bPx6AU6Q0iD8oyV2Tho40ftD5tuAYRFYfvBW8lI6qUelEb+HuujQ/FNMsx
vNrPRNzZjloNmQBuyl7JhvuTuHriToTU7O0+Vw1sLvklNHxxZdceNptLotbeo5Yt
jB4sKbMVMsbKmvNdS5zbW5Z8Arqiq5J2Sx0gC/lZr4A0vzQJFphNYwIp0OIxleSu
ulkmrfMOiOvg2PJJANEUpIw8D84nB97iqXYkRQ3BhZA9+arVm8ltNfrZ4e7Z6QUh
vxobb7I7uyKJgh+20UuYfUL//DOVMI3oHdViOpxMJFA8Ge87La+vlOz5DTcb57n+
yBpuxsgOcaFB/UaP8ENHbWY2zVLzmhvlIRqycNd7ZV37yweulwgwDB5zgcM+zQir
Pbkc6IEn0j3M/sS0sMsXVVaS4CQ14h4DMelzZk1z6ZqoqCKVwX6XOuxk8j2bY8qD
sIaBOHJLGHCn9ZXEeg2l61uoFnN83maH9LO2kpwiAvfGJeuhVwI=
=YCu3
-----END PGP SIGNATURE-----

--N/GrjenRD+RJfyz+--
