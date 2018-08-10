Received: from eggs.gnu.org ([2001:4830:134:3::10]:54521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fnvtA-0005nm-7W
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 21:06:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1fnvt7-0004aU-1D
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 21:06:48 -0400
Date: Fri, 10 Aug 2018 11:06:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180810010627.GD4079@umbus>
References: <20180809204010.3579-1-hpoussin@reactos.org>
	<20180809204010.3579-3-hpoussin@reactos.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kvUQC+jR9YzypDnK"
Content-Disposition: inline
In-Reply-To: <20180809204010.3579-3-hpoussin@reactos.org>
Subject: Re: [Qemu-devel] [PATCH 2/2] hw/ppc: deprecate the machine type
 'prep', replaced by '40p'
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>
Cc: qemu-devel@nongnu.org, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Alexander Graf <agraf@suse.de>, qemu-ppc@nongnu.org


--kvUQC+jR9YzypDnK
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 09, 2018 at 10:40:10PM +0200, Herv=E9 Poussineau wrote:
> - prep machine is a fictional machine, so has no specifications. Which
>   devices can be changed/added/removed without impact? Are interrupts
>   correctly mapped?
> - prep firmware (OHW) has support only for IDE drives (no SCSI).
>   Booting from IDE has been broken approximatively 3 years ago, and nobod=
y complained.
> - OHW is limited on IDE boot to a specific set of OS loaders.
>   These operating systems are of the 2004 time frame.
> - OHW can use -kernel. Linux kernel freezes a long time after PS/2 mouse
>   detection, and then screen becomes garbage. This was already broken in
>   QEMU v2.7, 2 years ago, and nobody complained.
>=20
> On the other side:
> - 40p is a real machine, so emulation can be checked against
>   hardware specifications
> - OpenBIOS has support for SCSI block devices, including 40p LSI adapter
> - OpenBIOS can start mostly all Linux kernels (including recent ones)
>   and recent operating system (like NetBSD 7.1.2)
>=20
> Signed-off-by: Herv=E9 Poussineau <hpoussin@reactos.org>

Applied to ppc-for-3.1.

> ---
>  hw/ppc/prep.c | 1 +
>  1 file changed, 1 insertion(+)
>=20
> diff --git a/hw/ppc/prep.c b/hw/ppc/prep.c
> index 1558855247..fbcaebabc0 100644
> --- a/hw/ppc/prep.c
> +++ b/hw/ppc/prep.c
> @@ -676,6 +676,7 @@ static void ppc_prep_init(MachineState *machine)
> =20
>  static void prep_machine_init(MachineClass *mc)
>  {
> +    mc->deprecation_reason =3D "use 40p machine type instead";
>      mc->desc =3D "PowerPC PREP platform";
>      mc->init =3D ppc_prep_init;
>      mc->block_default_type =3D IF_IDE;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kvUQC+jR9YzypDnK
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlts5RMACgkQbDjKyiDZ
s5LzCQ//ZV0MC0Ju4aqJy7gaZCeY+3AmThtOVtNw24i8zeZ2SLIwR6chK9kcO+ma
wM1Cz9b/CBa0c8hDI5e3ndMa/qf5J+iRDwVl4TZwbrJ9bH222cG7Qbz1flMQRV5I
h918e1bpUCHhSWmKnPwT7BPXJnZvod/2FEVDvnZoc8hFSy7bhk7tqz2UcmEFPrGZ
sdPNFjlYUGKVwI9I+BfnaY6m8A0Hl9WxN/jiznQXqYhci+iEQ/aHJD9SAI6NiD5G
GRLlvKvXZu9YO0l83KZjXpNtHWjGVLv5a2Ex7mlnxojsyWk+fyGy23ptHZsDUJ4o
+IHxGVBnAkqi3Fcl/wyMawtmtC6USteG7TJBlUWwtlGSH+pLV2afSZniKhuGMRKD
3rquqp+bQH7QCIRKKu67qhZyC6VXYQYJpyoWMqY4h7u4/Kj69eOKkVtmNtQzh+Rx
sCZQ1nL2u6kB+mZ32pOq84rbAqyKmjKbQ3ZyCC6C9sW0wsP5Aqs2K+REZh3K4KeG
ZrJLuExB/RjYhzyD/lOeXB0D6RfP+t3rtjO2OsJraRavRbz0hMhOtqjUvlXu7RZA
AX2kt/oDawDne1Ym+wddNOth2ZYJ+hy2cytEAnpe4T4upWeB37Hzo3bIgCfsN9sC
vIrbw00urfQ2Lc+7RbPTSGO7ME6dv6IX9RWtJPPr9DHrKKS+6xU=
=37U6
-----END PGP SIGNATURE-----

--kvUQC+jR9YzypDnK--
