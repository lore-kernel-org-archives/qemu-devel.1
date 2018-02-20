Received: from eggs.gnu.org ([2001:4830:134:3::10]:60051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eoCbW-0002W1-Ta
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:25:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eoCbT-0007Xw-LF
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:25:26 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-11-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <715fd4d5-13b8-2cbe-9f9d-545c56302933@amsat.org>
Date: Tue, 20 Feb 2018 15:25:20 -0300
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-11-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 10/19] include/hw/or-irq.h: Add missing
 include guard
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

On 02/20/2018 03:03 PM, Peter Maydell wrote:
> The or-irq.h header file is missing the customary guard against
> multiple inclusion, which means compilation fails if it gets
> included twice. Fix the omission.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/or-irq.h | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/include/hw/or-irq.h b/include/hw/or-irq.h
> index fd900fcf19..3f6fc1b58a 100644
> --- a/include/hw/or-irq.h
> +++ b/include/hw/or-irq.h
> @@ -22,6 +22,9 @@
>   * THE SOFTWARE.
>   */
>  
> +#ifndef HW_OR_IRQ_H
> +#define HW_OR_IRQ_H
> +
>  #include "hw/irq.h"
>  #include "hw/sysbus.h"
>  #include "qom/object.h"
> @@ -41,3 +44,5 @@ struct OrIRQState {
>      bool levels[MAX_OR_LINES];
>      uint16_t num_lines;
>  };
> +
> +#endif
> 
