Received: from eggs.gnu.org ([2001:4830:134:3::10]:46326)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWxNO-0004O7-8L
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 00:11:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWxNN-0001Lz-By
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 00:11:18 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170717023824.18796-1-famz@redhat.com>
	<20170717023824.18796-7-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e8dca1fa-8075-b1e7-3446-e8e8416fadae@amsat.org>
Date: Mon, 17 Jul 2017 01:11:07 -0300
MIME-Version: 1.0
In-Reply-To: <20170717023824.18796-7-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH v5 6/6] xilinx_axidma: Convert to
 DEFINE_PROP_LINK
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
>   hw/dma/xilinx_axidma.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/dma/xilinx_axidma.c b/hw/dma/xilinx_axidma.c
> index 3987b5f..9b48103 100644
> --- a/hw/dma/xilinx_axidma.c
> +++ b/hw/dma/xilinx_axidma.c
> @@ -562,18 +562,6 @@ static void xilinx_axidma_init(Object *obj)
>       XilinxAXIDMA *s = XILINX_AXI_DMA(obj);
>       SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>   
> -    object_property_add_link(obj, "axistream-connected", TYPE_STREAM_SLAVE,
> -                             (Object **)&s->tx_data_dev,
> -                             qdev_prop_allow_set_link_before_realize,
> -                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
> -                             &error_abort);
> -    object_property_add_link(obj, "axistream-control-connected",
> -                             TYPE_STREAM_SLAVE,
> -                             (Object **)&s->tx_control_dev,
> -                             qdev_prop_allow_set_link_before_realize,
> -                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
> -                             &error_abort);
> -
>       object_initialize(&s->rx_data_dev, sizeof(s->rx_data_dev),
>                         TYPE_XILINX_AXI_DMA_DATA_STREAM);
>       object_initialize(&s->rx_control_dev, sizeof(s->rx_control_dev),
> @@ -593,6 +581,10 @@ static void xilinx_axidma_init(Object *obj)
>   
>   static Property axidma_properties[] = {
>       DEFINE_PROP_UINT32("freqhz", XilinxAXIDMA, freqhz, 50000000),
> +    DEFINE_PROP_LINK("axistream-connected", XilinxAXIDMA,
> +                     tx_data_dev, TYPE_STREAM_SLAVE, StreamSlave *),
> +    DEFINE_PROP_LINK("axistream-control-connected", XilinxAXIDMA,
> +                     tx_control_dev, TYPE_STREAM_SLAVE, StreamSlave *),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> 
