Received: from eggs.gnu.org ([2001:4830:134:3::10]:48476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTDU7-0007Ct-M4
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 17:39:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fTDU4-0004XO-2w
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 17:39:19 -0400
Received: from mx1.redhat.com ([209.132.183.28]:46370)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fTDTp-0004PU-Hh
	for qemu-devel@nongnu.org; Wed, 13 Jun 2018 17:39:15 -0400
Date: Wed, 13 Jun 2018 18:38:58 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180613213858.GI24764@localhost.localdomain>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
	<20180601153809.15259-1-konrad.wilk@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601153809.15259-1-konrad.wilk@oracle.com>
Subject: Re: [Qemu-devel] [PATCH QEMU] Patches for new AMD CPU bits.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On Fri, Jun 01, 2018 at 11:38:07AM -0400, Konrad Rzeszutek Wilk wrote:
> Hi!
> 
> 
> I was reading the AMD whitepaper on SSBD and noticed that they have added
> two new bits in the 8000_0008 CPUID. EBX:
>  1) Bit[26] - similar to Intel's SSB_NO not needed anymore.
>  2) Bit[24] - use SPEC_CTRL MSR (0x48) instead of VIRT SPEC_CTRL MSR
>     (0xC001_011f).
> 
> See 124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf
> A copy of this document is available at
>         https://bugzilla.kernel.org/show_bug.cgi?id=199889
> 
> These two patches along with the kernel ones allow us to expose those
> two bits to the guest.

Queued on x86-next, thanks!

-- 
Eduardo
