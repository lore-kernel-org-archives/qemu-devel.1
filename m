Received: from eggs.gnu.org ([2001:4830:134:3::10]:57552)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK2dR-0003wt-2g
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 07:38:13 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <pbonzini@redhat.com>) id 1cK2dN-0003dU-Tq
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 07:38:13 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52988)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <pbonzini@redhat.com>) id 1cK2dN-0003dC-Nx
	for qemu-devel@nongnu.org; Thu, 22 Dec 2016 07:38:09 -0500
References: <20161215001305.146807-1-kirill.shutemov@linux.intel.com>
	<f27cbdb8-73a5-d043-5033-0a7870b77c64@redhat.com>
	<20161222123735.GA27861@node.shutemov.name>
From: Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <7b99d28c-05e7-de8c-df03-8d0cd2919f7e@redhat.com>
Date: Thu, 22 Dec 2016 13:38:05 +0100
MIME-Version: 1.0
In-Reply-To: <20161222123735.GA27861@node.shutemov.name>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Subject: Re: [Qemu-devel] [PATCH] x86: implement la57 paging mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: "Kirill A. Shutemov" <kirill@shutemov.name>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org



On 22/12/2016 13:37, Kirill A. Shutemov wrote:
> On Fri, Dec 16, 2016 at 01:59:36PM +0100, Paolo Bonzini wrote:
>>
>>
>> On 15/12/2016 01:13, Kirill A. Shutemov wrote:
>>> The new paging more is extension of IA32e mode with more additional page
>>> table level.
>>>
>>> It brings support of 57-bit vitrual address space (128PB) and 52-bit
>>> physical address space (4PB).
>>>
>>> The structure of new page table level is identical to pml4.
>>>
>>> The feature is enumerated with CPUID.(EAX=07H, ECX=0):ECX[bit 16].
>>>
>>> CR4.LA57[bit 12] need to be set when pageing enables to activate 5-level
>>> paging mode.
>>>
>>> Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
>>
>> Looks good, thanks!  The target-i386/translate.c bits are not necessary,
>> but I guess they can also be removed on commit.
> 
> Is there anything else I need to do to make it applied?

No, but 2.8 was only released a couple days ago so we were in freeze.

Paolo
