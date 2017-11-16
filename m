Received: from eggs.gnu.org ([2001:4830:134:3::10]:41727)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFGFI-0002Mz-Mw
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:14:05 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eFGFD-0001CV-Pb
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:14:04 -0500
Received: from mx1.redhat.com ([209.132.183.28]:34266)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eFGFD-00018k-Jh
	for qemu-devel@nongnu.org; Thu, 16 Nov 2017 04:13:59 -0500
References: <CACnE9pzALCNV62Jmo4SUawD=pQiPFENWR_BwK3=+yY7V1U54Ag@mail.gmail.com>
	<cd39d029-48f9-20d6-cc19-ff87a45240ab@redhat.com>
	<CACnE9pzm5zabq=nJhqB4LHzSXk2vDGiAN5SbJco3ZfGkfRbW-g@mail.gmail.com>
	<5A0D27D8.6050506@huawei.com>
	<2e0ddd76-3903-d715-9a86-73f1286322e7@redhat.com>
	<33183CC9F5247A488A2544077AF19020DA46E2A6@DGGEMA505-MBS.china.huawei.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <6aaaca2b-81ef-a1c1-4745-830d008b3770@redhat.com>
Date: Thu, 16 Nov 2017 17:13:37 +0800
MIME-Version: 1.0
In-Reply-To: <33183CC9F5247A488A2544077AF19020DA46E2A6@DGGEMA505-MBS.china.huawei.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Question] why need to start all queues in
 vhost_net_start
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>, longpeng <longpeng2@huawei.com>, "mst@redhat.com" <mst@redhat.com>
Cc: "Longpeng(Mike)" <longpeng.mike@gmail.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Wangjing (King, Euler)" <king.wang@huawei.com>, "Huangweidong (C)" <weidong.huang@huawei.com>, "stefanha@redhat.com" <stefanha@redhat.com>



On 2017=E5=B9=B411=E6=9C=8816=E6=97=A5 17:01, Gonglei (Arei) wrote:
> No, Windows guest + vhost-user/DPDK.
>
> BTW pls see virtio spec in :
>
> "If VIRTIO_NET_F_MQ is negotiated, each of receiveq1. . .receiveqN that=
 will be used SHOULD be populated
> with receive buffers."
>
> It is not mandatory that all queues must be initialized.

I think not, since it said we should fill receive buffers for each queue=20
which means we should initialize all queues. May Michael can clarify on=20
this.

Thanks

>
> Thanks,
> -Gonglei
>
