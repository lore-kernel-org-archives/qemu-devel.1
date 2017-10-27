Received: from eggs.gnu.org ([2001:4830:134:3::10]:48677)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87UO-0006VM-0B
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:28:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87UH-0002kL-K7
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:28:08 -0400
Received: from mail-qt0-x244.google.com ([2607:f8b0:400d:c0d::244]:48578)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1e87UH-0002k4-Dh
	for qemu-devel@nongnu.org; Fri, 27 Oct 2017 12:28:01 -0400
Received: by mail-qt0-x244.google.com with SMTP id f8so9101381qta.5
	for <qemu-devel@nongnu.org>; Fri, 27 Oct 2017 09:28:01 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <1508947167-5304-1-git-send-email-mark.cave-ayland@ilande.co.uk>
	<1508947167-5304-2-git-send-email-mark.cave-ayland@ilande.co.uk>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a9e6e26e-9a53-d840-8e0c-e36110a23795@amsat.org>
Date: Fri, 27 Oct 2017 13:27:57 -0300
MIME-Version: 1.0
In-Reply-To: <1508947167-5304-2-git-send-email-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCHv4 01/13] sparc32_dma: rename SPARC32_DMA
 type to SPARC32_DMA_DEVICE
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org, atar4qemu@gmail.com

On 10/25/2017 12:59 PM, Mark Cave-Ayland wrote:
> Also update the function names to match as appropriate. While we're
> here rename the type from sparc32_dma to sparc32-dma in order to
> match the current QOM convention.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> Reviewed-by: Artyom Tarasenko <atar4qemu@gmail.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  hw/dma/sparc32_dma.c |   67 +++++++++++++++++++++++++-------------------------
>  hw/sparc/sun4m.c     |    2 +-
>  2 files changed, 35 insertions(+), 34 deletions(-)
> 
> diff --git a/hw/dma/sparc32_dma.c b/hw/dma/sparc32_dma.c
> index eb491b5..a8d31c1 100644
> --- a/hw/dma/sparc32_dma.c
> +++ b/hw/dma/sparc32_dma.c
> @@ -61,12 +61,13 @@
>  /* XXX SCSI and ethernet should have different read-only bit masks */
>  #define DMA_CSR_RO_MASK 0xfe000007
>  
> -#define TYPE_SPARC32_DMA "sparc32_dma"
> -#define SPARC32_DMA(obj) OBJECT_CHECK(DMAState, (obj), TYPE_SPARC32_DMA)
> +#define TYPE_SPARC32_DMA_DEVICE "sparc32-dma-device"
> +#define SPARC32_DMA_DEVICE(obj) OBJECT_CHECK(DMADeviceState, (obj), \
> +                                             TYPE_SPARC32_DMA_DEVICE)
>  
> -typedef struct DMAState DMAState;
> +typedef struct DMADeviceState DMADeviceState;
>  
> -struct DMAState {
> +struct DMADeviceState {
>      SysBusDevice parent_obj;
>  
>      MemoryRegion iomem;
> @@ -86,7 +87,7 @@ enum {
>  void ledma_memory_read(void *opaque, hwaddr addr,
>                         uint8_t *buf, int len, int do_bswap)
>  {
> -    DMAState *s = opaque;
> +    DMADeviceState *s = opaque;
>      int i;
>  
>      addr |= s->dmaregs[3];
> @@ -106,7 +107,7 @@ void ledma_memory_read(void *opaque, hwaddr addr,
>  void ledma_memory_write(void *opaque, hwaddr addr,
>                          uint8_t *buf, int len, int do_bswap)
>  {
> -    DMAState *s = opaque;
> +    DMADeviceState *s = opaque;
>      int l, i;
>      uint16_t tmp_buf[32];
>  
> @@ -134,7 +135,7 @@ void ledma_memory_write(void *opaque, hwaddr addr,
>  
>  static void dma_set_irq(void *opaque, int irq, int level)
>  {
> -    DMAState *s = opaque;
> +    DMADeviceState *s = opaque;
>      if (level) {
>          s->dmaregs[0] |= DMA_INTR;
>          if (s->dmaregs[0] & DMA_INTREN) {
> @@ -154,7 +155,7 @@ static void dma_set_irq(void *opaque, int irq, int level)
>  
>  void espdma_memory_read(void *opaque, uint8_t *buf, int len)
>  {
> -    DMAState *s = opaque;
> +    DMADeviceState *s = opaque;
>  
>      trace_espdma_memory_read(s->dmaregs[1]);
>      sparc_iommu_memory_read(s->iommu, s->dmaregs[1], buf, len);
> @@ -163,7 +164,7 @@ void espdma_memory_read(void *opaque, uint8_t *buf, int len)
>  
>  void espdma_memory_write(void *opaque, uint8_t *buf, int len)
>  {
> -    DMAState *s = opaque;
> +    DMADeviceState *s = opaque;
>  
>      trace_espdma_memory_write(s->dmaregs[1]);
>      sparc_iommu_memory_write(s->iommu, s->dmaregs[1], buf, len);
> @@ -173,7 +174,7 @@ void espdma_memory_write(void *opaque, uint8_t *buf, int len)
>  static uint64_t dma_mem_read(void *opaque, hwaddr addr,
>                               unsigned size)
>  {
> -    DMAState *s = opaque;
> +    DMADeviceState *s = opaque;
>      uint32_t saddr;
>  
>      if (s->is_ledma && (addr > DMA_MAX_REG_OFFSET)) {
> @@ -190,7 +191,7 @@ static uint64_t dma_mem_read(void *opaque, hwaddr addr,
>  static void dma_mem_write(void *opaque, hwaddr addr,
>                            uint64_t val, unsigned size)
>  {
> -    DMAState *s = opaque;
> +    DMADeviceState *s = opaque;
>      uint32_t saddr;
>  
>      if (s->is_ledma && (addr > DMA_MAX_REG_OFFSET)) {
> @@ -252,28 +253,28 @@ static const MemoryRegionOps dma_mem_ops = {
>      },
>  };
>  
> -static void dma_reset(DeviceState *d)
> +static void sparc32_dma_device_reset(DeviceState *d)
>  {
> -    DMAState *s = SPARC32_DMA(d);
> +    DMADeviceState *s = SPARC32_DMA_DEVICE(d);
>  
>      memset(s->dmaregs, 0, DMA_SIZE);
>      s->dmaregs[0] = DMA_VER;
>  }
>  
> -static const VMStateDescription vmstate_dma = {
> +static const VMStateDescription vmstate_sparc32_dma_device = {
>      .name ="sparc32_dma",
>      .version_id = 2,
>      .minimum_version_id = 2,
>      .fields = (VMStateField[]) {
> -        VMSTATE_UINT32_ARRAY(dmaregs, DMAState, DMA_REGS),
> +        VMSTATE_UINT32_ARRAY(dmaregs, DMADeviceState, DMA_REGS),
>          VMSTATE_END_OF_LIST()
>      }
>  };
>  
> -static void sparc32_dma_init(Object *obj)
> +static void sparc32_dma_device_init(Object *obj)
>  {
>      DeviceState *dev = DEVICE(obj);
> -    DMAState *s = SPARC32_DMA(obj);
> +    DMADeviceState *s = SPARC32_DMA_DEVICE(obj);
>      SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>  
>      sysbus_init_irq(sbd, &s->irq);
> @@ -284,9 +285,9 @@ static void sparc32_dma_init(Object *obj)
>      qdev_init_gpio_out(dev, s->gpio, 2);
>  }
>  
> -static void sparc32_dma_realize(DeviceState *dev, Error **errp)
> +static void sparc32_dma_device_realize(DeviceState *dev, Error **errp)
>  {
> -    DMAState *s = SPARC32_DMA(dev);
> +    DMADeviceState *s = SPARC32_DMA_DEVICE(dev);
>      int reg_size;
>  
>      reg_size = s->is_ledma ? DMA_ETH_SIZE : DMA_SIZE;
> @@ -294,35 +295,35 @@ static void sparc32_dma_realize(DeviceState *dev, Error **errp)
>                            "dma", reg_size);
>  }
>  
> -static Property sparc32_dma_properties[] = {
> -    DEFINE_PROP_PTR("iommu_opaque", DMAState, iommu),
> -    DEFINE_PROP_UINT32("is_ledma", DMAState, is_ledma, 0),
> +static Property sparc32_dma_device_properties[] = {
> +    DEFINE_PROP_PTR("iommu_opaque", DMADeviceState, iommu),
> +    DEFINE_PROP_UINT32("is_ledma", DMADeviceState, is_ledma, 0),
>      DEFINE_PROP_END_OF_LIST(),
>  };
>  
> -static void sparc32_dma_class_init(ObjectClass *klass, void *data)
> +static void sparc32_dma_device_class_init(ObjectClass *klass, void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(klass);
>  
> -    dc->reset = dma_reset;
> -    dc->vmsd = &vmstate_dma;
> -    dc->props = sparc32_dma_properties;
> -    dc->realize = sparc32_dma_realize;
> +    dc->reset = sparc32_dma_device_reset;
> +    dc->vmsd = &vmstate_sparc32_dma_device;
> +    dc->props = sparc32_dma_device_properties;
> +    dc->realize = sparc32_dma_device_realize;
>      /* Reason: pointer property "iommu_opaque" */
>      dc->user_creatable = false;
>  }
>  
> -static const TypeInfo sparc32_dma_info = {
> -    .name          = TYPE_SPARC32_DMA,
> +static const TypeInfo sparc32_dma_device_info = {
> +    .name          = TYPE_SPARC32_DMA_DEVICE,
>      .parent        = TYPE_SYS_BUS_DEVICE,
> -    .instance_size = sizeof(DMAState),
> -    .instance_init = sparc32_dma_init,
> -    .class_init    = sparc32_dma_class_init,
> +    .instance_size = sizeof(DMADeviceState),
> +    .instance_init = sparc32_dma_device_init,
> +    .class_init    = sparc32_dma_device_class_init,
>  };
>  
>  static void sparc32_dma_register_types(void)
>  {
> -    type_register_static(&sparc32_dma_info);
> +    type_register_static(&sparc32_dma_device_info);
>  }
>  
>  type_init(sparc32_dma_register_types)
> diff --git a/hw/sparc/sun4m.c b/hw/sparc/sun4m.c
> index e1bdd48..82c553c 100644
> --- a/hw/sparc/sun4m.c
> +++ b/hw/sparc/sun4m.c
> @@ -313,7 +313,7 @@ static void *sparc32_dma_init(hwaddr daddr, qemu_irq parent_irq,
>      DeviceState *dev;
>      SysBusDevice *s;
>  
> -    dev = qdev_create(NULL, "sparc32_dma");
> +    dev = qdev_create(NULL, "sparc32-dma-device");
>      qdev_prop_set_ptr(dev, "iommu_opaque", iommu);
>      qdev_prop_set_uint32(dev, "is_ledma", is_ledma);
>      qdev_init_nofail(dev);
> 
