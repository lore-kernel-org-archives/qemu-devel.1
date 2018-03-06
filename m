Received: from eggs.gnu.org ([2001:4830:134:3::10]:38186)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et0Bh-0001Rj-QI
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 19:10:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1et0Be-0003DO-TF
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 19:10:37 -0500
Date: Tue, 6 Mar 2018 11:05:48 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180306000548.GO2650@umbus.fritz.box>
References: <20180305211928.466-1-f4bug@amsat.org>
	<20180305211928.466-5-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="68uOmRXIw+u8y5pO"
Content-Disposition: inline
In-Reply-To: <20180305211928.466-5-f4bug@amsat.org>
Subject: Re: [Qemu-devel] [RFC PATCH v2 04/22] hw/isa/pc87312: Rename the
 device type as TYPE_PC87312_SUPERIO
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <f4bug@amsat.org>
Cc: "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Alexander Graf <agraf@suse.de>, "open list:PReP" <qemu-ppc@nongnu.org>


--68uOmRXIw+u8y5pO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Mar 05, 2018 at 06:19:10PM -0300, Philippe Mathieu-Daud=E9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=E9 <f4bug@amsat.org>

hw/ppc part
Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  include/hw/isa/pc87312.h | 4 ++--
>  hw/isa/pc87312.c         | 2 +-
>  hw/ppc/prep.c            | 2 +-
>  3 files changed, 4 insertions(+), 4 deletions(-)
>=20
> diff --git a/include/hw/isa/pc87312.h b/include/hw/isa/pc87312.h
> index bf74470d40..710eb1c807 100644
> --- a/include/hw/isa/pc87312.h
> +++ b/include/hw/isa/pc87312.h
> @@ -28,8 +28,8 @@
>  #include "hw/isa/isa.h"
> =20
> =20
> -#define TYPE_PC87312 "pc87312"
> -#define PC87312(obj) OBJECT_CHECK(PC87312State, (obj), TYPE_PC87312)
> +#define TYPE_PC87312_SUPERIO "pc87312"
> +#define PC87312(obj) OBJECT_CHECK(PC87312State, (obj), TYPE_PC87312_SUPE=
RIO)
> =20
>  typedef struct PC87312State {
>      ISADevice dev;
> diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
> index 48b29e3c3c..e9edbc6c50 100644
> --- a/hw/isa/pc87312.c
> +++ b/hw/isa/pc87312.c
> @@ -391,7 +391,7 @@ static void pc87312_class_init(ObjectClass *klass, vo=
id *data)
>  }
> =20
>  static const TypeInfo pc87312_type_info =3D {
> -    .name          =3D TYPE_PC87312,
> +    .name          =3D TYPE_PC87312_SUPERIO,
>      .parent        =3D TYPE_ISA_DEVICE,
>      .instance_size =3D sizeof(PC87312State),
>      .instance_init =3D pc87312_initfn,
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index ae724b0613..610ec7ec32 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -613,7 +613,7 @@ static void ppc_prep_init(MachineState *machine)
>      isa_bus =3D ISA_BUS(qdev_get_child_bus(DEVICE(pci), "isa.0"));
> =20
>      /* Super I/O (parallel + serial ports) */
> -    isa =3D isa_create(isa_bus, TYPE_PC87312);
> +    isa =3D isa_create(isa_bus, TYPE_PC87312_SUPERIO);
>      dev =3D DEVICE(isa);
>      qdev_prop_set_uint8(dev, "config", 13); /* fdc, ser0, ser1, par0 */
>      qdev_init_nofail(dev);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--68uOmRXIw+u8y5pO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqd21wACgkQbDjKyiDZ
s5I7kRAAjY45WFTtFmQrWlmSC65ce9sNERrmPZBDBWnxxI1AmYJ8alnxkq4CNnr7
dzsI009nRByAU3j/Lb9/2DP9wOl+6654Wp0Hx4BtFEHQ6wu4Fc9euRqxo+CEXuFt
rhm0ArhiZRe62wiAHuHd8p0E5pBlQA/veDVJfzFaM0CNpHPoEnqKwUY0OCKRd8Y1
kYeS2UMYsJKAenxPRKJu5/8iur+0AF8Dxgt/C6g1Gz6zso1q929vOGpnPW7k/2by
RLifTUM7i+A1Ae6ry8PjI0CCypYYzezqDDfWsE3UI8yOYtNWBJMyWXf3nG5M/F64
pErKUUxazjhh+3iKv8oXLgq8w+UHQpXi3/EYZvBvu9heQO9V+Z85Fa5aC0W7FoKp
SK+M2w+0XUxMUwcRxQcBdwhaH1becILJYe/KXwUsE+HiZbdK4B9cikUMIQfnEHiX
qkaDXtT9YC+8qTxo7Qq4ZrgW1mEE3vp/gNVgvYLUhdX7sYm2Bi698ZrEHggVbCqj
aHVQilikIiDAVnRt1IFyb3q/b82paIxVYaBl/P652CS85WrRd2jnexyqUa6Ykqew
7o3tw920OxVQ2hraIEB3UWEvKXtjah2s44+ilZVH7Apr5Iu9JVgxqq6+boSJis6s
VAdh6sfjpnO5g3nI6trJLFoYfZaKkUGOMC5hTUEhw4ihGVSG83g=
=G0Lo
-----END PGP SIGNATURE-----

--68uOmRXIw+u8y5pO--
