Received: from eggs.gnu.org ([2001:4830:134:3::10]:45112)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEzFy-0005zi-S5
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:05:44 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jasowang@redhat.com>) id 1eEzFt-0001hr-B4
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:05:38 -0500
Received: from mx1.redhat.com ([209.132.183.28]:55174)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jasowang@redhat.com>) id 1eEzFt-0001gt-4P
	for qemu-devel@nongnu.org; Wed, 15 Nov 2017 10:05:33 -0500
References: <CACnE9pzALCNV62Jmo4SUawD=pQiPFENWR_BwK3=+yY7V1U54Ag@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cd39d029-48f9-20d6-cc19-ff87a45240ab@redhat.com>
Date: Wed, 15 Nov 2017 23:05:21 +0800
MIME-Version: 1.0
In-Reply-To: <CACnE9pzALCNV62Jmo4SUawD=pQiPFENWR_BwK3=+yY7V1U54Ag@mail.gmail.com>
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
To: "Longpeng(Mike)" <longpeng.mike@gmail.com>, qemu-devel@nongnu.org
Cc: "Longpeng(Mike)" <longpeng2@huawei.com>, arei.gonglei@huawei.com, king.wang@huawei.com, weidong.huang@huawei.com, stefanha@redhat.com, mst@redhat.com



On 2017=E5=B9=B411=E6=9C=8815=E6=97=A5 22:55, Longpeng(Mike) wrote:
> Hi guys,
>
> We got a BUG report from our testers yesterday, the testing scenario wa=
s
> migrating a VM (Windows guest, *4 vcpus*, 4GB, vhost-user net: *7 queue=
s*).
>
> We found the cause reason, and we'll report the BUG or send a fix patch
> to upstream if necessary( we haven't test the upstream yet, sorry... ).

Could you explain this a little bit more?

>
> We want to know why the vhost_net_start() must start *total queues* ( i=
n our
> VM there're 7 queues ) but not *the queues that current used* ( in our =
VM, guest
> only uses the first 4 queues because it's limited by the number of vcpu=
s) ?
>
> Looking forward to your help, thx :)

Since the codes have been there for years and works well for kernel=20
datapath. You should really explain what's wrong.

Thanks
