Received: from eggs.gnu.org ([2001:4830:134:3::10]:32907)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e86up-0004lF-5u
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:51:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e86uk-0004aY-TY
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:51:23 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:51534)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e86uk-0004a1-P0
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 11:51:18 -0400
Received: by mail-qt0-x244.google.com with SMTP id h4so8955760qtk.8
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 08:51:18 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508947167-5304-8-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <1f6a3e38-5267-f939-a5c2-2c1bc0cf93a6@amsat.org>
Date: Fri, 27 Oct 2017 12:51:09 -0300
MIME-Version: 1.0
In-Reply-To: <1508947167-5304-8-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv4 07/13] esp: move TYPE_ESP and
 SysBusESPState from esp.c to esp.h
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com
Cc: Paolo Bonzini <pbonzini@redhat.com>

On 10/25/2017 12:59 PM, Mark Cave-Ayland wrote:
> This enables them to be used outside of esp.c.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/scsi/esp.c         |   13 -------------
>  include/hw/scsi/esp.h |   14 ++++++++++++++
>  2 files changed, 14 insertions(+), 13 deletions(-)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index 22c2d91..ee586e7 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -592,19 +592,6 @@ const VMStateDescription vmstate_esp = {
>      }
>  };
>  
> -#define TYPE_ESP "esp"
> -#define ESP_STATE(obj) OBJECT_CHECK(SysBusESPState, (obj), TYPE_ESP)
> -
> -typedef struct {
> -    /*< private >*/
> -    SysBusDevice parent_obj;
> -    /*< public >*/
> -
> -    MemoryRegion iomem;
> -    uint32_t it_shift;
> -    ESPState esp;
> -} SysBusESPState;
> -
>  static void sysbus_esp_mem_write(void *opaque, hwaddr addr,
>                                   uint64_t val, unsigned int size)
>  {
> diff --git a/include/hw/scsi/esp.h b/include/hw/scsi/esp.h
> index d2c4886..3b160f8 100644
> --- a/include/hw/scsi/esp.h
> +++ b/include/hw/scsi/esp.h
> @@ -2,6 +2,7 @@
>  #define QEMU_HW_ESP_H
>  
>  #include "hw/scsi/scsi.h"
> +#include "hw/sysbus.h"
>  
>  /* esp.c */
>  #define ESP_MAX_DEVS 7
> @@ -52,6 +53,19 @@ struct ESPState {
>      void (*dma_cb)(ESPState *s);
>  };
>  
> +#define TYPE_ESP "esp"
> +#define ESP_STATE(obj) OBJECT_CHECK(SysBusESPState, (obj), TYPE_ESP)
> +
> +typedef struct {
> +    /*< private >*/
> +    SysBusDevice parent_obj;
> +    /*< public >*/
> +
> +    MemoryRegion iomem;
> +    uint32_t it_shift;
> +    ESPState esp;
> +} SysBusESPState;
> +
>  #define ESP_TCLO   0x0
>  #define ESP_TCMID  0x1
>  #define ESP_FIFO   0x2
> 
