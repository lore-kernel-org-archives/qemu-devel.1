Received: from eggs.gnu.org ([209.51.188.92]:37780)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2DkD-0003x3-U3
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:32:56 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <thuth@redhat.com>) id 1h2Dk9-000092-69
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 06:32:52 -0500
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-3-philmd@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e95c7422-c52e-2105-e314-ea19778f8d8c@redhat.com>
Date: Fri, 8 Mar 2019 12:32:32 +0100
MIME-Version: 1.0
In-Reply-To: <20190308013222.12524-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Qemu-ppc] [PATCH v2 02/18] hw/i386: Remove unused
 include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Laszlo Ersek <lersek@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: QEMU Trivial <qemu-trivial@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>, Igor Mammedov <imammedo@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>

On 08/03/2019 02.32, Philippe Mathieu-Daud=C3=A9 wrote:
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>
> ---
> v2: Drop files that do use fw_cfg (Michael):
> - hw/i386/acpi-build.c
> - hw/i386/pc.c
> ---
>  hw/acpi/piix4.c | 1 -
>  1 file changed, 1 deletion(-)
>=20
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 8fd25a5926..7b98121070 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -28,7 +28,6 @@
>  #include "sysemu/sysemu.h"
>  #include "qapi/error.h"
>  #include "qemu/range.h"
> -#include "hw/nvram/fw_cfg.h"
>  #include "exec/address-spaces.h"
>  #include "hw/acpi/piix4.h"
>  #include "hw/acpi/pcihp.h"
>=20

Reviewed-by: Thomas Huth <thuth@redhat.com>
