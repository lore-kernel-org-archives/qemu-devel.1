Received: from eggs.gnu.org ([2001:4830:134:3::10]:56051)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eb2Ci-0005Tr-52
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:41:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <wei.w.wang@intel.com>) id 1eb2Cc-0007Bl-Ju
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:41:24 -0500
Received: from mga14.intel.com ([192.55.52.115]:17182)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <wei.w.wang@intel.com>)
	id 1eb2Cc-00079C-9b
	for qemu-devel@nongnu.org; Mon, 15 Jan 2018 05:41:18 -0500
Message-ID: <5A5C85DD.10705@intel.com>
Date: Mon, 15 Jan 2018 18:43:41 +0800
From: Wei Wang <wei.w.wang@intel.com>
MIME-Version: 1.0
References: <20180110161438.GA28096@stefanha-x1.localdomain>
	<dcb849d4-82fb-de8a-5e81-23d47026c9eb@redhat.com>
	<20180111152345.GA7353@stefanha-x1.localdomain>
	<86106573-422b-fe4c-ec15-dad0edf05880@redhat.com>
	<20180112101807.GE7356@stefanha-x1.localdomain>
	<a45c1da8-03e8-140f-725c-af0f31e3da62@redhat.com>
	<5A5C5F7D.8070403@intel.com>
	<6b618d06-0891-fb3b-b845-8beae5649b22@redhat.com>
In-Reply-To: <6b618d06-0891-fb3b-b845-8beae5649b22@redhat.com>
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

On 01/15/2018 04:34 PM, Jason Wang wrote:
>
>
> On 2018年01月15日 15:59, Wei Wang wrote:
>> On 01/15/2018 02:56 PM, Jason Wang wrote:
>>>
>>>
>>> On 2018年01月12日 18:18, Stefan Hajnoczi wrote:
>>>>
>>>
>>> I just fail understand why we can't do software defined network or 
>>> storage with exist virtio device/drivers (or are there any 
>>> shortcomings that force us to invent new infrastructure).
>>>
>>
>> Existing virtio-net works with a host central vSwitch, and it has the 
>> following disadvantages:
>> 1) long code/data path;
>> 2) poor scalability; and
>> 3) host CPU sacrifice
>
> Please show me the numbers.

Sure. For 64B packet transmission between two VMs: vhost-user reports 
~6.8Mpps, and vhost-pci reports ~11Mpps, which is ~1.62x faster.


>
>>
>> Vhost-pci solves the above issues by providing a point-to-point 
>> communication between VMs. No matter how the control path would look 
>> like finally, the key point is that the data path is P2P between VMs.
>>
>> Best,
>> Wei
>>
>>
>
> Well, I think I've pointed out several times in the replies of 
> previous versions. Both vhost-pci-net and virtio-net is an ethernet 
> device, which is not tied to a central vswitch for sure. There're just 
> too many methods or tricks which can be used to build a point to point 
> data path.


Could you please show an existing example that makes virtio-net work 
without a host vswitch/bridge?
Could you also share other p2p data path solutions that you have in 
mind? Thanks.


Best,
Wei
