Received: from eggs.gnu.org ([2001:4830:134:3::10]:41172)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1ejzCe-0008Kd-BB
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 22:18:21 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kernellwp@gmail.com>) id 1ejzCd-000377-AH
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 22:18:20 -0500
Received: from mail-oi0-x243.google.com ([2607:f8b0:4003:c06::243]:40853)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kernellwp@gmail.com>) id 1ejzCd-00036d-5P
	for qemu-devel@nongnu.org; Thu, 08 Feb 2018 22:18:19 -0500
Received: by mail-oi0-x243.google.com with SMTP id 8so5068558oix.7
	for <qemu-devel@nongnu.org>; Thu, 08 Feb 2018 19:18:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20180208181207.GB13981@localhost.localdomain>
References: <1518083060-5881-1-git-send-email-wanpengli@tencent.com>
	<20180208181207.GB13981@localhost.localdomain>
From: Wanpeng Li <kernellwp@gmail.com>
Date: Fri, 9 Feb 2018 11:18:18 +0800
Message-ID: <CANRm+CwbM2u42bPz9C5fw0Lum5qsLZqg=0u2GXbLTwc0P7E76g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH] target-i386: adds PV_DEDICATED hint CPUID
 feature bit
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

2018-02-09 2:12 GMT+08:00 Eduardo Habkost <ehabkost@redhat.com>:
> On Thu, Feb 08, 2018 at 05:44:20PM +0800, Wanpeng Li wrote:
>> From: Wanpeng Li <wanpengli@tencent.com>
>>
>> Add PV_DEDICATED hint cpuid feature bit.
>>
> [...]
>> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
>> index d70954b..cf48931 100644
>> --- a/target/i386/cpu.c
>> +++ b/target/i386/cpu.c
>> @@ -4076,6 +4076,9 @@ static int x86_cpu_filter_features(X86CPU *cpu)
>>              x86_cpu_get_supported_feature_word(w, false);
>>          uint32_t requested_features = env->features[w];
>>          env->features[w] &= host_feat;
>> +        if (cpu->pv_dedicated && (w == FEAT_KVM)) {
>> +            env->features[w] |= CPUID_PV_DEDICATED;
>> +        }
>
> Why do this trick here instead of just adding "pv-dedicated" to
> feature_word_info[FEAT_KVM].feat_names?

Actually this hint doesn't depend on KVM, just qemu command-line gives
a hint and then guest kernel can recognize it. Is there a nicer
proposal in qemu? Paolo?

Regards,
Wanpeng Li
