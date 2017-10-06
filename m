Received: from eggs.gnu.org ([2001:4830:134:3::10]:36767)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCl-0002MG-QG
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1e0JCj-0005G4-Ee
	for qemu-devel@nongnu.org; Thu, 05 Oct 2017 23:21:39 -0400
Date: Fri, 6 Oct 2017 14:11:09 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20171006031109.GJ3260@umbus.fritz.box>
References: <1507220690-265042-1-git-send-email-imammedo@redhat.com>
	<1507220690-265042-8-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="U5yJ31ax00IavOwq"
Content-Disposition: inline
In-Reply-To: <1507220690-265042-8-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 07/23] ppc: bamboo: use generic cpu_model
 parsing
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@suse.de>, =?iso-8859-1?Q?Herv=E9?= Poussineau <hpoussin@reactos.org>, "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, "open list:ppce500" <qemu-ppc@nongnu.org>


--U5yJ31ax00IavOwq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


On Thu, Oct 05, 2017 at 06:24:34PM +0200, Igor Mammedov wrote:
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  hw/ppc/ppc440_bamboo.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
>=20
> diff --git a/hw/ppc/ppc440_bamboo.c b/hw/ppc/ppc440_bamboo.c
> index f92d47f..693c215 100644
> --- a/hw/ppc/ppc440_bamboo.c
> +++ b/hw/ppc/ppc440_bamboo.c
> @@ -182,11 +182,7 @@ static void bamboo_init(MachineState *machine)
>      int success;
>      int i;
> =20
> -    /* Setup CPU. */
> -    if (machine->cpu_model =3D=3D NULL) {
> -        machine->cpu_model =3D "440EP";
> -    }
> -    cpu =3D POWERPC_CPU(cpu_generic_init(TYPE_POWERPC_CPU, machine->cpu_=
model));
> +    cpu =3D POWERPC_CPU(cpu_create(machine->cpu_type));
>      env =3D &cpu->env;
> =20
>      if (env->mmu_model !=3D POWERPC_MMU_BOOKE) {
> @@ -297,6 +293,7 @@ static void bamboo_machine_init(MachineClass *mc)
>  {
>      mc->desc =3D "bamboo";
>      mc->init =3D bamboo_init;
> +    mc->default_cpu_type =3D POWERPC_CPU_TYPE_NAME("440epb");
>  }
> =20
>  DEFINE_MACHINE("bamboo", bamboo_machine_init)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--U5yJ31ax00IavOwq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlnW9E0ACgkQbDjKyiDZ
s5JvOhAAtH7+AnyoYideFkUUd3his0B36biZGsaohdr3AszUh7pWyc7jCFSGm3Nx
R7sewx+gkkKwKSGqPkBGg1yBzkT1rRwMb7k1dfsFEOVsYd6SmIU1YYUJs2npYyKB
i7NsA0yUb/NorsByjokKs644qOgWERXR6r75pAbooTPGbCiLzsQ38BwY6X0SsLzs
MJJEwfLuljjOCjn3f7tQYaG3T5s4ifMZggQQLN0Ee/K0HeF07JAylMxg4XopOL5V
ySJBjVhxQ8IkCwxD1tX0WgltM+3DStL2yatDRvJMXe9vycxVIhe3/q00uxccWlpb
qwfMJUUWrJ86QEhHcNsfWRhV/UgWOhCGNHLIiYuZtLTue6CHE5WtHOnPwTtQYNgD
y/mQDNwfP5PkhiFOZ1ErM1SIunD5kSz+4clh9tn5adfiSPW+bDLyj7C3hQ/3PT6h
YnVcBpkpPZtXMBNmpM1PJ56/Ny52cD23dR1l0xBnT2mp7rJ+u1szVljTekI/318m
lRewn/9QyS3VGIzBv/A8bjJL72GyTM+43MDt0s1JioFWtmZXkc90MYa7T7GCwUwC
U/uzJFGHstFavuW1z4N/7RmGPK2cM2y/8Hhe+pl1WcDyTTkTRFUOyyCutDv2lRwC
5+NzuGfTgowNA7tgmhD+ph98l6fWmiuB999YuSqk1zhRLvH9Yl4=
=n+94
-----END PGP SIGNATURE-----

--U5yJ31ax00IavOwq--
