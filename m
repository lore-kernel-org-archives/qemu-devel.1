Received: from eggs.gnu.org ([2001:4830:134:3::10]:38410)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1deix6-0004sk-Rb
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:24:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <lprosek@redhat.com>) id 1deix3-0006vP-HN
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:24:16 -0400
Received: from mail-ua0-f169.google.com ([209.85.217.169]:34684)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <lprosek@redhat.com>) id 1deix3-0006vC-Cg
	for qemu-devel@nongnu.org; Mon, 07 Aug 2017 10:24:13 -0400
Received: by mail-ua0-f169.google.com with SMTP id q25so2566837uah.1
	for <qemu-devel@nongnu.org>; Mon, 07 Aug 2017 07:24:12 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <940cc5b5-623d-9a47-47ce-72e84a93d952@redhat.com>
References: <20170807085703.32267-1-lprosek@redhat.com>
	<20170807085703.32267-2-lprosek@redhat.com>
	<940cc5b5-623d-9a47-47ce-72e84a93d952@redhat.com>
From: Ladi Prosek <lprosek@redhat.com>
Date: Mon, 7 Aug 2017 16:24:10 +0200
Message-ID: <CABdb735PDRbG9_0h+pgxBbjgHdAxhkGH8Gr-FTCWrTyGsaAguw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Subject: Re: [Qemu-devel] [PATCH v2 1/4] i386/kvm: use a switch statement
 for MSR detection
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: David Hildenbrand <david@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, KVM list <kvm@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Radim Krcmar <rkrcmar@redhat.com>

On Mon, Aug 7, 2017 at 4:19 PM, David Hildenbrand <david@redhat.com> wrote:
> On 07.08.2017 10:57, Ladi Prosek wrote:
>> Switch is easier on the eye and might lead to better codegen.
>>
>> Signed-off-by: Ladi Prosek <lprosek@redhat.com>
>> ---
>>  target/i386/kvm.c | 75 +++++++++++++++++++++++--------------------------------
>>  1 file changed, 31 insertions(+), 44 deletions(-)
>>
>> diff --git a/target/i386/kvm.c b/target/i386/kvm.c
>> index 6db7783..b14a0db 100644
>> --- a/target/i386/kvm.c
>> +++ b/target/i386/kvm.c
>> @@ -1081,65 +1081,52 @@ static int kvm_get_supported_msrs(KVMState *s)
>>              int i;
>>
>>              for (i = 0; i < kvm_msr_list->nmsrs; i++) {
>> -                if (kvm_msr_list->indices[i] == MSR_STAR) {
>> +                switch (kvm_msr_list->indices[i]) {
>> +                case MSR_STAR:
>>                      has_msr_star = true;
>> -                    continue;
>> -                }
>> -                if (kvm_msr_list->indices[i] == MSR_VM_HSAVE_PA) {
>> +                    break;
>> +                case MSR_VM_HSAVE_PA:
>>                      has_msr_hsave_pa = true;
>> -                    continue;
>> -                }
>> -                if (kvm_msr_list->indices[i] == MSR_TSC_AUX) {
>> +                    break;
>> +                case MSR_TSC_AUX:
>>                      has_msr_tsc_aux = true;
>> -                    continue;
>> -                }
>> -                if (kvm_msr_list->indices[i] == MSR_TSC_ADJUST) {
>> +                    break;
>> +                case MSR_TSC_ADJUST:
>>                      has_msr_tsc_adjust = true;
>> -                    continue;
>> -                }
>> -                if (kvm_msr_list->indices[i] == MSR_IA32_TSCDEADLINE) {
>> +                    break;
>> +                case MSR_IA32_TSCDEADLINE:
>>                      has_msr_tsc_deadline = true;
>> -                    continue;
>> -                }
>> -                if (kvm_msr_list->indices[i] == MSR_IA32_SMBASE) {
>> +                    break;
>> +                case MSR_IA32_SMBASE:
>>                      has_msr_smbase = true;
>> -                    continue;
>> -                }
>> -                if (kvm_msr_list->indices[i] == MSR_IA32_MISC_ENABLE) {
>> +                    break;
>> +                case MSR_IA32_MISC_ENABLE:
>>                      has_msr_misc_enable = true;
>> -                    continue;
>> -                }
>> -                if (kvm_msr_list->indices[i] == MSR_IA32_BNDCFGS) {
>> +                    break;
>> +                case MSR_IA32_BNDCFGS:
>>                      has_msr_bndcfgs = true;
>> -                    continue;
>> -                }
>> -                if (kvm_msr_list->indices[i] == MSR_IA32_XSS) {
>> +                    break;
>> +                case MSR_IA32_XSS:
>>                      has_msr_xss = true;
>> -                    continue;
>> -                }
>> -                if (kvm_msr_list->indices[i] == HV_X64_MSR_CRASH_CTL) {
>> +                    break;;
>> +                case HV_X64_MSR_CRASH_CTL:
>>                      has_msr_hv_crash = true;
>> -                    continue;
>> -                }
>> -                if (kvm_msr_list->indices[i] == HV_X64_MSR_RESET) {
>> +                    break;
>> +                case HV_X64_MSR_RESET:
>>                      has_msr_hv_reset = true;
>> -                    continue;
>> -                }
>> -                if (kvm_msr_list->indices[i] == HV_X64_MSR_VP_INDEX) {
>> +                    break;
>> +                case HV_X64_MSR_VP_INDEX:
>>                      has_msr_hv_vpindex = true;
>> -                    continue;
>> -                }
>> -                if (kvm_msr_list->indices[i] == HV_X64_MSR_VP_RUNTIME) {
>> +                    break;
>> +                case HV_X64_MSR_VP_RUNTIME:
>>                      has_msr_hv_runtime = true;
>> -                    continue;
>> -                }
>> -                if (kvm_msr_list->indices[i] == HV_X64_MSR_SCONTROL) {
>> +                    break;
>> +                case HV_X64_MSR_SCONTROL:
>>                      has_msr_hv_synic = true;
>> -                    continue;
>> -                }
>> -                if (kvm_msr_list->indices[i] == HV_X64_MSR_STIMER0_CONFIG) {
>> +                    break;
>> +                case HV_X64_MSR_STIMER0_CONFIG:
>>                      has_msr_hv_stimer = true;
>> -                    continue;
>> +                    break;
>>                  }
>>              }
>>          }
>>
>
> Think you forgot to add my r-b.

Oops, sorry about that!

> --
>
> Thanks,
>
> David
