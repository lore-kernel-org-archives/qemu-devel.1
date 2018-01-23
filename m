Received: from eggs.gnu.org ([2001:4830:134:3::10]:39718)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1edw3W-0001wV-Ox
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:43:55 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1edw3T-0005SB-MN
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:43:54 -0500
Received: from mga07.intel.com ([134.134.136.100]:49386)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1edw3T-0005Qa-Ba
	for qemu-devel@nongnu.org; Tue, 23 Jan 2018 05:43:51 -0500
Message-ID: <5A67127A.5060600@intel.com>
Date: Tue, 23 Jan 2018 18:46:18 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20180119130653.24044-1-stefanha@redhat.com>
	<9048a120-a3be-404d-e977-39f40b4d4561@redhat.com>
	<20180122121751.GD31621@stefanha-x1.localdomain>
In-Reply-To: <20180122121751.GD31621@stefanha-x1.localdomain>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [RFC 0/2] virtio-vhost-user: add virtio-vhost-user
 device
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>, Jason Wang <jasowang@redhat.com>
Cc: qemu-devel@nongnu.org, mst@redhat.com, zhiyong.yang@intel.com, Maxime Coquelin <maxime.coquelin@redhat.com>

On 01/22/2018 08:17 PM, Stefan Hajnoczi wrote:
> On Mon, Jan 22, 2018 at 11:33:46AM +0800, Jason Wang wrote:
>> On 2018年01月19日 21:06, Stefan Hajnoczi wrote:
>>
>> Probably not for the following cases:
>>
>> 1) kick/call
> I disagree here because kick/call is actually very efficient!
>
> VM1's irqfd is the ioeventfd for VM2.  When VM2 writes to the ioeventfd
> there is a single lightweight vmexit which injects an interrupt into
> VM1.  QEMU is not involved and the host kernel scheduler is not involved
> so this is a low-latency operation.
>
> I haven't tested this yet but the ioeventfd code looks like this will
> work.


This have been tested in vhost-pci v2 patches which worked with with a 
kernel driver. It worked pretty well.

>> Btw, it's better to have some early numbers, e.g what testpmd reports during
>> forwarding.
> I need to rely on others to do this (and many other things!) because
> virtio-vhost-user isn't the focus of my work.
>
> These patches were written to demonstrate my suggestions for vhost-pci.
> They were written at work but also on weekends, early mornings, and late
> nights to avoid delaying Wei and Zhiyong's vhost-pci work too much.
>
> If this approach has merit then I hope others will take over and I'll
> play a smaller role addressing some of the todo items and cleanups.

Thanks again for the great effort, your implementation looks nice.

If we finally decide to go with the virtio-vhost-user approach, I think 
zhiyong and I can help take over the work to continue, too.

I'm still thinking about solutions to the two issues that I shared 
yesterday - it should be like a normal PCI device, and if we unbind its 
driver, and bind back, it should also work.


Best,
Wei
