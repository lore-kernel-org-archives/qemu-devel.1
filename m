Received: from eggs.gnu.org ([2001:4830:134:3::10]:57805)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1f8blv-0002Bh-IU
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 21:20:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1f8blu-0003Fg-NM
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 21:20:31 -0400
Received: from mail-ot0-x22b.google.com ([2607:f8b0:4003:c0f::22b]:45868)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1f8blu-0003FU-HQ
	for qemu-devel@nongnu.org; Tue, 17 Apr 2018 21:20:30 -0400
Received: by mail-ot0-x22b.google.com with SMTP id w4-v6so112268ote.12
	for <qemu-devel@nongnu.org>; Tue, 17 Apr 2018 18:20:30 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20180417205913.GC29865@localhost.localdomain>
References: <1523953455-28053-1-git-send-email-wanpengli@tencent.com>
	<20180417205913.GC29865@localhost.localdomain>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Wed, 18 Apr 2018 09:20:29 +0800
Message-ID: <CANRm+CwWpVympddFxMjzjVytcEdKwTo=cxA0YzeceE36J4eomw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH RESEND v2] i386/kvm: add support for
 KVM_CAP_X86_DISABLE_EXITS
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>, kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

2018-04-18 4:59 GMT+08:00 Eduardo Habkost <ehabkost@redhat.com>:
> On Tue, Apr 17, 2018 at 01:24:15AM -0700, Wanpeng Li wrote:
[.../...]
>>
>> +    if (env->features[FEAT_KVM_HINTS] & KVM_HINTS_DEDICATED) {
>> +        int disable_exits = kvm_check_extension(cs->kvm_state, KVM_CAP_X86_DISABLE_EXITS);
>> +
>> +        if (disable_exits) {
>> +            disable_exits &= (KVM_X86_DISABLE_EXITS_MWAIT |
>> +                              KVM_X86_DISABLE_EXITS_HLT |
>> +                              KVM_X86_DISABLE_EXITS_PAUSE);
>> +            if (env->user_features[FEAT_KVM] & KVM_PV_UNHALT) {
>> +                disable_exits &= ~KVM_X86_DISABLE_EXITS_HLT;
>> +            }
>
> In the future, if we decide to enable kvm-pv-unhalt by default,
> should "-cpu ...,kvm-hint-dedicated=on" disable kvm-pv-unhalt
> automatically, or should we require an explicit
> "kvm-hint-dedicated=on,kvm-pv-unhalt=off" option?
>
> For today's defaults, this patch solves the problem, only one
> thing is missing before I give my R-b: we need to clearly
> document what exactly are the consequences and requirements of
> setting kvm-hint-dedicated=on (I'm not sure if the best place for
> this is qemu-options.hx, x86_cpu_list(), or somewhere else).

What's your opinion, Paolo?

Regards,
Wanpeng Li
