Received: from eggs.gnu.org ([2001:4830:134:3::10]:36347)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fnzj4-0007Xh-HP
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:12:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1fnzj0-0001Gs-KQ
	for qemu-devel@nongnu.org; Fri, 10 Aug 2018 01:12:38 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180809130115.28951-1-peter.maydell@linaro.org>
	<20180809130115.28951-16-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <282c54cf-bf16-f0a2-ff04-c5324c84eb83@amsat.org>
Date: Fri, 10 Aug 2018 02:12:30 -0300
MIME-Version: 1.0
In-Reply-To: <20180809130115.28951-16-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 15/16] hw/dma/pl080: Remove
 hw_error() if DMA is enabled
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

On 08/09/2018 10:01 AM, Peter Maydell wrote:
> The PL08x model currently will unconditionally call hw_error()
> if the DMA engine is enabled by the guest. This has been
> present since the PL080 model was edded in 2006, and is
> presumably either unintentional debug code left enabled,
> or a guard against untested DMA engine code being used.
> 
> Remove the hw_error(), since we now have a guest which
> will actually try to use the DMA engine (the self-test
> binary for the AN505 MPS2 FPGA image).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/dma/pl080.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/dma/pl080.c b/hw/dma/pl080.c
> index 8f92550392b..ef15d3e628d 100644
> --- a/hw/dma/pl080.c
> +++ b/hw/dma/pl080.c
> @@ -110,7 +110,6 @@ static void pl080_run(PL080State *s)
>      if ((s->conf & PL080_CONF_E) == 0)
>          return;
>  
> -hw_error("DMA active\n");
>      /* If we are already in the middle of a DMA operation then indicate that
>         there may be new DMA requests and return immediately.  */
>      if (s->running) {
> 
