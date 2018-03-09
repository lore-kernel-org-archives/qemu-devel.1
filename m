Received: from eggs.gnu.org ([2001:4830:134:3::10]:54192)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eu6B9-0007kq-83
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 19:46:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1eu6B8-000634-AO
	for qemu-devel@nongnu.org; Thu, 08 Mar 2018 19:46:35 -0500
Date: Fri, 9 Mar 2018 11:35:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180309003533.GS3083@umbus.fritz.box>
References: <20180306203103.25563-1-mark.cave-ayland@ilande.co.uk>
	<20180306203103.25563-5-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="2/Dpz40iF3jpiHxF"
Content-Disposition: inline
In-Reply-To: <20180306203103.25563-5-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH 04/19] uninorth: remove stray PCIBus
 realize from mac_newworld.c
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org


--2/Dpz40iF3jpiHxF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Mar 06, 2018 at 08:30:48PM +0000, Mark Cave-Ayland wrote:
> After QOMification this is clearly no longer needed (and possibly hasn't =
been
> for some time).
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied, thanks.

> ---
>  hw/ppc/mac_newworld.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/ppc/mac_newworld.c b/hw/ppc/mac_newworld.c
> index 1eba79d54b..3410bb13ad 100644
> --- a/hw/ppc/mac_newworld.c
> +++ b/hw/ppc/mac_newworld.c
> @@ -351,7 +351,6 @@ static void ppc_core99_init(MachineState *machine)
>          pci_bus =3D pci_pmac_init(pic, get_system_memory(), get_system_i=
o());
>          machine_arch =3D ARCH_MAC99;
>      }
> -    object_property_set_bool(OBJECT(pci_bus), true, "realized", &error_a=
bort);
> =20
>      machine->usb |=3D defaults_enabled() && !machine->usb_disabled;
> =20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--2/Dpz40iF3jpiHxF
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqh1tUACgkQbDjKyiDZ
s5ItVA/+Kz6bvbM9U2IECRU1T5pILC1zg2gpMOZBgIB95KKMMlfJ+/y8e1aSygMt
dr4m35lX275XwY9KkU2HMIkL0zUiZOr7DrPdx4mSBsGraKfUME6D0aOXUTWlelNt
cOfYp95j6US0HhJ+IG7JRxWPdgFG8Fg2OMAC/74N7TEoikxQYxkw+JJY/J7tu9kB
w25DHQDHq0sUaz74sGt+bWh8EHOd1Qany9Di4CGF3vgdfct0kFYJ8vbHOR/E+rXA
UPVxd/bO4KBdFj6EByoYlnllchLB77FOaMcmDY0AqZ0DNHc7DebFSzEGLgGgMn6B
UFr6hbEARqBC2F1H5KEjEaIZvaDSAo1hhXm+L/mgqLCh/Vgriq6KeivtpiwrpnXz
bOA0hPktRkaIiiR0nKQ+JcuPKjTQfVdb44BRRJbVBnbM8qATaPnw/3uV/n3gukt9
53BxvEbWtTddZg1aqhq62J0CAMDQiQlSZTEwZPEb/SnYYRlOExOnAbaOZO75sMx1
4UQUo5BphyKQAjRCPzSxedutIHKO9bgyagirTqts9MhaJWEP+a2ySIzgRky3i6jp
Q/fjhKzheE8RvcawVw1sSz13+mhXkg1ccHR8k54PLMN0xKOmJeTkzA8wpxG1jSxY
tO4mh9pRNI6Raevve/jlkDkqvLhD1shAH+8WhkB053ct0gKbnps=
=Xhjo
-----END PGP SIGNATURE-----

--2/Dpz40iF3jpiHxF--
