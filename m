Received: from eggs.gnu.org ([2001:4830:134:3::10]:50778)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dcxl9-0005Ma-4B
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 13:48:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <edgar.iglesias@gmail.com>) id 1dcxl8-0000Lu-AL
	for qemu-devel@nongnu.org; Wed, 02 Aug 2017 13:48:39 -0400
Date: Wed, 2 Aug 2017 19:48:29 +0200
From: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Message-ID: <20170802174829.GK4859@toto>
References: <1501692241-23310-1-git-send-email-peter.maydell@linaro.org>
	<1501692241-23310-6-git-send-email-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1501692241-23310-6-git-send-email-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 05/15] hw/intc/armv7m_nvic.c:
 Remove out of date comment
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

On Wed, Aug 02, 2017 at 05:43:51PM +0100, Peter Maydell wrote:
> Remove an out of date comment which says there's only one
> item in the NVIC container region -- we put systick into its
> own device object a while back and so now there are two
> things in the container.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Edgar E. Iglesias <edgar.iglesias@xilinx.com>


> ---
>  hw/intc/armv7m_nvic.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/intc/armv7m_nvic.c b/hw/intc/armv7m_nvic.c
> index 323e2d4..2e8166a 100644
> --- a/hw/intc/armv7m_nvic.c
> +++ b/hw/intc/armv7m_nvic.c
> @@ -1036,10 +1036,6 @@ static void armv7m_nvic_realize(DeviceState *dev, Error **errp)
>       *  0xd00..0xd3c - SCS registers
>       *  0xd40..0xeff - Reserved or Not implemented
>       *  0xf00 - STIR
> -     *
> -     * At the moment there is only one thing in the container region,
> -     * but we leave it in place to allow us to pull systick out into
> -     * its own device object later.
>       */
>      memory_region_init(&s->container, OBJECT(s), "nvic", 0x1000);
>      /* The system register region goes at the bottom of the priority
> -- 
> 2.7.4
> 
> 
