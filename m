Received: from eggs.gnu.org ([209.51.188.92]:57937)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGdnR-0007ve-Sb
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 02:11:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGdnQ-0002XW-N2
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 02:11:49 -0400
Date: Wed, 17 Apr 2019 15:23:56 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190417052356.GP32705@umbus.fritz.box>
References: <20190417025944.16154-1-ehabkost@redhat.com>
	<20190417025944.16154-5-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="24/piotZLKF/SXqU"
Content-Disposition: inline
In-Reply-To: <20190417025944.16154-5-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 4/5] bsd-user: Use lookup_cpu_class()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Paolo Bonzini <pbonzini@redhat.com>, Riku Voipio <riku.voipio@iki.fi>, Like Xu <like.xu@linux.intel.com>, Richard Henderson <rth@twiddle.net>, Thomas Huth <thuth@redhat.com>, Igor Mammedov <imammedo@redhat.com>, qemu-ppc@nongnu.org, Markus Armbruster <armbru@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, Artyom Tarasenko <atar4qemu@gmail.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


--24/piotZLKF/SXqU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 11:59:43PM -0300, Eduardo Habkost wrote:
> The hardcoded CPU models in the code are just CPU models and
> don't include any extra options.  We don't need to call
> parse_cpu_options().
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  bsd-user/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/bsd-user/main.c b/bsd-user/main.c
> index a6c055f5fb..d2915a9951 100644
> --- a/bsd-user/main.c
> +++ b/bsd-user/main.c
> @@ -732,6 +732,7 @@ int main(int argc, char **argv)
>      TaskState ts1, *ts =3D &ts1;
>      CPUArchState *env;
>      CPUState *cpu;
> +    CPUClass *cc;
>      int optind;
>      const char *r;
>      int gdbstub_port =3D 0;
> @@ -903,7 +904,8 @@ int main(int argc, char **argv)
>      /* init tcg before creating CPUs and to get qemu_host_page_size */
>      tcg_exec_init(0);
> =20
> -    cpu_type =3D parse_cpu_option(cpu_model);
> +    cc =3D lookup_cpu_class(cpu_model, &error_fatal);
> +    cpu_type =3D object_class_get_name(OBJECT_CLASS(cc));
>      cpu =3D cpu_create(cpu_type);
>      env =3D cpu->env_ptr;
>  #if defined(TARGET_SPARC) || defined(TARGET_PPC)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--24/piotZLKF/SXqU
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly2uGwACgkQbDjKyiDZ
s5I4qA//Un3ylIUuBSAN/ZuCQ53tYfLroprqFxMK1jmlJsK+SUxAi1o/smZb9Egq
I92aeWiimbB14XLNtf+Y/zDoB5h6vlLZi8XtW9t9R+9/rhY5MeezZZPKdrDVQVa3
3fODXYCdlUNBg/IB+2EZUTE5cn8fsbasNx0Q8TsR8UA+Xx74DuY7ehalzLnf6rWc
+dJmQr8rinjJGhWnRXA9Z9OI0gI5xku/GMh6flTvVnKCwkIIVPPlV4C4sA1m2ekI
R+TlIzVQJpFEDIf+lx7Rb4YwqGDE/RTgT7IiZFoSdBbbkzlyq1mjUZiVoYJKormV
pKKnZAFosRW3N+rhm3AONcReo3QaRvNWVZAeCQbweRxWYxw5bP8oClQdiDJyuTrn
pkn/kiiTkbTR9SZn5UArCeljXYTEgK+FHnEQOd4siz+G1J8sTvouOSp8wOGGdReF
o5uv0A1h8MUCQnrl+26WcnYMwWCk76EsTjojtLSHNe4PPKzPjGuy1nb69p1bUJnj
SdcLXatqPt8+3644eLNTWadHsUdtzcLlh908eXoHdGbDdLihOq0Em5v8O0asKML5
sRQtuBLv0TpiMzGLeH0En74GJ0YEwoVvSlJGp+LIdI8rvopHPavdVAPWQS8svBqm
jM01e1hqtuYuMmDldtMUXl16QCXojIk46n4kL9ldYL8PHS+qG6Q=
=gTSH
-----END PGP SIGNATURE-----

--24/piotZLKF/SXqU--
