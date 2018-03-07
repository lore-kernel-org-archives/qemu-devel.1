Received: from eggs.gnu.org ([2001:4830:134:3::10]:49429)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etRmI-0001eC-Ie
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 00:38:15 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1etRmF-0003FR-C8
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 00:38:14 -0500
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:37482 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1etRmF-0003Ew-7E
	for qemu-devel@nongnu.org; Wed, 07 Mar 2018 00:38:11 -0500
Date: Wed, 7 Mar 2018 13:38:00 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180307053800.GH17720@xz-mi>
References: <1519900415-30314-1-git-send-email-yi.l.liu@linux.intel.com>
	<20180306065545.GE3615@xz-mi>
	<A2975661238FB949B60364EF0F2C257439B87835@SHSMSX104.ccr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <A2975661238FB949B60364EF0F2C257439B87835@SHSMSX104.ccr.corp.intel.com>
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
To: "Liu, Yi L" <yi.l.liu@intel.com>
Cc: "Liu, Yi L" <yi.l.liu@linux.intel.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "mst@redhat.com" <mst@redhat.com>, "david@gibson.dropbear.id.au" <david@gibson.dropbear.id.au>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "eric.auger.pro@gmail.com" <eric.auger.pro@gmail.com>, "Tian, Kevin" <kevin.tian@intel.com>, "jasowang@redhat.com" <jasowang@redhat.com>

On Tue, Mar 06, 2018 at 07:45:39AM +0000, Liu, Yi L wrote:

[...]

> > Do you have online branch so that I can check out?
> 
> yes, I should have pasted it. Here it is:
> https://github.com/luxis1999/sva_notifier.git

Thanks.

> 
> > The patches are a bit scattered and it's really hard for me to
> > reference things within it... So a complete tree to read would be
> > nice.
> > 
> > I roughly went over most of the patches, and the framework you
> > introduced is still not that clear to me.  For now I feel like it can
> > be simplified somehow, but I'll hold and speak after I read the whole
> > tree again.
> > 
> > Also, it'll be good too if you can always provide some status update
> > of the kernel-counterpart it.
> 
> Good suggestion. For this patchset, it only affects Qemu. Yeah, but for
> the whole virt-SVA enabling, there is kernel-counterparts. I would do
> it in the virt-SVA patchset series.

If you still want to post separately - I'm thinking whether it'll be
good you put the vfio changes into the 2nd virt-sva series, since that
looks more like in that category.  Or say, we can introduce
SVAOps/PASIDOps, we implement more vIOMMU invalidation request
handling, we call it in IOMMU code, but we don't implement any of the
device (vfio) that provide that ops.

Or maybe we can just post the whole stuff altogether, since after all
these two series are still closely related IMHO (e.g., the SVAOps
definition should be closely related to how the first vfio user would
like to use it).

Only my two cents, and I don't know how other people think.  It's up
to you after all. :)

Thanks,

-- 
Peter Xu
