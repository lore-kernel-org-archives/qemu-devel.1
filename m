Received: from eggs.gnu.org ([2001:4830:134:3::10]:55157)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sridhar.samudrala@intel.com>) id 1fQ0z2-0005Su-8P
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 21:42:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sridhar.samudrala@intel.com>) id 1fQ0yx-0007Iy-Tu
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 21:42:00 -0400
Received: from mga17.intel.com ([192.55.52.151]:21169)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sridhar.samudrala@intel.com>)
	id 1fQ0yx-0007Gw-LJ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 21:41:55 -0400
References: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
From: "Samudrala, Sridhar" <sridhar.samudrala@intel.com>
Message-ID: <fcefe501-b410-f1ec-829c-68199edcdbef@intel.com>
Date: Mon, 4 Jun 2018 18:41:48 -0700
MIME-Version: 1.0
In-Reply-To: <1525734594-11134-1-git-send-email-sridhar.samudrala@intel.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH] qemu: Introduce VIRTIO_NET_F_STANDBY
 feature bit to virtio_net
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: mst@redhat.com, virtualization@lists.linux-foundation.org, virtio-dev@lists.oasis-open.org, jesse.brandeburg@intel.com, alexander.h.duyck@intel.com, jasowang@redhat.com, qemu-devel@nongnu.org

Ping on this patch now that the kernel patches are accepted into davem's net-next tree.
https://patchwork.ozlabs.org/cover/920005/


On 5/7/2018 4:09 PM, Sridhar Samudrala wrote:
> This feature bit can be used by hypervisor to indicate virtio_net device to
> act as a standby for another device with the same MAC address.
>
> I tested this with a small change to the patch to mark the STANDBY feature 'true'
> by default as i am using libvirt to start the VMs.
> Is there a way to pass the newly added feature bit 'standby' to qemu via libvirt
> XML file?
>
> Signed-off-by: Sridhar Samudrala <sridhar.samudrala@intel.com>
> ---
>   hw/net/virtio-net.c                         | 2 ++
>   include/standard-headers/linux/virtio_net.h | 3 +++
>   2 files changed, 5 insertions(+)
>
> diff --git a/hw/net/virtio-net.c b/hw/net/virtio-net.c
> index 90502fca7c..38b3140670 100644
> --- a/hw/net/virtio-net.c
> +++ b/hw/net/virtio-net.c
> @@ -2198,6 +2198,8 @@ static Property virtio_net_properties[] = {
>                        true),
>       DEFINE_PROP_INT32("speed", VirtIONet, net_conf.speed, SPEED_UNKNOWN),
>       DEFINE_PROP_STRING("duplex", VirtIONet, net_conf.duplex_str),
> +    DEFINE_PROP_BIT64("standby", VirtIONet, host_features, VIRTIO_NET_F_STANDBY,
> +                      false),
>       DEFINE_PROP_END_OF_LIST(),
>   };
>   
> diff --git a/include/standard-headers/linux/virtio_net.h b/include/standard-headers/linux/virtio_net.h
> index e9f255ea3f..01ec09684c 100644
> --- a/include/standard-headers/linux/virtio_net.h
> +++ b/include/standard-headers/linux/virtio_net.h
> @@ -57,6 +57,9 @@
>   					 * Steering */
>   #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
>   
> +#define VIRTIO_NET_F_STANDBY      62    /* Act as standby for another device
> +                                         * with the same MAC.
> +                                         */
>   #define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Device set linkspeed and duplex */
>   
>   #ifndef VIRTIO_NET_NO_LEGACY
