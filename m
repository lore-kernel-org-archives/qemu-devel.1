Received: from eggs.gnu.org ([2001:4830:134:3::10]:36731)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <davem@davemloft.net>) id 1eYwus-00078S-0b
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:38:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <davem@davemloft.net>) id 1eYwun-0002va-3P
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:38:22 -0500
Received: from shards.monkeyblade.net ([184.105.139.130]:32892)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <davem@davemloft.net>) id 1eYwum-0002sn-Tp
	for qemu-devel@nongnu.org; Tue, 09 Jan 2018 11:38:17 -0500
Date: Tue, 09 Jan 2018 11:38:12 -0500 (EST)
Message-Id: <20180109.113812.2257853296058477300.davem@davemloft.net>
From: David Miller <davem@davemloft.net>
In-Reply-To: <718139aaea9a1ef032b29429af570fb171fdacac.1515190238.git.jbaron@akamai.com>
References: <cover.1515190238.git.jbaron@akamai.com>
	<cover.1515190238.git.jbaron@akamai.com>
	<718139aaea9a1ef032b29429af570fb171fdacac.1515190238.git.jbaron@akamai.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH net-next v4 1/3] virtio_net: propagate
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
Cc: mst@redhat.com, jasowang@redhat.com, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, virtio-dev@lists.oasis-open.org

From: Jason Baron <jbaron@akamai.com>
Date: Fri,  5 Jan 2018 17:44:54 -0500

> The ability to set speed and duplex for virtio_net is useful in various
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
> Note that VIRTIO_NET_F_SPEED_DUPLEX is defined as bit 63, the intention
> is that device feature bits are to grow down from bit 63, since the
> transports are starting from bit 24 and growing up.
> 
> Signed-off-by: Jason Baron <jbaron@akamai.com>

Applied, thanks Jason.
