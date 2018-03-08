Received: from eggs.gnu.org ([2001:4830:134:3::10]:42918)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1etlaI-0005HP-JB
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 21:47:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1etlaF-0007pN-Gr
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 21:47:10 -0500
Date: Thu, 8 Mar 2018 13:06:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180308020603.GN3083@umbus.fritz.box>
References: <1520432574-20615-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uWbmMdDzzl2TXAgx"
Content-Disposition: inline
In-Reply-To: <1520432574-20615-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/misc/macio: Mark the macio devices with
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
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


--uWbmMdDzzl2TXAgx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 07, 2018 at 03:22:54PM +0100, Thomas Huth wrote:
> The macio devices currently cause a crash when the user tries to
> instantiate them on a different machine:
>=20
> $ ppc64-softmmu/qemu-system-ppc64 -device macio-newworld
> Unexpected error in qemu_chr_fe_init() at chardev/char-fe.c:222:
> qemu-system-ppc64: -device macio-newworld: Device 'serial0' is in use
> Aborted (core dumped)
>=20
> These devices are clearly not intended to be creatable by the user
> since they are using serial_hds[] directly in their instance_init
> function. So let's mark them with user_creatable =3D false.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied, thanks.

> ---
>  hw/misc/macio/macio.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/misc/macio/macio.c b/hw/misc/macio/macio.c
> index af1bd46..454244f 100644
> --- a/hw/misc/macio/macio.c
> +++ b/hw/misc/macio/macio.c
> @@ -406,6 +406,8 @@ static void macio_class_init(ObjectClass *klass, void=
 *data)
>      k->class_id =3D PCI_CLASS_OTHERS << 8;
>      dc->props =3D macio_properties;
>      set_bit(DEVICE_CATEGORY_BRIDGE, dc->categories);
> +    /* Reason: Uses serial_hds in macio_instance_init */
> +    dc->user_creatable =3D false;
>  }
> =20
>  static const TypeInfo macio_oldworld_type_info =3D {

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uWbmMdDzzl2TXAgx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlqgmosACgkQbDjKyiDZ
s5KvQg//XJ4+V4TRXZYtei9qo6HTjx02EiCsxcLfenATIslCrhhypnoDujKwiA90
XS+0iGzfGAWo+nVRc5acDgiQCuuBWMIR5WaYC/99xTdkL4UvowrTKHsI7SXdDYZ/
/xLdTSGX+AfQ1v+NlUDyNN9NxvM+hd4x0PKyXVzFSBDbuODUuV0MwDDPSqyD4gtY
dpiGdv8mM0TcqpT484FuYdVzxcrS/7dLazpofwIpWSsyrDUW3oalOwApVXgb2FIa
n9V2d9Y3v6oQun/tYW5HDaJdF7oU5QKM8H6ioU+pgH6gvCHS9ycjrvtBeBaow8oC
7ss6yjnIgcPR5GSicGbwtBKPg4Ko6jlwbsnhP/Sbn2CmH2t0wOvBKtPF/LTfXywa
bqnoeDwF7MI2MT9wSP2R0Jkly9mGu35yYx0+2wUmdyIhaeQxor8g1ubA+9TpTfBw
41+FH+yZBcy5S0lDjbNtM1/cAca7pchPNcX+vncBs42UMT5TTNGZp2pV1pMfkY24
KkoA0NC2zlPlhDqZjPyNoC6SF11tX16km7LRUIj2pk5mTDdQ1Y0UFnFQfZZaxJGR
fF/QPcFuWbGMPLZ6jwvIVIWNRLhUbPAwLDXQWbXbSOKsEul/VEdd4kgVYRk2xXpM
w3uiJV6o+U1NvUXBbvw6HzQ1y5mDF50XQDIif15n5IEteUqWAas=
=qTu/
-----END PGP SIGNATURE-----

--uWbmMdDzzl2TXAgx--
