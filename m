Received: from eggs.gnu.org ([2001:4830:134:3::10]:53994)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLgOj-00030P-85
	for qemu-devel@nongnu.org; Wed, 23 May 2018 22:54:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1fLgOe-0003LL-DK
	for qemu-devel@nongnu.org; Wed, 23 May 2018 22:54:37 -0400
Date: Thu, 24 May 2018 10:54:19 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20180524025419.GB756@xz-mi>
References: <20180518072517.20901-1-peterx@redhat.com>
	<20180518072517.20901-10-peterx@redhat.com>
	<20180523173227-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180523173227-mutt-send-email-mst@kernel.org>
Subject: Re: [Qemu-devel] [PATCH v4 9/9] intel-iommu: rework the page walk
 logic
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: qemu-devel@nongnu.org, Tian Kevin <kevin.tian@intel.com>, QEMU Stable <qemu-stable@nongnu.org>, Jintack Lim <jintack@cs.columbia.edu>, Jason Wang <jasowang@redhat.com>, Alex Williamson <alex.williamson@redhat.com>

On Wed, May 23, 2018 at 05:33:34PM +0300, Michael S. Tsirkin wrote:
> On Fri, May 18, 2018 at 03:25:17PM +0800, Peter Xu wrote:
> > SECURITY IMPLICATION: this patch will fix a potential small window that
> > the DMA page table might be incomplete or invalid when the guest sends
> > domain/context invalidations to a device.  It can cause random DMA
> > errors for assigned devices.
> 
> So this is more a correctness IMO. I don't see how can
> e.g. an application within guest cause any mischief
> with this, it will just get a non working device.

Yes, you are right.  It causes valid mappings missing so there's no
risk to anyone but only unfunction.  I should remove the "SECURITY
IMPLICATION" wordings.

Thanks,

-- 
Peter Xu
