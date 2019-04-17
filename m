Received: from eggs.gnu.org ([209.51.188.92]:57934)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGdnR-0007vd-P9
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 02:11:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1hGdnQ-0002XB-Lu
	for qemu-devel@nongnu.org; Wed, 17 Apr 2019 02:11:49 -0400
Date: Wed, 17 Apr 2019 15:23:38 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20190417052338.GO32705@umbus.fritz.box>
References: <20190417025944.16154-1-ehabkost@redhat.com>
	<20190417025944.16154-4-ehabkost@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="3snK74p7ddXn3Qrx"
Content-Disposition: inline
In-Reply-To: <20190417025944.16154-4-ehabkost@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 3/5] linux-user: Use lookup_cpu_class()
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


--3snK74p7ddXn3Qrx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Apr 16, 2019 at 11:59:42PM -0300, Eduardo Habkost wrote:
> The return value of cpu_get_model() is just a CPU model name and
> never includes extra options.  We don't need to call
> parse_cpu_option().
>=20
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  linux-user/main.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/linux-user/main.c b/linux-user/main.c
> index 20e0f51cfa..d74108e05c 100644
> --- a/linux-user/main.c
> +++ b/linux-user/main.c
> @@ -592,6 +592,7 @@ int main(int argc, char **argv, char **envp)
>      TaskState *ts;
>      CPUArchState *env;
>      CPUState *cpu;
> +    CPUClass *cc;
>      int optind;
>      char **target_environ, **wrk;
>      char **target_argv;
> @@ -660,7 +661,8 @@ int main(int argc, char **argv, char **envp)
>      if (cpu_model =3D=3D NULL) {
>          cpu_model =3D cpu_get_model(get_elf_eflags(execfd));
>      }
> -    cpu_type =3D parse_cpu_option(cpu_model);
> +    cc =3D lookup_cpu_class(cpu_model, &error_fatal);
> +    cpu_type =3D object_class_get_name(OBJECT_CLASS(cc));
> =20
>      /* init tcg before creating CPUs and to get qemu_host_page_size */
>      tcg_exec_init(0);

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--3snK74p7ddXn3Qrx
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAly2uFoACgkQbDjKyiDZ
s5JyeQ//Ya0MRbINQEKGC/4E0UfDqIQxlDjrC0rdkNPR+Iq2IBmRl2MfxLa3IQXc
lDbbCM6qCd7EPw6SY8LolqHEoG1a6CLazxsH3hXOeBIFLXUSCd2S7ky7YJSTcg/Z
sXy6LkM0Fi2pMuq8CntH8vsVVL9MHauVfCNla5U2Suy45PGpB+V3aaexXqJ7Dpru
T3iLx52GAwRe0I8Z2wxDJfbzCufafVcKfn1D1fCRI0P38g+vusKXGJOuC777Mhbt
/5t+t1YD8nbi3kgTQV3nvPldXP8LRc+AJ/mOrc6YfwUV2aA+B60WRyryZhbpBJ0O
jKrZsPY58E++IBe2rVzEp9Cjw/FtBuumwa6EHEfXxCZQblS0pFYDQb6SsZwEEPBK
tSEOneSc6vg7nkDGtFER2mzvg9u8b7Zh63djd8HjEOpagItNvPXFbcU+o87eGJkk
NfTO3N6u2aH1uBFjnQPLhROrbgIVNU/qgZXB5ye3oH6xjh1Hh6gWWqLwijSgyc6N
ur93GCgccPK/tNA3Qae7GsUnJ/yl8Po8N+1Ya6q2kssxpMJzy7i8VWiKT536NQV7
gD0eEVMl+y8jHSsrAzSmGoMLKjICXQ8xyUMni3koHimqW2cpO/WWZLCalTgHJhYi
pSf3MRAznJ0q3tJCMoT48176nnECtjer0EajkkCOrvbYLWeCzl8=
=94jm
-----END PGP SIGNATURE-----

--3snK74p7ddXn3Qrx--
