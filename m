Received: from eggs.gnu.org ([2001:4830:134:3::10]:51560)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ecS4f-0004lR-RX
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:30:58 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1ecS4c-0002WD-Op
	for qemu-devel@nongnu.org; Fri, 19 Jan 2018 03:30:57 -0500
References: <20180119081511.24010-1-clg@kaod.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <04bf5c9b-3f7d-ba2f-3957-486c5b41719e@redhat.com>
Date: Fri, 19 Jan 2018 09:30:48 +0100
MIME-Version: 1.0
In-Reply-To: <20180119081511.24010-1-clg@kaod.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH] ppc/pnv: fix PnvChip redefinition in
 <hw/ppc/pnv_xscom.h>
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org, David Gibson <david@gibson.dropbear.id.au>

On 19.01.2018 09:15, C=C3=A9dric Le Goater wrote:
> This redefinition generates warnings on some clang compilers and older
> gcc4.4.
>=20
> ...include/hw/ppc/pnv_xscom.h:24:24: warning: redefinition of typedef '=
PnvChip' is a C11
>       feature [-Wtypedef-redefinition]
> typedef struct PnvChip PnvChip;
>                        ^
> ...include/hw/ppc/pnv.h:65:3: note: previous definition is here
> } PnvChip;
>   ^
> 1 warning generated.
>   CC      ppc64-softmmu/hw/ppc/pnv_xscom.o
>=20
> Signed-off-by: C=C3=A9dric Le Goater <clg@kaod.org>
> ---
>  include/hw/ppc/pnv_xscom.h | 2 --
>  1 file changed, 2 deletions(-)
>=20
> diff --git a/include/hw/ppc/pnv_xscom.h b/include/hw/ppc/pnv_xscom.h
> index fb1bd5df095a..255b26a5aaf6 100644
> --- a/include/hw/ppc/pnv_xscom.h
> +++ b/include/hw/ppc/pnv_xscom.h
> @@ -21,8 +21,6 @@
> =20
>  #include "qom/object.h"
> =20
> -typedef struct PnvChip PnvChip;
> -
>  typedef struct PnvXScomInterface {
>      Object parent;
>  } PnvXScomInterface;
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
