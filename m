Received: from eggs.gnu.org ([2001:4830:134:3::10]:35395)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1ffEXV-0007L5-Q5
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 21:12:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <jingqi.liu@intel.com>) id 1ffEXR-0004n4-Cx
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 21:12:29 -0400
Received: from mga02.intel.com ([134.134.136.20]:17673)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <jingqi.liu@intel.com>)
	id 1ffEXR-0004mL-1X
	for qemu-devel@nongnu.org; Mon, 16 Jul 2018 21:12:25 -0400
References: <1531213054-63327-1-git-send-email-jingqi.liu@intel.com>
	<83838432-354e-d504-a988-aa7672814822@redhat.com>
From: "Liu, Jingqi" <jingqi.liu@intel.com>
Message-ID: <034503a9-aa83-1081-3b16-4111be78123a@intel.com>
Date: Tue, 17 Jul 2018 09:12:20 +0800
MIME-Version: 1.0
In-Reply-To: <83838432-354e-d504-a988-aa7672814822@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Subject: Re: [Qemu-devel] [PATCH 0/3] x86/cpu: Enable a few new cpu features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>, rth@twiddle.net, ehabkost@redhat.com
Cc: qemu-devel@nongnu.org, wei.w.wang@intel.com

On 7/16/2018 10:59 PM, Paolo Bonzini wrote:
> On 10/07/2018 10:57, Jingqi Liu wrote:
>> Enable a few new cpu features including UMONITOR, UMWAIT, TPAUSE,
>> MOVDIRI and MOVDIR64B.
>>
>> UMONITOR, UMWAIT, and TPAUSE are a set of user wait instructions.
>> MOVDIRI moves doubleword or quadword from register to memory through
>> direct store.
>> MOVDIR64B moves 64-bytes as direct-store with 64-bytes write atomicity.
> Do you have corresponding KVM changes?
Yes, the corresponding links are listed as below.
https://www.spinics.net/lists/kvm/msg171563.html
https://www.spinics.net/lists/kernel/msg2850965.html
The patches had been sent for your review also.
Thanks
Jingqi Liu
>
> Paolo
>
>> The bits definition:
>> CPUID.(EAX=7,ECX=0):ECX[bit 05] WAITPKG
>> CPUID.(EAX=7,ECX=0):ECX[bit 27] MOVDIRI
>> CPUID.(EAX=7,ECX=0):ECX[bit 28] MOVDIR64B
>>
>> The release document ref below link:
>> https://software.intel.com/sites/default/files/managed/c5/15/\
>> architecture-instruction-set-extensions-programming-reference.pdf
>>
>> Jingqi Liu (3):
>>    x86/cpu: Enable UMONITOR/UMWAIT/TPAUSE cpu features
>>    x86/cpu: Enable MOVDIRI cpu feature
>>    x86/cpu: Enable MOVDIR64B cpu feature
>>
>>   target/i386/cpu.c | 6 +++---
>>   target/i386/cpu.h | 3 +++
>>   2 files changed, 6 insertions(+), 3 deletions(-)
>>
