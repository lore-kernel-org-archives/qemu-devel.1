Received: from eggs.gnu.org ([2001:4830:134:3::10]:58760)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1eFckD-0001BZ-KX
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:15:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jfreimann@redhat.com>) id 1eFckC-0003L2-N0
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:15:29 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45904)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jfreimann@redhat.com>)
	id 1eFckC-0003KU-GF
	for qemu-devel@nongnu.org; Fri, 17 Nov 2017 04:15:28 -0500
Date: Fri, 17 Nov 2017 10:15:20 +0100
From: Jens Freimann <jfreimann@redhat.com>
Message-ID: <20171117091520.3n4xrohvkk26osrl@dhcp-192-218.str.redhat.com>
References: <20171116184835.28556-1-maxime.coquelin@redhat.com>
	<20171116184835.28556-2-maxime.coquelin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20171116184835.28556-2-maxime.coquelin@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] virtio: Add queue interface to restore
 avail index from vring used index
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Cc: mst@redhat.com, yuri.benditovich@daynix.com, yvugenfi@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org

On Thu, Nov 16, 2017 at 06:48:34PM +0000, Maxime Coquelin wrote:
>In case of backend crash, it is not possible to restore internal
>avail index from the backend value as vhost_get_vring_base
>callback fails.
>
>This patch provides a new interface to restore internal avail index
>from the vring used index, as done by some vhost-user backend on
>reconnection.
>
>Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
>---
> hw/virtio/virtio.c         | 10 ++++++++++
> include/hw/virtio/virtio.h |  1 +
> 2 files changed, 11 insertions(+)
>

Reviewed-by: Jens Freimann <jfreimann@redhat.com>
