Received: from eggs.gnu.org ([2001:4830:134:3::10]:42229)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1eJzUd-0005CW-FG
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:21:28 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jianfeng.tan@intel.com>) id 1eJzUY-0002lj-Jj
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:21:27 -0500
Received: from mga01.intel.com ([192.55.52.88]:15563)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jianfeng.tan@intel.com>)
	id 1eJzUY-0002kv-9i
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 05:21:22 -0500
References: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
	<1511859789-43680-4-git-send-email-arei.gonglei@huawei.com>
	<6635d6fc-b924-b558-0fff-120a55ef81e9@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA4A7DC2@DGGEMA505-MBS.china.huawei.com>
	<b98e2b09-35e7-47c2-b49f-982a09804b4f@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA4A7E32@DGGEMA505-MBS.china.huawei.com>
	<3f0ed9b0-ff77-bb0f-c868-609abf0826b2@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA4A8D54@DGGEMA505-MBS.china.huawei.com>
	<20171129060910-mutt-send-email-mst@kernel.org>
	<f06f4d8c-9dfb-1ce2-e3a8-d298573377f7@redhat.com>
From: "Tan, Jianfeng" <jianfeng.tan@intel.com>
Message-ID: <d43f0189-41ae-3573-38ea-f13452d7d5f3@intel.com>
Date: Wed, 29 Nov 2017 18:21:17 +0800
MIME-Version: 1.0
In-Reply-To: <f06f4d8c-9dfb-1ce2-e3a8-d298573377f7@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH 3/4] cryptodev-vhost-user: add crypto
 session handler
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>



On 11/29/2017 5:11 PM, Paolo Bonzini wrote:
> On 29/11/2017 05:10, Michael S. Tsirkin wrote:
>>> " Interrupt mode for vhost-user is still not supported in current
>>> implementation. But we are evaluating the necessity now.
>> That's more or less a spec violation. Guest must get interrupts
>> if it does not disable them. And it must notify host
>> if host does not disable notifications.

By that, I mean the transmission from virtio to vhost, if virtio is not 
actively sending packets, at vhost side, we can stop polling from that 
vhost port (i.e., virtio); if VM wants to send packets, besides putting 
packets on virtqueue, it also kicks the backend through pio/mmio.

So no need to modify spec.

> I understood that as "the vhost-user server is always using poll mode
> for the virtqueues" and cannot use e.g. ioeventfds.

We can change to work like this: stop polling, and wait for the eventfd, 
and then get back to polling.

Thanks,
Jianfeng

>
> Thanks,
>
> Paolo
