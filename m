Received: from eggs.gnu.org ([2001:4830:134:3::10]:36909)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fnqK4-0004ZE-BH
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 15:10:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <dgilbert@redhat.com>) id 1fnqK1-0003o0-50
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 15:10:12 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:34158 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1fnqK0-0003np-VY
	for qemu-devel@nongnu.org; Thu, 09 Aug 2018 15:10:09 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
	[10.11.54.4])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 77FAC40216E8
	for <qemu-devel@nongnu.org>; Thu,  9 Aug 2018 19:10:08 +0000 (UTC)
Date: Thu, 9 Aug 2018 20:10:05 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Message-ID: <20180809191004.GG2618@work-vm>
References: <20180808114830.7169-1-quintela@redhat.com>
	<20180808114830.7169-11-quintela@redhat.com>
	<810cc093-2a48-85a6-65e8-da4df6ba7e43@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <810cc093-2a48-85a6-65e8-da4df6ba7e43@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 10/22] virtio: split vsock bits from
 virtio-pci
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>
Cc: Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org, lvivier@redhat.com, peterx@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>

* Thomas Huth (thuth@redhat.com) wrote:
> On 08/08/2018 01:48 PM, Juan Quintela wrote:
> > Signed-off-by: Juan Quintela <quintela@redhat.com>
> > ---
> >  hw/virtio/Makefile.objs     |  2 +-
> >  hw/virtio/vhost-vsock-pci.c | 71 +++++++++++++++++++++++++++++++++++++
> >  hw/virtio/virtio-pci.c      | 51 --------------------------
> >  3 files changed, 72 insertions(+), 52 deletions(-)
> >  create mode 100644 hw/virtio/vhost-vsock-pci.c
> > 
> > diff --git a/hw/virtio/Makefile.objs b/hw/virtio/Makefile.objs
> > index 1b2799cfd8..4fbf7de84b 100644
> > --- a/hw/virtio/Makefile.objs
> > +++ b/hw/virtio/Makefile.objs
> > @@ -10,7 +10,7 @@ obj-$(CONFIG_VIRTIO_CRYPTO) += virtio-crypto.o
> >  obj-$(call land,$(CONFIG_VIRTIO_CRYPTO),$(CONFIG_VIRTIO_PCI)) += virtio-crypto-pci.o
> >  
> >  obj-$(CONFIG_LINUX) += vhost.o vhost-backend.o vhost-user.o
> > -obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o
> > +obj-$(CONFIG_VHOST_VSOCK) += vhost-vsock.o vhost-vsock-pci.o
> >  endif
> >  
> >  common-obj-$(call lnot,$(call land,$(CONFIG_VIRTIO),$(CONFIG_LINUX))) += vhost-stub.o
> > diff --git a/hw/virtio/vhost-vsock-pci.c b/hw/virtio/vhost-vsock-pci.c
> > new file mode 100644
> > index 0000000000..5805667dc0
> > --- /dev/null
> > +++ b/hw/virtio/vhost-vsock-pci.c
> > @@ -0,0 +1,71 @@
> > +/*
> > + * Virtio vsock PCI vhost Bindings
> > + *
> > + * Copyright IBM, Corp. 2007
> > + * Copyright (c) 2009 CodeSourcery
> > + *
> > + * Authors:
> > + *  Anthony Liguori   <aliguori@us.ibm.com>
> > + *  Paul Brook        <paul@codesourcery.com>
> 
> The vhost-vsock code has been added by Stefan in 2016, so these
> Copyright and Author informations looks somehow weird in this new file
> now. Not sure how to deal best with this situation, ... I'd maybe simply
> drop the above lines in the new file?

Well, we should figure it out; if it's all new code then it doesn't need
to be GPL 2 only either.

Dave

>  Thomas
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK
