Received: from eggs.gnu.org ([2001:4830:134:3::10]:39377)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cr5vC-0006Uy-Nw
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:49:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sstabellini@kernel.org>) id 1cr5v9-00013u-Hu
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:49:10 -0400
Received: from mail.kernel.org ([198.145.29.136]:57658)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <sstabellini@kernel.org>)
	id 1cr5v9-00011r-8l
	for qemu-devel@nongnu.org; Thu, 23 Mar 2017 12:49:07 -0400
Date: Thu, 23 Mar 2017 09:49:00 -0700 (PDT)
From: Stefano Stabellini <sstabellini@kernel.org>
In-Reply-To: <20170323093418.601a19b2@bahia.lan>
Message-ID: <alpine.DEB.2.10.1703230948510.8001@sstabellini-ThinkPad-X260>
References: <alpine.DEB.2.10.1703201117560.23684@sstabellini-ThinkPad-X260>
	<20170321112000.56a9737f@bahia.lan>
	<alpine.DEB.2.10.1703211035401.18429@sstabellini-ThinkPad-X260>
	<20170322094724.5f1f5cf9@bahia.lan>
	<alpine.DEB.2.10.1703221131160.13499@sstabellini-ThinkPad-X260>
	<20170323093418.601a19b2@bahia.lan>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: Re: [Qemu-devel] [Xen-devel] [PATCH v4 0/8] xen/9pfs: introduce the
 Xen 9pfs backend
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Greg Kurz <groug@kaod.org>
Cc: Stefano Stabellini <sstabellini@kernel.org>, anthony.perard@citrix.com, xen-devel@lists.xenproject.org, jgross@suse.com, aneesh.kumar@linux.vnet.ibm.com, qemu-devel@nongnu.org

On Thu, 23 Mar 2017, Greg Kurz wrote:
> On Wed, 22 Mar 2017 11:32:22 -0700 (PDT)
> Stefano Stabellini <sstabellini@kernel.org> wrote:
> 
> > On Wed, 22 Mar 2017, Greg Kurz wrote:
> > > On Tue, 21 Mar 2017 13:14:02 -0700 (PDT)
> > > Stefano Stabellini <sstabellini@kernel.org> wrote:
> > >   
> > > > On Tue, 21 Mar 2017, Greg Kurz wrote:  
> > > > > On Mon, 20 Mar 2017 11:18:46 -0700 (PDT)
> > > > > Stefano Stabellini <sstabellini@kernel.org> wrote:
> > > > >     
> > > > > > Hi all,
> > > > > > 
> > > > > > This patch series implements a new transport for 9pfs, aimed at Xen
> > > > > > systems.
> > > > > > 
> > > > > > The transport is based on a traditional Xen frontend and backend drivers
> > > > > > pair. This patch series implements the backend, which typically runs in
> > > > > > Dom0. I sent another series to implement the frontend in Linux
> > > > > > (http://marc.info/?l=linux-kernel&m=148883047125960&w=2).
> > > > > > 
> > > > > > The backend complies to the Xen transport for 9pfs specification
> > > > > > version 1, available here:
> > > > > > 
> > > > > > https://xenbits.xen.org/docs/unstable/misc/9pfs.html
> > > > > > 
> > > > > > 
> > > > > > Changes in v4:
> > > > > > - add reviewed-bys
> > > > > > - remove useless if(NULL) checks around g_free
> > > > > > - g_free g_malloc'ed sgs
> > > > > > - remove XEN_9PFS_RING_ORDER, make the ring order dynamic per ring,
> > > > > >   reading the ring_order field in xen_9pfs_data_intf
> > > > > > - remove patch not to build Xen backends on non-Xen capable targets
> > > > > >   because it is already upstream
> > > > > >     
> > > > > 
> > > > > Hi Stefano,
> > > > > 
> > > > > This looks good to me. Do you want these patches to go through my 9p
> > > > > tree or through your xen tree ?    
> > > > 
> > > > Thanks Greg! It can work both ways. If you have any changes in your queue
> > > > that could conflict with this, it's best to go via your tree.
> > > > 
> > > > Otherwise, I'll merge it in mine, so that I can keep an eye on the
> > > > correspondent Xen changes to the header files and make sure they are in
> > > > sync (specifically http://marc.info/?l=qemu-devel&m=149003412910278).
> > > >   
> > > 
> > > I don't have any conflicting patches on my side. Please merge this in your
> > > tree (as well as the MAINTAINERS patch).  
> > 
> > All right, thanks! I'll add a reviewed-by you on all patches if for you
> > is OK.
> > 
> 
> I'd prefer not as I haven't reviewed the Xen specific bits actually :)

OK :)


> > > >   
> > > > >  Also, I guess you may want to add
> > > > > F: hw/9pfs/xen-9p-backend.c to the Xen section in MAINTAINERS.    
> > > > 
> > > > I'll send a patch to be applied on top of the series
> > > > 
> > > >   
> > > > > --
> > > > > Greg
> > > > >     
> > > > > > Changes in v3:
> > > > > > - do not build backends for targets that do not support xen
> > > > > > - remove xen_9pfs.h, merge its content into xen-9p-backend.c
> > > > > > - remove xen_9pfs_header, introduce P9MsgHeader
> > > > > > - use le32_to_cpu to access P9MsgHeader fields
> > > > > > - many coding style fixes
> > > > > > - run checkpatch on all patches
> > > > > > - add check if num_rings < 1
> > > > > > - use g_strdup_printf
> > > > > > - free fsdev_id in xen_9pfs_free
> > > > > > - add comments
> > > > > > 
> > > > > > Changes in v2:
> > > > > > - fix coding style
> > > > > > - compile xen-9p-backend.c if CONFIG_XEN_BACKEND
> > > > > > - add patch to set CONFIG_XEN_BACKEND only for the right targets
> > > > > > - add review-bys
> > > > > > 
> > > > > > 
> > > > > > Stefano Stabellini (8):
> > > > > >       xen: import ring.h from xen
> > > > > >       9p: introduce a type for the 9p header
> > > > > >       xen/9pfs: introduce Xen 9pfs backend
> > > > > >       xen/9pfs: connect to the frontend
> > > > > >       xen/9pfs: receive requests from the frontend
> > > > > >       xen/9pfs: implement in/out_iov_from_pdu and vmarshal/vunmarshal
> > > > > >       xen/9pfs: send responses back to the frontend
> > > > > >       xen/9pfs: build and register Xen 9pfs backend
> > > > > > 
> > > > > >  hw/9pfs/9p.h                 |   6 +
> > > > > >  hw/9pfs/Makefile.objs        |   1 +
> > > > > >  hw/9pfs/virtio-9p-device.c   |   6 +-
> > > > > >  hw/9pfs/xen-9p-backend.c     | 444 +++++++++++++++++++++++++++++++++++++++++
> > > > > >  hw/block/xen_blkif.h         |   2 +-
> > > > > >  hw/usb/xen-usb.c             |   2 +-
> > > > > >  hw/xen/xen_backend.c         |   3 +
> > > > > >  include/hw/xen/io/ring.h     | 455 +++++++++++++++++++++++++++++++++++++++++++
> > > > > >  include/hw/xen/xen_backend.h |   3 +
> > > > > >  9 files changed, 915 insertions(+), 7 deletions(-)
> > > > > >  create mode 100644 hw/9pfs/xen-9p-backend.c
> > > > > >  create mode 100644 include/hw/xen/io/ring.h    
> > > > > 
> > > > >     
> > > 
> > >   
> 
> 
