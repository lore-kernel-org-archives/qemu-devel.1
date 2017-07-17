Received: from eggs.gnu.org ([2001:4830:134:3::10]:45752)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWxKM-0002SF-Kx
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 00:08:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWxKL-0007cd-Sn
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 00:08:10 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170717023824.18796-1-famz@redhat.com>
	<20170717023824.18796-2-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f15f64a1-f13d-57b5-2d1f-05927519318d@amsat.org>
Date: Mon, 17 Jul 2017 01:07:58 -0300
MIME-Version: 1.0
In-Reply-To: <20170717023824.18796-2-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 1/6] armv7m: Convert
 bitband.source-mamory to DEFINE_PROP_LINK
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Fam Zheng <famz@redhat.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org

On 07/16/2017 11:38 PM, Fam Zheng wrote:
> Signed-off-by: Fam Zheng <famz@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>   hw/arm/armv7m.c | 8 ++------
>   1 file changed, 2 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/arm/armv7m.c b/hw/arm/armv7m.c
> index c8a11f2..8efc4e8 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -97,12 +97,6 @@ static void bitband_init(Object *obj)
>       BitBandState *s = BITBAND(obj);
>       SysBusDevice *dev = SYS_BUS_DEVICE(obj);
>   
> -    object_property_add_link(obj, "source-memory",
> -                             TYPE_MEMORY_REGION,
> -                             (Object **)&s->source_memory,
> -                             qdev_prop_allow_set_link_before_realize,
> -                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
> -                             &error_abort);
>       memory_region_init_io(&s->iomem, obj, &bitband_ops, s,
>                             "bitband", 0x02000000);
>       sysbus_init_mmio(dev, &s->iomem);
> @@ -349,6 +343,8 @@ void armv7m_load_kernel(ARMCPU *cpu, const char *kernel_filename, int mem_size)
>   
>   static Property bitband_properties[] = {
>       DEFINE_PROP_UINT32("base", BitBandState, base, 0),
> +    DEFINE_PROP_LINK("source-memory", BitBandState, source_memory,
> +                     TYPE_MEMORY_REGION, MemoryRegion *),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> 
