Received: from eggs.gnu.org ([2001:4830:134:3::10]:33181)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1ekA2Y-00005z-Em
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:52:39 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1ekA2X-0001GQ-Au
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:52:38 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:46030)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1ekA2X-0001Fg-56
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 09:52:37 -0500
Received: by mail-oi0-x243.google.com with SMTP id c189so6275140oib.12
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 06:52:36 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180209143117.GL13981@localhost.localdomain>
References: <1518185725-69559-1-git-send-email-wanpengli@tencent.com>
	<20180209143117.GL13981@localhost.localdomain>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Fri, 9 Feb 2018 22:52:36 +0800
Message-ID: <CANRm+Cw1RcLyU5Lh_NmaPo=wTqYeifAHdM9_53xZwbUp1E2vFg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Subject: Re: [Qemu-devel] [PATCH v2] target-i386: add KVM_HINTS_DEDICATED
 performance hint
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>
Cc: kvm <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>, "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>

2018-02-09 22:31 GMT+08:00 Eduardo Habkost <ehabkost@redhat.com>:
> On Fri, Feb 09, 2018 at 06:15:25AM -0800, Wanpeng Li wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> Add KVM_HINTS_DEDICATED performance hint, guest checks this feature bit
>> to determine if they run on dedicated vCPUs, allowing optimizations such
>> as usage of qspinlocks.
>>
>> Cc: Paolo Bonzini <pbonzini@redhat.com>
>> Cc: Radim Kr=C4=8Dm=C3=A1=C5=99 <rkrcmar@redhat.com>
>> Cc: Eduardo Habkost <ehabkost@redhat.com>
>> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> [...]
>> +    [FEAT_KVM_HINTS] =3D {
>> +        .feat_names =3D {
>> +            "hint-dedicated", NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +            NULL, NULL, NULL, NULL,
>> +        },
>> +        .cpuid_eax =3D KVM_CPUID_FEATURES, .cpuid_reg =3D R_EDX,
>> +        .tcg_features =3D TCG_KVM_FEATURES,
>> +    },
>
> Do you have a pointer to the KVM patch that adds this bit to
> Documentation/virtual/kvm/cpuid.txt?  I would like to wait until
> the KVM CPUID docs are updated before applying the patch to QEMU.

Yeah, please refer to https://lkml.org/lkml/2018/2/9/476

Regards,
Wanpeng Li
