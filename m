Received: from eggs.gnu.org ([2001:4830:134:3::10]:42911)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwOT8-0007pb-5n
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:10:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dwOT3-0007s7-3s
	for qemu-devel@nongnu.org; Mon, 25 Sep 2017 04:10:22 -0400
Date: Mon, 25 Sep 2017 10:10:00 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170925101000.7e996270.cohuck@redhat.com>
In-Reply-To: <20170922154014.29350-2-f4bug@amsat.org>
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-2-f4bug@amsat.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH 01/34] hw: use "qemu/osdep.h" as first
 #include in source files
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Philippe =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <f4bug@amsat.org>
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, David Gibson <david@gibson.dropbear.id.au>, Alexander Graf <agraf@suse.de>, Alex Williamson <alex.williamson@redhat.com>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org, qemu-trivial@nongnu.org

On Fri, 22 Sep 2017 12:39:41 -0300
Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org> wrote:

> applied using ./scripts/clean-includes
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <f4bug@amsat.org>
> ---
>  hw/acpi/ipmi-stub.c             | 1 +
>  hw/audio/fmopl.c                | 1 -
>  hw/cpu/core.c                   | 1 +
>  hw/ppc/spapr_cpu_core.c         | 1 +
>  hw/smbios/smbios_type_38-stub.c | 1 +
>  hw/vfio/ccw.c                   | 2 +-
>  hw/virtio/vhost-vsock.c         | 2 +-
>  7 files changed, 6 insertions(+), 3 deletions(-)
>=20

> diff --git a/hw/vfio/ccw.c b/hw/vfio/ccw.c
> index a8baadf57a..4810fa0b50 100644
> --- a/hw/vfio/ccw.c
> +++ b/hw/vfio/ccw.c
> @@ -11,11 +11,11 @@
>   * directory.
>   */
> =20
> +#include "qemu/osdep.h"
>  #include <linux/vfio.h>
>  #include <linux/vfio_ccw.h>
>  #include <sys/ioctl.h>
> =20
> -#include "qemu/osdep.h"
>  #include "qapi/error.h"
>  #include "hw/sysbus.h"
>  #include "hw/vfio/vfio.h"

Acked-by: Cornelia Huck <cohuck@redhat.com>
