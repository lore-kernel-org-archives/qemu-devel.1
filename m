Received: from eggs.gnu.org ([2001:4830:134:3::10]:42697)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJdOb-0002p5-Q3
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:45:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJdOY-0006gn-LV
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:45:45 -0500
Received: from mx1.redhat.com ([209.132.183.28]:56142)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eJdOY-0006gY-FW
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 05:45:42 -0500
References: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
	<1511859789-43680-4-git-send-email-arei.gonglei@huawei.com>
	<6635d6fc-b924-b558-0fff-120a55ef81e9@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA4A7DC2@DGGEMA505-MBS.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <b98e2b09-35e7-47c2-b49f-982a09804b4f@redhat.com>
Date: Tue, 28 Nov 2017 11:45:31 +0100
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA4A7DC2@DGGEMA505-MBS.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
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
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "mst@redhat.com" <mst@redhat.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>

On 28/11/2017 11:43, Gonglei (Arei) wrote:
>> As far as I understand, VIRTIO_CRYPTO_CIPHER_CREATE_SESSION is called as
>> a result of sending a message on the control virtqueue.
>
> VIRTIO_CRYPTO_CIPHER_CREATE_SESSION is a message type of control queue,
> Means creating a session for next crypto requests.

Ok, so the message does have the same meaning as the control queue
message.  Thanks for confirming.

>> Why can't vhost-user also process create/destroy session messages on the
>> control virtqueue, instead of having device-specific messages in the
>> protocol?
>
> You mean we can share control virtqueue to DPDK as well? Like data queues?

I don't know :) but why not?

Thanks,

Paolo
