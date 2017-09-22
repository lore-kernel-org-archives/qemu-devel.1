Received: from eggs.gnu.org ([2001:4830:134:3::10]:52491)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1dvRHL-0005Z2-OX
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:58:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <tcminyard@gmail.com>) id 1dvRHH-0001Cm-Pu
	for qemu-devel@nongnu.org; Fri, 22 Sep 2017 12:58:15 -0400
Reply-To: minyard@acm.org
References: <20170922154014.29350-1-f4bug@amsat.org>
	<20170922154014.29350-15-f4bug@amsat.org>
From: Corey Minyard <tcminyard@gmail.com>
Message-ID: <5d7ffac0-e0a9-c503-7ae5-b27ad86f4c94@gmail.com>
Date: Fri, 22 Sep 2017 11:58:07 -0500
MIME-Version: 1.0
In-Reply-To: <20170922154014.29350-15-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Subject: Re: [Qemu-devel] [PATCH 14/34] hw/ipmi: remove old i386 dependency
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Corey Minyard <minyard@acm.org>
Cc: qemu-trivial@nongnu.org, qemu-devel@nongnu.org

On 09/22/2017 10:39 AM, Philippe Mathieu-Daudé wrote:
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

As mentioned before, I applied this series and did some basic testing, so

Reviewed-by: Corey Minyard <cminyard@mvista.com>
Tested-by: Corey Minyard <cminyard@mvista.com>

> ---
>   hw/ipmi/isa_ipmi_bt.c  | 1 -
>   hw/ipmi/isa_ipmi_kcs.c | 1 -
>   2 files changed, 2 deletions(-)
>
> diff --git a/hw/ipmi/isa_ipmi_bt.c b/hw/ipmi/isa_ipmi_bt.c
> index 2fcc3d2e7c..e098fd5206 100644
> --- a/hw/ipmi/isa_ipmi_bt.c
> +++ b/hw/ipmi/isa_ipmi_bt.c
> @@ -26,7 +26,6 @@
>   #include "hw/hw.h"
>   #include "hw/ipmi/ipmi.h"
>   #include "hw/isa/isa.h"
> -#include "hw/i386/pc.h"
>   
>   /* Control register */
>   #define IPMI_BT_CLR_WR_BIT         0
> diff --git a/hw/ipmi/isa_ipmi_kcs.c b/hw/ipmi/isa_ipmi_kcs.c
> index 80444977a0..689587b65d 100644
> --- a/hw/ipmi/isa_ipmi_kcs.c
> +++ b/hw/ipmi/isa_ipmi_kcs.c
> @@ -26,7 +26,6 @@
>   #include "hw/hw.h"
>   #include "hw/ipmi/ipmi.h"
>   #include "hw/isa/isa.h"
> -#include "hw/i386/pc.h"
>   
>   #define IPMI_KCS_OBF_BIT        0
>   #define IPMI_KCS_IBF_BIT        1
