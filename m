Received: from eggs.gnu.org ([2001:4830:134:3::10]:60770)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eoCdD-0003xK-77
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:27:12 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1eoCd9-0008TS-FQ
	for qemu-devel@nongnu.org; Tue, 20 Feb 2018 13:27:11 -0500
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180220180325.29818-1-peter.maydell@linaro.org>
	<20180220180325.29818-10-peter.maydell@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <9d59a47f-9b5b-f49d-c19b-7c10a7b8e8cc@amsat.org>
Date: Tue, 20 Feb 2018 15:27:04 -0300
MIME-Version: 1.0
In-Reply-To: <20180220180325.29818-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH 09/19] hw/misc/unimp: Move
 struct to header file
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

On 02/20/2018 03:03 PM, Peter Maydell wrote:
> Move the definition of the struct for the unimplemented-device
> from unimp.c to unimp.h, so that users can embed the struct
> in their own device structs if they prefer.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  include/hw/misc/unimp.h | 10 ++++++++++
>  hw/misc/unimp.c         | 10 ----------
>  2 files changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/include/hw/misc/unimp.h b/include/hw/misc/unimp.h
> index 52e068ec3e..2a291ca42d 100644
> --- a/include/hw/misc/unimp.h
> +++ b/include/hw/misc/unimp.h
> @@ -12,6 +12,16 @@
>  
>  #define TYPE_UNIMPLEMENTED_DEVICE "unimplemented-device"
>  
> +#define UNIMPLEMENTED_DEVICE(obj) \
> +    OBJECT_CHECK(UnimplementedDeviceState, (obj), TYPE_UNIMPLEMENTED_DEVICE)
> +
> +typedef struct {
> +    SysBusDevice parent_obj;
> +    MemoryRegion iomem;
> +    char *name;
> +    uint64_t size;
> +} UnimplementedDeviceState;
> +
>  /**
>   * create_unimplemented_device: create and map a dummy device
>   * @name: name of the device for debug logging
> diff --git a/hw/misc/unimp.c b/hw/misc/unimp.c
> index bcbb585888..1c0ba2f0a7 100644
> --- a/hw/misc/unimp.c
> +++ b/hw/misc/unimp.c
> @@ -18,16 +18,6 @@
>  #include "qemu/log.h"
>  #include "qapi/error.h"
>  
> -#define UNIMPLEMENTED_DEVICE(obj) \
> -    OBJECT_CHECK(UnimplementedDeviceState, (obj), TYPE_UNIMPLEMENTED_DEVICE)
> -
> -typedef struct {
> -    SysBusDevice parent_obj;
> -    MemoryRegion iomem;
> -    char *name;
> -    uint64_t size;
> -} UnimplementedDeviceState;
> -
>  static uint64_t unimp_read(void *opaque, hwaddr offset, unsigned size)
>  {
>      UnimplementedDeviceState *s = UNIMPLEMENTED_DEVICE(opaque);
> 
