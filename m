Received: from eggs.gnu.org ([2001:4830:134:3::10]:57641)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1csmMh-0004vE-D3
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cornelia.huck@de.ibm.com>) id 1csmMd-0003WH-CS
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:20:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:56597)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cornelia.huck@de.ibm.com>)
	id 1csmMd-0003V1-2D
	for qemu-devel@nongnu.org; Tue, 28 Mar 2017 04:20:27 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
	v2S8JLt3024755
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:20:25 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 29fktu9jbk-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Tue, 28 Mar 2017 04:20:25 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <cornelia.huck@de.ibm.com>;
	Tue, 28 Mar 2017 09:20:22 +0100
Date: Tue, 28 Mar 2017 10:20:16 +0200
From: Cornelia Huck <cornelia.huck@de.ibm.com>
In-Reply-To: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
References: <20170317031743.40128-1-bjsdjshi@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Message-Id: <20170328102016.4926f21d.cornelia.huck@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v4 00/16] basic vfio-ccw infrastructure
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, qemu-devel@nongnu.org, renxiaof@linux.vnet.ibm.com, borntraeger@de.ibm.com, agraf@suse.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

On Fri, 17 Mar 2017 04:17:27 +0100
Dong Jia Shi <bjsdjshi@linux.vnet.ibm.com> wrote:

> Dong Jia Shi (16):
>   s390: cio: introduce cio_cancel_halt_clear
>   s390: cio: export more interfaces
>   vfio: ccw: define device_api strings
>   vfio: ccw: basic implementation for vfio_ccw driver
>   vfio: ccw: introduce channel program interfaces
>   vfio: ccw: register vfio_ccw to the mediated device framework
>   vfio: ccw: introduce ccw_io_region
>   vfio: ccw: handle ccw command request
>   vfio: ccw: realize VFIO_DEVICE_GET_REGION_INFO ioctl
>   vfio: ccw: realize VFIO_DEVICE_RESET ioctl
>   vfio: ccw: realize VFIO_DEVICE_G(S)ET_IRQ_INFO ioctls
>   vfio: ccw: return I/O results asynchronously
>   vfio: ccw: introduce a finite state machine
>   docs: add documentation for vfio-ccw
>   vfio: ccw: introduce support for ccw0
>   MAINTAINERS: Add vfio-ccw maintainers
> 
>  Documentation/s390/00-INDEX         |   2 +
>  Documentation/s390/vfio-ccw.txt     | 303 +++++++++++++
>  MAINTAINERS                         |  10 +
>  arch/s390/Kconfig                   |  10 +
>  arch/s390/include/asm/cio.h         |  18 +
>  arch/s390/include/asm/isc.h         |   1 +
>  drivers/iommu/Kconfig               |   8 +
>  drivers/s390/cio/Makefile           |   3 +
>  drivers/s390/cio/cio.c              |  69 +++
>  drivers/s390/cio/cio.h              |   1 +
>  drivers/s390/cio/device_fsm.c       |  54 +--
>  drivers/s390/cio/vfio_ccw_cp.c      | 842 ++++++++++++++++++++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_cp.h      |  42 ++
>  drivers/s390/cio/vfio_ccw_drv.c     | 308 +++++++++++++
>  drivers/s390/cio/vfio_ccw_fsm.c     | 207 +++++++++
>  drivers/s390/cio/vfio_ccw_ops.c     | 447 +++++++++++++++++++
>  drivers/s390/cio/vfio_ccw_private.h |  96 ++++
>  include/uapi/linux/vfio.h           |  18 +
>  include/uapi/linux/vfio_ccw.h       |  24 +
>  19 files changed, 2417 insertions(+), 46 deletions(-)
>  create mode 100644 Documentation/s390/vfio-ccw.txt
>  create mode 100644 drivers/s390/cio/vfio_ccw_cp.c
>  create mode 100644 drivers/s390/cio/vfio_ccw_cp.h
>  create mode 100644 drivers/s390/cio/vfio_ccw_drv.c
>  create mode 100644 drivers/s390/cio/vfio_ccw_fsm.c
>  create mode 100644 drivers/s390/cio/vfio_ccw_ops.c
>  create mode 100644 drivers/s390/cio/vfio_ccw_private.h
>  create mode 100644 include/uapi/linux/vfio_ccw.h
> 

Patch set looks good to me, and I think we should target it for the
next merge window (the interface looks fine, and we can iron out any
other things later.)

Question: Which tree should this go through? Vfio or kvm/s390?
