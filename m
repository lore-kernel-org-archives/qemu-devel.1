Received: from eggs.gnu.org ([2001:4830:134:3::10]:49900)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <stone.xulei@huawei.com>) id 1dX0Yj-0005vK-W6
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 03:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <stone.xulei@huawei.com>) id 1dX0Yf-00080Y-2y
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 03:35:14 -0400
Received: from szxga02-in.huawei.com ([45.249.212.188]:3968)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_ARCFOUR_SHA1:16) (Exim 4.71)
	(envelope-from <stone.xulei@huawei.com>) id 1dX0Ye-0007uy-GB
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 03:35:09 -0400
From: "Xulei (Stone)" <stone.xulei@huawei.com>
Date: Mon, 17 Jul 2017 07:34:35 +0000
Message-ID: <8E78D212B8C25246BE4CE7EA0E645FE501067051@dggemi503-mbs.china.huawei.com>
References: <8E78D212B8C25246BE4CE7EA0E645FE501066958@dggemi503-mbs.china.huawei.com>,
	<d521a766-26c9-a5ab-3d80-9da47a2bc89e@gmail.com>
Content-Language: zh-CN
MIME-Version: 1.0
Content-Type: text/plain; charset="Windows-1252"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [Question] Seabios HANGs when mmio wirte in a
 nested vmware host wtih virito-scsi controller
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Xiao Guangrong <guangrong.xiao@gmail.com>, "seabios@seabios.org" <seabios@seabios.org>, qemu-devel <qemu-devel@nongnu.org>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, mst <mst@redhat.com>, jasowang <jasowang@redhat.com>, xiaoguangrong <xiaoguangrong@tencent.com>, Kevin O'Connor <kevin@koconnor.net>, kraxel <kraxel@redhat.com>, Paolo
	Bonzini <pbonzini@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>


On 07/17/2017 11:13 AM, Xulei (Stone) wrote:

>>                              |--virtio_queue_empty
>>
>> Then, kmod falls in infinite loop in handle EPT_MISCONFIG.
>> As far as i know, when kvm enters guest after handling EPT_MISCONFIG, se=
abios should return
>> from mmio write and wait for virtio backend(qemu) to handle this mmio wr=
iting.
>> What puzzles me:
>> 1) i can not understand why kvm runs in infinite loop and seabios does n=
ot return from writew.

  >From the trace in L1 guest, it did not hang in KVM, as it went into gues=
t mode normally.

>> 2) kvm nested kvm is ok. But vmware nested kvm is not ok. This problem h=
as anything related
>>     with vmware?
>>

> It is the issue in vmware, i guess the RIP register is not handled correc=
tly.
> BTW, does kvm unit tests run well on nested vmware?


Sadly, kvm unit tests run fail on nested vmware and make the  CentOS 7.3(wi=
th kmod 4.4.11) crashed...
