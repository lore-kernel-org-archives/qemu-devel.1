Received: from eggs.gnu.org ([2001:4830:134:3::10]:42699)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJyPF-0006Xl-Iu
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:11:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1eJyPB-0008Q8-JU
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:11:49 -0500
Received: from mx1.redhat.com ([209.132.183.28]:46416)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1eJyPB-0008PF-Cw
	for qemu-devel@nongnu.org; Wed, 29 Nov 2017 04:11:45 -0500
References: <1511859789-43680-1-git-send-email-arei.gonglei@huawei.com>
	<1511859789-43680-4-git-send-email-arei.gonglei@huawei.com>
	<6635d6fc-b924-b558-0fff-120a55ef81e9@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA4A7DC2@DGGEMA505-MBS.china.huawei.com>
	<b98e2b09-35e7-47c2-b49f-982a09804b4f@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA4A7E32@DGGEMA505-MBS.china.huawei.com>
	<3f0ed9b0-ff77-bb0f-c868-609abf0826b2@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA4A8D54@DGGEMA505-MBS.china.huawei.com>
	<20171129060910-mutt-send-email-mst@kernel.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <f06f4d8c-9dfb-1ce2-e3a8-d298573377f7@redhat.com>
Date: Wed, 29 Nov 2017 10:11:35 +0100
MIME-Version: 1.0
In-Reply-To: <20171129060910-mutt-send-email-mst@kernel.org>
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
To: "Michael S. Tsirkin" <mst@redhat.com>, "Gonglei (Arei)" <arei.gonglei@huawei.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>, "Zhoujian (jay)" <jianjay.zhou@huawei.com>, "pasic@linux.vnet.ibm.com" <pasic@linux.vnet.ibm.com>, longpeng <longpeng2@huawei.com>, "xin.zeng@intel.com" <xin.zeng@intel.com>, "roy.fan.zhang@intel.com" <roy.fan.zhang@intel.com>, "jianfeng.tan@intel.com" <jianfeng.tan@intel.com>

On 29/11/2017 05:10, Michael S. Tsirkin wrote:
>> " Interrupt mode for vhost-user is still not supported in current 
>> implementation. But we are evaluating the necessity now.
> 
> That's more or less a spec violation. Guest must get interrupts
> if it does not disable them. And it must notify host
> if host does not disable notifications.

I understood that as "the vhost-user server is always using poll mode
for the virtqueues" and cannot use e.g. ioeventfds.

Thanks,

Paolo
