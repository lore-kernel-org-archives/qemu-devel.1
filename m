Received: from eggs.gnu.org ([2001:4830:134:3::10]:46436)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWxO4-0004sG-PX
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 00:12:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWxO3-0001iH-TL
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 00:12:00 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170717023824.18796-1-famz@redhat.com>
	<20170717023824.18796-3-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <266263f5-22c5-1b91-937a-9c08d5034ea5@amsat.org>
Date: Mon, 17 Jul 2017 01:11:50 -0300
MIME-Version: 1.0
In-Reply-To: <20170717023824.18796-3-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 2/6] armv7m: Convert
 armv7m.memory to DEFINE_PROP_LINK
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
> index 8efc4e8..1c837da 100644
> --- a/hw/arm/armv7m.c
> +++ b/hw/arm/armv7m.c
> @@ -132,12 +132,6 @@ static void armv7m_instance_init(Object *obj)
>   
>       /* Can't init the cpu here, we don't yet know which model to use */
>   
> -    object_property_add_link(obj, "memory",
> -                             TYPE_MEMORY_REGION,
> -                             (Object **)&s->board_memory,
> -                             qdev_prop_allow_set_link_before_realize,
> -                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
> -                             &error_abort);
>       memory_region_init(&s->container, obj, "armv7m-container", UINT64_MAX);
>   
>       object_initialize(&s->nvic, sizeof(s->nvic), "armv7m_nvic");
> @@ -248,6 +242,8 @@ static void armv7m_realize(DeviceState *dev, Error **errp)
>   
>   static Property armv7m_properties[] = {
>       DEFINE_PROP_STRING("cpu-model", ARMv7MState, cpu_model),
> +    DEFINE_PROP_LINK("memory", ARMv7MState, board_memory, TYPE_MEMORY_REGION,
> +                     MemoryRegion *),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> 
