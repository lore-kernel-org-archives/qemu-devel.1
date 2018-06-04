Received: from eggs.gnu.org ([2001:4830:134:3::10]:47343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPeAE-0006CK-A7
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 21:20:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fPeAD-0003K8-6S
	for qemu-devel@nongnu.org; Sun, 03 Jun 2018 21:20:02 -0400
Date: Mon, 4 Jun 2018 10:53:22 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180604005322.GE4251@umbus>
References: <20180507180835.4b7b9222@bahia.lan>
	<20180507165242.46502-1-leandro.lupori@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="BZaMRJmqxGScZ8Mx"
Content-Disposition: inline
In-Reply-To: <20180507165242.46502-1-leandro.lupori@gmail.com>
Subject: Re: [Qemu-devel] [PATCH v3] target/ppc: Allow PIR read in
 privileged mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: luporl <leandro.lupori@gmail.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--BZaMRJmqxGScZ8Mx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, May 07, 2018 at 01:52:42PM -0300, luporl wrote:
> According to PowerISA, the PIR register should be readable in privileged
> mode also, not only in hypervisor privileged mode.
>=20
> PowerISA 3.0 - 4.3.3 Processor Identification Register
>=20
> "Read access to the PIR is privileged; write access is not
> provided."

Yes... but a little further down it says "The PIR is a hypervisor
resource".  Looking at the older 2.07 ISA, it says that
guest-supervisor mode reads to the PIR should be redirected to the
GPIR register, which this change won't accomplish.

So, I'm not sure what to make of this.

>=20
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Leandro Lupori <leandro.lupori@gmail.com>
> Reviewed-by: Jose Ricardo Ziviani <joserz@linux.ibm.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> ---
> Changes in v2:
> - added my Signed-off-by, maintainers CC and Jose's Reviewed-by tags
>=20
> Changes in v3:
> - added subsystem name, version tag and summary of changes
> - added the section of PowerISA that describes PIR access privileges
>=20
>  target/ppc/translate_init.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/translate_init.c b/target/ppc/translate_init.c
> index a72be6d121..7b56e3ffb9 100644
> --- a/target/ppc/translate_init.c
> +++ b/target/ppc/translate_init.c
> @@ -7816,7 +7816,7 @@ static void gen_spr_book3s_ids(CPUPPCState *env)
>      /* Processor identification */
>      spr_register_hv(env, SPR_PIR, "PIR",
>                   SPR_NOACCESS, SPR_NOACCESS,
> -                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, SPR_NOACCESS,
>                   &spr_read_generic, NULL,
>                   0x00000000);
>      spr_register_hv(env, SPR_HID0, "HID0",

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--BZaMRJmqxGScZ8Mx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsUjYIACgkQbDjKyiDZ
s5IrKw//ewYw+2Z/RqHMosXjzJOfjTnHFWdSc2uEkskP8w5lOR4JhANWcEaOuG0t
QgAhywFQku3wUbj0zbeNHouh6yslnsgJUSUHQWFlBUGbrU7ShCM8KTSdn704I15b
yyowKGeqttFfcMYYulY3NIrKiCnTgQ3sp59alUAAziphcDgwVtfjtz7zBBQBqQZ9
FKOkWrKOBRXeWz4sfIJFxsX8H1kVU7qXHf4XKe6KZBDaJsAQayerCCEncqxOFqHB
nJT3Y9CTTUF/PRpHdcmY/F9DFIdzIEDsyblh/tQ8UteQfFLape1kl9PNEqA1SKQ0
B79KE6ju4aDHtrabgGWEmCV9cinXzGkrUdbGcyWtKfS1dIHgXUUwQ+bbFT44OHop
1Zjcl80gc7KD1wvxi8CJLR4T6vh0du0lBJo0P3Ah+mtnOl6z5wKDWztkGfB1K3VS
DZE+U43WOPx0KckJQGphHbzQujRe+7nMSpkBM0ow9svM01HHCbZJfQYUwre4YtHl
lv4qrliUS2/lx75wW0QUHpA6xApG/TwnTAQ1t1sxWZUdvVbe62g3s6VLAMew44HO
GZRwsKHdpCHVMVdC39Nof1RxUMMMMRlpGecVLyZ7Pb20HjO93vYkZ8q7Yu0iQ6CY
Mal7V/6EXc5lJv5ZXZ/aro+RHbgDaMtBVLi5V9N9B1HRFH2FKDM=
=2fel
-----END PGP SIGNATURE-----

--BZaMRJmqxGScZ8Mx--
