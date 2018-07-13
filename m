Received: from eggs.gnu.org ([2001:4830:134:3::10]:45547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fdy49-00083A-2S
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:24:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fdy47-0002Sb-Kb
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:24:57 -0400
References: <20180712154152.32183-1-peter.maydell@linaro.org>
	<20180712154152.32183-3-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <d483ae97-c1bb-2df3-8610-538bbb6efb38@greensocs.com>
Date: Fri, 13 Jul 2018 15:24:48 +0200
MIME-Version: 1.0
In-Reply-To: <20180712154152.32183-3-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="6MIXvKl8x7kn5t5xjo6zocGuc3BTf8EW6"
Subject: Re: [Qemu-devel] [PATCH for-3.0 2/2] hw/intc/arm_gic: Fix handling
 of GICD_ITARGETSR
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org, Jan Kiszka <jan.kiszka@web.de>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6MIXvKl8x7kn5t5xjo6zocGuc3BTf8EW6
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org, Jan Kiszka <jan.kiszka@web.de>
Message-ID: <d483ae97-c1bb-2df3-8610-538bbb6efb38@greensocs.com>
Subject: Re: [PATCH for-3.0 2/2] hw/intc/arm_gic: Fix handling of
 GICD_ITARGETSR
References: <20180712154152.32183-1-peter.maydell@linaro.org>
 <20180712154152.32183-3-peter.maydell@linaro.org>
In-Reply-To: <20180712154152.32183-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 07/12/2018 05:41 PM, Peter Maydell wrote:
> The GICD_ITARGETSR implementation still has some 11MPCore behaviour
> that we were incorrectly using in our GICv1 and GICv2 implementations
> for the case where the interrupt number is less than GIC_INTERNAL.
> The desired behaviour here is:
>  * for 11MPCore: RAZ/WI for irqs 0..28; read a number matching the
>    CPU doing the read for irqs 29..31
>  * for GICv1 and v2: RAZ/WI if uniprocessor; otherwise read a
>    number matching the CPU doing the read for all irqs < 32
>=20
> Stop squashing GICD_ITARGETSR to 0 for IRQs 0..28 unless this
> is an 11MPCore GIC.
>=20
> Reported-by: Jan Kiszka <jan.kiszka@web.de>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gic.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

--=20
Luc



--6MIXvKl8x7kn5t5xjo6zocGuc3BTf8EW6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAltIqCAACgkQd8knW3Qn
Tr53Vg//QRGY7g8Cwt1F/J6IHCujH3pDhnMmP5brckQsTi3atcOI5gNNF++t5mZ1
/X+CExXtTgmb5bVW+ncueE8Kr5lKly8fIwbRnw0stu6i56C/IDyr49X3jyZfdrYN
COTqzX28mxy461rRQxs8MLG24MrwSHn7oLbBpRXtOhEZ2vc9hRREwuoc6cAPIc9w
HMUgdOyhA+rOqOnPXk2Yz3kxUo6aEcOHm0jr7DfIpGKUcCjDHERX20e5Ss058VyV
RakKftc6ZHbLR/vWdBZOaqBKgliYNoCuTa996Y+MqgFJVX5kTB07nnuR7ZZkhMLP
amht+o1UzDuesozEPn1kTtI+75O9Z0yq9gqiETi7bYfDu8jMWDxbZWrn5sNLK4dM
cXnLD2LjcYhvwYlt9e1FmN/lQK36YqVIXCwOlxZ8c6DUREcrK+03NVCk8cnLYpfH
vsQSqtt+M0abYRY5V1zChTTGSzK3PAzvlcLU2A+clmO2RVmQps8BM9sJj6WK5tpa
9n+zUBBQoN4rVdnPMXDzRF6++xq86hDQ4jUf2NiWxL1C7yiD5TEwKINqkXrnxOsS
9hHcBAJqSVMzs8rqQkfzUcccROxobG+1e6o6N2M5WgJIYy3Ta/IuUsIHkCcZc5xp
VSTyvS/a6PC5ddfwRghaq10783yUPDWESX/92SkMaip9HW63y2Y=
=WHAH
-----END PGP SIGNATURE-----

--6MIXvKl8x7kn5t5xjo6zocGuc3BTf8EW6--
