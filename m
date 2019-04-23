Received: from eggs.gnu.org ([209.51.188.92]:36431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hIqKv-0006SZ-Ec
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:59:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1hIqKu-0000fR-9x
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:59:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35160)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1hIqKu-0000ee-43
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 03:59:28 -0400
Date: Tue, 23 Apr 2019 09:59:21 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20190423095921.3af966b8.cohuck@redhat.com>
In-Reply-To: <20190419191910-mutt-send-email-mst@kernel.org>
References: <20190411110157.14252-1-yuval.shaia@oracle.com>
	<20190411110157.14252-3-yuval.shaia@oracle.com>
	<20190419191910-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 2/3] hw/virtio-rdma: VirtIO rdma device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Yuval Shaia <yuval.shaia@oracle.com>, virtualization@lists.linux-foundation.org, qemu-devel@nongnu.org, marcel.apfelbaum@gmail.com, linux-rdma@vger.kernel.org, jgg@mellanox.com

On Fri, 19 Apr 2019 19:20:22 -0400
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Apr 11, 2019 at 02:01:56PM +0300, Yuval Shaia wrote:
> > diff --git a/include/standard-headers/linux/virtio_ids.h b/include/standard-headers/linux/virtio_ids.h
> > index 6d5c3b2d4f..bd2c699450 100644
> > --- a/include/standard-headers/linux/virtio_ids.h
> > +++ b/include/standard-headers/linux/virtio_ids.h
> > @@ -43,5 +43,6 @@
> >  #define VIRTIO_ID_INPUT        18 /* virtio input */
> >  #define VIRTIO_ID_VSOCK        19 /* virtio vsock transport */
> >  #define VIRTIO_ID_CRYPTO       20 /* virtio crypto */
> > +#define VIRTIO_ID_RDMA         26 /* virtio crypto */

I think 26 is already de facto used by virtio-audio(?) and 27 has just
been reserved for virtio-pmem. The next free id seems to be 28.

(Also, the comment is a straight copy-paste :)

> >  
> >  #endif /* _LINUX_VIRTIO_IDS_H */  
> 
> 
> Please reserve an ID with the virtio TC.
> Process:
> - create a github issue
> - post patch with Fixes: tag
> - wait a bit
> - if no comments on either ask for a vote

Agreed, let's reserve an id. There seems to be enough interest in this
device type.
