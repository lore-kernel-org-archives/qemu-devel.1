Received: from eggs.gnu.org ([2001:4830:134:3::10]:53922)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <davem@davemloft.net>) id 1eUJUw-0007tB-Iu
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 16:44:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <davem@davemloft.net>) id 1eUJUf-0002Nq-Kj
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 16:44:25 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:40588)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <davem@davemloft.net>) id 1eUJUE-0001xv-8q
	for qemu-devel@nongnu.org; Wed, 27 Dec 2017 16:44:08 -0500
Date: Wed, 27 Dec 2017 16:43:34 -0500 (EST)
Message-Id: <20171227.164334.2079471466039224265.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <44da522ecee60792ec918234ee4d61a84e4574f0.1513974243.git.jbaron@akamai.com>
References: <1513979641-7999-1-git-send-email-jbaron@akamai.com>
	<cover.1513974243.git.jbaron@akamai.com>
	<44da522ecee60792ec918234ee4d61a84e4574f0.1513974243.git.jbaron@akamai.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH net-next v2 1/3] virtio_net: propagate
 linkspeed/duplex settings from the hypervisor
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: jbaron@akamai.com
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, mst@redhat.com, jasowang@redhat.com

From: Jason Baron <jbaron@akamai.com>
Date: Fri, 22 Dec 2017 16:54:01 -0500

> The ability to set speed and duplex for virtio_net in useful in various
> scenarios as described here:
> 
> 16032be virtio_net: add ethtool support for set and get of settings
> 
> However, it would be nice to be able to set this from the hypervisor,
> such that virtio_net doesn't require custom guest ethtool commands.
> 
> Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
> the hypervisor to export a linkspeed and duplex setting. The user can
> subsequently overwrite it later if desired via: 'ethtool -s'.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>
> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> Cc: Jason Wang <jasowang@redhat.com>

Looks mostly fine to me but need some virtio_net reviewers on this one.

> @@ -57,6 +57,8 @@
>  					 * Steering */
>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
>  
> +#define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Host set linkspeed and duplex */
> +

Why use a value so far away from the largest existing one?

Just curious.
