Received: from eggs.gnu.org ([209.51.188.92]:53717)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gpEc9-0002HA-QU
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:50:54 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gpEc8-00049r-La
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:50:53 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:42000)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gpEc8-00048A-B8
	for qemu-devel@nongnu.org; Thu, 31 Jan 2019 10:50:52 -0500
Received: by mail-wr1-f66.google.com with SMTP id q18so3818531wrx.9
	for <qemu-devel@nongnu.org>; Thu, 31 Jan 2019 07:50:50 -0800 (PST)
Date: Thu, 31 Jan 2019 16:50:46 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
Message-ID: <20190131155046.djju3av73ufzfj6p@steredhat>
References: <20190131151914.164903-1-sgarzare@redhat.com>
	<20190131151914.164903-3-sgarzare@redhat.com>
	<20190131154038.GH2870@work-vm>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190131154038.GH2870@work-vm>
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
To: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Thu, Jan 31, 2019 at 03:40:38PM +0000, Dr. David Alan Gilbert wrote:
> * Stefano Garzarella (sgarzare@redhat.com) wrote:
> > In order to avoid migration issues, we enable DISCARD and
> > WRITE ZEROES features only for machine type >= 4.0
> > 
> > Suggested-by: Dr. David Alan Gilbert <dgilbert@redhat.com>
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  hw/block/virtio-blk.c          | 2 ++
> >  hw/core/machine.c              | 1 +
> >  include/hw/virtio/virtio-blk.h | 1 +
> >  3 files changed, 4 insertions(+)
> > 
> > diff --git a/hw/block/virtio-blk.c b/hw/block/virtio-blk.c
> > index 8a6754d9a2..542ec52536 100644
> > --- a/hw/block/virtio-blk.c
> > +++ b/hw/block/virtio-blk.c
> > @@ -1026,6 +1026,8 @@ static Property virtio_blk_properties[] = {
> >      DEFINE_PROP_UINT16("queue-size", VirtIOBlock, conf.queue_size, 128),
> >      DEFINE_PROP_LINK("iothread", VirtIOBlock, conf.iothread, TYPE_IOTHREAD,
> >                       IOThread *),
> > +    DEFINE_PROP_BIT("discard-wzeroes", VirtIOBlock, conf.discard_wzeroes, 0,
> > +                     true),
> 
> I think that's OK, but do you really want a DEFINE_PROP_BOOL and
> a bool discard_wzeroes?
> I think DEFINE_PROP_BIT is mostly used for a flag word where each
> property is one more bit in the field.
> 
> Dave
> 

Hi Dave,
I was in doubt if to use DEFINE_PROP_BIT or DEFINE_PROP_BOOL, but
looking in the virtio-blk.c, I found that also other boolean like
"config-wce", "scsi", and "request-merging" was defined with
DEFINE_PROP_BIT, so I followed this trand.

But I agree with you, DEFINE_PROP_BOOL should be better, so I will change it!

Thanks,
Stefano
