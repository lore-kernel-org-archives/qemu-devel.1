Received: from eggs.gnu.org ([209.51.188.92]:37786)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2Bi7-0000Bo-T2
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:22:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lersek@redhat.com>) id 1h2Bi6-0004hl-Kx
	for qemu-devel@nongnu.org; Fri, 08 Mar 2019 04:22:35 -0500
References: <20190308013222.12524-1-philmd@redhat.com>
	<20190308013222.12524-3-philmd@redhat.com>
From: Laszlo Ersek <lersek@redhat.com>
Message-ID: <0d347de2-ad47-d71c-764f-f10d449f5510@redhat.com>
Date: Fri, 8 Mar 2019 10:22:05 +0100
MIME-Version: 1.0
In-Reply-To: <20190308013222.12524-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2 02/18] hw/i386: Remove unused include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Eduardo Habkost <ehabkost@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Artyom Tarasenko <atar4qemu@gmail.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, David Gibson <david@gibson.dropbear.id.au>, Igor Mammedov <imammedo@redhat.com>, Eric Blake <eblake@redhat.com>, qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Markus Armbruster <armbru@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Thomas Huth <thuth@redhat.com>, "Daniel P . Berrange" <berrange@redhat.com>

On 03/08/19 02:32, Philippe Mathieu-Daud=C3=A9 wrote:
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

Reviewed-by: Laszlo Ersek <lersek@redhat.com>
