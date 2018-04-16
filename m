Received: from eggs.gnu.org ([2001:4830:134:3::10]:35420)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1f7vg4-00026A-Qu
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 00:23:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1f7vfz-0007LN-Tu
	for qemu-devel@nongnu.org; Mon, 16 Apr 2018 00:23:40 -0400
References: <20180415234307.28132-1-f4bug@amsat.org>
	<20180415234307.28132-39-f4bug@amsat.org>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <3c4dcab3-b75f-8e1a-b4f0-9d7a7bda63a7@redhat.com>
Date: Mon, 16 Apr 2018 07:23:24 +0300
MIME-Version: 1.0
In-Reply-To: <20180415234307.28132-39-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v3 38/41] hw/rdma: Use the BYTE-based
 definitions
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-trivial@nongnu.org, Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Yuval Shaia <yuval.shaia@oracle.com>

On 16/04/2018 2:43, Philippe Mathieu-Daud=C3=A9 wrote:
> It eases code review, unit is explicit.
>=20
> Patch generated using:
>=20
>   $ git grep -E '(1024|2048|4096|8192|(<<|>>).?(10|20|30))' hw/ include=
/hw/
>=20
> and modified manually.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/rdma/vmw/pvrdma.h | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/hw/rdma/vmw/pvrdma.h b/hw/rdma/vmw/pvrdma.h
> index 8c173cb824..f17143f0e6 100644
> --- a/hw/rdma/vmw/pvrdma.h
> +++ b/hw/rdma/vmw/pvrdma.h
> @@ -16,6 +16,7 @@
>  #ifndef PVRDMA_PVRDMA_H
>  #define PVRDMA_PVRDMA_H
> =20
> +#include "qemu/units.h"
>  #include "hw/pci/pci.h"
>  #include "hw/pci/msix.h"
> =20
> @@ -30,7 +31,7 @@
>  #define RDMA_MSIX_BAR_IDX    0
>  #define RDMA_REG_BAR_IDX     1
>  #define RDMA_UAR_BAR_IDX     2
> -#define RDMA_BAR0_MSIX_SIZE  (16 * 1024)
> +#define RDMA_BAR0_MSIX_SIZE  (16 * K_BYTE)
>  #define RDMA_BAR1_REGS_SIZE  256
>  #define RDMA_BAR2_UAR_SIZE   (0x1000 * MAX_UCS) /* each uc gets page *=
/
> =20
>=20

Reviewed-by: Marcel Apfelbaum <marcel@redhat.com>

Thanks,
Marcel
