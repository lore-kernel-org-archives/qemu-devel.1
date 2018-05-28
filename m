Received: from eggs.gnu.org ([2001:4830:134:3::10]:36974)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fNRs4-0005eg-Sm
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:48:13 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.williamson@redhat.com>) id 1fNRs1-0000hM-RC
	for qemu-devel@nongnu.org; Mon, 28 May 2018 19:48:12 -0400
Date: Mon, 28 May 2018 17:48:05 -0600
From: Alex Williamson <alex.williamson@redhat.com>
Message-ID: <20180528174805.7a56a4b8@w520.home>
In-Reply-To: <20180528232719.4721-2-f4bug@amsat.org>
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v4 01/21] vfio: Include
 "exec/address-spaces.h" directly in the source file
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Cornelia Huck <cohuck@redhat.com>, "open list:S390" <qemu-s390x@nongnu.org>

On Mon, 28 May 2018 20:26:59 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

-ENOCOMMITLOG

Why?  Tangible benefit.  Looks like noise.  Thanks,

Alex

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  include/hw/vfio/vfio-common.h | 1 -
>  hw/vfio/ccw.c                 | 1 +
>  hw/vfio/platform.c            | 1 +
>  3 files changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/include/hw/vfio/vfio-common.h b/include/hw/vfio/vfio-common.h
> index d9360148e6..8264a65fa5 100644
> --- a/include/hw/vfio/vfio-common.h
> +++ b/include/hw/vfio/vfio-common.h
> @@ -22,7 +22,6 @@
>  #define HW_VFIO_VFIO_COMMON_H
> =20
>  #include "qemu-common.h"
> -#include "exec/address-spaces.h"
>  #include "exec/memory.h"
>  #include "qemu/queue.h"
>  #include "qemu/notify.h"
> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index e67392c5f9..76e4e8c652 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -22,6 +22,7 @@
>  #include "hw/vfio/vfio-common.h"
>  #include "hw/s390x/s390-ccw.h"
>  #include "hw/s390x/ccw-device.h"
> +#include "exec/address-spaces.h"
>  #include "qemu/error-report.h"
> =20
>  #define TYPE_VFIO_CCW "vfio-ccw"
> diff --git a/hw/vfio/platform.c b/hw/vfio/platform.c
> index 5c921c27ba..57c4a0ee2b 100644
> --- a/hw/vfio/platform.c
> +++ b/hw/vfio/platform.c
> @@ -24,6 +24,7 @@
>  #include "qemu/range.h"
>  #include "sysemu/sysemu.h"
>  #include "exec/memory.h"
> +#include "exec/address-spaces.h"
>  #include "qemu/queue.h"
>  #include "hw/sysbus.h"
>  #include "trace.h"
