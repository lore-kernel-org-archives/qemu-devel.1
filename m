Received: from eggs.gnu.org ([2001:4830:134:3::10]:36521)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eJlLo-0004fn-1K
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 14:15:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <mst@redhat.com>) id 1eJlLj-0000Gt-N3
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 14:15:23 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34918)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <mst@redhat.com>) id 1eJlLj-0000F5-Ah
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 14:15:19 -0500
Date: Tue, 28 Nov 2017 21:15:09 +0200
From: "Michael S. Tsirkin" <mst@redhat.com>
Message-ID: <20171128210805-mutt-send-email-mst@kernel.org>
References: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
	<1511859789-43680-4-git-send-email-arei.gonglei@huawei.com>
	<6635d6fc-b924-b558-0fff-120a55ef81e9@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA4A7DC2@DGGEMA505-MBS.china.huawei.com>
	<b98e2b09-35e7-47c2-b49f-982a09804b4f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b98e2b09-35e7-47c2-b49f-982a09804b4f@redhat.com>
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
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Gonglei (Arei)" <arei.gonglei@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>

On Tue, Nov 28, 2017 at 11:45:31AM +0100, Paolo Bonzini wrote:
> On 28/11/2017 11:43, Gonglei (Arei) wrote:
> >> As far as I understand, VIRTIO_CRYPTO_CIPHER_CREATE_SESSION is called as
> >> a result of sending a message on the control virtqueue.
> >
> > VIRTIO_CRYPTO_CIPHER_CREATE_SESSION is a message type of control queue,
> > Means creating a session for next crypto requests.
> 
> Ok, so the message does have the same meaning as the control queue
> message.  Thanks for confirming.
> 
> >> Why can't vhost-user also process create/destroy session messages on the
> >> control virtqueue, instead of having device-specific messages in the
> >> protocol?
> >
> > You mean we can share control virtqueue to DPDK as well? Like data queues?
> 
> I don't know :) but why not?
> 
> Thanks,
> 
> Paolo

There are advantages to parsing the control queue in QEMU, e.g. it then
has visibility into which sessions exist.

It's a question of what works and what are the driver's expectations.

E.g. for network guests tend to poll the control queue so handling
that queue in QEMU helps us to keep guest going even if
backend disconnects.

-- 
MST
