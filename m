Received: from eggs.gnu.org ([2001:4830:134:3::10]:59698)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHY9T-0005LX-89
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:50:11 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1gHY9P-00023o-1H
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:50:03 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45054)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1gHY9M-0001Vk-BT
	for qemu-devel@nongnu.org; Tue, 30 Oct 2018 13:49:57 -0400
References: <20181022165506.30332-1-vkuznets@redhat.com>
	<20181022165506.30332-3-vkuznets@redhat.com>
	<20181023125131.GA14424@rkaganb>
	<871s87fi6s.fsf@vitty.brq.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4f2e9c57-b0f6-fdff-42c8-2953d0ef3832@redhat.com>
Date: Tue, 30 Oct 2018 18:49:14 +0100
MIME-Version: 1.0
In-Reply-To: <871s87fi6s.fsf@vitty.brq.redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 2/2] x86: hv_evmcs CPU flag support
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, Roman Kagan <rkagan@virtuozzo.com>

On 30/10/2018 18:38, Vitaly Kuznetsov wrote:
> Roman Kagan <rkagan@virtuozzo.com> writes:
> 
>> On Mon, Oct 22, 2018 at 06:55:06PM +0200, Vitaly Kuznetsov wrote:
>>> Adds a new CPU flag to enable the Enlightened VMCS KVM feature.
>>> QEMU enables KVM_CAP_HYPERV_ENLIGHTENED_VMCS and gets back the
>>> version to be advertised in lower 16 bits of CPUID.0x4000000A:EAX.
>>>
>>> Suggested-by: Ladi Prosek <lprosek@redhat.com>
>>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>>> ---
>>> Changes since v1:
>>> - Throw away HV_CPUID_MIN_NESTED.
>>> - Create zeroed 0x40000006-0x40000009 CPUID leaves.
>>> ---
>>>  target/i386/cpu.c          |  1 +
>>>  target/i386/cpu.h          |  1 +
>>>  target/i386/hyperv-proto.h |  2 ++
>>>  target/i386/kvm.c          | 30 ++++++++++++++++++++++++++++--
>>>  4 files changed, 32 insertions(+), 2 deletions(-)
>>
>> Reviewed-by: Roman Kagan <rkagan@virtuozzo.com>
> 
> With soft freeze date being today, would it still be possible to squeeze
> this one in?

Yes, I'm going to send a pull request in a matter of minutes.  I'm not
sure if technically it should have been sent yesterday, but I suppose we
can have some leeway because of the conference last week.

Paolo
