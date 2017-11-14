Received: from eggs.gnu.org ([2001:4830:134:3::10]:33807)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eEd4Q-0006pt-9E
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:24:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1eEd4N-0007lc-28
	for qemu-devel@nongnu.org; Tue, 14 Nov 2017 10:24:14 -0500
Date: Tue, 14 Nov 2017 16:23:41 +0100
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20171114162341.4d648e59.cohuck@redhat.com>
In-Reply-To: <1509033294-4945-1-git-send-email-akrowiak@linux.vnet.ibm.com>
References: <1509033294-4945-1-git-send-email-akrowiak@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC 0/5] guest dedicated crypto adapters: QEMU
 usage
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tony Krowiak <akrowiak@linux.vnet.ibm.com>
Cc: linux-s390@vger.kernel.org, qemu-s390x@nongnu.org, kvm@vger.kernel.org, freude@de.ibm.com, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, borntraeger@de.ibm.com, kwankhede@nvidia.com, bjsdjshi@linux.vnet.ibm.com, pbonzini@redhat.com, alex.williamson@redhat.com, pmorel@linux.vnet.ibm.com, alifm@linux.vnet.ibm.com, mjrosato@linux.vnet.ibm.com, jjherne@linux.vnet.ibm.com, thuth@redhat.com, pasic@linux.vnet.ibm.com, qemu-devel@nongnu.org

On Thu, 26 Oct 2017 11:54:49 -0400
Tony Krowiak <akrowiak@linux.vnet.ibm.com> wrote:

> I was asked to post this QEMU patch set to the mailing list to illustrate
> how the KVM/kernel counterpart will be used. The KVM/kernel patches can be
> viewed at:
> 
> https://lkml.org/lkml/2017/10/13/706
> 
> The IBM Adjunct Processor (AP) Cryptographic Facility is comprised 
> of three AP instructions and from 1 to 256 PCIe cryptographic adapter cards.
> These AP adapters provide cryptographic functions to all CPUs assigned to a
> linux system running in an IBM Z system LPAR.
> 
> This patch series introduces a new QEMU command line option and QEMU object
> model to obtain direct guest access to one or more AP adapter cards assigned
> to the LPAR in which the host linux system is running. It is predicated 
> on the KVM/kernel model for providing direct guest access to AP adapters. A 
> complete description for dedicating crypto adapters to a linux guest can be 
> found in the docs/ap-matrix.txt file provided with this patch set.
> 
> Signed-off-by: Tony Krowiak <akrowiak@linux.vnet.ibm.com>

+cc qemu-devel@nongnu.org

The interface exposed by the kernel looks fine to me, and I did not
spot really broken things on a quick readthrough. I'd like more
feedback, though.

> 
> Tony Krowiak (5):
>   s390x/ap-matrix: Adjunct Processor (AP) matrix object model
>   s390x/vfio: ap-matrix: Introduce VFIO AP Matrix device
>   s390x/ap-matrix: Configure AP matrix for KVM guest
>   s390x/cpumodel: enable AP facilities for guest
>   s390x/docs: documentation for ap-matrix
> 
>  default-configs/s390x-softmmu.mak |    1 +
>  docs/ap_matrix.txt                |  529 +++++++++++++++++++++++++++++++++++++
>  hw/s390x/Makefile.objs            |    2 +
>  hw/s390x/ap-matrix-device.c       |   33 +++
>  hw/s390x/ap-matrix-device.h       |   53 ++++
>  hw/s390x/s390-ap-matrix.c         |   52 ++++
>  hw/vfio/Makefile.objs             |    1 +
>  hw/vfio/ap-matrix.c               |  224 ++++++++++++++++
>  include/hw/s390x/s390-ap-matrix.h |   39 +++
>  include/hw/vfio/vfio-common.h     |    1 +
>  linux-headers/linux/vfio.h        |   29 ++-
>  target/s390x/cpu_features.c       |    2 +
>  target/s390x/cpu_features_def.h   |    2 +
>  target/s390x/gen-features.c       |    4 +
>  14 files changed, 969 insertions(+), 3 deletions(-)
>  create mode 100644 docs/ap_matrix.txt
>  create mode 100644 hw/s390x/ap-matrix-device.c
>  create mode 100644 hw/s390x/ap-matrix-device.h
>  create mode 100644 hw/s390x/s390-ap-matrix.c
>  create mode 100644 hw/vfio/ap-matrix.c
>  create mode 100644 include/hw/s390x/s390-ap-matrix.h
> 
