Received: from eggs.gnu.org ([2001:4830:134:3::10]:39181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jacob.jun.pan@intel.com>) id 1dAFpW-0006VE-Nf
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:14:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jacob.jun.pan@intel.com>) id 1dAFpS-0005fx-PT
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:14:30 -0400
Received: from mga02.intel.com ([134.134.136.20]:65105)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jacob.jun.pan@intel.com>)
	id 1dAFpS-0005fO-Gv
	for qemu-devel@nongnu.org; Mon, 15 May 2017 09:14:26 -0400
Date: Mon, 15 May 2017 06:14:22 -0700
From: jacob pan <jacob.jun.pan@intel.com>
Message-ID: <20170515061422.0000350b@intel.com>
In-Reply-To: <20170512155929.66809113@t450s.home>
References: <1493201525-14418-1-git-send-email-yi.l.liu@intel.com>
	<1493201525-14418-3-git-send-email-yi.l.liu@intel.com>
	<20170512155929.66809113@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [RFC PATCH 2/8] iommu/vt-d: add bind_pasid_table
 function
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: "Liu, Yi L" <yi.l.liu@intel.com>, kvm@vger.kernel.org, iommu@lists.linux-foundation.org, peterx@redhat.com, jasowang@redhat.com, qemu-devel@nongnu.org, kevin.tian@intel.com, ashok.raj@intel.com, tianyu.lan@intel.com, jean-philippe.brucker@arm.com, Jacob Pan <jacob.jun.pan@linux.intel.com>, "Liu, Yi L" <yi.l.liu@linux.intel.com>, jacob.jun.pan@intel.com

On Fri, 12 May 2017 15:59:29 -0600
Alex Williamson <alex.williamson@redhat.com> wrote:

> > +	if (pasidt_binfo->size >= intel_iommu_get_pts(iommu)) {
> > +		pr_err("Invalid gPASID table size %llu, host size
> > %lu\n",
> > +			pasidt_binfo->size,
> > +			intel_iommu_get_pts(iommu));
> > +		ret = -EINVAL;
> > +		goto out;  
> 
> equal is not valid?

you are right, equal is valid. I was thinking of shared PASID space
between guest and host but that is not the case here.

The rest of your comments are taken too, thanks for the review.

Jacob
