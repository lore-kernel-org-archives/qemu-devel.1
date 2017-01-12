Received: from eggs.gnu.org ([2001:4830:134:3::10]:43038)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cRlci-0000AL-Mv
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:05:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1cRlcf-0008IV-GQ
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:05:24 -0500
Received: from mx1.redhat.com ([209.132.183.28]:36176)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1cRlcf-0008IC-Ax
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 15:05:21 -0500
Date: Thu, 12 Jan 2017 22:05:20 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20170112220500-mutt-send-email-mst@kernel.org>
References: <20170112114612.14520-1-stefanha@redhat.com>
	<fc5de032-a64b-b072-6e52-441b6a685ee3@cardoe.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <fc5de032-a64b-b072-6e52-441b6a685ee3@cardoe.com>
Subject: Re: [Qemu-devel] [PATCH 0/2] virtio: revert
 virtio_queue_set_notification() nesting
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Doug Goldstein <cardoe@cardoe.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org, "Dr . David Alan Gilbert" <dgilbert@redhat.com>

On Thu, Jan 12, 2017 at 10:57:53AM -0600, Doug Goldstein wrote:
> On 1/12/17 5:46 AM, Stefan Hajnoczi wrote:
> > The virtio_queue_set_notification() nesting introduced for AioContext polling
> > raised an assertion with virtio-net (even in non-polling mode).  Converting
> > virtio-net and virtio-crypto to use virtio_queue_set_notification() in a
> > nesting fashion would be invasive and isn't worth it.
> > 
> > Patch 1 contains the revert to resolve the bug that Doug noticed.
> > 
> > Patch 2 is a less efficient but safe alternative.
> > 
> > Stefan Hajnoczi (2):
> >   Revert "virtio: turn vq->notification into a nested counter"
> >   virtio: disable notifications again after poll succeeded
> > 
> >  hw/virtio/virtio.c | 21 +++++++++------------
> >  1 file changed, 9 insertions(+), 12 deletions(-)
> > 
> 
> So I just gave this series a whirl and it fixes the assert but causes
> another issue for me. While iPXE is getting a DHCP address the screen
> immediately flashes over to the UEFI shell. Its like a timeout is
> getting hit and just dropping me to the shell.
> 
> -- 
> Doug Goldstein
> 

Is this just with UEFI or with seabios as well?

-- 
MST
