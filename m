Received: from eggs.gnu.org ([2001:4830:134:3::10]:56608)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ3l9-0003Yv-Jm
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 17:52:16 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1cZ3l6-0000Y4-HW
	for qemu-devel@nongnu.org; Wed, 01 Feb 2017 17:52:15 -0500
Date: Thu, 2 Feb 2017 09:27:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170201222755.GB13219@umbus.fritz.box>
References: <1485946990-11090-1-git-send-email-thuth@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="uZ3hkaAS1mZxFaxD"
Content-Disposition: inline
In-Reply-To: <1485946990-11090-1-git-send-email-thuth@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] hw/ppc/pnv: Use error_report instead of
 hw_error if a ROM file can't be found
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


--uZ3hkaAS1mZxFaxD
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 01, 2017 at 12:03:10PM +0100, Thomas Huth wrote:
> hw_error() is for CPU related errors only (it dumps the CPU registers
> and  calls abort()!), so using error_report() is the better choice
> of reporting an error in case we simply did not find a file.
>=20
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Applied to ppc-for-2.9.

> ---
>  hw/ppc/pnv.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 83597fe..4fab5c0 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -381,7 +381,7 @@ static void ppc_powernv_init(MachineState *machine)
> =20
>      fw_size =3D load_image_targphys(fw_filename, FW_LOAD_ADDR, FW_MAX_SI=
ZE);
>      if (fw_size < 0) {
> -        hw_error("qemu: could not load OPAL '%s'\n", fw_filename);
> +        error_report("qemu: could not load OPAL '%s'", fw_filename);
>          exit(1);
>      }
>      g_free(fw_filename);
> @@ -393,8 +393,8 @@ static void ppc_powernv_init(MachineState *machine)
>          kernel_size =3D load_image_targphys(machine->kernel_filename,
>                                            KERNEL_LOAD_ADDR, 0x2000000);
>          if (kernel_size < 0) {
> -            hw_error("qemu: could not load kernel'%s'\n",
> -                     machine->kernel_filename);
> +            error_report("qemu: could not load kernel'%s'",
> +                         machine->kernel_filename);
>              exit(1);
>          }
>      }

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--uZ3hkaAS1mZxFaxD
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJYkmDrAAoJEGw4ysog2bOS/mMQAKApfNO+eeFvmgY30tFkWKEE
b7JlHThP9gRgBuFA4d0B5JISzkw9xD2qZUy8aeZN0jYXBteMbVsYHVU4NvlEhehO
BZbi37pF8XwLIKeBwzPRt3SAA0JuwR0/Aakiyie329/S3f0k/t7ueoSZMz1VYuKx
cr6MLXTU84f5ii9Ad0h9PAqeD5RHtZu53Mv5sCjXCvF1I2XfPS8LzTwpa7CI8YOy
v0SyPwA11amY1PQNjt7nGrdnhEszOfWbcxiJII6tLAGzqqPVnz9aFHJdrW71ANUu
psAciE60mQXUh2T4PffwqNadzOpsuIsfdXb8Q3Lu51kqPv8kvT2qiqv0NFhCLIWD
Gkj+WPmNBGdaR5oCY+ARH7KHA/U8XuuAAKqxgixvmsZHo0SMdHfC5Jf8fhS85RPJ
4O/P8gYee5LqasDWi4gFsmaXsF8cccIBf9VIewg8VR4f+4tOdriCn3094jxJhJZJ
5eT/FcZZywnA9IXgb9oeQjnxbCc5+lpdwo3XsTbdXLOoxiiX0wR4Gqc0L2E5wV8h
aMuXOd/s/brxBwEzdD1D6NXmUaYnZY9R6U+/bp61QU/yTnKynpYnML9REe+Wrcax
HCefm/9aCTfanhzVOaRzdU2aG0E9kus4Z0d4eqjhV07deoJmH4Cv8xmRYSpFsqOZ
PbiyBkCzemGXn9A9Zkro
=f2rb
-----END PGP SIGNATURE-----

--uZ3hkaAS1mZxFaxD--
