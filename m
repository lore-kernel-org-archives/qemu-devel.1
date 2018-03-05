Received: from eggs.gnu.org ([2001:4830:134:3::10]:60508)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eslPB-0006hB-Of
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:23:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.l.liu@linux.intel.com>) id 1eslP7-0004w6-NO
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:23:33 -0500
Received: from mga18.intel.com ([134.134.136.126]:62790)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.l.liu@linux.intel.com>)
	id 1eslP7-0004ug-Cc
	for qemu-devel@nongnu.org; Mon, 05 Mar 2018 03:23:29 -0500
Date: Mon, 5 Mar 2018 16:06:40 +0800
From: "Liu, Yi L" <yi.l.liu@linux.intel.com>
Message-ID: <20180305080640.GB2482@sky-dev>
References: <1519900322-30263-1-git-send-email-yi.l.liu@linux.intel.com>
	<20180301152451-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180301152451-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v3 00/12] Introduce new iommu notifier
 framework for virt-SVA
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, david@gibson.dropbear.id.au, pbonzini@redhat.com, alex.williamson@redhat.com, eric.auger.pro@gmail.com

On Thu, Mar 01, 2018 at 03:32:22PM +0200, Michael S. Tsirkin wrote:
> On Thu, Mar 01, 2018 at 06:31:50PM +0800, Liu, Yi L wrote:
> > This patchset is to introduce a notifier framework for virt-SVA.
> > You may find virt-SVA design details from the link below.
> > 
> > https://lists.gnu.org/archive/html/qemu-devel/2017-04/msg04925.html
> > 
> > SVA is short for Shared Virtual Addressing. This is also called Shared
> > Virtual Memory in previous patchsets. However, SVM is confusing as it
> > can also be short for Secure Virtual Machine. So this patchset use
> > Shared Virtual Addressing instead of Shared Virtual Memory. And it
> > would be applied in future (SVA)related patch series as well.
> 
> Just as a matter of naming, it might be a good idea to just call
> this feature "PASID support". QEMU only cares about the mechanism,
> now about how applications use it.

Thanks for the idea. Will apply it in the next version.

Regards,
Yi Liu
