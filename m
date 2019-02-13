Received: from eggs.gnu.org ([209.51.188.92]:49963)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1gtnVU-00007K-LY
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:54:53 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yi.y.sun@linux.intel.com>) id 1gtnRj-00007w-9o
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:51:01 -0500
Received: from mga05.intel.com ([192.55.52.43]:31242)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yi.y.sun@linux.intel.com>)
	id 1gtnRd-0006Ez-N2
	for qemu-devel@nongnu.org; Wed, 13 Feb 2019 00:50:55 -0500
Date: Wed, 13 Feb 2019 13:46:28 +0800
From: Yi Sun <yi.y.sun@linux.intel.com>
Message-ID: <20190213054628.GD16968@yi.y.sun>
References: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
	<20190211103741.GH1011@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190211103741.GH1011@xz-x1>
Subject: Re: [Qemu-devel] [RFC v1 0/3] intel_iommu: support scalable mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com

On 19-02-11 18:37:41, Peter Xu wrote:
> On Wed, Jan 30, 2019 at 01:09:10PM +0800, Yi Sun wrote:
> > Intel vt-d rev3.0 [1] introduces a new translation mode called
> > 'scalable mode', which enables PASID-granular translations for
> > first level, second level, nested and pass-through modes. The
> > vt-d scalable mode is the key ingredient to enable Scalable I/O
> > Virtualization (Scalable IOV) [2] [3], which allows sharing a
> > device in minimal possible granularity (ADI - Assignable Device
> > Interface). As a result, previous Extended Context (ECS) mode
> > is deprecated (no production ever implements ECS).
> > 
> > This patch set emulates a minimal capability set of VT-d scalable
> > mode, equivalent to what is available in VT-d legacy mode today:
> >     1. Scalable mode root entry, context entry and PASID table
> >     2. Seconds level translation under scalable mode
> >     3. Queued invalidation (with 256 bits descriptor)
> >     4. Pass-through mode
> > 
> > Corresponding intel-iommu driver support will be included in
> > kernel 5.0:
> >     https://www.spinics.net/lists/kernel/msg2985279.html
> > 
> > We will add emulation of full scalable mode capability along with
> > guest iommu driver progress later, e.g.:
> >     1. First level translation
> >     2. Nested translation
> >     3. Per-PASID invalidation descriptors
> >     4. Page request services for handling recoverable faults
> 
> Hi, YiSun/YiLiu,
> 
> Have you tested against any existing usages of VT-d with this series
> applied?
> 
Thanks for the review!

With kernel/qemu scalable mode enabling patch sets applied, I tested
kernel build/data copy/netperf on guest under both "scalable-mode"
enabled and "scalable-mode" disabled scenarios.

> Thanks,
> 
> -- 
> Peter Xu
