Received: from eggs.gnu.org ([2001:4830:134:3::10]:38168)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d53Dv-0004D5-1z
	for qemu-devel@nongnu.org; Mon, 01 May 2017 00:46:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1d53Dr-0002Jw-3q
	for qemu-devel@nongnu.org; Mon, 01 May 2017 00:46:11 -0400
Date: Mon, 1 May 2017 14:45:47 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170501044547.GG13773@umbus.fritz.box>
References: <1493367991-21269-1-git-send-email-clg@kaod.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="eMnpOGXCMazMAbfp"
Content-Disposition: inline
In-Reply-To: <1493367991-21269-1-git-send-email-clg@kaod.org>
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: restrict BMC object to the BMC
 simulator
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Cc: Corey Minyard <cminyard@mvista.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--eMnpOGXCMazMAbfp
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 28, 2017 at 10:26:31AM +0200, C=E9dric Le Goater wrote:
> Today, when a PowerNV guest runs, it uses the sensor definitions of
> the BMC simulator to populate the device tree. But an external IPMI
> BMC could also be used and, in that case, it is not (yet) possible to
> retrieve the sensor list. Generating the OEM SEL event for shutdown or
> reboot also does not make sense as it should be generated on the BMC
> side.
>=20
> This change allows a guest to use an 'ipmi-bmc-extern' backend to the
> 'isa-ipmi-bt' device and a 'chardev' for transport such as :
> =20
> 	-chardev socket,id=3Dipmi0,host=3Dlocalhost,port=3D9002,reconnect=3D10 \
> 	-device ipmi-bmc-extern,id=3Dbmc0,chardev=3Dipmi0 \
> 	-device isa-ipmi-bt,bmc=3Dbmc0,irq=3D10
>=20
> and connect to a BMC simulator, the OpenIPMI ipmi_sim simulator for
> instance.
>=20
> Signed-off-by: C=E9dric Le Goater <clg@kaod.org>

Applied to ppc-for-2.10.

> ---
>=20
>  Corey,
>=20
>  Should we externalize the TYPE_IPMI_BMC_EXTERN and TYPE_IPMI_BMC_SIMULAT=
OR
>  defines ?

That's a good question, though.  My inclination would be yes.

>=20
>  hw/ppc/pnv.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> Index: qemu-powernv-2.10.git/hw/ppc/pnv.c
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> --- qemu-powernv-2.10.git.orig/hw/ppc/pnv.c
> +++ qemu-powernv-2.10.git/hw/ppc/pnv.c
> @@ -520,7 +520,7 @@ static void ppc_powernv_reset(void)
>       * This is the internal simulator but it could also be an external
>       * BMC.
>       */
> -    obj =3D object_resolve_path_type("", TYPE_IPMI_BMC, NULL);
> +    obj =3D object_resolve_path_type("", "ipmi-bmc-sim", NULL);
>      if (obj) {
>          pnv->bmc =3D IPMI_BMC(obj);
>      }
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--eMnpOGXCMazMAbfp
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJZBr17AAoJEGw4ysog2bOS57QP/RrDzJrybMEXXrtJ1M6ywRzO
Vi+Ez6u8xCD2ExQfqcHpVYD6cxuppEwakEXUd0khjscpS8tfUSoQ+fq5RKaqNH4U
EaBUc89yhtjn7nYTziGV8iEaTNVZoN3HDVM9stK/wc27kj4jWLai13Ze5c69gdTT
J05hPUXqkQwl2Ns0tT0sPnJky0I4d3D51ZTHdgQp33RvD3u+Tim/O5byohkNy6ut
iEqnwFiaXhJX2vyg0hz5ayTYPfqynUlry7SAKJQQSUH4vYj6zcb36PbDeRNpMCtH
2oJvJdEFAGoXBs6xTpGSYwx7A2HyUxNfApXzea5He+l1/i083w7jhiSylcttdHgB
lzbzJUujUNvtu2+D0t85fc7i55OgA7z7qMUaYppGxslvSV34dnpzukwdjsDU7bag
uSScyz56Zz2YBsnAPq5SZJb4QX1R+76TbOTY2ZS9207Bgv5TPlbeeUfz43bf54Vq
0ZzQdOfQP+7cXli0UCKy+MXNJDTRST+mFisbPkzHFwVaQHwKFajvDqTFRWMOJl0w
9AG7QRduhEhwIHNkrciQV3u49mgcshw+opgXrm3BUea1xYLGajopg9KFnsQwToAI
78bqRMz/WxthYCHsATwIZyaY39NqgknN0DeLWQj6rA+h87U7mgfcke7BEiG3DoRB
Uxw9RxyC/6HyJHsgud0S
=XZaV
-----END PGP SIGNATURE-----

--eMnpOGXCMazMAbfp--
