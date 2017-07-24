Received: from eggs.gnu.org ([2001:4830:134:3::10]:57535)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dZbWJ-0000DN-9x
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:27:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <yang.zhong@intel.com>) id 1dZbWF-00037v-Ug
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:27:27 -0400
Received: from mga06.intel.com ([134.134.136.31]:2274)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <yang.zhong@intel.com>)
	id 1dZbWF-00037e-N0
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 07:27:23 -0400
Date: Mon, 24 Jul 2017 19:26:48 +0800
From: Zhong Yang <yang.zhong@intel.com>
Message-ID: <20170724112648.GB16720@yangzhon-Virtual>
References: <20170724014741.GA16720@yangzhon-Virtual>
	<9f3c0221-6d62-7d5e-0f86-9cd839e2c34e@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9f3c0221-6d62-7d5e-0f86-9cd839e2c34e@redhat.com>
Subject: Re: [Qemu-devel] About virtio device hotplug in Q35!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Marcel Apfelbaum <marcel@redhat.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, anthony.xu@intel.com

On Mon, Jul 24, 2017 at 08:05:54AM +0300, Marcel Apfelbaum wrote:

+ Anthony

> On 24/07/2017 4:47, Zhong Yang wrote:
> >Hello all,
> >
> 
> Hi,
> 
> >When we did virtio device hotplug in Q35 platform, which always failed in hotplug.
> >
> 
> Can we please see the QEMU command line and the description
> of the hotplug steps?
> 
> >Would you please tell me how to configure VM to make virtio device hotplug work in Q35 platform?  Many thanks!
> >
> 
> The virtio devices can be hot-plugged into PCIe Root Ports:
> HMP example:
>  Start the VM with several PCIe Root Ports:
>    <qemu-bin> -M q35 -monitor stdio \
>                      -device pcie-root-port,id=rp1 \
>                      -device pcie-root port,id=rp2 \
>                      ...
>  Then from QEMU's hmp:
>      device-add virtio-net-pci,id=n1,bus=rp1
>      ...
> 
> 
> I hope it helps,
> Marcel
> 
> 
> >
> >Regards,
> >
> >Yang zhong
> >
