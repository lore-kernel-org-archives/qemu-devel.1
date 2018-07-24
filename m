Received: from eggs.gnu.org ([2001:4830:134:3::10]:55212)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fhyUC-0006N1-Tz
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:40:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1fhyU8-000771-I7
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:40:24 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:56586 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1fhyU8-00076b-8y
	for qemu-devel@nongnu.org; Tue, 24 Jul 2018 10:40:20 -0400
References: <1519726932-13833-1-git-send-email-liran.alon@oracle.com>
	<20180724112911.GA2314@work-vm>
	<20180724143914.GE3896@localhost.localdomain>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <baabc7d2-3945-b016-4f93-7a67a9842bf1@redhat.com>
Date: Tue, 24 Jul 2018 16:40:15 +0200
MIME-Version: 1.0
In-Reply-To: <20180724143914.GE3896@localhost.localdomain>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] KVM: x86: Add support for save/load
 MSR_SMI_COUNT
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Cc: Liran Alon <liran.alon@oracle.com>, qemu-devel@nongnu.org, mtosatti@redhat.com, rth@twiddle.net, kvm@vger.kernel.org, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, quintela@redhat.com

On 24/07/2018 16:39, Eduardo Habkost wrote:
> On Tue, Jul 24, 2018 at 12:29:12PM +0100, Dr. David Alan Gilbert wrote:
>> * Liran Alon (liran.alon@oracle.com) wrote:
>>> This MSR returns the number of #SMIs that occurred on
>>> CPU since boot.
>>>
>>> KVM commit 52797bf9a875 ("KVM: x86: Add emulation of MSR_SMI_COUNT")
>>> introduced support for emulating this MSR.
>>>
>>> This commit adds support for QEMU to save/load this
>>> MSR for migration purposes.
>>>
>>> Signed-off-by: Liran Alon <liran.alon@oracle.com>
>>> Reviewed-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
>>
>> Note this breaks 2.12->2.11 migration if SMM is enabled
>> with a:
>>
>> qemu-system-x86_64: error while loading state for instance 0x0 of device 'cpu'
> 
> Right, the MSR can't be enabled unconditionally.
> 
> It looks like there's no CPUID bit for reporting the MSR as
> available?  How exactly would guests know if the MSR is really
> safe to use?

As far as we know, the only guest that uses it is ESX.  Like most other
MSRs, the guest should in general be ready for it to cause a #GP fault.

Paolo
