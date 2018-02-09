Received: from eggs.gnu.org ([2001:4830:134:3::10]:55025)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ek4Ff-0001po-T8
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:41:48 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <paolo.bonzini@gmail.com>) id 1ek4Fb-0001c9-1U
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:41:47 -0500
Received: from mail-wr0-x241.google.com ([2a00:1450:400c:c0c::241]:37465)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <paolo.bonzini@gmail.com>)
	id 1ek4Fa-0001bj-Qf
	for qemu-devel@nongnu.org; Fri, 09 Feb 2018 03:41:42 -0500
Received: by mail-wr0-x241.google.com with SMTP id k32so862818wrk.4
	for <qemu-devel@nongnu.org>; Fri, 09 Feb 2018 00:41:42 -0800 (PST)
Sender: Paolo Bonzini <paolo.bonzini@gmail.com>
References: <1518083060-5881-1-git-send-email-wanpengli@tencent.com>
	<20180208181207.GB13981@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fcb084ce-1615-f100-4137-e0fa46098d7b@redhat.com>
Date: Fri, 9 Feb 2018 09:41:41 +0100
MIME-Version: 1.0
In-Reply-To: <20180208181207.GB13981@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Eduardo Habkost <ehabkost@redhat.com>, Wanpeng Li <kernellwp@gmail.com>
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, =?UTF-8?B?UmFkaW0gS3LEjW3DocWZ?= <rkrcmar@redhat.com>

On 08/02/2018 19:12, Eduardo Habkost wrote:
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

I think because it can be added independent of KVM_GET_SUPPORTED_CPUID.

Paolo
