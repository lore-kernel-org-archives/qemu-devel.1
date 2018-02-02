Received: from eggs.gnu.org ([208.118.235.92]:60645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ehPpj-00071q-0q
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 20:09:09 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianjay.zhou@huawei.com>) id 1ehPoe-0008VE-ST
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 20:08:02 -0500
Received: from [45.249.212.35] (port=39624 helo=huawei.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianjay.zhou@huawei.com>)
	id 1ehPoe-0008MB-5J
	for qemu-devel@nongnu.org; Thu, 01 Feb 2018 20:06:56 -0500
References: <cover.1516538887.git.arei.gonglei@huawei.com>
	<B2D15215269B544CADD246097EACE7473AB6F5B2@DGGEMM505-MBS.china.huawei.com>
	<20180201190537-mutt-send-email-mst@kernel.org>
From: Jay Zhou <jianjay.zhou@huawei.com>
Message-ID: <5A73B97C.2080600@huawei.com>
Date: Fri, 2 Feb 2018 09:06:04 +0800
MIME-Version: 1.0
In-Reply-To: <20180201190537-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v6 0/4] cryptodev: add vhost support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "pbonzini@redhat.com" <pbonzini@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>


On 2018/2/2 1:06, Michael S. Tsirkin wrote:
> Yes, I plan to merge it in the next pull.
> Pls don't assume anything until it's merged upstream though,
> some issues surface late.
>

Okay, I see. Thanks for reviewing!

Regards,
Jay

> On Thu, Feb 01, 2018 at 11:29:15AM +0000, Zhoujian (jay) wrote:
>> Hi Michael,
>> I am wondering whether this version is OK for you?
>> Any comment will be appreciated, thanks.
>>
>> Regards,
>> Jay
>>
>>> -----Original Message-----
>>> From: Zhoujian (jay)
>>> Sent: Sunday, January 21, 2018 8:55 PM
>>> To: qemu-devel@nongnu.org
>>> Cc: mst@redhat.com; pbonzini@redhat.com; Huangweidong (C)
>>> <weidong.huang@huawei.com>; stefanha@redhat.com; Zhoujian (jay)
>>> <jianjay.zhou@huawei.com>; pasic@linux.vnet.ibm.com; longpeng
>>> <longpeng2@huawei.com>; xin.zeng@intel.com; roy.fan.zhang@intel.com; Gonglei
>>> (Arei) <arei.gonglei@huawei.com>; wangxin (U) <wangxinxin.wang@huawei.com>
>>> Subject: [PATCH v6 0/4] cryptodev: add vhost support
>>>
>>> From: Gonglei <arei.gonglei@huawei.com>
>>>
>>> I posted the RFC verion a few months ago for DPDK vhost-crypto implmention,
>>> and now it's time to send the formal version. Because we need an user space
>>> scheme for better performance.
>>>
>>> The vhost user crypto server side patches had been sent to DPDK community,
>>> pls see
>>>
>>> [RFC PATCH 0/6] lib/librte_vhost: introduce new vhost_user crypto backend
>>> support http://dpdk.org/ml/archives/dev/2017-November/081048.html
>>>
>>> You also can get virtio-crypto polling mode driver from:
>>>
>>> [PATCH] virtio: add new driver for crypto devices
>>> http://dpdk.org/ml/archives/dev/2017-November/081985.html
>>>
>>> v5 -> v6:
>>>    Fix compile error about backends/cryptodev-vhost-user.o and rebase on
>>>    the master
>>> v4 -> v5:
>>>    squash [PATCH v4 5/5] into previous patches [Michael]
>>> v3 -> v4:
>>>    "[PATCH v4 5/5] cryptodev-vhost-user: depend on CONFIG_VHOST_CRYPTO
>>>    and CONFIG_VHOST_USER" newly added to fix compilation dependency [Michael]
>>> v2 -> v3:
>>>    New added vhost user messages should be sent only when feature
>>>    has been successfully negotiated [Michael]
>>> v1 -> v2:
>>>    Fix compile error on mingw32
>>>
>>> Gonglei (4):
>>>    cryptodev: add vhost-user as a new cryptodev backend
>>>    cryptodev: add vhost support
>>>    cryptodev-vhost-user: add crypto session handler
>>>    cryptodev-vhost-user: set the key length
>>>
>>>   backends/Makefile.objs                |   6 +
>>>   backends/cryptodev-builtin.c          |   1 +
>>>   backends/cryptodev-vhost-user.c       | 379
>>> ++++++++++++++++++++++++++++++++++
>>>   backends/cryptodev-vhost.c            | 347 +++++++++++++++++++++++++++++++
>>>   configure                             |  15 ++
>>>   docs/interop/vhost-user.txt           |  26 +++
>>>   hw/virtio/Makefile.objs               |   2 +-
>>>   hw/virtio/vhost-user.c                | 104 ++++++++++
>>>   hw/virtio/virtio-crypto.c             |  70 +++++++
>>>   include/hw/virtio/vhost-backend.h     |   8 +
>>>   include/hw/virtio/virtio-crypto.h     |   1 +
>>>   include/sysemu/cryptodev-vhost-user.h |  47 +++++
>>>   include/sysemu/cryptodev-vhost.h      | 154 ++++++++++++++
>>>   include/sysemu/cryptodev.h            |   8 +
>>>   qemu-options.hx                       |  21 ++
>>>   vl.c                                  |   6 +
>>>   16 files changed, 1194 insertions(+), 1 deletion(-)  create mode 100644
>>> backends/cryptodev-vhost-user.c  create mode 100644 backends/cryptodev-
>>> vhost.c  create mode 100644 include/sysemu/cryptodev-vhost-user.h
>>>   create mode 100644 include/sysemu/cryptodev-vhost.h
>>>
>>> --
>>> 1.8.3.1
>>>
>
> .
>
