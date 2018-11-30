Received: from eggs.gnu.org ([2001:4830:134:3::10]:50869)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gSePM-0000fS-Pi
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:44:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1gSeK0-0007xu-Ch
	for qemu-devel@nongnu.org; Fri, 30 Nov 2018 03:38:49 -0500
References: <20181129163655.20370-1-edgar.iglesias@gmail.com>
	<20181129163655.20370-2-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <60274731-58ee-0edd-52db-313780909834@greensocs.com>
Date: Fri, 30 Nov 2018 09:38:25 +0100
MIME-Version: 1.0
In-Reply-To: <20181129163655.20370-2-edgar.iglesias@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="taoMADTdYPEZv5T0MLWf7NzOiZ1rvCkhn"
Subject: Re: [Qemu-devel] [PATCH v1 1/4] hw/arm: versal: Remove bogus
 virtio-mmio creation
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, muhammad_bilal@mentor.com, frederic.konrad@adacore.com, alistair@alistair23.me, philmd@redhat.com, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--taoMADTdYPEZv5T0MLWf7NzOiZ1rvCkhn
From: Luc Michel <luc.michel@greensocs.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, muhammad_bilal@mentor.com,
 frederic.konrad@adacore.com, alistair@alistair23.me, philmd@redhat.com,
 frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org,
 sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com
Message-ID: <60274731-58ee-0edd-52db-313780909834@greensocs.com>
Subject: Re: [PATCH v1 1/4] hw/arm: versal: Remove bogus virtio-mmio creation
References: <20181129163655.20370-1-edgar.iglesias@gmail.com>
 <20181129163655.20370-2-edgar.iglesias@gmail.com>
In-Reply-To: <20181129163655.20370-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 11/29/18 5:36 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>=20
> Remove bogus virtio-mmio creation. This was an accidental
> left-over an experiment.
>=20
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>

Reviewed-by: Luc Michel <luc.michel@greensocs.com>

Luc

> ---
>  hw/arm/xlnx-versal-virt.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/arm/xlnx-versal-virt.c b/hw/arm/xlnx-versal-virt.c
> index 1e31a3f442..41b8d801c8 100644
> --- a/hw/arm/xlnx-versal-virt.c
> +++ b/hw/arm/xlnx-versal-virt.c
> @@ -364,7 +364,6 @@ static void create_virtio_regions(VersalVirt *s)
>          sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, pic_irq);
>          mr =3D sysbus_mmio_get_region(SYS_BUS_DEVICE(dev), 0);
>          memory_region_add_subregion(&s->soc.mr_ps, base, mr);
> -        sysbus_create_simple("virtio-mmio", base, pic_irq);
>      }
> =20
>      for (i =3D 0; i < NUM_VIRTIO_TRANSPORT; i++) {
>=20


--taoMADTdYPEZv5T0MLWf7NzOiZ1rvCkhn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlwA9wEACgkQd8knW3Qn
Tr6BXA//fIzD8sipgf9bAot29h+JPW87hPKHNcDi0nqeYIuGK1W0E8VxFTTsZ24q
/ihSiwiZFFibPYq6IwyjL72YhCRxyf35Axunb1GIuCATf5fVDb+D8tkgwOEDZfJw
bQA0BtyeLijED1sTYsOPrPeDARmnFcpsNRZH39rxf96u+vJsk6d8/Z7akkjx/bDG
IW339+VnU2O0/7FrILw21w/hprAelzbtjNiCXBcAs9rTdG6HOwnzJ1MbTvUPLC5T
fDAA7Gm5CVG8AV7teR8e1dHVgIN/mF5SNF7w2aIFu9sj5ebqxSeV9S63EzAnLeNV
RQruRaGE9BS+Z0/dyBYd/EIpgAw/xQ3U2ZveN6C4gAAgWSJGkPg3rry4ExL5524y
97YuEgJlIhoTuD2D9T5Qb4enVW2gHydYW3SeNwGKJq3XC4xUUOPqnl59gN5id0KG
6/E+tnRD7N1z1br+tpauy3cmcyTlw18MZBhCJh/PUErt1KSoN2yYFnWriJo/J6jT
/BJzZSDDfMXhffZ1akJpOFUQOhh7IvMi4xHD7ngqb8tbDUuICD8kiTjmIv9up9Z3
CdaO6297Vgfa4XIY05Y+/sUqp8oRTkH4QeVO4J3mshVkd69QQ6FhCd4XE9+seZnb
JHnW1+JtvgNk0vX6ptMjkvDs8IIeAiNOvCtRysWnTpGP9xzDzQA=
=idpr
-----END PGP SIGNATURE-----

--taoMADTdYPEZv5T0MLWf7NzOiZ1rvCkhn--
