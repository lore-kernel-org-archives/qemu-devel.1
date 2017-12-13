Received: from eggs.gnu.org ([2001:4830:134:3::10]:55212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ePEv9-0000H5-DA
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:50:32 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <maxime.coquelin@redhat.com>) id 1ePEv4-0002Zc-FB
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:50:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:60698)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <maxime.coquelin@redhat.com>)
	id 1ePEv3-0002Yp-P6
	for qemu-devel@nongnu.org; Wed, 13 Dec 2017 16:50:26 -0500
References: <CAJSP0QX4V64OoU4-Dhb93MUZ9Rz0FPR-La5Xq4_yqGH7SG6PjQ@mail.gmail.com>
	<20171207213420-mutt-send-email-mst@kernel.org>
	<5A2A347B.9070006@intel.com>
	<CAJSP0QUAqCzFgVtM1cg_KybdyrZa_FRUHhDN7oLfRjZ2ZVkp4g@mail.gmail.com>
	<286AC319A985734F985F78AFA26841F73937E001@shsmsx102.ccr.corp.intel.com>
	<20171211111147.GF13593@stefanha-x1.localdomain>
	<286AC319A985734F985F78AFA26841F73937EEED@shsmsx102.ccr.corp.intel.com>
	<20171212101440.GB6985@stefanha-x1.localdomain>
	<5A30E0C1.3070905@intel.com>
	<20171213123521.GL16782@stefanha-x1.localdomain>
	<20171213165142-mutt-send-email-mst@kernel.org>
	<CAJSP0QWHJBL4APkeMt8-P8PFaPF=Vbi0NSnJtU7YX67fJrW=hw@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Message-ID: <825b8205-0b88-a198-b77d-63c8f2563c2e@redhat.com>
Date: Wed, 13 Dec 2017 22:50:11 +0100
MIME-Version: 1.0
In-Reply-To: <CAJSP0QWHJBL4APkeMt8-P8PFaPF=Vbi0NSnJtU7YX67fJrW=hw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [virtio-dev] [PATCH v3 0/7] Vhost-pci for inter-VM
 communication
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Wei Wang <wei.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>, "virtio-dev@lists.oasis-open.org" <virtio-dev@lists.oasis-open.org>, "Yang, Zhiyong" <zhiyong.yang@intel.com>, "jan.kiszka@siemens.com" <jan.kiszka@siemens.com>, "jasowang@redhat.com" <jasowang@redhat.com>, "avi.cohen@huawei.com" <avi.cohen@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "marcandre.lureau@redhat.com" <marcandre.lureau@redhat.com>

Hi Stefan,

On 12/13/2017 09:08 PM, Stefan Hajnoczi wrote:
> On Wed, Dec 13, 2017 at 3:01 PM, Michael S. Tsirkin <mst@redhat.com> wrote:
>> On Wed, Dec 13, 2017 at 12:35:21PM +0000, Stefan Hajnoczi wrote:
>>> I'm not saying that DPDK should use libvhost-user.  I'm saying that it's
>>> easy to add vfio vhost-pci support (for the PCI adapter I described) to
>>> DPDK.  This patch series would require writing a completely new slave
>>> for vhost-pci because the device interface is so different from
>>> vhost-user.
>>
>> The main question is how appropriate is the vhost user protocol
>> for passing to guests. And I am not sure at this point.
>>
>> Someone should go over vhost user messages and see whether they are safe
>> to pass to guest. If most are then we can try the transparent approach.
>> If most aren't then we can't and might as well use the proposed protocol
>> which at least has code behind it.
> 
> I have done that:
> 
...
>   * VHOST_USER_SET_MEM_TABLE
> 
>     Set up BARs before sending a VHOST_USER_SET_MEM_TABLE to the guest.

It would require to filter out userspace_addr from the payload not to
leak other QEMU process VAs to the guest.

Maxime
