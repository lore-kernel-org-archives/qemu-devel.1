Received: from eggs.gnu.org ([209.51.188.92]:48708)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grOaL-0004CR-3W
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:53:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grOaK-00061Y-9y
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:53:56 -0500
References: <20190204210433.26088-1-philmd@redhat.com>
	<20190204210433.26088-2-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <9b5cdbdd-4d54-88e5-ecad-2c08c89fcd5f@vivier.eu>
Date: Wed, 6 Feb 2019 15:53:36 +0100
MIME-Version: 1.0
In-Reply-To: <20190204210433.26088-2-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 1/3] hw/sparc64/sun4u: Drop
 useless inclusion of "hw/i386/pc.h"
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>, qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Cc: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, qemu-ppc@nongnu.org, Guan Xuetao <gxt@mprc.pku.edu.cn>, Artyom Tarasenko <atar4qemu@gmail.com>, David Gibson <david@gibson.dropbear.id.au>

On 04/02/2019 22:04, Philippe Mathieu-Daudé wrote:
> In 47973a2dbf we split the last generic chipset out of the PC
> board, but forgot to remove the include of "hw/i386/pc.h".
> Since it is now unused, remove it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/sparc64/sun4u.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/sparc64/sun4u.c b/hw/sparc64/sun4u.c
> index f76b19e4e9..fdf3f14a29 100644
> --- a/hw/sparc64/sun4u.c
> +++ b/hw/sparc64/sun4u.c
> @@ -33,7 +33,6 @@
>  #include "hw/pci/pci_bus.h"
>  #include "hw/pci/pci_host.h"
>  #include "hw/pci-host/sabre.h"
> -#include "hw/i386/pc.h"
>  #include "hw/char/serial.h"
>  #include "hw/char/parallel.h"
>  #include "hw/timer/m48t59.h"
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
