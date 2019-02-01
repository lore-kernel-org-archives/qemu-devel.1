Received: from eggs.gnu.org ([209.51.188.92]:50889)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gpcT7-00017U-N5
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:19:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1gpcT6-0002oh-TY
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:19:09 -0500
Received: from mail-oi1-f193.google.com ([209.85.167.193]:34825)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1gpcT6-0002mo-Mm
	for qemu-devel@nongnu.org; Fri, 01 Feb 2019 12:19:08 -0500
Received: by mail-oi1-f193.google.com with SMTP id v6so6436192oif.2
	for <qemu-devel@nongnu.org>; Fri, 01 Feb 2019 09:19:06 -0800 (PST)
MIME-Version: 1.0
References: <20190131151914.164903-1-sgarzare@redhat.com>
	<20190131151914.164903-3-sgarzare@redhat.com>
	<20190201101604-mutt-send-email-mst@kernel.org>
In-Reply-To: <20190201101604-mutt-send-email-mst@kernel.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Fri, 1 Feb 2019 18:18:52 +0100
Message-ID: <CAGxU2F50t=OeuoJMn7q7iDYyy+mc=3vz7V8dVe77KtOu1hKHyw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
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
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu devel list <qemu-devel@nongnu.org>, Kevin Wolf <kwolf@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>, "Dr . David Alan Gilbert" <dgilbert@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, Thomas Huth <thuth@redhat.com>, qemu-block@nongnu.org

On Fri, Feb 1, 2019 at 4:17 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Thu, Jan 31, 2019 at 04:19:11PM +0100, Stefano Garzarella wrote:
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
> >      DEFINE_PROP_END_OF_LIST(),
> >  };
> >
>
> Thinking about it, are there security implications for discard?
> Should we make it default false?

Hi Michael,

I'm not completely sure but if the guest can write on a specific sector,
discard or write_zeroes operations should not have a security implication.

Do I miss something?

Thanks,
Stefano
