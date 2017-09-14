Received: from eggs.gnu.org ([2001:4830:134:3::10]:38425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsIKK-0004v8-5I
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 20:48:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1dsIKJ-0007Tv-5v
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 20:48:20 -0400
Date: Thu, 14 Sep 2017 10:14:09 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170914001409.GG3972@umbus.fritz.box>
References: <20170913142036.2469-1-lvivier@redhat.com>
	<20170913142036.2469-2-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="kjpMrWxdCilgNbo1"
Content-Disposition: inline
In-Reply-To: <20170913142036.2469-2-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v4 1/4] hmp: fix "dump-quest-memory"
 segfault (ppc)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Laurent Vivier <lvivier@redhat.com>
Cc: "Dr . David Alan Gilbert" <dgilbert@redhat.com>, qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, Greg Kurz <groug@kaod.org>


--kjpMrWxdCilgNbo1
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 13, 2017 at 04:20:33PM +0200, Laurent Vivier wrote:
> Running QEMU with
>     qemu-system-ppc64 -M none -nographic -m 256
> and executing
>     dump-guest-memory /dev/null 0 8192
> results in segfault
>=20
> Fix by checking if we have CPU, and exit with
> error if there is no CPU:
>=20
>     (qemu) dump-guest-memory /dev/null
>     this feature or command is not currently supported
>=20
> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> Reviewed-by: Greg Kurz <groug@kaod.org>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
>  target/ppc/arch_dump.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
>=20
> diff --git a/target/ppc/arch_dump.c b/target/ppc/arch_dump.c
> index 8e9397aa58..95b9ab6f29 100644
> --- a/target/ppc/arch_dump.c
> +++ b/target/ppc/arch_dump.c
> @@ -224,8 +224,15 @@ typedef struct NoteFuncDescStruct NoteFuncDesc;
>  int cpu_get_dump_info(ArchDumpInfo *info,
>                        const struct GuestPhysBlockList *guest_phys_blocks)
>  {
> -    PowerPCCPU *cpu =3D POWERPC_CPU(first_cpu);
> -    PowerPCCPUClass *pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> +    PowerPCCPU *cpu;
> +    PowerPCCPUClass *pcc;
> +
> +    if (first_cpu =3D=3D NULL) {
> +        return -1;
> +    }
> +
> +    cpu =3D POWERPC_CPU(first_cpu);
> +    pcc =3D POWERPC_CPU_GET_CLASS(cpu);
> =20
>      info->d_machine =3D PPC_ELF_MACHINE;
>      info->d_class =3D ELFCLASS;

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--kjpMrWxdCilgNbo1
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm5yc4ACgkQbDjKyiDZ
s5KfFBAArG6NHKIXQhjW4z6VFtPr1Xe972lUA2yf/KLetpA7zXMOmRur21WoqVFv
xSuANg8hDaN8dZXlDzYOsOe9nhkuViMsk6K2nABhPMGR6HRl2MLE9/36Id/V2b0R
cLTPJMw2xMN/VftSROkLt0aghTHS/kEzyEyldrgiwVovotEwlWL477WBs/T2s6b/
UQrEKdvrrIw3T/CSWF29DNvMhzNCyTO+NADaaX+qPC7+ZD39MPtASwj8RyRaIic7
xvREhXIDdcHitMbH165ul+/UF7SKDLeVU5C6RjGRy2wypxAsV72sll9suJoi26h2
/6U906ORIjojRIPTz7VGYNXPSlGKfQ95Vk/wP8G0ck2KLN6n9M9uXWWL/n6iF8uE
+OImJHvUloOTvhaIR7ioCiIdaC7sDuWFgnNU0yV/aOQhGITyBL/w/3YvKUjH+yWx
rjrC8eTVQ43G15/iSLsspydIJoBxdFLgVmX7kUHIp6iD0cGdqqbTB+59qAldgcer
EbmC50HvPq7R1LrT4MEUZp79Y1y81jZyT4HmyHsUPvhoV5GdXRqVstG7t93ijwKs
W15FXb6p68RqpUJMu402Gt342sgBCknj/k9TMbtqw272Su/8glzybuy8tZ9K4DwU
ElYVozE6npGTKug0IxvGwTwACgaABmy9F0kOkxTISvBMmZTiUFs=
=pphb
-----END PGP SIGNATURE-----

--kjpMrWxdCilgNbo1--
