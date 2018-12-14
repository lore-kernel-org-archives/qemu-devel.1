Received: from eggs.gnu.org ([2001:4830:134:3::10]:43487)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jiangyiwen@huawei.com>) id 1gXk2I-0006ec-6o
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:45:35 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jiangyiwen@huawei.com>) id 1gXk2B-0004O7-Fv
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:45:32 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:3113 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jiangyiwen@huawei.com>)
	id 1gXk2B-0004Lj-0Q
	for qemu-devel@nongnu.org; Fri, 14 Dec 2018 04:45:27 -0500
References: <5C10DAE9.3010605@huawei.com>
	<20181212081902-mutt-send-email-mst@kernel.org>
	<5C11D19C.4010007@huawei.com>
	<20181213153434.GL23318@stefanha-x1.localdomain>
From: jiangyiwen <jiangyiwen@huawei.com>
Message-ID: <5C137BAE.9090805@huawei.com>
Date: Fri, 14 Dec 2018 17:45:18 +0800
MIME-Version: 1.0
In-Reply-To: <20181213153434.GL23318@stefanha-x1.localdomain>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] vhost-vsock: support parse mergeable
 feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, qemu-devel@nongnu.org

On 2018/12/13 23:34, Stefan Hajnoczi wrote:
> On Thu, Dec 13, 2018 at 11:27:24AM +0800, jiangyiwen wrote:
>> On 2018/12/12 21:19, Michael S. Tsirkin wrote:
>>> On Wed, Dec 12, 2018 at 05:54:49PM +0800, jiangyiwen wrote:
>>>> Currently vhost-vsock doesn't have any feature bits, so it
>>>> don't support parse mergeable rx buffer feature. And the
>>>> feature is support in another series of patches named
>>>> "VSOCK: support mergeable rx buffer in vhost-vsock".
>>>>
>>>> So we neet to support parse mergeable feature in vhost-vsock
>>>> if above patches are merged.
>>>>
>>>> Signed-off-by: Yiwen Jiang <jiangyiwen@huawei.com>
>>>
>>> OK but what does it do? this just defines the feature bit ...
>>> Also pls copy virtio-dev whenever you change the host/guest
>>> interface.
>>>
>>> Thanks!
>>>
>>
>> Hi Michael,
>>
>> In my opinion, for vhost device, device feature bits need to be
>> intersected between vhost and qemu, so I add mergeable rx buffer feature
>> into vdev->host_features, and then intersected with vhost_dev features.
>>
>> Later if someone want to add new feature, it can use virtio_add_feature()
>> in vhost_vsock_get_features().
> 
> Hi Yiwen,
> I think Michael's comment is about documenting the behavior of the new
> feature bit.
> 
> Each change to a VIRTIO device host<->guest interface needs to be
> discussed in the VIRTIO community <virtio-dev@lists.oasis-open.org> and
> described in a patch to the VIRTIO specification
> (https://github.com/oasis-tcs/virtio-spec/).
> 
> Stefan
> 

Hi Stefan,

Ok, I will fix it in the later version, I have not sent
a series of patches before, thank you for your help.

Thanks again,
Yiwen.
