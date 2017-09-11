Received: from eggs.gnu.org ([2001:4830:134:3::10]:50788)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drLOi-0001VW-Qj
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:52:57 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1drLOd-0000pd-RT
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:52:56 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38192)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1drLOd-0000pC-LM
	for qemu-devel@nongnu.org; Mon, 11 Sep 2017 05:52:51 -0400
References: <20170807085703.32267-1-lprosek@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <cb1570cc-0dfa-026b-1ade-44aa64d3b746@redhat.com>
Date: Mon, 11 Sep 2017 11:52:43 +0200
MIME-Version: 1.0
In-Reply-To: <20170807085703.32267-1-lprosek@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH v2 0/4] i386/kvm: advertise Hyper-V
 frequency MSRs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Ladi Prosek <lprosek@redhat.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org
Cc: mtosatti@redhat.com, david@redhat.com, rkrcmar@redhat.com

On 07/08/2017 10:56, Ladi Prosek wrote:
> This is the QEMU part of the changes required for nested Hyper-V to read
> timestamps with RDTSC + TSC page. Without exposing the frequency MSRs,
> Windows with the Hyper-V role enabled use the much slower
> HV_X64_MSR_TIME_REF_COUNT (0x40000020) RDMSR to read timestamps.
> 
> The new registers are exposed only if the TSC frequency is stable across
> migration and known, as suggested by Paolo.
> 
> v1->v2:
> * deleted an extra empty line in patch 1
> * added patch 3 introducing a helper function for the "TSC is stable and
>   known" check (David)
> 
> Ladi Prosek (4):
>   i386/kvm: use a switch statement for MSR detection
>   i386/kvm: set tsc_khz before configuring Hyper-V CPUID
>   i386/kvm: introduce tsc_is_stable_and_known()
>   i386/kvm: advertise Hyper-V frequency MSRs
> 
>  target/i386/kvm.c | 138 ++++++++++++++++++++++++++++--------------------------
>  1 file changed, 71 insertions(+), 67 deletions(-)
> 

Queued, thanks.

Paolo
