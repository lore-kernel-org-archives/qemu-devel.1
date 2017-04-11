Received: from eggs.gnu.org ([2001:4830:134:3::10]:53368)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cxsCJ-0000r0-14
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:34:52 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bjsdjshi@linux.vnet.ibm.com>) id 1cxsCE-0005XB-Ux
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:34:51 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:40158)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <bjsdjshi@linux.vnet.ibm.com>)
	id 1cxsCE-0005Wf-MJ
	for qemu-devel@nongnu.org; Tue, 11 Apr 2017 05:34:46 -0400
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v3B9SuwK126868
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 05:34:43 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29rku0d1jc-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 11 Apr 2017 05:34:43 -0400
Received: from localhost
	by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
	Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <bjsdjshi@linux.vnet.ibm.com>;
	Tue, 11 Apr 2017 05:34:41 -0400
Date: Tue, 11 Apr 2017 17:34:35 +0800
From: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
References: <20170317031928.40189-1-bjsdjshi@linux.vnet.ibm.com>
	<20170411110658.2bf778e3.cornelia.huck@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20170411110658.2bf778e3.cornelia.huck@de.ibm.com>
Message-Id: <20170411093435.GC2730@bjsdjshi@linux.vnet.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/11] basic channel IO passthrough
 infrastructure based on vfio
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cornelia.huck@de.ibm.com>
Cc: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

* Cornelia Huck <cornelia.huck@de.ibm.com> [2017-04-11 11:06:58 +0200]:

> On Fri, 17 Mar 2017 04:19:17 +0100
> Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:
> 
> > The patch series introduce a basic channel I/O passthrough
> > infrastructure based on vfio.
> 
> I think this is basically ready for 2.10, once the kernel changes hit
> master (they are queued in the s390 tree).
:>

> 
> (...)
> 
> >  default-configs/s390x-softmmu.mak  |   1 +
> >  hw/s390x/Makefile.objs             |   1 +
> >  hw/s390x/css-bridge.c              |   2 +
> >  hw/s390x/css.c                     | 290 ++++++++++++++++++++++--
> >  hw/s390x/s390-ccw.c                | 137 ++++++++++++
> >  hw/s390x/s390-ccw.h                |  39 ++++
> >  hw/s390x/s390-virtio-ccw.c         |  35 ++-
> >  hw/s390x/virtio-ccw.c              |   7 +-
> >  hw/vfio/Makefile.objs              |   1 +
> >  hw/vfio/ccw.c                      | 442 +++++++++++++++++++++++++++++++++++++
> >  include/hw/s390x/css-bridge.h      |   1 +
> >  include/hw/s390x/css.h             |  67 +++---
> >  include/hw/s390x/s390-virtio-ccw.h |   1 +
> >  include/hw/vfio/vfio-common.h      |   1 +
> >  linux-headers/linux/vfio.h         |  17 ++
> >  linux-headers/linux/vfio_ccw.h     |  28 +++
> >  qemu-options.hx                    |   6 +-
> >  target/s390x/cpu.h                 |  10 +
> >  target/s390x/ioinst.c              |   9 +
> >  19 files changed, 1047 insertions(+), 48 deletions(-)
> >  create mode 100644 hw/s390x/s390-ccw.c
> >  create mode 100644 hw/s390x/s390-ccw.h
> >  create mode 100644 hw/vfio/ccw.c
> >  create mode 100644 linux-headers/linux/vfio_ccw.h
> 
> It's probably best to take this through my tree (pending acks of the
> vfio parts from Alex W.). It probably also would be good to add an s390
> maintainer for  hw/vfio/ccw.c (I'd be willing to do that).
> 
> Could you please resend on top of git://github.com/cohuck/qemu s390-next
> and add a MAINTAINERS patch as well?
Sure. Will do.
