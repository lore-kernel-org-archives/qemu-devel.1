Received: from eggs.gnu.org ([209.51.188.92]:48102)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hArNL-00036i-Dg
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:29:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1hArNK-0005B9-EU
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:28:59 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45834)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1hArNK-0005Aa-4g
	for qemu-devel@nongnu.org; Mon, 01 Apr 2019 03:28:58 -0400
References: <CAP8WD_bf=0=tyCumcNpVLtneio+vbd4JuFMmtWqSwXWFC-7PMg@mail.gmail.com>
	<6da0c28c-ef4f-8199-1cee-bf1f08387ff1@redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <ea9cf5ec-f259-9a23-eae1-1b2250c367b0@redhat.com>
Date: Mon, 1 Apr 2019 09:28:49 +0200
MIME-Version: 1.0
In-Reply-To: <6da0c28c-ef4f-8199-1cee-bf1f08387ff1@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] Pentium Pro Feature Bugs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, whiteheadm@acm.org, qemu-devel@nongnu.org
Cc: Eduardo Habkost <ehabkost@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>

On 01/04/19 07:35, Thomas Huth wrote:
> On 01/04/2019 05.36, tedheadster wrote:
>> I just noticed this in the code regarding MMX and I wonder if it is correct:
>>
>> target/i386/cpu.c:
>>
>> #define PPRO_FEATURES (CPUID_FP87 | CPUID_DE | CPUID_PSE | CPUID_TSC | \
>>           CPUID_MSR | CPUID_MCE | CPUID_CX8 | CPUID_PGE | CPUID_CMOV | \
>>           CPUID_PAT | CPUID_FXSR | CPUID_MMX | CPUID_SSE | CPUID_SSE2 | \
>>           CPUID_PAE | CPUID_SEP | CPUID_APIC)
>>
>> The problem I see is that the PentiumPro never supported the MMX
>> instruction extensions (oddly supported in the the Pentium MMX), nor
>> the even later SSE (Pentium III) and SSE2 (Pentium 4) features.
>>
>> Also, the Pentium Pro never officially supported  SYSENTER/SYSEXIT
>> (CPUID_SEP), though they originally intended to. Intel discovered
>> shortly before the product release that the hardware didn't work
>> correctly, so they never documented it as a feature to prevent its
>> use.
>>
>> Should these be removed?
> 
> Looking at the output of "qemu-system-x86_64 -cpu help", it seems to me
> like QEMU does not emulate the Pention Pro at all. So maybe we should
> simply rename that macro to "QEMU32_FEATURES" or something similar?

Yes, I agree.

Paolo
