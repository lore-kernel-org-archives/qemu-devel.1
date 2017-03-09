Received: from eggs.gnu.org ([2001:4830:134:3::10]:41747)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cm056-0002Q0-SV
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 10:34:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cm050-0004ah-T0
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 10:34:19 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46822)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cm050-0004aZ-Nc
	for qemu-devel@nongnu.org; Thu, 09 Mar 2017 10:34:14 -0500
References: <1487742565-2513-1-git-send-email-peterx@redhat.com>
	<20170222103047.2c1b63f2@t450s.home>
	<20170223030647.GB4015@pxdev.xzpeter.org>
	<7cd743a2-b4c2-1d96-892e-c3a7db07da16@redhat.com>
	<20170223081616.GI4015@pxdev.xzpeter.org>
	<52e4d43f-c51f-0ac5-7409-f3087f61f44e@redhat.com>
	<20170223083533.17899e2f@t450s.home>
	<d7bd30e6-c166-24c8-3cf2-31bb0d4f6525@redhat.com>
	<20170309172619-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <344eccb6-336a-23a2-cc2d-5505ac304a12@redhat.com>
Date: Thu, 9 Mar 2017 16:34:11 +0100
MIME-Version: 1.0
In-Reply-To: <20170309172619-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] intel_iommu: make sure its init before PCI
 dev
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Alex Williamson <alex.williamson@redhat.com>, Marcel Apfelbaum <marcel@redhat.com>, yi.l.liu@intel.com, qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, Jintack Lim <jintack@cs.columbia.edu>



On 09/03/2017 16:29, Michael S. Tsirkin wrote:
>> If VFIO had an iommu property, to be used like "-device
>> intel_iommu,id=iommu0 -device vfio-pci,iommu=iommu0", It could tell VFIO
>> to use separate containers and also ensure proper ordering of command
>> line arguments.
>
> Lots of guests can't handle arbitrary stuff like this though.
> Normally IOMMU attaches to a bus and that's the only bus it can
> handle and that's the only IOMMU that can handle the devices
> on this bus.
> 
> It's a fact of life that not all hardware dependencies are in a form of
> a bus-device relashionship, while modelling it as a bus internally might
> be feasible exposing that to users seems risky and confusing as that's
> our artifact.

I'm not saying it's a bus.

But it's pretty common to have multiple IOMMUs for one bus.  A
relatively common case is to have one for the graphics card and one for
everything else, if I'm not mistaken.

Paolo
