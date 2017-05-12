Received: from eggs.gnu.org ([2001:4830:134:3::10]:43338)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@antfield.fr>) id 1d97nJ-0001lV-Gp
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:27:34 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@antfield.fr>) id 1d97nI-0001ka-JK
	for qemu-devel@nongnu.org; Fri, 12 May 2017 06:27:33 -0400
From: Luc MICHEL <luc.michel@git.antfield.fr>
References: <20170428125632.5704-1-luc.michel@git.antfield.fr>
Message-ID: <39e542f5-59e1-7598-f751-ee905ce264e3@antfield.fr>
Date: Fri, 12 May 2017 12:28:02 +0200
MIME-Version: 1.0
In-Reply-To: <20170428125632.5704-1-luc.michel@git.antfield.fr>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="XL2bfSxRpjAumrC7wVtqMgD5SQMflOQqk"
Subject: Re: [Qemu-devel] [PATCH 0/1] target/arm: add data cache
 invalidation cp15 instruction to cortex-r5
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Luc MICHEL <luc.michel@git.antfield.fr>
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--XL2bfSxRpjAumrC7wVtqMgD5SQMflOQqk
From: Luc MICHEL <luc.michel@git.antfield.fr>
To: Luc MICHEL <luc.michel@git.antfield.fr>
Cc: qemu-trivial@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org
Message-ID: <39e542f5-59e1-7598-f751-ee905ce264e3@antfield.fr>
Subject: Re: [Qemu-devel] [PATCH 0/1] target/arm: add data cache invalidation
 cp15 instruction to cortex-r5
References: <20170428125632.5704-1-luc.michel@git.antfield.fr>
In-Reply-To: <20170428125632.5704-1-luc.michel@git.antfield.fr>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

ping

The patchwork link: https://patchwork.ozlabs.org/patch/756408/

Thanks,

--=20
Luc

On 04/28/2017 02:56 PM, Luc MICHEL wrote:
> This patch adds the cp15, CRn=3D15, opc1=3D0, CRm=3D5, opc2=3D0 coproce=
ssor
> instruction
> to the cortex-r5. As stated in the TRM, this instruction invalidates
> all the
> data cache. This trivial patch implements it as NOP as cache
> operations are not
> implemented in QEMU.
>
> The documentation is here:
> http://infocenter.arm.com/help/index.jsp?topic=3D/com.arm.doc.ddi0460d/=
Bgbdbdjc.html
>
> Tested using this minimal program:
>  .global _start
> =20
>  .section .text
>  _start:
>    mcr p15, 0, r1, c15, c5, 0
> =20
>  idle:
>    wfi
>    b idle
>
> Before implementation:
>  IN:
>  0x00008000:  ee0f1f15      mcr 15, 0, r1, cr15, cr5, {0}
>
>  Taking exception 1 [Undefined Instruction]
>  ...from EL1 to EL1
>  ...with ESR 0x0/0x2000000
>
> After implementation:
>  IN:
>  0x00008000:  ee0f1f15      mcr 15, 0, r1, cr15, cr5, {0}
>  0x00008004:  e320f003      wfi
>
> Luc MICHEL (1):
>   target/arm: add data cache invalidation cp15 instruction to cortex-r5=

>
>  target/arm/cpu.c | 2 ++
>  1 file changed, 2 insertions(+)
>



--XL2bfSxRpjAumrC7wVtqMgD5SQMflOQqk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlkVjjIACgkQd8knW3Qn
Tr6QNBAArgtXMQNdpYO3U5+eJJzhBhc9XYOgMMxtAdclvmWcBVxUkEZgzajX1Cy5
rA+uvj8VKjsC6Edv5IltmRkWGDLex7G7R673fVLU0sQ9ucKWv96fOlQ/JpMBvL0t
VyI8WnntUFobPrbZZojfJruRnya1uhqKwVaH346p0dpf2Xtrz4gUlKpzn01LG+qN
Ft7OmAVpPn71223LWLADuISedlxR0nezX1dAb7c+PxFEy4eEG1GBeOSbT4BoAYmx
auv8wH8P0W49z16z9vCdHkEkCCmi3mz35UjsJXS9nw2wgKn94xW3OllqHex85hKs
OAShPlGHhepv0yp6/V9fbI+PRd05FINkVljkOWHRjfJE1JFyi7MO45WTFjODRmre
AlsbbV5Q2Eg5pKrKsEl+Pw194XRxG/MooRAefQAROnPcB9PmV25PJq7fyD7a1kbk
c8Rl3eLAs7jmrQaB4wcaUNVokXR/sby0OGEXihLscBEYDJRvsUZozTGRL4h+HuWY
nuXwzwaXylwN6/W+6aHZFEJEQv25t4JsrWZDweeNtxEF7FezXIlp5yNF48T2+Cy1
ai8etFNvY1Y4wKVh1oUs1Oz34ap5+YwY5ruVlFBYskPXiA0o60ggkYtGDeIj/3/u
J4TVVdJiDFsYsEaIOb6BPEiaLhvYzanhjElx/5YqW6HQoh97iS4=
=/VlO
-----END PGP SIGNATURE-----

--XL2bfSxRpjAumrC7wVtqMgD5SQMflOQqk--
