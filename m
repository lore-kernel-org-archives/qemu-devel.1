Received: from eggs.gnu.org ([2001:4830:134:3::10]:57431)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1df6KW-0004gJ-A6
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:22:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1df6KR-0002QI-DL
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:22:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:37652)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1df6KR-0002Pt-6V
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 11:21:55 -0400
Date: Tue, 8 Aug 2017 17:21:48 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170808172141.72e66af7@gondolin>
In-Reply-To: <20170808161559.3f623c89@bahia.lan>
References: <20170808121701.18353-1-cohuck@redhat.com>
	<20170808121701.18353-2-cohuck@redhat.com>
	<20170808145000.3259f597@bahia.lan>
	<20170808161559.3f623c89@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 1/1] 9pfs: fix and simplify dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, thuth@redhat.com, aneesh.kumar@linux.vnet.ibm.com, agraf@suse.de

On Tue, 8 Aug 2017 16:15:59 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Tue, 8 Aug 2017 14:50:00 +0200
> Greg Kurz <groug@kaod.org> wrote:
> 
> > On Tue,  8 Aug 2017 14:17:01 +0200
> > Cornelia Huck <cohuck@redhat.com> wrote:
> >   
> > > We want to compile the 9pfs code iff virtfs is enabled and a virtio
> > > transport is available (not only pci!).
> > > 
> > > Let's make the generated CONFIG_VIRTFS statement depend on either
> > > CONFIG_VIRTIO_PCI or (new) CONFIG_VIRTIO_CCW. The Makefiles for fsdev/
> > > and hw/9pfs/ can then depend on CONFIG_VIRTFS directly.
> > > 
> > > Suggested-by: Thomas Huth <thuth@redhat.com>
> > > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > > ---    
> > 
> > It looks good to me.
> >   
> 
> Oops, reading Thomas's other mail, I now realize that with this patch we
> end up with the following in config-host.mak:
> 
> CONFIG_VIRTFS=$(call lor, $(CONFIG_VIRTIO_PCI),$(CONFIG_VIRTIO_CCW))
> 
> which looks wrong even if it may "work"... but we also get the
> following in config-host.h:
> 
> #define CONFIG_VIRTFS $(call lor, $(CONFIG_VIRTIO_PCI),$(CONFIG_VIRTIO_CCW))
> 
> which is clearly wrong.

Eek. Oh well, it would have been nice...

> 
> Maybe post the changes from your other mail instead ?
> 
> Message-ID: <20170808111542.16422571@gondolin>
> 
> The patch isn't that ugly, given the ugliness of the current makefiles :)

It is slightly differently ugly :)

> 
> And we can come up with some cleanup patch later.

Nod.

> 
> > Acked-by: Greg Kurz <groug@kaod.org>
> >   
> 
> NAcked-by: in fact :)

Heh :)

I'll post the other patch properly.
