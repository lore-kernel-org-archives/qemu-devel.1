Received: from eggs.gnu.org ([2001:4830:134:3::10]:45469)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eWjQ7-0005lb-VY
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 08:49:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eWjQ4-0005cH-Qy
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 08:49:28 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45004)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eWjQ4-0005bt-KV
	for qemu-devel@nongnu.org; Wed, 03 Jan 2018 08:49:24 -0500
Date: Wed, 3 Jan 2018 15:49:21 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20180103154824-mutt-send-email-mst@kernel.org>
References: <1513979641-7999-1-git-send-email-jbaron@akamai.com>
	<cover.1513974243.git.jbaron@akamai.com>
	<44da522ecee60792ec918234ee4d61a84e4574f0.1513974243.git.jbaron@akamai.com>
	<20171227.164334.2079471466039224265.davem@davemloft.net>
	<93b66082-f37c-0463-e977-d4b430a44008@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <93b66082-f37c-0463-e977-d4b430a44008@akamai.com>
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
To: Jason Baron <jbaron@akamai.com>
Cc: David Miller <davem@davemloft.net>, netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, jasowang@redhat.com

On Thu, Dec 28, 2017 at 10:53:54AM -0500, Jason Baron wrote:
> 
> 
> On 12/27/2017 04:43 PM, David Miller wrote:
> > From: Jason Baron <jbaron@akamai.com>
> > Date: Fri, 22 Dec 2017 16:54:01 -0500
> > 
> >> The ability to set speed and duplex for virtio_net in useful in various
> >> scenarios as described here:
> >>
> >> 16032be virtio_net: add ethtool support for set and get of settings
> >>
> >> However, it would be nice to be able to set this from the hypervisor,
> >> such that virtio_net doesn't require custom guest ethtool commands.
> >>
> >> Introduce a new feature flag, VIRTIO_NET_F_SPEED_DUPLEX, which allows
> >> the hypervisor to export a linkspeed and duplex setting. The user can
> >> subsequently overwrite it later if desired via: 'ethtool -s'.
> >>
> >> Signed-off-by: Jason Baron <jbaron@akamai.com>
> >> Cc: "Michael S. Tsirkin" <mst@redhat.com>
> >> Cc: Jason Wang <jasowang@redhat.com>
> > 
> > Looks mostly fine to me but need some virtio_net reviewers on this one.
> > 
> >> @@ -57,6 +57,8 @@
> >>  					 * Steering */
> >>  #define VIRTIO_NET_F_CTRL_MAC_ADDR 23	/* Set MAC address */
> >>  
> >> +#define VIRTIO_NET_F_SPEED_DUPLEX 63	/* Host set linkspeed and duplex */
> >> +
> > 
> > Why use a value so far away from the largest existing one?
> > 
> > Just curious.
> > 
> 
> So that came from a discussion with Michael about which bit to use for
> this, and he suggested using 63:
> 
> "
> Transports started from bit 24 and are growing up.
> So I would say devices should start from bit 63 and grow down.
> "
> 
> https://patchwork.ozlabs.org/patch/848814/#1826669
> 
> I will add a comment to explain it.

Maybe in the commit log. I don't think we need it in the header.

> Thanks,
> 
> -Jason
