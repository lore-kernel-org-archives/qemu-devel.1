Received: from eggs.gnu.org ([2001:4830:134:3::10]:53892)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1ewqvV-0007fA-0E
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:05:49 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <vkuznets@redhat.com>) id 1ewqvP-0003wg-GE
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:05:48 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:39544 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <vkuznets@redhat.com>) id 1ewqvP-0003t7-Cj
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:05:43 -0400
From: Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20180312151233.16565-1-vkuznets@redhat.com>
	<20180312151233.16565-3-vkuznets@redhat.com>
	<7d1afa27-9653-75dc-ebfe-8633b93f1ce6@redhat.com>
Date: Fri, 16 Mar 2018 16:05:40 +0100
In-Reply-To: <7d1afa27-9653-75dc-ebfe-8633b93f1ce6@redhat.com> (Paolo
	Bonzini's message of "Fri, 16 Mar 2018 15:49:30 +0100")
Message-ID: <87efkk9i2j.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Subject: Re: [Qemu-devel] [PATCH 2/2] i386/kvm: lower requirements for
 Hyper-V frequency MSRs exposure
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
>>  
>> -        if (has_msr_hv_frequencies && tsc_is_stable_and_known(env)) {
>> +        if (has_msr_hv_frequencies && env->tsc_khz) {
>
> Should this be
>
> ((env->tsc_khz && has_msr_hv_reenlightenment) ||
>  tsc_is_stable_and_known(env))
>
> so that you don't regress on older kernels?
>

I don't actually see where the regression might come from: frequency
MSRs are supported regardless or reenlightenment/invtsc and there's
nothing wrong with exposing them but I may be missing something..

-- 
  Vitaly
