Received: from eggs.gnu.org ([2001:4830:134:3::10]:40778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fbcoB-0006YH-6M
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 22:18:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fbcoA-0005ow-0m
	for qemu-devel@nongnu.org; Fri, 06 Jul 2018 22:18:47 -0400
Date: Sat, 7 Jul 2018 12:12:48 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180707021248.GS3450@umbus.fritz.box>
References: <20180706075155.14116-1-mark.cave-ayland@ilande.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8N5nZmKALFZnI1Hj"
Content-Disposition: inline
In-Reply-To: <20180706075155.14116-1-mark.cave-ayland@ilande.co.uk>
Subject: Re: [Qemu-devel] [PATCH for-3.0] ppc: fix default VGA display for
 PReP machines
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, ehabkost@redhat.com, kraxel@redhat.com


--8N5nZmKALFZnI1Hj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 06, 2018 at 08:51:55AM +0100, Mark Cave-Ayland wrote:
> Commit 29f9cef "ppc: Include vga cirrus card into the compiling process"
> changed the default display adapter for all PPC machines to cirrus. Unfor=
tunately
> it missed setting the default display type to stdvga for both PReP machin=
es
> causing the display to fail to initialise under OpenHackWare.
>=20
> Update the MachineClass for both prep and 40p machines so that the default
> std(vga) display adapter is the default if no options are specified
> which fixes the display for the PReP machines.
>=20
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>

Applied to ppc-for-3.0.

> ---
>  hw/ppc/prep.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 6689407b3d..3401570d98 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -682,6 +682,7 @@ static void prep_machine_init(MachineClass *mc)
>      mc->max_cpus =3D MAX_CPUS;
>      mc->default_boot_order =3D "cad";
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("602");
> +    mc->default_display =3D "std";
>  }
> =20
>  static int prep_set_cmos_checksum(DeviceState *dev, void *opaque)
> @@ -888,6 +889,7 @@ static void ibm_40p_machine_init(MachineClass *mc)
>      mc->block_default_type =3D IF_SCSI;
>      mc->default_boot_order =3D "c";
>      mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("604");
> +    mc->default_display =3D "std";
>  }
> =20
>  DEFINE_MACHINE("40p", ibm_40p_machine_init)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--8N5nZmKALFZnI1Hj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAltAIZ0ACgkQbDjKyiDZ
s5LlZw/7Bxu/vvslxFE3nXzswBoriM8hpx6pRhHFafpIX4REBrh69qs96K39Rpto
xF+M2orn6ZC52r3bvK+yn1lzsoDWZNpx8dKxy2Zg1ReY3rMxpHoe5m0OgHkmO4Bt
sLb6ohx99EHsx0gPdBdrQvJMojLkQTWjyBffgDAqL3PmWL8IbhJRqcCfF9B2R1Ez
2mGf8NibcAfOnZo7+UDNguiRNk/g5LsbGudgCdNbqUNAhGEPFZnb/YKIjQit3T89
zRF1q4VL2aYpLTod+O9SzaVWB+0hf3OU07Y0V8P5rMjomk32rfjMpBy4odlv9fe/
teka5eQWgWf9R5jQL/fi3XxiC50MrlUExHpd7H/Y8KahbfuIKznveO8/PYcUNvz3
WKMLorWhrmMpQOfp+CT++wOWVa3BeZnJhBjuhAEddJNoNodluLRUfyINPsk99kTt
ueOJQMQ+GqQpw+rwDhdOFtdN53KjXkyq7ZkL+PU/RAkbRrDuh3ff5AFE2Mldu3qn
3MyiWLXnksLx9M7HsstTJTWZUxiHWWp3cqgoIr0lDPbBHYqYJxwVNByRBP+q6P2c
tDCPR1Q5p/HeaiWO1CTNRVERHGgX6CNoSqnCYUZLBaJHLvzqZM/JWS3CHwTHjVo7
NUztuCNnB/ysDyEZgosBK7QGzhXxzT/zBiwxnA3Em26Gw6Z6PxA=
=obQM
-----END PGP SIGNATURE-----

--8N5nZmKALFZnI1Hj--
