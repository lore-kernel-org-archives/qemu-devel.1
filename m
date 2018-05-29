Received: from eggs.gnu.org ([2001:4830:134:3::10]:53382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fNZWJ-0002rC-Om
	for qemu-devel@nongnu.org; Tue, 29 May 2018 03:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel.apfelbaum@gmail.com>) id 1fNZWI-0008GL-R7
	for qemu-devel@nongnu.org; Tue, 29 May 2018 03:58:15 -0400
References: <20180528232719.4721-1-f4bug@amsat.org>
	<20180528232719.4721-18-f4bug@amsat.org>
From: Marcel Apfelbaum <marcel.apfelbaum@gmail.com>
Message-ID: <145a7511-f2f9-6535-9711-8614a2ec16f1@gmail.com>
Date: Tue, 29 May 2018 10:58:05 +0300
MIME-Version: 1.0
In-Reply-To: <20180528232719.4721-18-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH v4 17/21] hw/misc/sga: Use the correct ISA
 include
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Thomas Huth <thuth@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-trivial@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>



On 05/29/2018 02:27 AM, Philippe Mathieu-Daudé wrote:
> The SGA BIOS loader is an ISA device, it does not require the PCI header.
>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/misc/sga.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/hw/misc/sga.c b/hw/misc/sga.c
> index 97fd63f176..4a22a52a60 100644
> --- a/hw/misc/sga.c
> +++ b/hw/misc/sga.c
> @@ -25,7 +25,7 @@
>    *
>    */
>   #include "qemu/osdep.h"
> -#include "hw/pci/pci.h"
> +#include "hw/isa/isa.h"
>   #include "hw/loader.h"
>   #include "sysemu/sysemu.h"
>   

Reviewed-by: Marcel Apfelbaum<marcel.apfelbaum@gmail.com>

Thanks,
Marcel
