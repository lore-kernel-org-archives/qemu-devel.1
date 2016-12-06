Received: from eggs.gnu.org ([2001:4830:134:3::10]:35634)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cE5Kt-0000sS-4H
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:18:27 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1cE5Kq-0002D2-0d
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:18:27 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45420)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1cE5Kp-0002Cm-R8
	for qemu-devel@nongnu.org; Mon, 05 Dec 2016 21:18:23 -0500
Date: Tue, 6 Dec 2016 10:18:17 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20161206021817.GA4344@pxdev.xzpeter.org>
References: <1480348315-13332-1-git-send-email-bd.aviv@gmail.com>
	<20161130092359.GC4731@pxdev.xzpeter.org>
	<b5d782cb-22f3-1000-8424-b5af67d78f5b@intel.com>
	<20161202060859.GD21601@pxdev.xzpeter.org>
	<20161202103034.34651a52@t450s.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20161202103034.34651a52@t450s.home>
Subject: Re: [Qemu-devel] [PATCH v7 0/5] IOMMU: intel_iommu support map and
 unmap notifications
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Lan Tianyu <tianyu.lan@intel.com>, "Aviv B.D" <bd.aviv@gmail.com>, Jason Wang <jasowang@redhat.com>, Jan Kiszka <jan.kiszka@siemens.com>, qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>

On Fri, Dec 02, 2016 at 10:30:34AM -0700, Alex Williamson wrote:

[...]

> On the host though, I'd expect we still have separate IOMMU domains,
> one for each device and we do DMA_{UN}MAP ioctls separately per
> container.  Thanks,

I have a RFC version of replay implementation that used the way to do
it (each device will have its own address space, even if more than one
devices are in the same IOMMU domain). I'll arrange the patches and
post soon. Let's see whether that's a valid approach to fix existing
issues for vfio enablement on vt-d.

Thanks,

-- peterx
