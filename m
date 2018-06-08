Received: from eggs.gnu.org ([2001:4830:134:3::10]:33469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fRFiV-0007uQ-00
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 07:38:03 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fRFiR-0008Oc-Qz
	for qemu-devel@nongnu.org; Fri, 08 Jun 2018 07:38:03 -0400
Date: Fri, 8 Jun 2018 21:24:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180608112433.GV3344@umbus.fritz.box>
References: <152845121577.13960.4480474870896921301.stgit@bahia.lan>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="TPGKQYD3WP7vMswh"
Content-Disposition: inline
In-Reply-To: <152845121577.13960.4480474870896921301.stgit@bahia.lan>
Subject: Re: [Qemu-devel] [PATCH v4] target/ppc: Allow PIR read in
 privileged mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, leandro.lupori@gmail.com


--TPGKQYD3WP7vMswh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 08, 2018 at 11:46:55AM +0200, Greg Kurz wrote:
> From: luporl <leandro.lupori@gmail.com>
>=20
> According to PowerISA, the PIR register should be readable in privileged
> mode also, not only in hypervisor privileged mode.
>=20
> PowerISA 3.0 - 4.3.3 Processor Identification Register
>=20
> "Read access to the PIR is privileged; write access is not provided."
>=20
> Figure 18 in section 4.4.4 explicitly confirms that mfspr PIR is privileg=
ed
> and doesn't require hypervisor state.

Applied, thanks.

>=20
> Cc: David Gibson <david@gibson.dropbear.id.au>
> Cc: Alexander Graf <agraf@suse.de>
> Cc: qemu-ppc@nongnu.org
> Signed-off-by: Leandro Lupori <leandro.lupori@gmail.com>
> Reviewed-by: Jose Ricardo Ziviani <joserz@linux.ibm.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
> Changes in v2:
> - added my Signed-off-by, maintainers CC and Jose's Reviewed-by tags
>=20
> Changes in v3:
> - added subsystem name, version tag and summary of changes
> - added the section of PowerISA that describes PIR access privileges
>=20
> Changes in v4 (Greg):
> - rebased against ppc-for-3.0 (ie, file is now target/ppc/translate_init.=
inc.c)
> - added some more context from PowerISA
> ---
>  target/ppc/translate_init.inc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/target/ppc/translate_init.inc.c b/target/ppc/translate_init.=
inc.c
> index 1a89017ddea8..bb9296f5a3da 100644
> --- a/target/ppc/translate_init.inc.c
> +++ b/target/ppc/translate_init.inc.c
> @@ -7819,7 +7819,7 @@ static void gen_spr_book3s_ids(CPUPPCState *env)
>      /* Processor identification */
>      spr_register_hv(env, SPR_PIR, "PIR",
>                   SPR_NOACCESS, SPR_NOACCESS,
> -                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, SPR_NOACCESS,
>                   &spr_read_generic, NULL,
>                   0x00000000);
>      spr_register_hv(env, SPR_HID0, "HID0",
>=20

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--TPGKQYD3WP7vMswh
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlsaZ28ACgkQbDjKyiDZ
s5L2OhAArItP0Z0Kv8KhHcGTq4cgArDPlzTr+KXkpGsRLUR0toaRiafhskWArFpG
RvGwXN44wXcdwmR4L2KQbKGS/ZubES3ThCk+NGGIS0n7F6Jc+TKlDVLIMRHHH0Lu
YpNoq6vPbZW4a48ex9yktE3Wtot/zjW00FnnDQMvvUQg+nhcNsjiXJbXfqdlPVkz
EEXeCfBSt/HLnQ+UVS+7vFCcv4pqoTREeKqWl4rFPgSh3tobzEMbI8PhrbLu4QoL
7RKNusodPYybVcO0FHD8h2qi93HLbXWy8MISltPs6pSC9Y8Y7oWPY9PpCUeUT1x/
ie28x1La1m6OqFPIt4rdYVSsJBX/z8ba61PjA03dpfr2kzHy8quKXv9IDQRj8gfO
po8Rl439JBpw0hm8gt+v+HmbrSb77pSql2/PKumIajWMfF+E2aDhxgAK9Kh5LmKt
yn7ZBCAcwH0tKV4tgAAXTdr11/NJRm7fNAdHPTMkyqsJd5cL5Y59vHMRoN4JqeHm
IuaX3+qgaHmuQ164mZlnoe9w85kqygd5qwNL80ETv3WgkdthgBjSMaJAtAFJJfQ+
dhHHAmQKh35DvxZxCzmko9lDoGk9EQrj9aA5cE7YR4IXCX9PN6V/UyiSQwvhiwhu
D7Q+Tqf5+A1tmpm01hvzvZwJ7NmX0NnRIPM4E87lHtv3MxsuZ/I=
=eZfZ
-----END PGP SIGNATURE-----

--TPGKQYD3WP7vMswh--
