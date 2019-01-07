Received: from eggs.gnu.org ([209.51.188.92]:56628)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ggQWx-0001Ig-LW
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:45:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <luc.michel@greensocs.com>) id 1ggQWv-0005Yp-T4
	for qemu-devel@nongnu.org; Mon, 07 Jan 2019 03:45:07 -0500
References: <20190104142812.20444-1-edgar.iglesias@gmail.com>
	<20190104142812.20444-2-edgar.iglesias@gmail.com>
From: Luc Michel <luc.michel@greensocs.com>
Message-ID: <9675af33-37b0-55c7-9f81-511f0916abb9@greensocs.com>
Date: Mon, 7 Jan 2019 09:44:37 +0100
MIME-Version: 1.0
In-Reply-To: <20190104142812.20444-2-edgar.iglesias@gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature";
	boundary="U80yTnc5JATO2gsn35zfrZUEAsBcxfqZD"
Subject: Re: [Qemu-devel] [PATCH v1 1/2] hw/microblaze: s3adsp1800: Create
 an unimplemented GPIO area
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
--U80yTnc5JATO2gsn35zfrZUEAsBcxfqZD
From: Luc Michel <luc.michel@greensocs.com>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
Cc: peter.maydell@linaro.org, frederic.konrad@adacore.com,
 alistair@alistair23.me, philmd@redhat.com, frasse.iglesias@gmail.com,
 figlesia@xilinx.com, sstabellini@kernel.org, sai.pavan.boddu@xilinx.com,
 edgar.iglesias@xilinx.com
Message-ID: <9675af33-37b0-55c7-9f81-511f0916abb9@greensocs.com>
Subject: Re: [PATCH v1 1/2] hw/microblaze: s3adsp1800: Create an unimplemented
 GPIO area
References: <20190104142812.20444-1-edgar.iglesias@gmail.com>
 <20190104142812.20444-2-edgar.iglesias@gmail.com>
In-Reply-To: <20190104142812.20444-2-edgar.iglesias@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 1/4/19 3:28 PM, Edgar E. Iglesias wrote:
> From: "Edgar E. Iglesias" <edgar.iglesias@xilinx.com>
>=20
> Create an unimplemented GPIO area instead of leaving it unassigned.
>=20
> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>
Reviewed-by: Luc Michel <luc.michel@greensocs.com>

> ---
>  hw/microblaze/petalogix_s3adsp1800_mmu.c | 4 ++++
>  1 file changed, 4 insertions(+)
>=20
> diff --git a/hw/microblaze/petalogix_s3adsp1800_mmu.c b/hw/microblaze/p=
etalogix_s3adsp1800_mmu.c
> index 5cf7b84c79..b9f0b0d06e 100644
> --- a/hw/microblaze/petalogix_s3adsp1800_mmu.c
> +++ b/hw/microblaze/petalogix_s3adsp1800_mmu.c
> @@ -35,6 +35,7 @@
>  #include "sysemu/sysemu.h"
>  #include "hw/devices.h"
>  #include "hw/boards.h"
> +#include "hw/misc/unimp.h"
>  #include "exec/address-spaces.h"
>  #include "hw/char/xilinx_uartlite.h"
> =20
> @@ -47,6 +48,7 @@
> =20
>  #define MEMORY_BASEADDR 0x90000000
>  #define FLASH_BASEADDR 0xa0000000
> +#define GPIO_BASEADDR 0x81400000
>  #define INTC_BASEADDR 0x81800000
>  #define TIMER_BASEADDR 0x83c00000
>  #define UARTLITE_BASEADDR 0x84000000
> @@ -122,6 +124,8 @@ petalogix_s3adsp1800_init(MachineState *machine)
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, ETHLITE_BASEADDR);
>      sysbus_connect_irq(SYS_BUS_DEVICE(dev), 0, irq[ETHLITE_IRQ]);
> =20
> +    create_unimplemented_device("gpio", GPIO_BASEADDR, 0x10000);
> +
>      microblaze_load_kernel(cpu, ddr_base, ram_size,
>                             machine->initrd_filename,
>                             BINARY_DEVICE_TREE_FILE,
>=20


--U80yTnc5JATO2gsn35zfrZUEAsBcxfqZD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEUvSC0Bi15mxw2PT5d8knW3QnTr4FAlwzEXwACgkQd8knW3Qn
Tr41vQ//Wrras38Hz22rnTb2J9YkYTqJ4Z7oxkbjLINwtwejbILt4lh72ua1drmd
N56QyPDhvzXBNNYksqfvJ62K4xDUc5S7euLMeHWhZ0lpsurxS74mEqYjOHUrUPKG
E8u28bxaBY07b9rYTDkRMCBGSMUAFT3adHEp5aIjZa+smU2UpVdgGd+xHrrdQqoA
mEhdqDlCQpiF59Tg3stoQxioODlF7gx0553dpxAZFoo4VY103nZPKqRoHecrSoYO
mLUd8OE7O01DzkqSE9yFcePJYZkvn4uoNu/8XEApsBWH3WeDNa8eO+Q5OGnQ0pNa
AeP+3E89Gd8P2kKh9YB4/Y0uE8znWfonGCZZV4rnNqotNMSSWznPJlNiH1hwl8Mw
5ZI0QP6BV39F7GkDtmL4VcR1JD1ccUpjHpuoufWf3SE/lG67hUWXWc4Zd/ywJ/J9
5Dp/BsNKarmDyiVFQJUU4CcUMoxosRl7TybEFv2E+KFhWhIID+MiBjYeCRdiX7LB
PMLWzTNYMvfcuUKC5rvrl915GCe4bansFi/Xyx8UhkYiNlXOwQ4/BpactAtBR6YR
7hXJyZ8JAOef+gJRi7HZMT9Kjjz0kaJRcgDNOUKAXNG8XL1FRJUhs5TnsahjRsiN
+fglcFNJKFTctyt7ocFnd+xQXT1sHqwRMyf3BQLl8Bp8YvctJZY=
=whE6
-----END PGP SIGNATURE-----

--U80yTnc5JATO2gsn35zfrZUEAsBcxfqZD--
