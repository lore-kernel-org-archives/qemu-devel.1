Received: from eggs.gnu.org ([2001:4830:134:3::10]:49293)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermBW-00062p-BI
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:01:23 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ermBV-0003CO-Gq
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:01:22 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:54146 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ermBV-0003C7-CK
	for qemu-devel@nongnu.org; Fri, 02 Mar 2018 10:01:21 -0500
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-2-git-send-email-yi.l.liu@linux.intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e96e4f84-b25e-7aeb-41bf-1c21a1ba1d4f@redhat.com>
Date: Fri, 2 Mar 2018 16:01:11 +0100
MIME-Version: 1.0
In-Reply-To: <1519900415-30314-2-git-send-email-yi.l.liu@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v3 01/12] memory: rename existing iommu
 notifier to be iommu mr notifier
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Liu, Yi L" <yi.l.liu@linux.intel.com>, qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au
Cc: alex.williamson@redhat.com, eric.auger.pro@gmail.com, yi.l.liu@intel.com, peterx@redhat.com, kevin.tian@intel.com, jasowang@redhat.com

On 01/03/2018 11:33, Liu, Yi L wrote:
> From: Peter Xu <peterx@redhat.com>
> 
> IOMMU notifiers before are mostly used for [dev-]IOTLB stuffs. It is not
> suitable for other kind of notifiers (one example would be the future
> virt-svm support). Considering that current notifiers are targeted for
> per memory region, renaming the iommu notifier definitions.
> 
> This patch has following changes:
> * all the notifier types from IOMMU_NOTIFIER_* prefix into IOMMU_MR_EVENT_*
>   to better show its usage (for memory regions).
> * rename IOMMUNotifier to IOMMUMRNotifier
> * rename iommu_notifier to iommu_mr_notifier

Do you need this?  Could the IOMMUSVANotifier simply be renamed to
SVANotifier?

Thanks,

Paolo

> Signed-off-by: Peter Xu <peterx@redhat.com>
> Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
