Received: from eggs.gnu.org ([2001:4830:134:3::10]:38080)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1euFN0-00070E-ET
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:35:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mark.cave-ayland@ilande.co.uk>) id 1euFMz-0004XT-Gk
	for qemu-devel@nongnu.org; Fri, 09 Mar 2018 05:35:26 -0500
References: <20180308223946.26784-1-f4bug@amsat.org>
	<20180308223946.26784-8-f4bug@amsat.org>
From: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
Message-ID: <d649ccc6-0b91-40d7-38f0-2fbc3a57494b@ilande.co.uk>
Date: Fri, 9 Mar 2018 10:35:08 +0000
MIME-Version: 1.0
In-Reply-To: <20180308223946.26784-8-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH 07/25] hw/isa/pc87312: Use 'unsigned int'
 for the irq value
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>, "Michael S . Tsirkin" <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Herv=c3=a9_Poussineau?= <hpoussin@reactos.org>, Marcel Apfelbaum <marcel@redhat.com>, Aurelien Jarno <aurelien@aurel32.net>, Alexey Kardashevskiy <aik@ozlabs.ru>, Thomas Huth <thuth@redhat.com>
Cc: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, "open list:PReP" <qemu-ppc@nongnu.org>, Guan Xuetao <gxt@mprc.pku.edu.cn>, Yongbok Kim <yongbok.kim@mips.com>, Artyom Tarasenko <atar4qemu@gmail.com>, Richard Henderson <rth@twiddle.net>

On 08/03/18 22:39, Philippe Mathieu-Daudé wrote:

> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>   hw/isa/pc87312.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/isa/pc87312.c b/hw/isa/pc87312.c
> index 105c23e680..fda91fed21 100644
> --- a/hw/isa/pc87312.c
> +++ b/hw/isa/pc87312.c
> @@ -76,9 +76,9 @@ static inline uint16_t get_parallel_iobase(PC87312State *s)
>       return parallel_base[s->regs[REG_FAR] & FAR_PARALLEL_ADDR];
>   }
>   
> -static const uint32_t parallel_irq[] = { 5, 7, 5, 0 };
> +static const unsigned int parallel_irq[] = { 5, 7, 5, 0 };
>   
> -static inline uint32_t get_parallel_irq(PC87312State *s)
> +static inline unsigned int get_parallel_irq(PC87312State *s)
>   {
>       int idx;
>       idx = (s->regs[REG_FAR] & FAR_PARALLEL_ADDR);
> @@ -110,7 +110,7 @@ static inline uint16_t get_uart_iobase(PC87312State *s, int i)
>       }
>   }
>   
> -static inline uint32_t get_uart_irq(PC87312State *s, int i)
> +static inline unsigned int get_uart_irq(PC87312State *s, int i)
>   {
>       int idx;
>       idx = (s->regs[REG_FAR] >> (2 * i + 2)) & 0x3;
> 

Reviewed-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>


ATB,

Mark.
