Received: from eggs.gnu.org ([2001:4830:134:3::10]:58182)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dZVZA-0001q6-Bl
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 01:06:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <marcel@redhat.com>) id 1dZVZ7-0006Sb-5A
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 01:06:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:60082)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <marcel@redhat.com>) id 1dZVZ6-0006SS-Us
	for qemu-devel@nongnu.org; Mon, 24 Jul 2017 01:05:57 -0400
References: <20170724014741.GA16720@yangzhon-Virtual>
From: Marcel Apfelbaum <marcel@redhat.com>
Message-ID: <9f3c0221-6d62-7d5e-0f86-9cd839e2c34e@redhat.com>
Date: Mon, 24 Jul 2017 08:05:54 +0300
MIME-Version: 1.0
In-Reply-To: <20170724014741.GA16720@yangzhon-Virtual>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] About virtio device hotplug in Q35!
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Zhong Yang <yang.zhong@intel.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com

On 24/07/2017 4:47, Zhong Yang wrote:
> Hello all,
> 

Hi,

> When we did virtio device hotplug in Q35 platform, which always failed in hotplug.
> 

Can we please see the QEMU command line and the description
of the hotplug steps?

> Would you please tell me how to configure VM to make virtio device hotplug work in Q35 platform?  Many thanks!
> 

The virtio devices can be hot-plugged into PCIe Root Ports:
HMP example:
  Start the VM with several PCIe Root Ports:
    <qemu-bin> -M q35 -monitor stdio \
                      -device pcie-root-port,id=rp1 \
                      -device pcie-root port,id=rp2 \
                      ...
  Then from QEMU's hmp:
      device-add virtio-net-pci,id=n1,bus=rp1
      ...


I hope it helps,
Marcel


> 
> Regards,
> 
> Yang zhong
> 
