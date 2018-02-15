Received: from eggs.gnu.org ([2001:4830:134:3::10]:47743)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emChg-0005KR-43
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 01:07:33 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1emChf-0007f0-78
	for qemu-devel@nongnu.org; Thu, 15 Feb 2018 01:07:32 -0500
References: <20180215042900.16078-1-f4bug@amsat.org>
	<20180215042900.16078-4-f4bug@amsat.org>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <f021eed7-5613-6608-aaa9-951733f80c3f@redhat.com>
Date: Thu, 15 Feb 2018 07:07:22 +0100
MIME-Version: 1.0
In-Reply-To: <20180215042900.16078-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 03/30] hw/block/nvme: include the
 "qemu/cutils.h" in the source file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, qemu-devel@nongnu.org
Cc: Keith Busch <keith.busch@intel.com>, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org, Max Reitz <mreitz@redhat.com>, qemu-trivial@nongnu.org

On 15.02.2018 05:28, Philippe Mathieu-Daud=C3=A9 wrote:
> where it is used.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/block/nvme.h | 1 -
>  hw/block/nvme.c | 1 +
>  2 files changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/hw/block/nvme.h b/hw/block/nvme.h
> index 8f3981121d..cabcf20c32 100644
> --- a/hw/block/nvme.h
> +++ b/hw/block/nvme.h
> @@ -1,6 +1,5 @@
>  #ifndef HW_NVME_H
>  #define HW_NVME_H
> -#include "qemu/cutils.h"
>  #include "block/nvme.h"
> =20
>  typedef struct NvmeAsyncEvent {
> diff --git a/hw/block/nvme.c b/hw/block/nvme.c
> index 85d2406400..811084b6a7 100644
> --- a/hw/block/nvme.c
> +++ b/hw/block/nvme.c
> @@ -35,6 +35,7 @@
>  #include "sysemu/block-backend.h"
> =20
>  #include "qemu/log.h"
> +#include "qemu/cutils.h"
>  #include "trace.h"
>  #include "nvme.h"

Reviewed-by: Thomas Huth <thuth@redhat.com>
