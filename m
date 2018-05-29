Received: from eggs.gnu.org ([2001:4830:134:3::10]:53787)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fNZXe-0003eq-Cx
	for qemu-devel@nongnu.org; Tue, 29 May 2018 03:59:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fNZXd-0000Zc-JK
	for qemu-devel@nongnu.org; Tue, 29 May 2018 03:59:38 -0400
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-11-f4bug@amsat.org>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <b3a40260-924b-405b-80fc-521e74498c31@gmail.com>
Date: Tue, 29 May 2018 10:59:29 +0300
MIME-Version: 1.0
In-Reply-To: <20180528232719.4721-11-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 10/21] hw: Do not include
 "exec/ioport.h" if it is not necessary
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Igor Mammedov <imammedo@redhat.com>



On 05/29/2018 02:27 AM, Philippe Mathieu-Daudé wrote:
> Code change produced with:
>      $ git grep '#include "exec/ioport.h"' hw | \
>        cut -d: -f-1 | \
>        xargs egrep -Li "(portio|cpu_(in|out).\()" | \
>        xargs sed -i.bak '/#include "exec\/ioport.h"/d'
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/acpi/pcihp.c | 1 -
>   hw/acpi/piix4.c | 1 -
>   2 files changed, 2 deletions(-)
>
> diff --git a/hw/acpi/pcihp.c b/hw/acpi/pcihp.c
> index 91c82fdc7a..80d42e12ff 100644
> --- a/hw/acpi/pcihp.c
> +++ b/hw/acpi/pcihp.c
> @@ -32,7 +32,6 @@
>   #include "hw/pci/pci.h"
>   #include "hw/acpi/acpi.h"
>   #include "sysemu/sysemu.h"
> -#include "exec/ioport.h"
>   #include "exec/address-spaces.h"
>   #include "hw/pci/pci_bus.h"
>   #include "qapi/error.h"
> diff --git a/hw/acpi/piix4.c b/hw/acpi/piix4.c
> index 8b703455b7..6404af5f33 100644
> --- a/hw/acpi/piix4.c
> +++ b/hw/acpi/piix4.c
> @@ -28,7 +28,6 @@
>   #include "sysemu/sysemu.h"
>   #include "qapi/error.h"
>   #include "qemu/range.h"
> -#include "exec/ioport.h"
>   #include "hw/nvram/fw_cfg.h"
>   #include "exec/address-spaces.h"
>   #include "hw/acpi/piix4.h"

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
