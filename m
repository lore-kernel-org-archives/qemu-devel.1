Received: from eggs.gnu.org ([2001:4830:134:3::10]:47376)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gaQ4F-0002PM-Ek
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 14:02:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1gaQ4A-0006rQ-D4
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 14:02:39 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47158)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1gaQ4A-0006nc-68
	for qemu-devel@nongnu.org; Fri, 21 Dec 2018 14:02:34 -0500
Date: Fri, 21 Dec 2018 14:02:28 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20181221140016-mutt-send-email-mst@kernel.org>
References: <20181217141740.16ccfaa1@Igors-MacBook-Pro.local>
	<20181218092723.yhaerzm4vlzgef65@linux.intel.com>
	<20181218155536.2b35a037@Igors-MacBook-Pro.local>
	<20181219025717.6m72hq73p2haexkv@linux.intel.com>
	<20181219114037.5550a562@redhat.com>
	<20181220211801.GR19442@habkost.net>
	<20181221151325.39b64733@redhat.com>
	<20181221160944.65c5skjhkel3of7y@linux.intel.com>
	<20181221120320-mutt-send-email-mst@kernel.org>
	<20181221173758.4ohku43as4dkb355@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221173758.4ohku43as4dkb355@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH v3 1/2] intel-iommu: differentiate host
 address width from IOVA address width.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Yu Zhang <yu.c.zhang@linux.intel.com>
Cc: Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>

On Sat, Dec 22, 2018 at 01:37:58AM +0800, Yu Zhang wrote:
> On Fri, Dec 21, 2018 at 12:04:49PM -0500, Michael S. Tsirkin wrote:
> > On Sat, Dec 22, 2018 at 12:09:44AM +0800, Yu Zhang wrote:
> > > Well, my understanding of the vt-d spec is that the address limitation in
> > > DMAR are referring to the same concept of CPUID.MAXPHYSADDR. I do not think
> > > there's any different in the native scenario. :)
> > 
> > I think native machines exist on which the two values are different.
> > Is that true?
> 
> I think the answer is not. My understanding is that HAW(host address wdith) is
> the maximum physical address width a CPU can detects(by cpuid.0x80000008).
> 
> I agree there are some addresses the CPU does not touch, but they are still in
> the physical address space, and there's only one physical address space...
> 
> B.R.
> Yu

Ouch I thought we are talking about the virtual address size.
I think I did have a box where VTD's virtual address size was
smaller than CPU's.
For physical one - we just need to make it as big as max supported
memory right?

-- 
MST
