Received: from eggs.gnu.org ([209.51.188.92]:48951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grObD-0004qV-MV
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:54:52 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <laurent@vivier.eu>) id 1grObC-0006Ol-Jq
	for qemu-devel@nongnu.org; Wed, 06 Feb 2019 09:54:51 -0500
References: <20190204210433.26088-1-philmd@redhat.com>
	<20190204210433.26088-3-philmd@redhat.com>
From: Laurent Vivier <laurent@vivier.eu>
Message-ID: <a131c869-cc90-eb4c-1a21-746cc9b29b33@vivier.eu>
Date: Wed, 6 Feb 2019 15:54:29 +0100
MIME-Version: 1.0
In-Reply-To: <20190204210433.26088-3-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-trivial] [PATCH 2/3] hw/unicore32/puv3: Drop
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
>  hw/unicore32/puv3.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/unicore32/puv3.c b/hw/unicore32/puv3.c
> index 830fe3face..b42e600f74 100644
> --- a/hw/unicore32/puv3.c
> +++ b/hw/unicore32/puv3.c
> @@ -15,7 +15,6 @@
>  #include "ui/console.h"
>  #include "hw/boards.h"
>  #include "hw/loader.h"
> -#include "hw/i386/pc.h"
>  #include "sysemu/qtest.h"
>  
>  #undef DEBUG_PUV3
> 

Applied to my trivial-patches branch.

Thanks,
Laurent
