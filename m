Received: from eggs.gnu.org ([209.51.188.92]:57861)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ggQaJ-0002B0-N0
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:48:38 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ggQaH-0007IY-Nd
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:48:35 -0500
References: <20190104142812.20444-1-edgar.iglesias@gmail.com>
	<20190104142812.20444-3-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <b35dfd51-bf47-7cca-159b-0649f8caebf8@greensocs.com>
Date: Mon, 7 Jan 2019 09:48:24 +0100
MIME-Version: 1.0
In-Reply-To: <20190104142812.20444-3-edgar.iglesias@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="cJKqJ45iR8fo8AsiVhOGC0hAlBolVKpzk"
Subject: Re: [Qemu-devel] [PATCH v1 2/2] target/microblaze: Add props
 enabling exceptions on failed bus accesses
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, frederic.konrad@adacore.com, alistair@alistair23.me, philmd@redhat.com, frasse.iglesias@gmail.com, figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com, edgar.iglesias@xilinx.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--cJKqJ45iR8fo8AsiVhOGC0hAlBolVKpzk
From: Luc Michel <luc.michel@greensocs.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, frederic.konrad@adacore.com,
 alistair@alistair23.me, philmd@redhat.com, frasse.iglesias@gmail.com,
 figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com,
 edgar.iglesias@xilinx.com
Message-ID: <b35dfd51-bf47-7cca-159b-0649f8caebf8@greensocs.com>
Subject: Re: [PATCH v1 2/2] target/microblaze: Add props enabling exceptions
 on failed bus accesses
References: <20190104142812.20444-1-edgar.iglesias@gmail.com>
 <20190104142812.20444-3-edgar.iglesias@gmail.com>
In-Reply-To: <20190104142812.20444-3-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/4/19 3:28 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>=20
> Add MicroBlaze CPU properties to enable exceptions on failed
> bus accesses.
>=20
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  target/microblaze/cpu.c | 12 +++++++++++-
>  target/microblaze/cpu.h |  2 ++
>  2 files changed, 13 insertions(+), 1 deletion(-)
>=20
> diff --git a/target/microblaze/cpu.c b/target/microblaze/cpu.c
> index 49876b19b3..5596cd5485 100644
> --- a/target/microblaze/cpu.c
> +++ b/target/microblaze/cpu.c
> @@ -202,7 +202,11 @@ static void mb_cpu_realizefn(DeviceState *dev, Err=
or **errp)
>                          (cpu->cfg.use_barrel ? PVR2_USE_BARREL_MASK : =
0) |
>                          (cpu->cfg.use_div ? PVR2_USE_DIV_MASK : 0) |
>                          (cpu->cfg.use_msr_instr ? PVR2_USE_MSR_INSTR :=
 0) |
> -                        (cpu->cfg.use_pcmp_instr ? PVR2_USE_PCMP_INSTR=
 : 0);
> +                        (cpu->cfg.use_pcmp_instr ? PVR2_USE_PCMP_INSTR=
 : 0) |
> +                        (cpu->cfg.dopb_bus_exception ?
> +                                                 PVR2_DOPB_BUS_EXC_MAS=
K : 0) |
> +                        (cpu->cfg.iopb_bus_exception ?
> +                                                 PVR2_IOPB_BUS_EXC_MAS=
K : 0);
> =20
>      env->pvr.regs[5] |=3D cpu->cfg.dcache_writeback ?
>                                          PVR5_DCACHE_WRITEBACK_MASK : 0=
;
> @@ -265,6 +269,12 @@ static Property mb_properties[] =3D {
>      DEFINE_PROP_BOOL("dcache-writeback", MicroBlazeCPU, cfg.dcache_wri=
teback,
>                       false),
>      DEFINE_PROP_BOOL("endianness", MicroBlazeCPU, cfg.endi, false),
> +    /* Enables bus exceptions on failed data accesses (load/stores).  =
*/
> +    DEFINE_PROP_BOOL("dopb-bus-exception", MicroBlazeCPU,
> +                     cfg.dopb_bus_exception, false),
> +    /* Enables bus exceptions on failed instruction fetches.  */
> +    DEFINE_PROP_BOOL("iopb-bus-exception", MicroBlazeCPU,
> +                     cfg.iopb_bus_exception, false),
>      DEFINE_PROP_STRING("version", MicroBlazeCPU, cfg.version),
>      DEFINE_PROP_UINT8("pvr", MicroBlazeCPU, cfg.pvr, C_PVR_FULL),
>      DEFINE_PROP_END_OF_LIST(),
> diff --git a/target/microblaze/cpu.h b/target/microblaze/cpu.h
> index 03ca91007d..792bbc97c7 100644
> --- a/target/microblaze/cpu.h
> +++ b/target/microblaze/cpu.h
> @@ -308,6 +308,8 @@ struct MicroBlazeCPU {
>          bool use_mmu;
>          bool dcache_writeback;
>          bool endi;
> +        bool dopb_bus_exception;
> +        bool iopb_bus_exception;
>          char *version;
>          uint8_t pvr;
>      } cfg;
>=20


--cJKqJ45iR8fo8AsiVhOGC0hAlBolVKpzk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlwzElgACgkQd8knW3Qn
Tr6DuhAAlLLjK7ik55617B5bbLGLNH/HmfUoWbS7RXxqveT3VmjwdYT6gsutzC5g
E3Od4a7ylz0uLUNH3FSVHIcBVyisB8vn/F4oJGpR+/xAPioTS7D2wYaUkz9WzfWc
H5sxXYMWTM5LSzgvM5CL5hAleIYqANKZtUctECiKRkZfaTVeP6lnomC+hdLg0Pfj
CTBwwF06ygt7ExfNrmrnEmF3LSQgge7ZLzFO0Yw9ijk8cu7l20vS1UCfA2wiLVmg
uGr1V3yZFesNZLIDy9L9dFX3zOOyz76PTU/R5CiDyJui/5IM3J7Vq7nHVx2HuR38
Lt/zUOmXXlDPOKn6mvg+R8VSuyeAbMYhGqcWF3ZEgsv6qHiG62F7uFUb/w4WzquA
y0L/wPofAnAIsD26Nf7lIiKmxjfb/IcbBZKRc7iqJmNhbIn/cXR7IdcoLvJUZMfH
r65X7toRQMiPD5wGRwncltrQ+ggDcg88qZXMFOhe/pXpFI4N6qgdUcsT+fKV5x63
zA5iZKgIDXZ1RN6h19YWF1fvTBP0nP3kmD8GhkWfKebB3ev/whV4dwT4SsfApP3Q
YPXOX/6S3fNBCwixe7Uv0z+yUKC0fv6ATLMIDR+dDZmFks+HSychD3b/3d3rlQg3
Q1NHONeIKc+4iWNeZZuWVDmXbiPXCmzrPsGUwZnyVAn1ZPZLWpk=
=TCMI
-----END PGP SIGNATURE-----

--cJKqJ45iR8fo8AsiVhOGC0hAlBolVKpzk--
