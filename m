Received: from eggs.gnu.org ([2001:4830:134:3::10]:45315)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fdy3L-00079u-Fq
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:24:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fdy3K-00026o-N2
	for qemu-devel@nongnu.org; Fri, 13 Jul 2018 09:24:07 -0400
References: <20180712154152.32183-1-peter.maydell@linaro.org>
	<20180712154152.32183-2-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <7450c9f1-2c97-4a49-ab4a-9c9ce6314eaa@greensocs.com>
Date: Fri, 13 Jul 2018 15:23:41 +0200
MIME-Version: 1.0
In-Reply-To: <20180712154152.32183-2-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="VomOzvduyhTSMxYlQmWc27HaL4TZkVhE3"
Subject: Re: [Qemu-devel] [PATCH for-3.0 1/2] hw/intc/arm_gic: Check
 interrupt number in gic_deactivate_irq()
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
--VomOzvduyhTSMxYlQmWc27HaL4TZkVhE3
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org, Jan Kiszka <jan.kiszka@web.de>
Message-ID: <7450c9f1-2c97-4a49-ab4a-9c9ce6314eaa@greensocs.com>
Subject: Re: [PATCH for-3.0 1/2] hw/intc/arm_gic: Check interrupt number in
 gic_deactivate_irq()
References: <20180712154152.32183-1-peter.maydell@linaro.org>
 <20180712154152.32183-2-peter.maydell@linaro.org>
In-Reply-To: <20180712154152.32183-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 07/12/2018 05:41 PM, Peter Maydell wrote:
> In gic_deactivate_irq() the interrupt number comes from the guest
> (on a write to the GICC_DIR register), so we need to sanity check
> that it isn't out of range before we use it as an array index.
> Handle this in a similar manner to the check we do in
> gic_complete_irq() for the GICC_EOI register.
>=20
> The array overrun is not disastrous because the calling code
> uses (value & 0x3ff) to extract the interrupt field, so the
> only out-of-range values possible are 1020..1023, which allow
> overrunning only from irq_state[] into the following
> irq_target[] array which the guest can already manipulate.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/intc/arm_gic.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

--=20
Luc


--VomOzvduyhTSMxYlQmWc27HaL4TZkVhE3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAltIp90ACgkQd8knW3Qn
Tr5WIA//R8P6oGehEDk90QywivlL78s33sBKCS6vZ9FZvpWS5idr93LKgsZeiTp8
z9AdgrnVXS1iyw6rCt4GiMvmFY4T8k33tf4Y/lZxdPbHYxOVDZCXO85vZppPfSgi
1gL1CgVddRdsoUdY9BF3sdJEa3IezbS8Bj5YR5DpXqvluLpsNxLbHZRue8THjfkJ
TjmrhAIMV8AHxTa1ECw9uzDRwVjeOHkPJRON4RtqoWJGnwQCCNLmAYaM5TXQy8yx
DsNrIqupf6p5vAF7X4ZC9Q8HZ7cRMAVaGPlk3a51ZVx7/UzoB7mwCJVA5tToFD2H
xr5KIAzYOisu2ysCWngAcAQeKVbgUma9BkDMQ7AexBH0vOj6sXbq9a3an+Y1lTaa
hwJtIv8T11hk6HGPpkEVN7IetOK/VGRgoR5IxfpXB5I0IHCBbsSVa4nc+kz0n4mt
bnPVwJziipyJbVH3d3iRSwPTieq3jB2ORxyxo1UeC1/R2fYNFp3ER5TRMQcHaZcy
rUTrvTTrLUQ/gtec4WHKbCdvOCLrBpD0NZQMRINJ11rV8hQbmbUdbCgvZslfgJM9
0O/G46A0Uf+V/F1UfRAi48jZuoqYmfcj8Dajsak4U2Lu1s31CaeJ1i0Jy/GRGV2R
edMtKytCAmFgF48RI5rRJdxPSZ7DVZX/v+/6ywIer9DSknon3os=
=MN4h
-----END PGP SIGNATURE-----

--VomOzvduyhTSMxYlQmWc27HaL4TZkVhE3--
