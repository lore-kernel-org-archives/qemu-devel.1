Received: from eggs.gnu.org ([2001:4830:134:3::10]:58951)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJYTC-0003PJ-5x
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:02:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fJYT4-0005en-NV
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:02:26 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:35520 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1fJYT4-0005ee-J9
	for qemu-devel@nongnu.org; Fri, 18 May 2018 02:02:18 -0400
Date: Fri, 18 May 2018 14:02:12 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180518060212.GF2569@xz-mi>
References: <20180504030811.28111-1-peterx@redhat.com>
	<20180504030811.28111-7-peterx@redhat.com>
	<99079f7d-c447-d615-83c0-bb943557258d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <99079f7d-c447-d615-83c0-bb943557258d@redhat.com>
Subject: Re: [Qemu-devel] [PATCH v2 06/10] intel-iommu: pass in address
 space when page walk
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Auger Eric <eric.auger@redhat.com>
Cc: qemu-devel@nongnu.org, Tian Kevin <kevin.tian@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>

On Thu, May 17, 2018 at 04:32:55PM +0200, Auger Eric wrote:
> Hi Peter,
> 
> On 05/04/2018 05:08 AM, Peter Xu wrote:
> > We pass in the VTDAddressSpace to replace the aw bits when doing page
> > walk.  The VTDAddressSpace contains the aw bits information, meanwhile
> > we'll need to do something more in the follow up patches regarding to
> > the address spaces.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>

This one is also changed in version 3.  Please have a look there too.

Thanks,

-- 
Peter Xu
