Received: from eggs.gnu.org ([2001:4830:134:3::10]:51092)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJdva-0000KT-GI
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:19:51 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJdvV-0002mQ-IQ
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:19:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:58940)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eJdvV-0002lz-CJ
	for qemu-devel@nongnu.org; Tue, 28 Nov 2017 06:19:45 -0500
References: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
	<1511859789-43680-4-git-send-email-arei.gonglei@huawei.com>
	<6635d6fc-b924-b558-0fff-120a55ef81e9@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA4A7DC2@DGGEMA505-MBS.china.huawei.com>
	<b98e2b09-35e7-47c2-b49f-982a09804b4f@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA4A7E32@DGGEMA505-MBS.china.huawei.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <3f0ed9b0-ff77-bb0f-c868-609abf0826b2@redhat.com>
Date: Tue, 28 Nov 2017 12:19:35 +0100
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA4A7E32@DGGEMA505-MBS.china.huawei.com>
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

On 28/11/2017 12:06, Gonglei (Arei) wrote:
>>> You mean we can share control virtqueue to DPDK as well? Like data queues?
>> I don't know :) but why not?
>>
> Current there are two main reasons for this design:
> 
> 1) we should use another cpu to polling the control virtqueue, which is expensive.

IIRC DPDK also supports interrupt mode, doesn't it?  Is it possible to
do interrupt mode for some virtqueues and poll mode for others?

> 2) we should copy the logic of parsing control message to DPDK, which break
>  current layered architecture .

But isn't it already a layering violation that you're adding *some*
control messages to the vhost-user protocol?  I am not sure why only
these two are necessary.

Paolo

> I'm not sure if there are any other hidden issues for future scalability, such as
> using Qemu to manage some control messages, avoiding D-Dos attack etc.
> 
> Thanks,
> -Gonglei
