Received: from eggs.gnu.org ([208.118.235.92]:33411)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfUFa-00007r-Ay
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:31:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gfUFX-0003wm-83
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:31:18 -0500
Received: from mail-wr1-f67.google.com ([209.85.221.67]:37682)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gfUFX-0003vf-24
	for qemu-devel@nongnu.org; Fri, 04 Jan 2019 13:31:15 -0500
Received: by mail-wr1-f67.google.com with SMTP id s12so37354654wrt.4
	for <qemu-devel@nongnu.org>; Fri, 04 Jan 2019 10:31:13 -0800 (PST)
References: <20190104182057.8778-1-philmd@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8176371f-6dff-adee-84d1-5758ed74700c@redhat.com>
Date: Fri, 4 Jan 2019 19:31:10 +0100
MIME-Version: 1.0
In-Reply-To: <20190104182057.8778-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH] hw/char/stm32f2xx_usart: Do not update
 data register when device is disabled
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Marc-Andr=c3=a9_Lureau?= <marcandre.lureau@redhat.com>, Alistair Francis <alistair@alistair23.me>, Peter Maydell <peter.maydell@linaro.org>

On 1/4/19 7:20 PM, Philippe Mathieu-Daudé wrote:
> When the device is disable, the internal circuitry keep the data

"keep" -> "keeps"

> register loaded and doesn't update it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  hw/char/stm32f2xx_usart.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/hw/char/stm32f2xx_usart.c b/hw/char/stm32f2xx_usart.c
> index f3363a2952..10392c70e2 100644
> --- a/hw/char/stm32f2xx_usart.c
> +++ b/hw/char/stm32f2xx_usart.c
> @@ -53,14 +53,13 @@ static void stm32f2xx_usart_receive(void *opaque, const uint8_t *buf, int size)
>  {
>      STM32F2XXUsartState *s = opaque;
>  
> -    s->usart_dr = *buf;
> -
>      if (!(s->usart_cr1 & USART_CR1_UE && s->usart_cr1 & USART_CR1_RE)) {
>          /* USART not enabled - drop the chars */
>          DB_PRINT("Dropping the chars\n");
>          return;
>      }
>  
> +    s->usart_dr = *buf;
>      s->usart_sr |= USART_SR_RXNE;
>  
>      if (s->usart_cr1 & USART_CR1_RXNEIE) {
> 
