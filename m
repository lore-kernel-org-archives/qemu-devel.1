Received: from eggs.gnu.org ([2001:4830:134:3::10]:50887)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dd1Vy-0000jo-7A
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:49:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dd1Vx-0000hC-9p
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 17:49:14 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-15-git-send-email-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <988ce89c-4e6c-5cf3-f040-7797a9f7902d@amsat.org>
Date: Wed, 2 Aug 2017 18:49:09 -0300
MIME-Version: 1.0
In-Reply-To: <1501692241-23310-15-git-send-email-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
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
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: patches@linaro.org

On 08/02/2017 01:44 PM, Peter Maydell wrote:
> The armv7m_nvic.h header file was accidentally placed in
> include/hw/arm; move it to include/hw/intc to match where
> its corresponding .c file lives.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/intc/armv7m_nvic.c                  | 2 +-
>   include/hw/arm/armv7m.h                | 2 +-
>   include/hw/{arm => intc}/armv7m_nvic.h | 0
>   3 files changed, 2 insertions(+), 2 deletions(-)
>   rename include/hw/{arm => intc}/armv7m_nvic.h (100%)
> 
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 343bc16..5a18025 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -17,7 +17,7 @@
>   #include "hw/sysbus.h"
>   #include "qemu/timer.h"
>   #include "hw/arm/arm.h"
> -#include "hw/arm/armv7m_nvic.h"
> +#include "hw/intc/armv7m_nvic.h"
>   #include "target/arm/cpu.h"
>   #include "exec/exec-all.h"
>   #include "qemu/log.h"
> diff --git a/include/hw/arm/armv7m.h b/include/hw/arm/armv7m.h
> index a9b3f2a..10eb058 100644
> --- a/include/hw/arm/armv7m.h
> +++ b/include/hw/arm/armv7m.h
> @@ -11,7 +11,7 @@
>   #define HW_ARM_ARMV7M_H
>   
>   #include "hw/sysbus.h"
> -#include "hw/arm/armv7m_nvic.h"
> +#include "hw/intc/armv7m_nvic.h"
>   
>   #define TYPE_BITBAND "ARM,bitband-memory"
>   #define BITBAND(obj) OBJECT_CHECK(BitBandState, (obj), TYPE_BITBAND)
> diff --git a/include/hw/arm/armv7m_nvic.h b/include/hw/intc/armv7m_nvic.h
> similarity index 100%
> rename from include/hw/arm/armv7m_nvic.h
> rename to include/hw/intc/armv7m_nvic.h
> 
