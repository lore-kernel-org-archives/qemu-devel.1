Received: from eggs.gnu.org ([2001:4830:134:3::10]:45384)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1df47x-0001HH-4J
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:00:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1df47s-0004jP-CA
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:00:53 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1df47s-0004iH-5b
	for qemu-devel@nongnu.org; Tue, 08 Aug 2017 09:00:48 -0400
Date: Tue, 8 Aug 2017 15:00:42 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170808150042.5bf155ae@gondolin>
In-Reply-To: <20170808145000.3259f597@bahia.lan>
References: <20170808121701.18353-1-cohuck@redhat.com>
	<20170808121701.18353-2-cohuck@redhat.com>
	<20170808145000.3259f597@bahia.lan>
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
Cc: aneesh.kumar@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.de, thuth@redhat.com, qemu-devel@nongnu.org

On Tue, 8 Aug 2017 14:50:00 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Tue,  8 Aug 2017 14:17:01 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > We want to compile the 9pfs code iff virtfs is enabled and a virtio
> > transport is available (not only pci!).
> > 
> > Let's make the generated CONFIG_VIRTFS statement depend on either
> > CONFIG_VIRTIO_PCI or (new) CONFIG_VIRTIO_CCW. The Makefiles for fsdev/
> > and hw/9pfs/ can then depend on CONFIG_VIRTFS directly.
> > 
> > Suggested-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Cornelia Huck <cohuck@redhat.com>
> > ---  
> 
> It looks good to me.
> 
> Acked-by: Greg Kurz <groug@kaod.org>
> 
> >  configure                         | 2 +-
> >  default-configs/s390x-softmmu.mak | 1 +
> >  fsdev/Makefile.objs               | 2 +-
> >  hw/Makefile.objs                  | 2 +-
> >  4 files changed, 4 insertions(+), 3 deletions(-)

Thanks!

Will you queue this yourself, or should I send it together with the
zpci cleanup patches?
