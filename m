Received: from eggs.gnu.org ([2001:4830:134:3::10]:48193)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1d8oSv-0002MU-J8
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:49:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1d8oSr-0008Te-1m
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:49:13 -0400
Received: from mail-oi0-x235.google.com ([2607:f8b0:4003:c06::235]:35484)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1d8oSq-0008TH-Sx
	for qemu-devel@nongnu.org; Thu, 11 May 2017 09:49:08 -0400
Received: by mail-oi0-x235.google.com with SMTP id l18so30578375oig.2
	for <qemu-devel@nongnu.org>; Thu, 11 May 2017 06:49:08 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CANRm+CzvNpLGqH5KuqqO7Wh7UabSkMBbxuTymbM0CZPgpQOwCg@mail.gmail.com>
References: <830bfc39-56c7-a901-9ebb-77d6e7a5614c@huawei.com>
	<874lxeovrg.fsf@secure.mitica>
	<7cd332ec-48d4-1feb-12e2-97b50b04e028@huawei.com>
	<20170424164244.GJ2362@work-vm>
	<B2D15215269B544CADD246097EACE747395AD759@dggeml511-mbx.china.huawei.com>
	<85e3a0dd-20c8-8ff2-37ce-bfdf543e7787@redhat.com>
	<CANRm+CzvNpLGqH5KuqqO7Wh7UabSkMBbxuTymbM0CZPgpQOwCg@mail.gmail.com>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Thu, 11 May 2017 21:49:07 +0800
Message-ID: <CANRm+CwvYa01CLChSOGjG6P0q2_Zybov3ZMSULsCGH5GtmRy8A@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] About QEMU BQL and dirty log switch in Migration
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Zhoujian (jay)" <jianjay.zhou@huawei.com>
Cc: "Dr. David Alan Gilbert" <dgilbert@redhat.com>, yanghongyang <yanghongyang@huawei.com>, "quintela@redhat.com" <quintela@redhat.com>, "wangxin (U)" <wangxinxin.wang@huawei.com>, "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Gonglei (Arei)" <arei.gonglei@huawei.com>, Huangzhichao <huangzhichao@huawei.com>, Zhanghailiang <zhang.zhanghailiang@huawei.com>, "Herongguang (Stephen)" <herongguang.he@huawei.com>, Xiao Guangrong <xiaoguangrong@tencent.com>, Paolo Bonzini <pbonzini@redhat.com>

2017-05-11 21:43 GMT+08:00 Wanpeng Li <kernellwp@gmail.com>:
> 2017-05-11 20:24 GMT+08:00 Paolo Bonzini <pbonzini@redhat.com>:
>>
>>
>> On 11/05/2017 14:07, Zhoujian (jay) wrote:
>>> -        * Scan sptes if dirty logging has been stopped, dropping those
>>> -        * which can be collapsed into a single large-page spte.  Later
>>> -        * page faults will create the large-page sptes.
>>> +        * Reset each vcpu's mmu, then page faults will create the large-page
>>> +        * sptes later.
>>>          */
>>>         if ((change != KVM_MR_DELETE) &&
>>>                 (old->flags & KVM_MEM_LOG_DIRTY_PAGES) &&
>>> -               !(new->flags & KVM_MEM_LOG_DIRTY_PAGES))
>>> -               kvm_mmu_zap_collapsible_sptes(kvm, new);
>
> This is an unlikely branch(unless guest live migration fails and
> continue to run on the source machine) instead of hot path, do you
> have any performance number for your real workloads?

I find the original discussion by google.
https://lists.nongnu.org/archive/html/qemu-devel/2017-04/msg04143.html
You will not go to this branch if the guest live migration
successfully.

Regards,
Wanpeng Li
