Received: from eggs.gnu.org ([2001:4830:134:3::10]:42094)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsOUG-0007jz-BA
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:27:33 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsOUF-0002Wl-36
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:27:31 -0400
References: <20180821132811.17675-1-peter.maydell@linaro.org>
	<20180821132811.17675-9-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <ca7da7bc-2bcb-f99b-7606-32e16afd9e2a@greensocs.com>
Date: Wed, 22 Aug 2018 10:27:06 +0200
MIME-Version: 1.0
In-Reply-To: <20180821132811.17675-9-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="l6Ra2MdfSdB3BqlULtqZq3Rqj6mUHruH2"
Subject: Re: [Qemu-devel] [PATCH 8/9] hw/arm/vexpress: Don't set
 info->secure_boot if CPU doesn't have EL3
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--l6Ra2MdfSdB3BqlULtqZq3Rqj6mUHruH2
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org
Message-ID: <ca7da7bc-2bcb-f99b-7606-32e16afd9e2a@greensocs.com>
Subject: Re: [PATCH 8/9] hw/arm/vexpress: Don't set info->secure_boot if CPU
 doesn't have EL3
References: <20180821132811.17675-1-peter.maydell@linaro.org>
 <20180821132811.17675-9-peter.maydell@linaro.org>
In-Reply-To: <20180821132811.17675-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 8/21/18 3:28 PM, Peter Maydell wrote:
> Don't request that the arm_load_kernel() code should boot in secure
> state if the CPU doesn't have a secure state. Currently this
> doesn't make a difference because the boot.c code only examines
> the secure_boot flag in code guarded by an ARM_FEATURE_EL3 check,
> but upcoming changes for supporting booting into Hyp mode will
> change that.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/arm/vexpress.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/arm/vexpress.c b/hw/arm/vexpress.c
> index dc47ed84c20..3631f4de3a4 100644
> --- a/hw/arm/vexpress.c
> +++ b/hw/arm/vexpress.c
> @@ -705,8 +705,8 @@ static void vexpress_common_init(MachineState *mach=
ine)
>      daughterboard->bootinfo.smp_bootreg_addr =3D map[VE_SYSREGS] + 0x3=
0;
>      daughterboard->bootinfo.gic_cpu_if_addr =3D daughterboard->gic_cpu=
_if_addr;
>      daughterboard->bootinfo.modify_dtb =3D vexpress_modify_dtb;
> -    /* Indicate that when booting Linux we should be in secure state *=
/
> -    daughterboard->bootinfo.secure_boot =3D true;
> +    /* When booting Linux we should be in secure state if the CPU has =
one. */
> +    daughterboard->bootinfo.secure_boot =3D vms->secure;
>      arm_load_kernel(ARM_CPU(first_cpu), &daughterboard->bootinfo);
>  }
> =20
>=20


--l6Ra2MdfSdB3BqlULtqZq3Rqj6mUHruH2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlt9HloACgkQd8knW3Qn
Tr7QYQ/8D0/+Lh1Nyz2Oku1dQ/wsgjHIxgHn/iZ+E88XDZSevqZV78NqJ15nfZWv
Pz8AVP3XyOcqEQH4q0wkxy01we7qKDJDiThLdT9oPHseWN37dCiiqOtKa3V7GRaZ
N0MfkUCcYohdG9ce7q5fIFyrQN2ZN/Ro93vWoJm3we5/lWb6H2aFOJguST5LO1W/
UsIbM3f8mVQG5vsjf9Fv6sDErSMHvLezPyP10N5IF+70WZX1t6vBAzVgPRP6gToN
jxVO/g3tKmBvZQqdUURWfwOJF+HF1t9OA5fREsxj9tuS53nWvXk0a/gqAjGnn6CD
j1XUV0WNEnz/UfDyafILQ8ux1ni6awxOhKZ2NE6Ji/W68/AkI6aub7BUycZycHyG
Y87dXBF8UmiH/UPYNEpWzXfxr/vQvAHkUoFpgCTgrgimodmzw044B1K7tzd7L79u
4bdDWbESKJCPjYCHCmpDE86jaYk2HgbnvoGbRTZpAkgUQ0XhQbVhNZzsCj4rFOJI
PDd9XK/b1Z0Xzrf6XP3NOE9TKHcOoWFtGa1KHCXqtxpNdsJukZmnjNXQf++sEcNX
UgGl4Rsx8RYkxOiECWZeDJzXhM/3osCs9ryaRVHnQs9B/wAVMcmjcxci8pVBRzja
pSmpTgfOLneAO1LYbaX+CqHOCh142BZLWPZKGV/iYSzHUfzp4Bs=
=BPRe
-----END PGP SIGNATURE-----

--l6Ra2MdfSdB3BqlULtqZq3Rqj6mUHruH2--
