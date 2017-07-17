Received: from eggs.gnu.org ([2001:4830:134:3::10]:39858)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dWzqN-0000sX-Tt
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:49:24 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <guangrong.xiao@gmail.com>) id 1dWzqJ-0006RC-2p
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:49:23 -0400
Received: from mail-pg0-x244.google.com ([2607:f8b0:400e:c05::244]:34262)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <guangrong.xiao@gmail.com>)
	id 1dWzqI-0006ND-SN
	for qemu-devel@nongnu.org; Mon, 17 Jul 2017 02:49:19 -0400
Received: by mail-pg0-x244.google.com with SMTP id v190so4608527pgv.1
	for <qemu-devel@nongnu.org>; Sun, 16 Jul 2017 23:49:17 -0700 (PDT)
References: <8E78D212B8C25246BE4CE7EA0E645FE501066958@dggemi503-mbs.china.huawei.com>
From: Xiao Guangrong <guangrong.xiao@gmail.com>
Message-ID: <d521a766-26c9-a5ab-3d80-9da47a2bc89e@gmail.com>
Date: Mon, 17 Jul 2017 14:49:23 +0800
MIME-Version: 1.0
In-Reply-To: <8E78D212B8C25246BE4CE7EA0E645FE501066958@dggemi503-mbs.china.huawei.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: "Xulei (Stone)" <stone.xulei@huawei.com>, seabios <seabios@seabios.org>, qemu-devel <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>
Cc: "Huangweidong (C)" <weidong.huang@huawei.com>, mst <mst@redhat.com>, jasowang <jasowang@redhat.com>, xiaoguangrong <xiaoguangrong@tencent.com>, kevin <kevin@koconnor.net>, kraxel <kraxel@redhat.com>, pbonzini <pbonzini@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>



On 07/17/2017 11:13 AM, Xulei (Stone) wrote:

>                              |--virtio_queue_empty
> 
> Then, kmod falls in infinite loop in handle EPT_MISCONFIG.
> As far as i know, when kvm enters guest after handling EPT_MISCONFIG, seabios should return
> from mmio write and wait for virtio backend(qemu) to handle this mmio writing.
> What puzzles me:
> 1) i can not understand why kvm runs in infinite loop and seabios does not return from writew.

 From the trace in L1 guest, it did not hang in KVM, as it went into guest mode normally.

> 2) kvm nested kvm is ok. But vmware nested kvm is not ok. This problem has anything related
>      with vmware?
> 

It is the issue in vmware, i guess the RIP register is not handled correctly.
BTW, does kvm unit tests run well on nested vmware?
