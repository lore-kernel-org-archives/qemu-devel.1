Received: from eggs.gnu.org ([2001:4830:134:3::10]:48648)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kirill@shutemov.name>) id 1cHsIP-0007Sk-8R
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 08:11:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kirill@shutemov.name>) id 1cHsIL-0004QP-9s
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 08:11:33 -0500
Received: from mail-wj0-x241.google.com ([2a00:1450:400c:c01::241]:35477)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <kirill@shutemov.name>)
	id 1cHsIL-0004Op-3w
	for qemu-devel@nongnu.org; Fri, 16 Dec 2016 08:11:29 -0500
Received: by mail-wj0-x241.google.com with SMTP id he10so14556918wjc.2
	for <qemu-devel@nongnu.org>; Fri, 16 Dec 2016 05:11:27 -0800 (PST)
Date: Fri, 16 Dec 2016 16:11:24 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
Message-ID: <20161216131124.GG27758@node>
References: <20161215001305.146807-1-kirill.shutemov@linux.intel.com>
	<f27cbdb8-73a5-d043-5033-0a7870b77c64@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f27cbdb8-73a5-d043-5033-0a7870b77c64@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] x86: implement la57 paging mode
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, Richard Henderson <rth@twiddle.net>, Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org

On Fri, Dec 16, 2016 at 01:59:36PM +0100, Paolo Bonzini wrote:
> 
> 
> On 15/12/2016 01:13, Kirill A. Shutemov wrote:
> > The new paging more is extension of IA32e mode with more additional page
> > table level.
> > 
> > It brings support of 57-bit vitrual address space (128PB) and 52-bit
> > physical address space (4PB).
> > 
> > The structure of new page table level is identical to pml4.
> > 
> > The feature is enumerated with CPUID.(EAX=07H, ECX=0):ECX[bit 16].
> > 
> > CR4.LA57[bit 12] need to be set when pageing enables to activate 5-level
> > paging mode.
> > 
> > Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
> 
> Looks good, thanks!  The target-i386/translate.c bits are not necessary,
> but I guess they can also be removed on commit.
> 
> Any chance you could also implement the MPX bits?

I don't have time for this right now. Maybe later.

-- 
 Kirill A. Shutemov
