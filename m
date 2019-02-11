Received: from eggs.gnu.org ([209.51.188.92]:44894)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gt8yi-0001q8-By
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 05:38:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <peterx@redhat.com>) id 1gt8yg-0002tU-KP
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 05:38:20 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <peterx@redhat.com>) id 1gt8yg-0002se-DT
	for qemu-devel@nongnu.org; Mon, 11 Feb 2019 05:38:18 -0500
Date: Mon, 11 Feb 2019 18:37:41 +0800
From: Peter Xu <peterx@redhat.com>
Message-ID: <20190211103741.GH1011@xz-x1>
References: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1548824953-23413-1-git-send-email-yi.y.sun@linux.intel.com>
Subject: Re: [Qemu-devel] [RFC v1 0/3] intel_iommu: support scalable mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yi Sun <yi.y.sun@linux.intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net, ehabkost@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, kevin.tian@intel.com, yi.l.liu@intel.com, yi.y.sun@intel.com

On Wed, Jan 30, 2019 at 01:09:10PM +0800, Yi Sun wrote:
> Intel vt-d rev3.0 [1] introduces a new translation mode called
> 'scalable mode', which enables PASID-granular translations for
> first level, second level, nested and pass-through modes. The
> vt-d scalable mode is the key ingredient to enable Scalable I/O
> Virtualization (Scalable IOV) [2] [3], which allows sharing a
> device in minimal possible granularity (ADI - Assignable Device
> Interface). As a result, previous Extended Context (ECS) mode
> is deprecated (no production ever implements ECS).
> 
> This patch set emulates a minimal capability set of VT-d scalable
> mode, equivalent to what is available in VT-d legacy mode today:
>     1. Scalable mode root entry, context entry and PASID table
>     2. Seconds level translation under scalable mode
>     3. Queued invalidation (with 256 bits descriptor)
>     4. Pass-through mode
> 
> Corresponding intel-iommu driver support will be included in
> kernel 5.0:
>     https://www.spinics.net/lists/kernel/msg2985279.html
> 
> We will add emulation of full scalable mode capability along with
> guest iommu driver progress later, e.g.:
>     1. First level translation
>     2. Nested translation
>     3. Per-PASID invalidation descriptors
>     4. Page request services for handling recoverable faults

Hi, YiSun/YiLiu,

Have you tested against any existing usages of VT-d with this series
applied?

Thanks,

-- 
Peter Xu
