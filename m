Received: from eggs.gnu.org ([2001:4830:134:3::10]:57056)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMKTL-0002V6-EZ
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:42:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fMKTK-0006T1-2c
	for qemu-devel@nongnu.org; Fri, 25 May 2018 17:42:03 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1527266793-301361-1-git-send-email-mst@redhat.com>
	<1527266793-301361-2-git-send-email-mst@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <20665619-b2ad-4a4a-b28d-06cfc023d47b@amsat.org>
Date: Fri, 25 May 2018 18:41:52 -0300
MIME-Version: 1.0
In-Reply-To: <1527266793-301361-2-git-send-email-mst@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 01/20] block: use local path for local
 headers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Kevin Wolf <kwolf@redhat.com>, peter.maydell@linaro.org, qemu-block@nongnu.org, Jeff Cody <jcody@redhat.com>, Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 05/25/2018 01:47 PM, Michael S. Tsirkin wrote:
> When pulling in headers that are in the same directory as C file (as
> opposed to one in include/), we should use its relative path, without a
> directory.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  block/crypto.c         | 2 +-
>  block/nbd.c            | 2 +-
>  block/qcow.c           | 2 +-
>  block/qcow2-bitmap.c   | 2 +-
>  block/qcow2-cluster.c  | 2 +-
>  block/qcow2-refcount.c | 2 +-
>  block/qcow2-snapshot.c | 2 +-
>  block/qcow2.c          | 4 ++--
>  block/vhdx-endian.c    | 2 +-
>  block/vhdx-log.c       | 2 +-
>  block/vhdx.c           | 2 +-
>  11 files changed, 12 insertions(+), 12 deletions(-)
> 
> diff --git a/block/crypto.c b/block/crypto.c
> index 7e7ad2d..bc322b5 100644
> --- a/block/crypto.c
> +++ b/block/crypto.c
> @@ -29,7 +29,7 @@
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/error.h"
>  #include "qemu/option.h"
> -#include "block/crypto.h"
> +#include "crypto.h"
>  
>  typedef struct BlockCrypto BlockCrypto;
>  
> diff --git a/block/nbd.c b/block/nbd.c
> index 3e1693c..ff8333e 100644
> --- a/block/nbd.c
> +++ b/block/nbd.c
> @@ -27,7 +27,7 @@
>   */
>  
>  #include "qemu/osdep.h"
> -#include "block/nbd-client.h"
> +#include "nbd-client.h"
>  #include "qapi/error.h"
>  #include "qemu/uri.h"
>  #include "block/block_int.h"
> diff --git a/block/qcow.c b/block/qcow.c
> index 3ba2ca2..1f866af 100644
> --- a/block/qcow.c
> +++ b/block/qcow.c
> @@ -37,7 +37,7 @@
>  #include "qapi/qapi-visit-block-core.h"
>  #include "crypto/block.h"
>  #include "migration/blocker.h"
> -#include "block/crypto.h"
> +#include "crypto.h"
>  
>  /**************************************************************/
>  /* QEMU COW block driver with compression and encryption support */
> diff --git a/block/qcow2-bitmap.c b/block/qcow2-bitmap.c
> index 6e93ec4..60d5290 100644
> --- a/block/qcow2-bitmap.c
> +++ b/block/qcow2-bitmap.c
> @@ -30,7 +30,7 @@
>  #include "qemu/cutils.h"
>  
>  #include "block/block_int.h"
> -#include "block/qcow2.h"
> +#include "qcow2.h"
>  
>  /* NOTICE: BME here means Bitmaps Extension and used as a namespace for
>   * _internal_ constants. Please do not use this _internal_ abbreviation for
> diff --git a/block/qcow2-cluster.c b/block/qcow2-cluster.c
> index 1aee726..0d74584 100644
> --- a/block/qcow2-cluster.c
> +++ b/block/qcow2-cluster.c
> @@ -28,7 +28,7 @@
>  #include "qapi/error.h"
>  #include "qemu-common.h"
>  #include "block/block_int.h"
> -#include "block/qcow2.h"
> +#include "qcow2.h"
>  #include "qemu/bswap.h"
>  #include "trace.h"
>  
> diff --git a/block/qcow2-refcount.c b/block/qcow2-refcount.c
> index 2dc2300..4032362 100644
> --- a/block/qcow2-refcount.c
> +++ b/block/qcow2-refcount.c
> @@ -26,7 +26,7 @@
>  #include "qapi/error.h"
>  #include "qemu-common.h"
>  #include "block/block_int.h"
> -#include "block/qcow2.h"
> +#include "qcow2.h"
>  #include "qemu/range.h"
>  #include "qemu/bswap.h"
>  #include "qemu/cutils.h"
> diff --git a/block/qcow2-snapshot.c b/block/qcow2-snapshot.c
> index 74293be..bb6a5b7 100644
> --- a/block/qcow2-snapshot.c
> +++ b/block/qcow2-snapshot.c
> @@ -25,7 +25,7 @@
>  #include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "block/block_int.h"
> -#include "block/qcow2.h"
> +#include "qcow2.h"
>  #include "qemu/bswap.h"
>  #include "qemu/error-report.h"
>  #include "qemu/cutils.h"
> diff --git a/block/qcow2.c b/block/qcow2.c
> index 6d53247..db13109 100644
> --- a/block/qcow2.c
> +++ b/block/qcow2.c
> @@ -27,7 +27,7 @@
>  #include "sysemu/block-backend.h"
>  #include "qemu/module.h"
>  #include <zlib.h>
> -#include "block/qcow2.h"
> +#include "qcow2.h"
>  #include "qemu/error-report.h"
>  #include "qapi/error.h"
>  #include "qapi/qapi-events-block-core.h"
> @@ -39,7 +39,7 @@
>  #include "qemu/bswap.h"
>  #include "qapi/qobject-input-visitor.h"
>  #include "qapi/qapi-visit-block-core.h"
> -#include "block/crypto.h"
> +#include "crypto.h"
>  
>  /*
>    Differences with QCOW:
> diff --git a/block/vhdx-endian.c b/block/vhdx-endian.c
> index 429d755..41fbdd2 100644
> --- a/block/vhdx-endian.c
> +++ b/block/vhdx-endian.c
> @@ -19,7 +19,7 @@
>  #include "qemu-common.h"
>  #include "block/block_int.h"
>  #include "qemu/bswap.h"
> -#include "block/vhdx.h"
> +#include "vhdx.h"
>  
>  /*
>   * All the VHDX formats on disk are little endian - the following
> diff --git a/block/vhdx-log.c b/block/vhdx-log.c
> index 0ac4863..d2f1b98 100644
> --- a/block/vhdx-log.c
> +++ b/block/vhdx-log.c
> @@ -24,7 +24,7 @@
>  #include "qemu/error-report.h"
>  #include "qemu/module.h"
>  #include "qemu/bswap.h"
> -#include "block/vhdx.h"
> +#include "vhdx.h"
>  
>  
>  typedef struct VHDXLogSequence {
> diff --git a/block/vhdx.c b/block/vhdx.c
> index 0b1e21c..79c68a2 100644
> --- a/block/vhdx.c
> +++ b/block/vhdx.c
> @@ -23,7 +23,7 @@
>  #include "qemu/option.h"
>  #include "qemu/crc32c.h"
>  #include "qemu/bswap.h"
> -#include "block/vhdx.h"
> +#include "vhdx.h"
>  #include "migration/blocker.h"
>  #include "qemu/uuid.h"
>  #include "qapi/qmp/qdict.h"
> 
