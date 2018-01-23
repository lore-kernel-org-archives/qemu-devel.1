Received: from eggs.gnu.org ([2001:4830:134:3::10]:47568)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1edwYE-0004Zb-MW
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:15:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgibson@ozlabs.org>) id 1edwYD-0005ZU-GX
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 06:15:38 -0500
Date: Tue, 23 Jan 2018 22:14:55 +1100
From: David Gibson <david@gibson.dropbear.id.au>
Message-ID: <20180123111455.GG11419@umbus>
References: <1516694904-64879-1-git-send-email-imammedo@redhat.com>
	<1516694904-64879-15-git-send-email-imammedo@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="1Ow488MNN9B9o/ov"
Content-Disposition: inline
In-Reply-To: <1516694904-64879-15-git-send-email-imammedo@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v3 14/25] ppc: cpu: add CPU_RESOLVING_TYPE
 macro
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, Laurent Vivier <laurent@vivier.eu>, Eduardo Habkost <ehabkost@redhat.com>, qemu-s390x@nongnu.org, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Alexander Graf <agraf@suse.de>


--1Ow488MNN9B9o/ov
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 23, 2018 at 09:08:13AM +0100, Igor Mammedov wrote:
> it will be used for providing to cpu name resolving class for
> parsing cpu model for system and user emulation code.
>=20
> Along with change add target to null-machine test, so
> that when switch to CPU_RESOLVING_TYPE happens,
> test would ensure that null-mchine usecase still works.
>=20
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Acked-by: David Gibson <david@gibson.dropbear.id.au>

> ---
> CC: Laurent Vivier <laurent@vivier.eu>
> CC: David Gibson <david@gibson.dropbear.id.au>
> CC: Alexander Graf <agraf@suse.de>
> CC: qemu-ppc@nongnu.org
> ---
>  target/ppc/cpu.h          | 1 +
>  tests/machine-none-test.c | 3 +++
>  2 files changed, 4 insertions(+)
>=20
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 603a38c..d5f2f3d 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -1380,6 +1380,7 @@ int ppc_dcr_write (ppc_dcr_t *dcr_env, int dcrn, ui=
nt32_t val);
> =20
>  #define POWERPC_CPU_TYPE_SUFFIX "-" TYPE_POWERPC_CPU
>  #define POWERPC_CPU_TYPE_NAME(model) model POWERPC_CPU_TYPE_SUFFIX
> +#define CPU_RESOLVING_TYPE TYPE_POWERPC_CPU
> =20
>  #define cpu_signal_handler cpu_ppc_signal_handler
>  #define cpu_list ppc_cpu_list
> diff --git a/tests/machine-none-test.c b/tests/machine-none-test.c
> index 160aa13..052b8c0 100644
> --- a/tests/machine-none-test.c
> +++ b/tests/machine-none-test.c
> @@ -41,6 +41,9 @@ static struct arch2cpu cpus_map[] =3D {
>      { "moxie", "MoxieLite" },
>      { "nios2", "FIXME" },
>      { "or1k", "or1200" },
> +    { "ppc", "604" },
> +    { "ppc64", "power8e_v2.1" },
> +    { "ppcemb", "440epb" },
>  };
> =20
>  static const char *get_cpu_model_by_arch(const char *arch)

--=20
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson

--1Ow488MNN9B9o/ov
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEdfRlhq5hpmzETofcbDjKyiDZs5IFAlpnGSwACgkQbDjKyiDZ
s5JRLhAAxEVU/ehkcA7Z6vjLebfc2d57XtHdlrp+gRcpcoEtDxKhYDKocJlU0HDL
FbAujmeQjQoZJwC3X51y/eSRAUo0JliTl8JnACyVRQBK85geYxIqxZZWcJo4MOmX
Dl2JgYWnfVJ91VrKDDqsdcaI8VpRn+9VdSNeBN4hDU/2MjET9XUrIG0/+Y/3Pemw
uBoRT4jxb+w+sW7Q/46erYE2GRUEJD7aBLufaAy3pFp8P9lEjN9CIVNrah4A/zSi
RCv3BVKCJKb5BKulfReQor+okW0Py8NrYebBoBTygMAoyIHre5yU+mVGLJghh/ZQ
7wvu86AHRmJc8ui9eirsV63CkhBcx6dOwmTfnkKtIsnz8TungZGN29AqtYlCpWap
Ybdgj1z2PuCHt+jdgrGS7rOLZHdiS5hO9atAASBuq9CETMuK4XPwVSmPSTP/YkQD
0ZZNETb3l01xk7ziIdUAncICG2p/39pUE0PIkrxyO9Qbvt14xuLDLWgB7VIQnbph
tDc4EcgBrKvCIQjouOt4tIp+30YDztDGRVQOhq2OCmvXDuved7QPmXkG7bW+2cRU
k/X6uKSOE7AQkjEnMHjQ2AWCIJuB+4n8vTZxTljG53awoK/fZATxp2wPAXJDHnsd
Jwt4B9xMAlN++exkv3jLHAZL4p2zBBRee69y1YwrEZoSL1LS33I=
=BbwF
-----END PGP SIGNATURE-----

--1Ow488MNN9B9o/ov--
