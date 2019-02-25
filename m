Received: from eggs.gnu.org ([209.51.188.92]:35368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gyLQA-0006Vv-49
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:56:10 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gyLQ9-0000MJ-DN
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:56:10 -0500
Received: from 2.mo177.mail-out.ovh.net ([178.33.109.80]:42924)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gyLQ9-0000Ku-7h
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:56:09 -0500
Received: from player716.ha.ovh.net (unknown [10.109.143.72])
	by mo177.mail-out.ovh.net (Postfix) with ESMTP id 706EFE491A
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 19:56:07 +0100 (CET)
References: <20190225170155.1972-1-muriloo@linux.ibm.com>
	<20190225170155.1972-3-muriloo@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <f8b90b26-7838-28b4-0909-dbffb809465e@kaod.org>
Date: Mon, 25 Feb 2019 19:55:56 +0100
MIME-Version: 1.0
In-Reply-To: <20190225170155.1972-3-muriloo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 2/3] ppc/pnv: add INITRD_MAX_SIZE
 constant
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
> The current 0x10000000 value is actually 256MiB, not 128MB as the comme=
nt
> suggests. Move it to a constant and fix the comment (no change in the s=
ize
> value).
>=20
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>=09



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/ppc/pnv.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 1dbb62c4c9..c308ae423a 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -56,6 +56,7 @@
>  #define KERNEL_LOAD_ADDR        0x20000000
>  #define KERNEL_MAX_SIZE         (256 * MiB)
>  #define INITRD_LOAD_ADDR        0x60000000
> +#define INITRD_MAX_SIZE         (256 * MiB)
> =20
>  static const char *pnv_chip_core_typename(const PnvChip *o)
>  {
> @@ -601,7 +602,7 @@ static void pnv_init(MachineState *machine)
>      if (machine->initrd_filename) {
>          pnv->initrd_base =3D INITRD_LOAD_ADDR;
>          pnv->initrd_size =3D load_image_targphys(machine->initrd_filen=
ame,
> -                                  pnv->initrd_base, 0x10000000); /* 12=
8MB max */
> +                                  pnv->initrd_base, INITRD_MAX_SIZE);
>          if (pnv->initrd_size < 0) {
>              error_report("Could not load initial ram disk '%s'",
>                           machine->initrd_filename);
>=20
