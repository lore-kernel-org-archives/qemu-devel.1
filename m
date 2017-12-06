Received: from eggs.gnu.org ([2001:4830:134:3::10]:40819)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eMWyh-0007ZH-Ni
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:31:00 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eMWyc-00086Y-Vx
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:30:59 -0500
Received: from mga04.intel.com ([192.55.52.120]:42463)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eMWyc-00084x-Me
	for qemu-devel@nongnu.org; Wed, 06 Dec 2017 05:30:54 -0500
Message-ID: <5A27C752.2050906@intel.com>
Date: Wed, 06 Dec 2017 18:32:50 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <1512444796-30615-1-git-send-email-wei.w.wang@intel.com>
	<1512444796-30615-6-git-send-email-wei.w.wang@intel.com>
	<20171205160020.GH31150@stefanha-x1.localdomain>
In-Reply-To: <20171205160020.GH31150@stefanha-x1.localdomain>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] Re: [PATCH v3 5/7] vhost-user:
 VHOST_USER_SET_VHOST_PCI msg
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: virtio-dev@lists.oasis-open.org, qemu-devel@nongnu.org, mst@redhat.com, marcandre.lureau@redhat.com, jasowang@redhat.com, pbonzini@redhat.com, jan.kiszka@siemens.com, avi.cohen@huawei.com, zhiyong.yang@intel.com

On 12/06/2017 12:00 AM, Stefan Hajnoczi wrote:
> On Tue, Dec 05, 2017 at 11:33:14AM +0800, Wei Wang wrote:
>> Add a new vhost-uer protocol msg, VHOST_USER_SET_VHOST_PCI. This msg is
>> used to signal the vhost-pci device to start/stop working.
>>
>> Signed-off-by: Wei Wang <wei.w.wang@intel.com>
>> ---
>>   hw/net/vhost_net.c                | 37 +++++++++++++++++++++++++++++++++++++
>>   hw/virtio/vhost-pci-slave.c       |  2 +-
>>   hw/virtio/vhost-user.c            | 17 +++++++++++++++++
>>   hw/virtio/vhost.c                 |  7 +++++++
>>   include/hw/virtio/vhost-backend.h |  2 ++
>>   include/hw/virtio/vhost-user.h    |  2 ++
>>   include/hw/virtio/vhost.h         |  2 ++
>>   include/net/vhost_net.h           |  2 ++
>>   8 files changed, 70 insertions(+), 1 deletion(-)
> New protocol messages must be documented in docs/interop/vhost-user.txt.

OK, I'll add it to the doc after the discussion.

>
> Why is a new message needed?  I'm not sure why it is specific to
> vhost-pci.

Yes, it might be useful for other vhost-user slave implementations. 
Probably we can name it "VHOST_USER_SET_SLAVE"?
The message is used to "link up" or "link down" the slave device. For 
example, when virtio-net leaves, it sends a "VHOST_USER_SET_SLAVE" msg 
to the salve to link down the slave device.
(a similar msg is VHOST_USER_SET_VRING_ENABLE, but that is for virtqueue 
enable/disable, not for a device level enable/disable)

Best,
Wei
