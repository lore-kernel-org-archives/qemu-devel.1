Received: from eggs.gnu.org ([2001:4830:134:3::10]:36844)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fFjSn-00046s-BA
	for qemu-devel@nongnu.org; Mon, 07 May 2018 12:58:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fFjSk-0002mB-AN
	for qemu-devel@nongnu.org; Mon, 07 May 2018 12:58:13 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:53078 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fFjSk-0002lj-5N
	for qemu-devel@nongnu.org; Mon, 07 May 2018 12:58:10 -0400
References: <20180411115036.31832-1-vkuznets@redhat.com>
	<877eomtssk.fsf@vitty.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <2cb9716d-e5bf-7bd7-e217-8c2d090a2564@redhat.com>
Date: Mon, 7 May 2018 18:57:58 +0200
MIME-Version: 1.0
In-Reply-To: <877eomtssk.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v5 0/1] i386/kvm: TSC page clocksource for
 Hyper-V-on-KVM fixes
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>, qemu-devel@nongnu.org
Cc: Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

On 02/05/2018 09:34, Vitaly Kuznetsov wrote:
> Vitaly Kuznetsov <vkuznets@redhat.com> writes:
> 
>> Changes since v4:
>> - Rebase on top of Roman's patches.
>> - Drop PATCH2 as it is no longer needed (after adding explicit
>>   hv_frequencies).
>>
>> Previously, Ladi was working on enabling TSC page clocksource for nested
>> Hyper-V-on-KVM workloads. He found out that if Hyper-V frequency MSRs are
>> exposed to L1 as well as INVTSC flag Hyper-V enables TSC page clocksource
>> to its guests. Qemu doesn't pass INVTSC by default as it is a migration
>> blocker.
>>
>> I found out there's a different way to make Hyper-V like us: expose
>> Reenlightenment MSRs to it. KVM doesn't fully support the feature as
>> we're still unable to migrate nested environments but rudimentary support
>> we have there is enough.
>>
>> Enable Hyper-V reenlightenment MSRs to make things work.
>>
> 
> Gentle ping :-)
> 
> With Roman's Reviewed-by:, is there anything else needed from me to get
> this accepted?
> 
> Thanks!
> 

Queued, thanks.

Paolo
