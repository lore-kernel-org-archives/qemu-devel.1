Received: from eggs.gnu.org ([2001:4830:134:3::10]:44930)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1coMfT-0004G3-RT
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 00:05:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1coMfS-0003c0-LJ
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 00:05:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41070)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1coMfS-0003bq-Fe
	for qemu-devel@nongnu.org; Thu, 16 Mar 2017 00:05:38 -0400
Date: Thu, 16 Mar 2017 12:05:26 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170316040526.GJ5971@pxdev.xzpeter.org>
References: <1486456099-7345-1-git-send-email-peterx@redhat.com>
	<1486456099-7345-18-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1486456099-7345-18-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v7 17/17] intel_iommu: enable vfio devices
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>, "Aviv B.D." <bd.aviv@gmail.com>
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, jan.kiszka@siemens.com, jasowang@redhat.com, David Gibson <david@gibson.dropbear.id.au>, alex.williamson@redhat.com

On Tue, Feb 07, 2017 at 04:28:19PM +0800, Peter Xu wrote:
> This patch is based on Aviv Ben-David (<bd.aviv@gmail.com>)'s patch
> upstream:
> 
>   "IOMMU: enable intel_iommu map and unmap notifiers"
>   https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg01453.html
> 
> However I removed/fixed some content, and added my own codes.
> 
> Instead of translate() every page for iotlb invalidations (which is
> slower), we walk the pages when needed and notify in a hook function.
> 
> This patch enables vfio devices for VT-d emulation.
> 
> And, since we already have vhost DMAR support via device-iotlb, a
> natural benefit that this patch brings is that vt-d enabled vhost can
> live even without ATS capability now. Though more tests are needed.
> 

Hi, Michael,

If there is any possiblility that this version be merged in the future
at any point, would you please help add Aviv's sign-off into this
patch as well right here (I think it should be before Jason's r-b):

Signed-off-by: Aviv Ben-David <bd.aviv@gmail.com>

Since I think we should definitely give Aviv more credit since he's
done a great work before (and devoted lots of time).

(Aviv, please reply if you have other opinions, or I'll just make
 myself bold)

Thanks,

> Reviewed-by: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>

[...]

-- peterx
