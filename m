Received: from eggs.gnu.org ([2001:4830:134:3::10]:57948)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cEDJg-0001fs-6m
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:49:45 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cEDJc-0006Q9-1R
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:49:44 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60678)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cEDJb-0006Pq-SG
	for qemu-devel@nongnu.org; Tue, 06 Dec 2016 05:49:39 -0500
Date: Tue, 6 Dec 2016 18:49:32 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161206104932.GA3469@pxdev.xzpeter.org>
References: <1481020588-4245-1-git-send-email-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1481020588-4245-1-git-send-email-peterx@redhat.com>
Subject: Re: [Qemu-devel] [RFC PATCH 00/13] VT-d replay and misc cleanup
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: qemu-devel@nongnu.org
Cc: tianyu.lan@intel.com, kevin.tian@intel.com, mst@redhat.com, jan.kiszka@siemens.com, bd.aviv@gmail.com, alex.williamson@redhat.com, jasowang@redhat.com, Paolo Bonzini <pbonzini@redhat.com>, David Gibson <david@gibson.dropbear.id.au>

On Tue, Dec 06, 2016 at 06:36:15PM +0800, Peter Xu wrote:
> This RFC series is a continue work for Aviv B.D.'s vfio enablement
> series with vt-d. Aviv has done a great job there, and what we still
> lack there are mostly the following:
> 
> (1) VFIO got duplicated IOTLB notifications due to splitted VT-d IOMMU
>     memory region.
> 
> (2) VT-d still haven't provide a correct replay() mechanism (e.g.,
>     when IOMMU domain switches, things will broke).
> 
> Here I'm trying to solve the above two issues.
> 
> (1) is solved by patch 7, (2) is solved by patch 11-12.

One thing to mention: this series is based on Aviv's series v6:

  https://lists.gnu.org/archive/html/qemu-devel/2016-11/msg01452.html

I pushed an online branch for better reference:

  https://github.com/xzpeter/qemu/tree/vtd-vfio-enablement

Forgot to CC Paolo & DavidG. Adding in.

Thanks,

-- peterx
