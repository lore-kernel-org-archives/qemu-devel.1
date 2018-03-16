Received: from eggs.gnu.org ([2001:4830:134:3::10]:35374)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewrHZ-0001QW-NE
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:28:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1ewrHU-0001TY-Pz
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:28:37 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:48162 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1ewrHU-0001TI-KS
	for qemu-devel@nongnu.org; Fri, 16 Mar 2018 11:28:32 -0400
References: <20180312151233.16565-1-vkuznets@redhat.com>
	<20180312151233.16565-3-vkuznets@redhat.com>
	<7d1afa27-9653-75dc-ebfe-8633b93f1ce6@redhat.com>
	<87efkk9i2j.fsf@vitty.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cd71ecd6-7a3c-05e5-7854-d71763cbc4c2@redhat.com>
Date: Fri, 16 Mar 2018 16:28:20 +0100
MIME-Version: 1.0
In-Reply-To: <87efkk9i2j.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>, qemu-devel@nongnu.org

On 16/03/2018 16:05, Vitaly Kuznetsov wrote:
>>>  
>>> -        if (has_msr_hv_frequencies && tsc_is_stable_and_known(env)) {
>>> +        if (has_msr_hv_frequencies && env->tsc_khz) {
>> Should this be
>>
>> ((env->tsc_khz && has_msr_hv_reenlightenment) ||
>>  tsc_is_stable_and_known(env))
>>
>> so that you don't regress on older kernels?
>>
> I don't actually see where the regression might come from: frequency
> MSRs are supported regardless or reenlightenment/invtsc and there's
> nothing wrong with exposing them but I may be missing something..

On older kernel without re-enlightenment support, you don't want to
expose the frequency MSRs unless invtsc is on, right?

Paolo
