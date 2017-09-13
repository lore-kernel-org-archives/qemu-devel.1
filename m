Received: from eggs.gnu.org ([2001:4830:134:3::10]:57441)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ds0L9-0005kY-QX
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 01:36:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1ds0L8-0004P7-LG
	for qemu-devel@nongnu.org; Wed, 13 Sep 2017 01:35:59 -0400
Date: Wed, 13 Sep 2017 15:35:33 +1000
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20170913053533.GF7550@umbus.fritz.box>
References: <20170912140149.7692-1-lvivier@redhat.com>
	<20170912140149.7692-2-lvivier@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="s5/bjXLgkIwAv6Hi"
Content-Disposition: inline
In-Reply-To: <20170912140149.7692-2-lvivier@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/3] hmp: fix "dump-quest-memory"
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
Cc: qemu-devel@nongnu.org, "Daniel P . Berrange" <berrange@redhat.com>, Cornelia Huck <cohuck@redhat.com>, Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org, qemu-ppc@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Greg Kurz <groug@kaod.org>


--s5/bjXLgkIwAv6Hi
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 12, 2017 at 04:01:47PM +0200, Laurent Vivier wrote:
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

Applied to ppc-for-2.11.  I'm not really sure what to do with the rest
of the series though.

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

--s5/bjXLgkIwAv6Hi
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlm4w6UACgkQbDjKyiDZ
s5I49A/8D8OoS1m+Hj9mqIIhNCXPCUoUu3JciF/6KaMDhsRf5iVHFh4f57S4JBV1
kDY3KVMgHr3XDi0Ne8NuHoOxMCvso2qHl6EJzLdzL5DDLMDF8VbRwwph/ZZsg7we
8lOEQJHGFRTc9Vm8IJ+JJO3w0gc04AHhm6cSgGXiIB1VQCwO2nJqjt4kqlinvg10
teAIca6k/3/KBO1fmoLLBcBDnNWB11WFa5AUilY42zzsMB8ZMXDILB/kN6IxmfgE
1DR/H7wHFeTr01bwlflLdY3usKthYhIypAz9+a4mZuzE4/zBc7z3elhwUeFDLZCR
0y+Uw1HtmU9h3oM6ybkMYIxoN4NS7r4XKkFwL6tYeao4mM0WnshMe0gKIf9NS8dL
XRIvbqRDyuu01JS6/fmocYcSNok1wUhzUrbqMiWrFAkc701aceBTWnPqiLm3z5xf
81f5O76CKuC0XXDAkJegjxhE603FaZg+b03gHs6Fuojjs3OfgNIjGNG3+617BZyx
EhQne7q3gvESA48oVcroDZk8jZeHKzr9JhWCWDTtvBHClxNDnJstvmqqQDjWI+D2
IxA6NZBxoI7PLJ0XgsrxuUth1F+odLxF8ZwCupVIiDfCcS2O5rUhe6CzrlXgpacz
BLDrsKXO9yaCmivQsYYqQUTNEszL2i2pPVTGyhNlJlzVB7gPJlw=
=JniD
-----END PGP SIGNATURE-----

--s5/bjXLgkIwAv6Hi--
