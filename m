Received: from eggs.gnu.org ([2001:4830:134:3::10]:58129)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1esnJx-0003ye-LJ
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:26:18 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1esnJu-0000OX-HU
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:26:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:54346)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1esnJu-0000O3-78
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 05:26:14 -0500
Date: Mon, 5 Mar 2018 18:09:23 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20180305100923.GL2482@sky-dev>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<1519900415-30314-2-git-send-email-yi.l.liu@linux.intel.com>
	<e96e4f84-b25e-7aeb-41bf-1c21a1ba1d4f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e96e4f84-b25e-7aeb-41bf-1c21a1ba1d4f@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, david@gibson.dropbear.id.au, kevin.tian@intel.com, yi.l.liu@intel.com, jasowang@redhat.com, peterx@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com

On Fri, Mar 02, 2018 at 04:01:11PM +0100, Paolo Bonzini wrote:
> On 01/03/2018 11:33, Liu, Yi L wrote:
> > From: Peter Xu <peterx@redhat.com>
> > 
> > IOMMU notifiers before are mostly used for [dev-]IOTLB stuffs. It is not
> > suitable for other kind of notifiers (one example would be the future
> > virt-svm support). Considering that current notifiers are targeted for
> > per memory region, renaming the iommu notifier definitions.
> > 
> > This patch has following changes:
> > * all the notifier types from IOMMU_NOTIFIER_* prefix into IOMMU_MR_EVENT_*
> >   to better show its usage (for memory regions).
> > * rename IOMMUNotifier to IOMMUMRNotifier
> > * rename iommu_notifier to iommu_mr_notifier
> 
> Do you need this?  Could the IOMMUSVANotifier simply be renamed to
> SVANotifier?

I also considered it before sending out this series. It is necessary under
previous naming(the new notifier was planned to be name as IOMMUNotifier).
However, it is not necessary now since notifier can be SVANotifier.

But the changes in this patch still have some benefit. e.g. much clear
on the naming since existing iommu notifier is actually IOMMU MR based.
So I didn't remove it from this series. I plan to remove it in next
version as it is not necessary for this series now. Even we need it,
it can be done in other series. How about your opinion?

Thanks,
Yi Liu
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > Signed-off-by: Liu, Yi L <yi.l.liu@linux.intel.com>
