Received: from eggs.gnu.org ([2001:4830:134:3::10]:54430)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddIUw-0002Xr-7k
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:57:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1ddIUv-0006pe-6a
	for qemu-devel@nongnu.org; Thu, 03 Aug 2017 11:57:18 -0400
Date: Thu, 3 Aug 2017 17:57:08 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170803155708.GV4859@toto>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-15-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501692241-23310-15-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 14/15] armv7m_nvic.h: Move from
 include/hw/arm to include/hw/intc
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org, patches@linaro.org

On Wed, Aug 02, 2017 at 05:44:00PM +0100, Peter Maydell wrote:
> The armv7m_nvic.h header file was accidentally placed in
> include/hw/arm; move it to include/hw/intc to match where
> its corresponding .c file lives.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  hw/intc/armv7m_nvic.c                  | 2 +-
>  include/hw/arm/armv7m.h                | 2 +-
>  include/hw/{arm => intc}/armv7m_nvic.h | 0
>  3 files changed, 2 insertions(+), 2 deletions(-)
>  rename include/hw/{arm => intc}/armv7m_nvic.h (100%)
> 
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 343bc16..5a18025 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -17,7 +17,7 @@
>  #include "hw/sysbus.h"
>  #include "qemu/timer.h"
>  #include "hw/arm/arm.h"
> -#include "hw/arm/armv7m_nvic.h"
> +#include "hw/intc/armv7m_nvic.h"
>  #include "target/arm/cpu.h"
>  #include "exec/exec-all.h"
>  #include "qemu/log.h"
> diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
> index a9b3f2a..10eb058 100644
> --- a/include/hw/arm/armv7m.h
> +++ b/include/hw/arm/armv7m.h
> @@ -11,7 +11,7 @@
>  #define HW_ARM_ARMV7M_H
>  
>  #include "hw/sysbus.h"
> -#include "hw/arm/armv7m_nvic.h"
> +#include "hw/intc/armv7m_nvic.h"
>  
>  #define TYPE_BITBAND "ARM,bitband-memory"
>  #define BITBAND(obj) OBJECT_CHECK(BitBandState, (obj), TYPE_BITBAND)
> diff --git a/include/hw/arm/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
> similarity index 100%
> rename from include/hw/arm/armv7m_nvic.h
> rename to include/hw/intc/armv7m_nvic.h
> -- 
> 2.7.4
> 
> 
