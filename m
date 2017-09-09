Received: from eggs.gnu.org ([2001:4830:134:3::10]:58132)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dqgRN-0001BR-VP
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 10:08:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1dqgRJ-00066M-Vz
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 10:08:57 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57600)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1dqgRJ-000660-P9
	for qemu-devel@nongnu.org; Sat, 09 Sep 2017 10:08:53 -0400
References: <20170903163615.15562-1-n54@gmx.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f8a871b8-5cc8-8ebe-5c0e-7983a85b993b@redhat.com>
Date: Sat, 9 Sep 2017 16:08:50 +0200
MIME-Version: 1.0
In-Reply-To: <20170903163615.15562-1-n54@gmx.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] scsi/esp: Rename the ESP symbol to QESP
 (QEMU ESP)
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Kamil Rytarowski <n54@gmx.com>
Cc: qemu-devel@nongnu.org

On 03/09/2017 18:36, Kamil Rytarowski wrote:
> SunOS defines ESP (x86 register) in <sys/regset.h> as 7.
> 
> This fixes build on SmartOS (Joyent).
> 
> Signed-off-by: Kamil Rytarowski <n54@gmx.com>
> ---
>  hw/scsi/esp.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index eee831efeb..38ddfd6715 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -593,7 +593,7 @@ const VMStateDescription vmstate_esp = {
>  };
>  
>  #define TYPE_ESP "esp"
> -#define ESP(obj) OBJECT_CHECK(SysBusESPState, (obj), TYPE_ESP)
> +#define QESP(obj) OBJECT_CHECK(SysBusESPState, (obj), TYPE_ESP)
>  
>  typedef struct {
>      /*< private >*/
> @@ -644,7 +644,7 @@ void esp_init(hwaddr espaddr, int it_shift,
>      ESPState *esp;
>  
>      dev = qdev_create(NULL, TYPE_ESP);
> -    sysbus = ESP(dev);
> +    sysbus = QESP(dev);
>      esp = &sysbus->esp;
>      esp->dma_memory_read = dma_memory_read;
>      esp->dma_memory_write = dma_memory_write;
> @@ -672,7 +672,7 @@ static const struct SCSIBusInfo esp_scsi_info = {
>  
>  static void sysbus_esp_gpio_demux(void *opaque, int irq, int level)
>  {
> -    SysBusESPState *sysbus = ESP(opaque);
> +    SysBusESPState *sysbus = QESP(opaque);
>      ESPState *s = &sysbus->esp;
>  
>      switch (irq) {
> @@ -688,7 +688,7 @@ static void sysbus_esp_gpio_demux(void *opaque, int irq, int level)
>  static void sysbus_esp_realize(DeviceState *dev, Error **errp)
>  {
>      SysBusDevice *sbd = SYS_BUS_DEVICE(dev);
> -    SysBusESPState *sysbus = ESP(dev);
> +    SysBusESPState *sysbus = QESP(dev);
>      ESPState *s = &sysbus->esp;
>  
>      sysbus_init_irq(sbd, &s->irq);
> @@ -706,7 +706,7 @@ static void sysbus_esp_realize(DeviceState *dev, Error **errp)
>  
>  static void sysbus_esp_hard_reset(DeviceState *dev)
>  {
> -    SysBusESPState *sysbus = ESP(dev);
> +    SysBusESPState *sysbus = QESP(dev);
>      esp_hard_reset(&sysbus->esp);
>  }
>  
> 

Sorry for bikeshedding, let's rename it to ESP_STATE instead.

Thanks,

Paolo
