Received: from eggs.gnu.org ([2001:4830:134:3::10]:46155)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWxMo-00044m-0t
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 00:10:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1dWxMj-0000aI-14
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 00:10:42 -0400
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20170717023824.18796-1-famz@redhat.com>
	<20170717023824.18796-6-famz@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <a237c7b7-9e27-bf0d-30c3-013f979fd248@amsat.org>
Date: Mon, 17 Jul 2017 01:10:30 -0300
MIME-Version: 1.0
In-Reply-To: <20170717023824.18796-6-famz@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [Qemu-arm] [PATCH v5 5/6] xilinx_axienet: Convert
 to DEFINE_PROP_LINK
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
>   hw/net/xilinx_axienet.c | 16 ++++------------
>   1 file changed, 4 insertions(+), 12 deletions(-)
> 
> diff --git a/hw/net/xilinx_axienet.c b/hw/net/xilinx_axienet.c
> index 5ffa739..d4c2c89 100644
> --- a/hw/net/xilinx_axienet.c
> +++ b/hw/net/xilinx_axienet.c
> @@ -989,18 +989,6 @@ static void xilinx_enet_init(Object *obj)
>       XilinxAXIEnet *s = XILINX_AXI_ENET(obj);
>       SysBusDevice *sbd = SYS_BUS_DEVICE(obj);
>   
> -    object_property_add_link(obj, "axistream-connected", TYPE_STREAM_SLAVE,
> -                             (Object **) &s->tx_data_dev,
> -                             qdev_prop_allow_set_link_before_realize,
> -                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
> -                             &error_abort);
> -    object_property_add_link(obj, "axistream-control-connected",
> -                             TYPE_STREAM_SLAVE,
> -                             (Object **) &s->tx_control_dev,
> -                             qdev_prop_allow_set_link_before_realize,
> -                             OBJ_PROP_LINK_UNREF_ON_RELEASE,
> -                             &error_abort);
> -
>       object_initialize(&s->rx_data_dev, sizeof(s->rx_data_dev),
>                         TYPE_XILINX_AXI_ENET_DATA_STREAM);
>       object_initialize(&s->rx_control_dev, sizeof(s->rx_control_dev),
> @@ -1021,6 +1009,10 @@ static Property xilinx_enet_properties[] = {
>       DEFINE_PROP_UINT32("rxmem", XilinxAXIEnet, c_rxmem, 0x1000),
>       DEFINE_PROP_UINT32("txmem", XilinxAXIEnet, c_txmem, 0x1000),
>       DEFINE_NIC_PROPERTIES(XilinxAXIEnet, conf),
> +    DEFINE_PROP_LINK("axistream-connected", XilinxAXIEnet,
> +                     tx_data_dev, TYPE_STREAM_SLAVE, StreamSlave *),
> +    DEFINE_PROP_LINK("axistream-control-connected", XilinxAXIEnet,
> +                     tx_control_dev, TYPE_STREAM_SLAVE, StreamSlave *),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> 
