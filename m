Received: from eggs.gnu.org ([209.51.188.92]:48418)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gpUp0-0000EJ-Ru
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 04:09:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gpUp0-000393-67
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 04:09:14 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51748)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gpUp0-00038D-0B
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 04:09:14 -0500
Received: by mail-wm1-f66.google.com with SMTP id b11so5276991wmj.1
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 01:09:13 -0800 (PST)
Date: Fri, 1 Feb 2019 10:09:08 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190201090908.vtb2u5pwvouej7ei@steredhat>
References: <20190131151914.164903-1-sgarzare@redhat.com>
	<20190131151914.164903-3-sgarzare@redhat.com>
	<20190201042928.GC23131@stefanha-x1.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190201042928.GC23131@stefanha-x1.localdomain>
Subject: Re: [Qemu-devel] [PATCH v2 2/5] virtio-blk: add "discard-wzeroes"
 boolean property
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, Feb 01, 2019 at 12:29:28PM +0800, Stefan Hajnoczi wrote:
> On Thu, Jan 31, 2019 at 04:19:11PM +0100, Stefano Garzarella wrote:
> > In order to avoid migration issues, we enable DISCARD and
> > WRITE ZEROES features only for machine type >= 4.0
> 
> Please use two separate properties that correspond to the
> VIRTIO_BLK_F_DISCARD and VIRTIO_BLK_F_WRITE_ZEROES virtio-blk feature
> bits.

Okay.
As Michael suggested, what do you think if I use a similar approach of
virtio-net, adding an host_features variable and setting a corresponding
feature bit?

Thanks,
Stefano
