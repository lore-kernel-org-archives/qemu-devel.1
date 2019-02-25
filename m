Received: from eggs.gnu.org ([209.51.188.92]:35504)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gyLQk-0006wY-GB
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:56:47 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <clg@kaod.org>) id 1gyLQj-0000sJ-ON
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:56:46 -0500
Received: from 7.mo7.mail-out.ovh.net ([46.105.43.131]:33757)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <clg@kaod.org>) id 1gyLQj-0000rL-He
	for qemu-devel@nongnu.org; Mon, 25 Feb 2019 13:56:45 -0500
Received: from player699.ha.ovh.net (unknown [10.109.143.146])
	by mo7.mail-out.ovh.net (Postfix) with ESMTP id ECFDA10213C
	for <qemu-devel@nongnu.org>; Mon, 25 Feb 2019 19:56:43 +0100 (CET)
References: <20190225170155.1972-1-muriloo@linux.ibm.com>
	<20190225170155.1972-4-muriloo@linux.ibm.com>
From: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Message-ID: <184c919d-e61e-fdab-3309-52f50d999d9e@kaod.org>
Date: Mon, 25 Feb 2019 19:56:33 +0100
MIME-Version: 1.0
In-Reply-To: <20190225170155.1972-4-muriloo@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 3/3] ppc/pnv: use IEC binary prefixes to
 represent sizes
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
> Using IEC binary prefixes from qemu/units.h provides a more human-frien=
dly value
> to size constants.
>=20
> Suggested-by: Eric Blake <eblake@redhat.com>
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>



Reviewed-by: C=C3=A9dric Le Goater <clg@kaod.org>

Thanks,

C.

> ---
>  hw/ppc/pnv.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index c308ae423a..b6c5d1eff9 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -47,11 +47,11 @@
> =20
>  #include <libfdt.h>
> =20
> -#define FDT_MAX_SIZE            0x00100000
> +#define FDT_MAX_SIZE            (1 * MiB)
> =20
>  #define FW_FILE_NAME            "skiboot.lid"
>  #define FW_LOAD_ADDR            0x0
> -#define FW_MAX_SIZE             0x00400000
> +#define FW_MAX_SIZE             (4 * MiB)
> =20
>  #define KERNEL_LOAD_ADDR        0x20000000
>  #define KERNEL_MAX_SIZE         (256 * MiB)
>=20
