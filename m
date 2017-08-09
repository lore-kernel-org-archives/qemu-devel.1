Received: from eggs.gnu.org ([2001:4830:134:3::10]:34444)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfOog-0007HG-VF
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 07:06:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dfOoe-0007PL-6f
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 07:06:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53850)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dfOoe-0007Oy-0Z
	for qemu-devel@nongnu.org; Wed, 09 Aug 2017 07:06:20 -0400
Date: Wed, 9 Aug 2017 13:06:14 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170809130608.3ce61bd3.cohuck@redhat.com>
In-Reply-To: <20170809114705.39dc0455@bahia.lan>
References: <20170809071718.17924-1-cohuck@redhat.com>
	<f384f920-9d51-4663-f7e7-95c8b13044f4@redhat.com>
	<20170809102737.18436fb4.cohuck@redhat.com>
	<20170809114705.39dc0455@bahia.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2] 9pfs: fix dependencies
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Thomas Huth <thuth@redhat.com>, aneesh.kumar@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.de, qemu-devel@nongnu.org, Stefano Stabellini <sstabellini@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>

On Wed, 9 Aug 2017 11:47:05 +0200
Greg Kurz <groug@kaod.org> wrote:

> On Wed, 9 Aug 2017 10:27:37 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
> 
> > On Wed, 9 Aug 2017 10:23:04 +0200
> > Thomas Huth <thuth@redhat.com> wrote:

> > > But thinking about this again, I wonder whether it would be enough to
> > > simply check for CONFIG_VIRTIO=y here instead. CONFIG_VIRTIO=y should be
> > > sufficient to assert that there is also at least one kind of virtio
> > > transport available, right?
> > > Otherwise this will look really horrible as soon as somebody also tries
> > > to add support for virtio-mmio here later ;-)    
> >   
> 
> And virtio isn't the only transport for 9p: we also have a Xen backend,
> which happen to be built because targets that support Xen also have
> CONFIG_PCI I guess.

Only if they also have virtio enabled, no?

Should the condition be VIRTFS && (VIRTIO || XEN), then?
