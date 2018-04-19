Received: from eggs.gnu.org ([2001:4830:134:3::10]:52305)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f9BoB-0007jU-JB
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:49:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1f9Bo5-0008Ot-NS
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:49:15 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:49784 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1f9Bo5-0008Gv-H5
	for qemu-devel@nongnu.org; Thu, 19 Apr 2018 11:49:09 -0400
References: <1523953455-28053-1-git-send-email-wanpengli@tencent.com>
	<20180417205913.GC29865@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <02887fa6-d7c8-bc39-6e65-3c3caec5b903@redhat.com>
Date: Thu, 19 Apr 2018 17:48:57 +0200
MIME-Version: 1.0
In-Reply-To: <20180417205913.GC29865@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
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
To: Eduardo Habkost <ehabkost@redhat.com>, Wanpeng Li <kernellwp@gmail.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

On 17/04/2018 22:59, Eduardo Habkost wrote:
>> +        if (disable_exits) {
>> +            disable_exits &=3D (KVM_X86_DISABLE_EXITS_MWAIT |
>> +                              KVM_X86_DISABLE_EXITS_HLT |
>> +                              KVM_X86_DISABLE_EXITS_PAUSE);
>> +            if (env->user_features[FEAT_KVM] & KVM_PV_UNHALT) {
>> +                disable_exits &=3D ~KVM_X86_DISABLE_EXITS_HLT;
>> +            }
>
> In the future, if we decide to enable kvm-pv-unhalt by default,
> should "-cpu ...,kvm-hint-dedicated=3Don" disable kvm-pv-unhalt
> automatically, or should we require an explicit
> "kvm-hint-dedicated=3Don,kvm-pv-unhalt=3Doff" option?

It should be automatic.

> For today's defaults, this patch solves the problem, only one
> thing is missing before I give my R-b: we need to clearly
> document what exactly are the consequences and requirements of
> setting kvm-hint-dedicated=3Don (I'm not sure if the best place for
> this is qemu-options.hx, x86_cpu_list(), or somewhere else).

I don't think we have a good place for this kind of documentation,
unfortunately.  Right now it is mentioned in
Documentation/virtual/kvm/cpuid.txt.

Paolo
