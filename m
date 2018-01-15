Received: from eggs.gnu.org ([2001:4830:134:3::10]:44158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eazeB-0004rT-KN
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:57:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eaze8-0004h3-JF
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:57:35 -0500
Received: from mga01.intel.com ([192.55.52.88]:30034)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eaze8-0004et-BX
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 02:57:32 -0500
Message-ID: <5A5C5F7D.8070403@intel.com>
Date: Mon, 15 Jan 2018 15:59:57 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20180110161438.GA28096@stefanha-x1.localdomain>	<dcb849d4-82fb-de8a-5e81-23d47026c9eb@redhat.com>	<20180111152345.GA7353@stefanha-x1.localdomain>	<86106573-422b-fe4c-ec15-dad0edf05880@redhat.com>	<20180112101807.GE7356@stefanha-x1.localdomain>
	<a45c1da8-03e8-140f-725c-af0f31e3da62@redhat.com>
In-Reply-To: <a45c1da8-03e8-140f-725c-af0f31e3da62@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] vhost-pci and virtio-vhost-user
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org

On 01/15/2018 02:56 PM, Jason Wang wrote:
>
>
> On 2018年01月12日 18:18, Stefan Hajnoczi wrote:
>>
>
> I just fail understand why we can't do software defined network or 
> storage with exist virtio device/drivers (or are there any 
> shortcomings that force us to invent new infrastructure).
>

Existing virtio-net works with a host central vSwitch, and it has the 
following disadvantages:
1) long code/data path;
2) poor scalability; and
3) host CPU sacrifice

Vhost-pci solves the above issues by providing a point-to-point 
communication between VMs. No matter how the control path would look 
like finally, the key point is that the data path is P2P between VMs.

Best,
Wei
