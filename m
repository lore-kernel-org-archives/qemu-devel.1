Received: from eggs.gnu.org ([2001:4830:134:3::10]:47133)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d7bYx-0004pA-5i
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:50:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1d7bYt-00031V-6W
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:50:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41152)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1d7bYt-00031P-0G
	for qemu-devel@nongnu.org; Mon, 08 May 2017 01:50:23 -0400
Date: Mon, 8 May 2017 13:50:10 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20170508055010.GB2820@pxdev.xzpeter.org>
References: <1493285660-4470-1-git-send-email-peterx@redhat.com>
	<1493285660-4470-4-git-send-email-peterx@redhat.com>
	<20170501045335.GJ13773@umbus.fritz.box>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20170501045335.GJ13773@umbus.fritz.box>
Subject: Re: [Qemu-devel] [RFC PATCH 3/8] memory: rename
 iommu_notifier_init()
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: qemu-devel@nongnu.org, tianyu.lan@intel.com, Paolo Bonzini <pbonzini@redhat.com>, kevin.tian@intel.com, yi.l.liu@intel.com, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

On Mon, May 01, 2017 at 02:53:35PM +1000, David Gibson wrote:
> On Thu, Apr 27, 2017 at 05:34:15PM +0800, Peter Xu wrote:
> > It's new name is iommu_mr_notifier_init(). Again, literal changes only.
> > 
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> 
> Again, I think this could be folded with the previous two patches.

Sure. I can squash them all after I know whether we'll need this
series.

> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>
> 
> I also note that these patches will conflict with Alexey's proposed
> changes to make IOMMU MR's a QOM subtype of the ordinary MR (thus
> removing some of the MR specific fields from other MRs.

No problem. Due to some reason I just came back to read all the mails,
so haven't read them yet. I can rebase when needed. Thanks,

-- 
Peter Xu
