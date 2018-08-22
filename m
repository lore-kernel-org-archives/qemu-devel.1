Received: from eggs.gnu.org ([2001:4830:134:3::10]:40584)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsOPb-0002eZ-LU
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:22:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1fsOPT-00081a-OZ
	for qemu-devel@nongnu.org; Wed, 22 Aug 2018 04:22:39 -0400
References: <20180821132811.17675-1-peter.maydell@linaro.org>
	<20180821132811.17675-3-peter.maydell@linaro.org>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <766c6d21-6adc-e2a4-d299-f5ad69745081@greensocs.com>
Date: Wed, 22 Aug 2018 10:17:25 +0200
MIME-Version: 1.0
In-Reply-To: <20180821132811.17675-3-peter.maydell@linaro.org>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="GsnHEC6NylLgPIGC3GiRk6pwMOnRT3pLs"
Subject: Re: [Qemu-devel] [PATCH 2/9] hw/intc/arm_gic: Make per-cpu GICH
 memory regions 0x200 bytes large
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
--GsnHEC6NylLgPIGC3GiRk6pwMOnRT3pLs
From: Luc Michel <luc.michel@greensocs.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: patches@linaro.org
Message-ID: <766c6d21-6adc-e2a4-d299-f5ad69745081@greensocs.com>
Subject: Re: [PATCH 2/9] hw/intc/arm_gic: Make per-cpu GICH memory regions
 0x200 bytes large
References: <20180821132811.17675-1-peter.maydell@linaro.org>
 <20180821132811.17675-3-peter.maydell@linaro.org>
In-Reply-To: <20180821132811.17675-3-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 8/21/18 3:28 PM, Peter Maydell wrote:
> Reduce the size of the per-cpu GICH memory regions from 0x1000
> to 0x200. The registers only cover 0x200 bytes, and the Cortex-A15
> wants to map them at a spacing of 0x200 bytes apart. Having the
> region be too large interferes with mapping them like that, so
> reduce it.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-By: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/intc/arm_gic.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/intc/arm_gic.c b/hw/intc/arm_gic.c
> index c1b35fc1ee2..542b4b93eab 100644
> --- a/hw/intc/arm_gic.c
> +++ b/hw/intc/arm_gic.c
> @@ -2084,7 +2084,7 @@ static void arm_gic_realize(DeviceState *dev, Err=
or **errp)
>          for (i =3D 0; i < s->num_cpu; i++) {
>              memory_region_init_io(&s->vifaceiomem[i + 1], OBJECT(s),
>                                    &gic_viface_ops, &s->backref[i],
> -                                  "gic_viface", 0x1000);
> +                                  "gic_viface", 0x200);
>              sysbus_init_mmio(sbd, &s->vifaceiomem[i + 1]);
>          }
>      }
>=20


--GsnHEC6NylLgPIGC3GiRk6pwMOnRT3pLs
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlt9HBUACgkQd8knW3Qn
Tr7OSg/9GDBuLCyKqQnz9/7ZtAV77g2T4zBXpsSZ4dsSv+kO0knsp++xkzaoN0kE
IMLyZdp/3P0oq9t8G8LMGrQB4HVh8xdjka9NQQgzBS5gM8FiKi32LXilX819kYvs
/2ZiEbgBNeeGndtkv4MI1WcX50e3ZkWSOxPKnuqOjpEuyi4WE0D2acsbTmYS+3iq
lol7hfZIyOSb2MMmUKE6TCb41M/mIQ8W7ReHraB0zqjOB2/x6/VkopR8ljTlAkeh
NNaDz2Z537gNHXSZESLzvsye6fCW+ab0qp/Z/j5R7caZsTqQhmcaf9QopdQQkD3I
LVeGOkakWXOQucRVFhRW6jA4CRmQd1fWWR3l/LfgmZ5u3FDF3MQvGL+eZXIj3nGY
NctFjEXGfmnRBU/zRFECeNLCjAKtidH7YXhF45uFlG0VMQqPCIDscCZoiDf3Bl+b
SyvHQRa5A17NYbUB3lCyVFF6Nenkn5cwrC6R593UoHn21WreDVq1rrCoXRWSIML3
86Yt7r3dLnlv1f2D5AiK1fkEJwaoUs+CINOHgrNJ7sgItBSO+/Iu9iRjVMK4ECfN
Kj9wDDqEKpPhr6A6b3U2tupQFrYNoeXK4dKGSBMin5h8FXAqgJBEfWlzKwITPKGa
wzfQ6CRonM87PtuoDNiTHveXbeyUIu/h+7jqXMHAy6czaJ3zW9M=
=bSc8
-----END PGP SIGNATURE-----

--GsnHEC6NylLgPIGC3GiRk6pwMOnRT3pLs--
