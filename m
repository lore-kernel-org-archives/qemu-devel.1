Received: from eggs.gnu.org ([2001:4830:134:3::10]:54942)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dkmu7-0007AP-JP
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:50:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <borntraeger@de.ibm.com>) id 1dkmu3-0000yk-NI
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:50:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:60890)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <borntraeger@de.ibm.com>)
	id 1dkmu3-0000yc-EA
	for qemu-devel@nongnu.org; Thu, 24 Aug 2017 03:50:11 -0400
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
	v7O7o8jL009245
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 03:50:09 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
	by mx0a-001b2d01.pphosted.com with ESMTP id 2chsj1n39v-1
	(version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
	for <qemu-devel@nongnu.org>; Thu, 24 Aug 2017 03:50:08 -0400
Received: from localhost
	by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use
	Only! Violators will be prosecuted
	for <qemu-devel@nongnu.org> from <borntraeger@de.ibm.com>;
	Thu, 24 Aug 2017 08:49:21 +0100
References: <20170823155458.19601-1-cohuck@redhat.com>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Thu, 24 Aug 2017 09:49:18 +0200
MIME-Version: 1.0
In-Reply-To: <20170823155458.19601-1-cohuck@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Message-Id: <aa9f83b7-fa91-bfff-eb4c-e8d24f8e1358@de.ibm.com>
Subject: Re: [Qemu-devel] [PATCH v5 0/9] zpci detangling
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Cornelia Huck <cohuck@redhat.com>, qemu-devel@nongnu.org
Cc: agraf@suse.de, thuth@redhat.com, david@redhat.com, pmorel@linux.vnet.ibm.com, zyimin@linux.vnet.ibm.com, pasic@linux.vnet.ibm.com

As there are only minor things left, 
whole series

Acked-by: Christian Borntraeger <borntraeger@de.ibm.com>


On 08/23/2017 05:54 PM, Cornelia Huck wrote:
> Hopefully should be close now...
> 
> v4->v5:
> - dropped "s390x/kvm: msi route fixup for non-pci"
> - reworked "s390x/sclp: properly guard pci-specific functions": the
>   configure/deconfigure stuff is about I/O adapters, we were missing
>   checks, and I used an incorrect return code -- please review
> - collected more r-bs
> 
> Cornelia Huck (9):
>   9pfs: fix dependencies
>   kvm: remove hard dependency on pci
>   s390x/pci: add stubs
>   s390x: chsc nt2 events are pci-only
>   s390x/pci: do not advertise pci on non-pci builds
>   s390x/ccw: create s390 phb conditionally
>   s390x/sclp: properly guard pci-specific functions
>   s390x/pci: fence off instructions for non-pci
>   s390x: refine pci dependencies
> 
>  accel/kvm/kvm-all.c               |  6 ++--
>  default-configs/s390x-softmmu.mak |  2 +-
>  fsdev/Makefile.objs               |  9 ++---
>  hw/9pfs/Makefile.objs             |  2 +-
>  hw/Makefile.objs                  |  2 +-
>  hw/pci/pci-stub.c                 | 16 ++++++++-
>  hw/pci/pci.c                      |  2 ++
>  hw/s390x/Makefile.objs            |  3 +-
>  hw/s390x/s390-pci-bus.c           | 18 +++-------
>  hw/s390x/s390-pci-bus.h           | 12 ++-----
>  hw/s390x/s390-pci-stub.c          | 76 +++++++++++++++++++++++++++++++++++++++
>  hw/s390x/s390-virtio-ccw.c        | 14 ++++----
>  hw/s390x/sclp.c                   | 39 +++++++++++++++++---
>  include/hw/pci/pci.h              |  2 ++
>  include/hw/s390x/sclp.h           | 17 ++++++---
>  target/s390x/ioinst.c             | 16 +++++++++
>  target/s390x/kvm.c                | 58 ++++++++++++++++++++++--------
>  17 files changed, 227 insertions(+), 67 deletions(-)
>  create mode 100644 hw/s390x/s390-pci-stub.c
> 
