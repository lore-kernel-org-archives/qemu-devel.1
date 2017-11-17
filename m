Received: from eggs.gnu.org ([2001:4830:134:3::10]:58564)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1eFcjG-0000bd-Bp
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:14:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1eFcjD-0002lh-5g
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:14:30 -0500
Date: Fri, 17 Nov 2017 10:14:14 +0100
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20171117091414.y57oguzv2jruobdd@dhcp-192-218.str.redhat.com>
References: <20171116184835.28556-1-maxime.coquelin@redhat.com>
	<20171116184835.28556-3-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171116184835.28556-3-maxime.coquelin@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] vhost: restore avail index from vring
 used index on disconnection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, yuri.benditovich@daynix.com, yvugenfi@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, qemu-stable@nongnu.org

On Thu, Nov 16, 2017 at 06:48:35PM +0000, Maxime Coquelin wrote:
>vhost_virtqueue_stop() gets avail index value from the backend,
>except if the backend is not responding.
>
>It happens when the backend crashes, and in this case, internal
>state of the virtio queue is inconsistent, making packets
>to corrupt the vring state.
>
>With a Linux guest, it results in following error message on
>backend reconnection:
>
>[   22.444905] virtio_net virtio0: output.0:id 0 is not a head!
>[   22.446746] net enp0s3: Unexpected TXQ (0) queue failure: -5
>[   22.476360] net enp0s3: Unexpected TXQ (0) queue failure: -5
>
>Fixes: 283e2c2adcb8 ("net: virtio-net discards TX data after link down")
>Cc: qemu-stable@nongnu.org
>Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>---
> hw/virtio/vhost.c | 4 ++++
> 1 file changed, 4 insertions(+)
>

Reviewed-by: Jens Freimann <jfreimann@redhat.com>
