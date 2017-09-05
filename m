Received: from eggs.gnu.org ([2001:4830:134:3::10]:34840)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpCVf-00030R-N4
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:59:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <cohuck@redhat.com>) id 1dpCVa-0003mO-TN
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:59:15 -0400
Received: from mx1.redhat.com ([209.132.183.28]:57484)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <cohuck@redhat.com>) id 1dpCVa-0003lo-N5
	for qemu-devel@nongnu.org; Tue, 05 Sep 2017 07:59:10 -0400
Date: Tue, 5 Sep 2017 13:58:32 +0200
From: Cornelia Huck <cohuck@redhat.com>
Message-ID: <20170905135832.70a0397c.cohuck@redhat.com>
In-Reply-To: <1504606380-49341-1-git-send-email-zyimin@linux.vnet.ibm.com>
References: <1504606380-49341-1-git-send-email-zyimin@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 0/3] three zpci patches
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Min Zhao <zyimin@linux.vnet.ibm.com>
Cc: qemu-devel@nongnu.org, borntraeger@de.ibm.com, pasic@linux.vnet.ibm.com, pmorel@linux.vnet.ibm.com, agraf@suse.de, richard.henderson@linaro.org

On Tue,  5 Sep 2017 12:12:57 +0200
Yi Min Zhao <zyimin@linux.vnet.ibm.com> wrote:

> This patch set contains three small zpci patches to fixup different issues.
> 1) remove zpci idx from msix message, instead we could use PCIDevice's id to
>    find zpci device in kvm_arch_fixup_msi_route()
> 2) fixup ind_offset calculation for adapter interrupt routing entry
> 3) introduce our own iommu_replay callback
> 
> Yi Min Zhao (3):
>   s390x/pci: remove idx from msix msg data
>   s390x/pci: fixup ind_offset of msix routing entry
>   s390x/pci: add iommu replay callback
> 
>  hw/s390x/s390-pci-bus.c  | 28 +++++++++++++++++-----------
>  hw/s390x/s390-pci-bus.h  |  2 ++
>  hw/s390x/s390-pci-inst.c | 24 ------------------------
>  hw/s390x/s390-pci-stub.c |  3 ++-
>  target/s390x/kvm.c       | 14 ++++++++------
>  5 files changed, 29 insertions(+), 42 deletions(-)
> 

Thanks, applied.
