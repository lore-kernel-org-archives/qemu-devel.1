Return-Path: <SRS0=UKTp=CS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E34AC43461
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:21:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BFD40207DE
	for <qemu-devel@archiver.kernel.org>; Wed,  9 Sep 2020 07:21:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ej4cS59q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD40207DE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kFuQE-00031M-Ie
	for qemu-devel@archiver.kernel.org; Wed, 09 Sep 2020 03:21:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48788)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFuPQ-0002ai-Mk
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 03:20:48 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:48393
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1kFuPO-00056t-KP
 for qemu-devel@nongnu.org; Wed, 09 Sep 2020 03:20:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599636045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Rgr2tldACa50bpQV7nzGXs8dm+k7ReejMEjqpEm6mYI=;
 b=Ej4cS59qiIoUi8xGELg5T+kLaIwXhrQbV183lbQFNoguGOatrhEaOLjJuSi/43MuGSL/yB
 H5ZHQfKcZQmi+jDmnDIsJI5hyoRSeH9gz5oWzscWbEb2KFJFD4SrlUItiH/lZ+hbEYvu8h
 mELFrkOdSxn3fPfjTWYXoj1QlcLtBD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-6tuZ1oNhNF24w4XjnT5siQ-1; Wed, 09 Sep 2020 03:20:41 -0400
X-MC-Unique: 6tuZ1oNhNF24w4XjnT5siQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ECC5E107B277;
 Wed,  9 Sep 2020 07:20:38 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-234.ams2.redhat.com [10.36.112.234])
 by smtp.corp.redhat.com (Postfix) with ESMTP id B99E860C0F;
 Wed,  9 Sep 2020 07:20:35 +0000 (UTC)
Subject: Re: [PATCH V2 for-5.2] hw/null-machine: Add the kvm_type() hook for
 MIPS
To: chen huacai <zltjiangshi@gmail.com>
References: <1598256668-12131-1-git-send-email-chenhc@lemote.com>
 <caa3c014-ba68-0875-4dd5-faed9282ca95@redhat.com>
 <CABDp7VoRCMsW6b17XEek3-EJLHgY=bCXnx5B1ZWCOkHq0aasxw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Message-ID: <e3c09cb0-1cc5-2fb3-8dc7-d2a1aed74c04@redhat.com>
Date: Wed, 9 Sep 2020 09:20:34 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CABDp7VoRCMsW6b17XEek3-EJLHgY=bCXnx5B1ZWCOkHq0aasxw@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=thuth@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Received-SPF: pass client-ip=205.139.110.61; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/09 03:20:45
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 NICE_REPLY_A=-1.626, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Aleksandar Rikalo <aleksandar.rikalo@syrmia.com>,
 Huacai Chen <chenhuacai@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-level <qemu-devel@nongnu.org>,
 Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, David Gibson <dgibson@redhat.com>,
 Huacai Chen <chenhc@lemote.com>, Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 09/09/2020 04.57, chen huacai wrote:
> Hi, all,
> 
> On Wed, Sep 9, 2020 at 1:25 AM Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 24/08/2020 10.11, Huacai Chen wrote:
>>> MIPS has two types of KVM: TE & VZ, and TE is the default type. Now,
>>> libvirt uses a null-machine to detect the kvm capability. In the MIPS
>>> case, it will return "KVM not supported" on a VZ platform by default.
>>> So, add the kvm_type() hook to the null-machine.
>>>
>>> This seems not a very good solution, but I cannot do it better now.
>>
>> This is still ugly. Why do the other architectures do not have the
>> same problem? Let's see... in kvm-all.c, we have:
>>
>>     int type = 0;
>>     [...]
>>     kvm_type = qemu_opt_get(qemu_get_machine_opts(), "kvm-type");
>>     if (mc->kvm_type) {
>>         type = mc->kvm_type(ms, kvm_type);
>>     } else if (kvm_type) {
>>         ret = -EINVAL;
>>         fprintf(stderr, "Invalid argument kvm-type=%s\n", kvm_type);
>>         goto err;
>>     }
>>
>>     do {
>>         ret = kvm_ioctl(s, KVM_CREATE_VM, type);
>>     } while (ret == -EINTR);
>>
>> Thus the KVM_CREATE_VM ioctl is likely called with type = 0 in this
>> case (i.e. when libvirt probes with the "null"-machine).
>>
>> Now let's have a look at the kernel. The "type" parameter is passed
>> there to the architecture specific function kvm_arch_init_vm().
>> For powerpc, this looks like:
>>
>>         if (type == 0) {
>>                 if (kvmppc_hv_ops)
>>                         kvm_ops = kvmppc_hv_ops;
>>                 else
>>                         kvm_ops = kvmppc_pr_ops;
>>                 if (!kvm_ops)
>>                         goto err_out;
>>         } else  if (type == KVM_VM_PPC_HV) {
>>                 if (!kvmppc_hv_ops)
>>                         goto err_out;
>>                 kvm_ops = kvmppc_hv_ops;
>>         } else if (type == KVM_VM_PPC_PR) {
>>                 if (!kvmppc_pr_ops)
>>                         goto err_out;
>>                 kvm_ops = kvmppc_pr_ops;
>>         } else
>>                 goto err_out;
>>
>> That means for type == 0, it automatically detects the best
>> kvm-type.
>>
>> For mips, this function looks like this:
>>
>>         switch (type) {
>> #ifdef CONFIG_KVM_MIPS_VZ
>>         case KVM_VM_MIPS_VZ:
>> #else
>>         case KVM_VM_MIPS_TE:
>> #endif
>>                 break;
>>         default:
>>                 /* Unsupported KVM type */
>>                 return -EINVAL;
>>         };
>>
>> That means, for type == 0, it returns -EINVAL here!
>>
>> Looking at the API docu in Documentation/virt/kvm/api.rst
>> the description of the type parameter is quite sparse, but it
>> says:
>>
>>  "You probably want to use 0 as machine type."
>>
>> So I think this is a bug in the implementation of KVM in the
>> mips kernel code. The kvm_arch_init_vm() in the mips code should
>> do the same as on powerpc, and use the best available KVM type
>> there instead of returning EINVAL. Once that is fixed there,
>> you don't need this patch here for QEMU anymore.
> Yes, PPC use a good method, because it can use 0 as "automatic"
> #define KVM_VM_PPC_HV 1
> #define KVM_VM_PPC_PR 2
> 
> Unfortunately, MIPS cannot do like this because it define 0 as "TE":
> #define KVM_VM_MIPS_TE          0
> #define KVM_VM_MIPS_VZ          1
> 
> So, it cannot be solved in kernel side, unless changing the definition
> of TE/VZ, but I think changing their definition is also unacceptable.

Ouch, ok, now I understood the problem. That sounds like a really bad
decision on the kernel side.

But I think you could at least try to get it fixed on the kernel side:
Propose a patch to rename KVM_VM_MIPS_TE to KVM_VM_MIPS_DEFAULT and use
2 as new value for TE. The code that handles the default 0 case should
then prefer TE over VZ, so that old userspace applications that provide
0 will continue to work as they did before, so I hope that the change is
acceptable by the kernel folks. You should add a remark to the patch
description that 0 is the established default value for probing in the
QEMU/libvirt stack and that your patch is required on the kernel side to
avoid ugly hacks in QEMU userspace code.

If they still reject your patch, I guess we have to bite the bullet and
add your patch here...

Thanks,
 Thomas


