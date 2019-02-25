Received: from eggs.gnu.org ([209.51.188.92]:35343)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gyLQ8-0006Vj-Il
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:56:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gyLQ7-0000Ki-PM
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:56:08 -0500
Received: from 15.mo6.mail-out.ovh.net ([188.165.39.161]:47710)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gyLQ7-00009p-IN
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:56:07 -0500
Received: from player739.ha.ovh.net (unknown [10.109.146.86])
	by mo6.mail-out.ovh.net (Postfix) with ESMTP id 4D1D81AFBA7
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 19:55:57 +0100 (CET)
References: <20190225170155.1972-1-muriloo@linux.ibm.com>
	<20190225170155.1972-2-muriloo@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <8abd8e00-933b-f772-52d0-2afdb05fe571@kaod.org>
Date: Mon, 25 Feb 2019 19:55:44 +0100
MIME-Version: 1.0
In-Reply-To: <20190225170155.1972-2-muriloo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 1/3] ppc/pnv: increase kernel size limit
 to 256MiB
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Murilo Opsfelder Araujo <mopsfelder@gmail.com>, qemu-devel@nongnu.org
Cc: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>, David Gibson <david@gibson.dropbear.id.au>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org

On 2/25/19 6:01 PM, Murilo Opsfelder Araujo wrote:
> Building kernel with CONFIG_DEBUG_INFO_REDUCED can generate a ~90MB ima=
ge and
> building with CONFIG_DEBUG_INFO can generate a ~225M one, both exceeds =
the
> current limit of 32MiB.
>=20
> Increasing kernel size limit to 256MiB should fit for now.



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

>=20
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>
> ---
>  hw/ppc/pnv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index da540860a2..1dbb62c4c9 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -54,6 +54,7 @@
>  #define FW_MAX_SIZE             0x00400000
> =20
>  #define KERNEL_LOAD_ADDR        0x20000000
> +#define KERNEL_MAX_SIZE         (256 * MiB)
>  #define INITRD_LOAD_ADDR        0x60000000
> =20
>  static const char *pnv_chip_core_typename(const PnvChip *o)
> @@ -588,7 +589,7 @@ static void pnv_init(MachineState *machine)
>          long kernel_size;
> =20
>          kernel_size =3D load_image_targphys(machine->kernel_filename,
> -                                          KERNEL_LOAD_ADDR, 0x2000000)=
;
> +                                          KERNEL_LOAD_ADDR, KERNEL_MAX=
_SIZE);
>          if (kernel_size < 0) {
>              error_report("Could not load kernel '%s'",
>                           machine->kernel_filename);
>=20
