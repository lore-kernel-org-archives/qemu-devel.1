Received: from eggs.gnu.org ([2001:4830:134:3::10]:41374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cognH-0004Pj-Nj
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 21:35:04 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <famz@redhat.com>) id 1cognC-0006v1-RM
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 21:35:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47642)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <famz@redhat.com>) id 1cognC-0006ul-LI
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 21:34:58 -0400
Date: Fri, 17 Mar 2017 09:34:52 +0800
From: Fam Zheng <famz@redhat.com>
Message-ID: <20170317013452.GA13125@lemon.lan>
References: <20170314153626.16989-1-famz@redhat.com>
	<20170314153626.16989-3-famz@redhat.com>
	<CAO_EM_k2FRArLndbSQnzbqkkmB6wRvcHCHsWbf1QRn=G=WHvZA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO_EM_k2FRArLndbSQnzbqkkmB6wRvcHCHsWbf1QRn=G=WHvZA@mail.gmail.com>
Subject: Re: [Qemu-devel] [PATCH v2 2/2] virtio-scsi: Fix acquire/release in
 dataplane handlers
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ed Swierk <eswierk@skyportsystems.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>

On Thu, 03/16 16:48, Ed Swierk wrote:
> On Tue, Mar 14, 2017 at 8:36 AM, Fam Zheng <famz@redhat.com> wrote:
> > diff --git a/hw/scsi/virtio-scsi.c b/hw/scsi/virtio-scsi.c
> > index e7466d3..4939f1f 100644
> > --- a/hw/scsi/virtio-scsi.c
> > +++ b/hw/scsi/virtio-scsi.c
> > ...
> >  bool virtio_scsi_handle_event_vq(VirtIOSCSI *s, VirtQueue *vq)
> >  {
> > -    virtio_scsi_acquire(s);
> >      if (s->events_dropped) {
> >          virtio_scsi_push_event(s, NULL, VIRTIO_SCSI_T_NO_EVENT, 0);
> >          virtio_scsi_release(s);
> 
> Did you intend to leave this virtio_scsi_release() call?

Oops, no, we should drop it.

Fam

> 
> >          return true;
> >      }
> > -    virtio_scsi_release(s);
> >      return false;
> >  }
