Received: from eggs.gnu.org ([2001:4830:134:3::10]:44902)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbd23-0003F9-OW
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 19:56:24 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cbd22-0001o2-Hu
	for qemu-devel@nongnu.org; Wed, 08 Feb 2017 19:56:19 -0500
Date: Thu, 9 Feb 2017 11:56:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170209005609.GK17644@umbus.fritz.box>
References: <1486578717-30324-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="tBhgiDt8dP1efIIJ"
Content-Disposition: inline
In-Reply-To: <1486578717-30324-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/pnv: Remove superfluous "qemu"
 prefix from error strings
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org


--tBhgiDt8dP1efIIJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 08, 2017 at 07:31:57PM +0100, Thomas Huth wrote:
> error_report() already puts a prefix with the program name in front
> of the error strings, so the "qemu:" prefix is not necessary here
> anymore.
>=20
> Reported-by: Markus Armbruster <armbru@redhat.com>
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-2.9, thanks.

> ---
>  hw/ppc/pnv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 4fab5c0..09f0d22 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -381,7 +381,7 @@ static void ppc_powernv_init(MachineState *machine)
> =20
>      fw_size =3D load_image_targphys(fw_filename, FW_LOAD_ADDR, FW_MAX_SI=
ZE);
>      if (fw_size < 0) {
> -        error_report("qemu: could not load OPAL '%s'", fw_filename);
> +        error_report("Could not load OPAL '%s'", fw_filename);
>          exit(1);
>      }
>      g_free(fw_filename);
> @@ -393,7 +393,7 @@ static void ppc_powernv_init(MachineState *machine)
>          kernel_size =3D load_image_targphys(machine->kernel_filename,
>                                            KERNEL_LOAD_ADDR, 0x2000000);
>          if (kernel_size < 0) {
> -            error_report("qemu: could not load kernel'%s'",
> +            error_report("Could not load kernel '%s'",
>                           machine->kernel_filename);
>              exit(1);
>          }
> @@ -405,7 +405,7 @@ static void ppc_powernv_init(MachineState *machine)
>          pnv->initrd_size =3D load_image_targphys(machine->initrd_filenam=
e,
>                                    pnv->initrd_base, 0x10000000); /* 128M=
B max */
>          if (pnv->initrd_size < 0) {
> -            error_report("qemu: could not load initial ram disk '%s'",
> +            error_report("Could not load initial ram disk '%s'",
>                           machine->initrd_filename);
>              exit(1);
>          }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--tBhgiDt8dP1efIIJ
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYm74nAAoJEGw4ysog2bOSjqkP/0+z4MFTXn735ibeT44u863p
P86IvDIPRviHSbM3zUyFTPUUtNs3VwZ5K3DNekIFVsSXfKBBe4MtOHfwaiLym66y
2yef2spa3/MFcOnylW9p0N9It2SA3b9+OkwSXyw4C/POumF+R8LicE2sWqq7ONuD
zkxrsAeGUeP4i1TDHyOu8ZrttpCPfaawa6SdN0c/bdvfHIpvr7LRmXR5GLXxe+oP
WVgp0CUwnMqnL22PziYnF50MSqiz1shEPtCCyPjvaYuTOTH3u8KXptEQuS3e0rIi
ehorr5bKKhHgPnGvbRtv/QyR3BZl1aX2lneGH9wMu5rv5yNkWkuXH3MvjzTAvGSB
RWHDKcrWER1CozsptPJEE5NZ9EiJgJAk81HxrNw2K7d8n9XR1YQazgmwIMTwG+vI
Jbu+igO1WCarVbtT9qPSHfE9YgnKVn4Wkthb6A4VX610ZIqD0VChlICdBDnYmu26
f2/DloHmd28kuePNW51FZZTiJjrxXWbZFLU2GEJfSAyXkYZmSrFttuXnl91A83PS
/OYINTEGUL2m12wUZ4gOshPIxUmCO9szeonIUxK6g5c5i1QV3Z3DFrO/0KBAczvE
zZv1hHC+D0ddfGJCj6hjm4DwJWGVdL7+ezmoi1h+j3GmtA5t8LFWSTOyKcH/dVfV
yrKCxR+bQMJWhP+KNqKc
=ZmU2
-----END PGP SIGNATURE-----

--tBhgiDt8dP1efIIJ--
