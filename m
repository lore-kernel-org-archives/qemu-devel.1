Received: from eggs.gnu.org ([209.51.188.92]:39033)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gyme6-0003cq-Gb
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 19:00:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gyme5-0001Ob-5w
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 19:00:22 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:32895)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gyme4-0001N2-Su
	for qemu-devel@nongnu.org; Tue, 26 Feb 2019 19:00:21 -0500
Received: by mail-wm1-f66.google.com with SMTP id c13so3234320wmb.0
	for <qemu-devel@nongnu.org>; Tue, 26 Feb 2019 16:00:19 -0800 (PST)
References: <20190226193408.23862-1-armbru@redhat.com>
	<20190226193408.23862-5-armbru@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <fbf70a4d-4098-8289-ebc4-3d3249f127a1@redhat.com>
Date: Wed, 27 Feb 2019 01:00:16 +0100
MIME-Version: 1.0
In-Reply-To: <20190226193408.23862-5-armbru@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v2 04/11] pflash: Rename *CFI_PFLASH* to
 *PFLASH_CFI*
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: kwolf@redhat.com, qemu-block@nongnu.org, alex.bennee@linaro.org, mreitz@redhat.com, qemu-ppc@nongnu.org, lersek@redhat.com

On 2/26/19 8:34 PM, Markus Armbruster wrote:
> pflash_cfi01.c and pflash_cfi02.c start their identifiers with
> pflash_cfi01_ and pflash_cfi02_ respectively, except for
> CFI_PFLASH01(), TYPE_CFI_PFLASH01, CFI_PFLASH02(), TYPE_CFI_PFLASH02.
> Rename for consistency.
> 
> Suggested-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  hw/block/pflash_cfi01.c  | 12 ++++++------
>  hw/block/pflash_cfi02.c  | 12 ++++++------
>  include/hw/block/flash.h |  4 ++--
>  3 files changed, 14 insertions(+), 14 deletions(-)
> 
> diff --git a/hw/block/pflash_cfi01.c b/hw/block/pflash_cfi01.c
> index d381f14e3c..f75f0a6998 100644
> --- a/hw/block/pflash_cfi01.c
> +++ b/hw/block/pflash_cfi01.c
> @@ -59,8 +59,8 @@ do {                                                        \
>  #define DPRINTF(fmt, ...) do { } while (0)
>  #endif
>  
> -#define CFI_PFLASH01(obj) \
> -    OBJECT_CHECK(PFlashCFI01, (obj), TYPE_CFI_PFLASH01)
> +#define PFLASH_CFI01(obj) \
> +    OBJECT_CHECK(PFlashCFI01, (obj), TYPE_PFLASH_CFI01)
>  
>  #define PFLASH_BE          0
>  #define PFLASH_SECURE      1
> @@ -698,7 +698,7 @@ static const MemoryRegionOps pflash_cfi01_ops = {
>  
>  static void pflash_cfi01_realize(DeviceState *dev, Error **errp)
>  {
> -    PFlashCFI01 *pfl = CFI_PFLASH01(dev);
> +    PFlashCFI01 *pfl = PFLASH_CFI01(dev);
>      uint64_t total_len;
>      int ret;
>      uint64_t blocks_per_device, sector_len_per_device, device_len;
> @@ -926,7 +926,7 @@ static void pflash_cfi01_class_init(ObjectClass *klass, void *data)
>  
>  
>  static const TypeInfo pflash_cfi01_info = {
> -    .name           = TYPE_CFI_PFLASH01,
> +    .name           = TYPE_PFLASH_CFI01,
>      .parent         = TYPE_SYS_BUS_DEVICE,
>      .instance_size  = sizeof(PFlashCFI01),
>      .class_init     = pflash_cfi01_class_init,
> @@ -949,7 +949,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
>                                     uint16_t id2, uint16_t id3,
>                                     int be)
>  {
> -    DeviceState *dev = qdev_create(NULL, TYPE_CFI_PFLASH01);
> +    DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI01);
>  
>      if (blk) {
>          qdev_prop_set_drive(dev, "drive", blk, &error_abort);
> @@ -966,7 +966,7 @@ PFlashCFI01 *pflash_cfi01_register(hwaddr base,
>      qdev_init_nofail(dev);
>  
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> -    return CFI_PFLASH01(dev);
> +    return PFLASH_CFI01(dev);
>  }
>  
>  MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl)
> diff --git a/hw/block/pflash_cfi02.c b/hw/block/pflash_cfi02.c
> index 9f8486e4cf..c0869fc417 100644
> --- a/hw/block/pflash_cfi02.c
> +++ b/hw/block/pflash_cfi02.c
> @@ -57,8 +57,8 @@ do {                                                       \
>  
>  #define PFLASH_LAZY_ROMD_THRESHOLD 42
>  
> -#define CFI_PFLASH02(obj) \
> -    OBJECT_CHECK(PFlashCFI02, (obj), TYPE_CFI_PFLASH02)
> +#define PFLASH_CFI02(obj) \
> +    OBJECT_CHECK(PFlashCFI02, (obj), TYPE_PFLASH_CFI02)
>  
>  struct PFlashCFI02 {
>      /*< private >*/
> @@ -534,7 +534,7 @@ static const MemoryRegionOps pflash_cfi02_ops_le = {
>  
>  static void pflash_cfi02_realize(DeviceState *dev, Error **errp)
>  {
> -    PFlashCFI02 *pfl = CFI_PFLASH02(dev);
> +    PFlashCFI02 *pfl = PFLASH_CFI02(dev);
>      uint32_t chip_len;
>      int ret;
>      Error *local_err = NULL;
> @@ -706,7 +706,7 @@ static void pflash_cfi02_class_init(ObjectClass *klass, void *data)
>  }
>  
>  static const TypeInfo pflash_cfi02_info = {
> -    .name           = TYPE_CFI_PFLASH02,
> +    .name           = TYPE_PFLASH_CFI02,
>      .parent         = TYPE_SYS_BUS_DEVICE,
>      .instance_size  = sizeof(PFlashCFI02),
>      .class_init     = pflash_cfi02_class_init,
> @@ -731,7 +731,7 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
>                                     uint16_t unlock_addr1,
>                                     int be)
>  {
> -    DeviceState *dev = qdev_create(NULL, TYPE_CFI_PFLASH02);
> +    DeviceState *dev = qdev_create(NULL, TYPE_PFLASH_CFI02);
>  
>      if (blk) {
>          qdev_prop_set_drive(dev, "drive", blk, &error_abort);
> @@ -751,5 +751,5 @@ PFlashCFI02 *pflash_cfi02_register(hwaddr base,
>      qdev_init_nofail(dev);
>  
>      sysbus_mmio_map(SYS_BUS_DEVICE(dev), 0, base);
> -    return CFI_PFLASH02(dev);
> +    return PFLASH_CFI02(dev);
>  }
> diff --git a/include/hw/block/flash.h b/include/hw/block/flash.h
> index 51d8f60c65..333005d9ff 100644
> --- a/include/hw/block/flash.h
> +++ b/include/hw/block/flash.h
> @@ -7,7 +7,7 @@
>  
>  /* pflash_cfi01.c */
>  
> -#define TYPE_CFI_PFLASH01 "cfi.pflash01"
> +#define TYPE_PFLASH_CFI01 "cfi.pflash01"
>  
>  typedef struct PFlashCFI01 PFlashCFI01;
>  
> @@ -24,7 +24,7 @@ MemoryRegion *pflash_cfi01_get_memory(PFlashCFI01 *fl);
>  
>  /* pflash_cfi02.c */
>  
> -#define TYPE_CFI_PFLASH02 "cfi.pflash02"
> +#define TYPE_PFLASH_CFI02 "cfi.pflash02"
>  
>  typedef struct PFlashCFI02 PFlashCFI02;
>  
> 

Thanks!

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
