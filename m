Received: from eggs.gnu.org ([2001:4830:134:3::10]:56790)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1ewr0V-0002KJ-AY
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:11:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1ewr0O-0007sj-Sl
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:10:59 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:58720 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1ewr0O-0007rP-CW
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:10:52 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20180312151233.16565-1-vkuznets@redhat.com>
	<20180312151233.16565-2-vkuznets@redhat.com>
	<435d80c2-ec07-9032-8d07-cac15fc437db@redhat.com>
Date: Fri, 16 Mar 2018 16:10:42 +0100
In-Reply-To: <435d80c2-ec07-9032-8d07-cac15fc437db@redhat.com> (Paolo
	Bonzini's message of "Fri, 16 Mar 2018 15:48:02 +0100")
Message-ID: <87a7v89hu5.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 1/2] i386/kvm: add support for Hyper-V
 reenlightenment MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 12/03/2018 16:12, Vitaly Kuznetsov wrote:

[snip]

>> @@ -2294,6 +2318,15 @@ static int kvm_get_msrs(X86CPU *cpu)
>>              env->msr_hv_stimer_count[(index - HV_X64_MSR_STIMER0_COUNT)/2] =
>>                                  msrs[i].data;
>>              break;
>> +        case HV_X64_MSR_REENLIGHTENMENT_CONTROL:
>> +            env->msr_hv_reenlightenment_control = msrs[i].data;
>> +            break;
>> +        case HV_X64_MSR_TSC_EMULATION_CONTROL:
>> +            env->msr_hv_tsc_emulation_control = msrs[i].data;
>> +            break;
>> +        case HV_X64_MSR_TSC_EMULATION_STATUS:
>> +            env->msr_hv_tsc_emulation_status = msrs[i].data;
>> +            break;
>>          case MSR_MTRRdefType:
>>              env->mtrr_deftype = msrs[i].data;
>>              break;
>> 
>
> Doesn't this also need a new subsection in target/i386/machine.c?
>

Actually yes, missed that completely! Thanks!

-- 
  Vitaly
