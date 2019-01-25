Received: from eggs.gnu.org ([209.51.188.92]:53958)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn4Vh-0003D4-An
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:39:19 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gn4Vg-0003nL-3P
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:39:17 -0500
Received: from mail-wr1-f53.google.com ([209.85.221.53]:45166)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gn4Vb-0003kp-36
	for qemu-devel@nongnu.org; Fri, 25 Jan 2019 11:39:13 -0500
Received: by mail-wr1-f53.google.com with SMTP id t6so10934504wrr.12
	for <qemu-devel@nongnu.org>; Fri, 25 Jan 2019 08:39:09 -0800 (PST)
References: <20190125155630.17430-1-sourav.jb1988@gmail.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <634199bb-6444-a5de-2234-1895b02b5615@redhat.com>
Date: Fri, 25 Jan 2019 17:39:07 +0100
MIME-Version: 1.0
In-Reply-To: <20190125155630.17430-1-sourav.jb1988@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/arm/nrf51_soc: set object owner in
 memory_region_init_ram
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kumar sourav <sourav.jb1988@gmail.com>, qemu-trivial@nongnu.org
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org, joel@jms.id.au, qemu-devel@nongnu.org

On 1/25/19 4:56 PM, kumar sourav wrote:
> set object owner in memory_region_init_ram() instead
> of NULL.
> 
> Signed-off-by: kumar sourav <sourav.jb1988@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  hw/arm/nrf51_soc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/hw/arm/nrf51_soc.c b/hw/arm/nrf51_soc.c
> index 1630c27594..3a1c7e200c 100644
> --- a/hw/arm/nrf51_soc.c
> +++ b/hw/arm/nrf51_soc.c
> @@ -89,7 +89,8 @@ static void nrf51_soc_realize(DeviceState *dev_soc, Error **errp)
>      }
>      memory_region_add_subregion(&s->container, NRF51_FLASH_BASE, &s->flash);
>  
> -    memory_region_init_ram(&s->sram, NULL, "nrf51.sram", s->sram_size, &err);
> +    memory_region_init_ram(&s->sram, OBJECT(s), "nrf51.sram", s->sram_size,
> +                           &err);
>      if (err) {
>          error_propagate(errp, err);
>          return;
> 
