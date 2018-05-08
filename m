Received: from eggs.gnu.org ([2001:4830:134:3::10]:41284)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fG009-0002Gm-G8
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:37:46 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fG008-0000Z8-Nb
	for qemu-devel@nongnu.org; Tue, 08 May 2018 06:37:45 -0400
Date: Tue, 8 May 2018 18:37:34 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180508103734.GB19024@xz-mi>
References: <20180427110137.19304-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180427110137.19304-1-peter.maydell@linaro.org>
Subject: Re: [Qemu-devel] [PATCH] hw/arm/iotkit.c: fix minor memory leak
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

On Fri, Apr 27, 2018 at 12:01:37PM +0100, Peter Maydell wrote:
> Coverity (CID1390573) spots that we forgot to free the
> gpioname strings in a loop in the iotkit realize function.
> Correct the error.
> 
> This isn't a significant leak, because this function
> only ever runs once.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

I believe this even does not require ARM knowledges, so:

Reviewed-by: Peter Xu <peterx@redhat.com>

> ---
>  hw/arm/iotkit.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/arm/iotkit.c b/hw/arm/iotkit.c
> index c5f0a5b98a..234185e8f7 100644
> --- a/hw/arm/iotkit.c
> +++ b/hw/arm/iotkit.c
> @@ -517,6 +517,7 @@ static void iotkit_realize(DeviceState *dev, Error **errp)
>                                qdev_get_gpio_in(DEVICE(&s->ppc_irq_orgate), i));
>          qdev_connect_gpio_out_named(DEVICE(ppc), "irq", 0,
>                                      qdev_get_gpio_in(devs, 0));
> +        g_free(gpioname);
>      }
>  
>      iotkit_forward_sec_resp_cfg(s);
> -- 
> 2.17.0
> 
> 

-- 
Peter Xu
