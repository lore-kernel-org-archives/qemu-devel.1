Received: from eggs.gnu.org ([2001:4830:134:3::10]:56872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1fOm8C-0002tz-8g
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:38:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <konrad.wilk@oracle.com>) id 1fOm88-0003CM-AU
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:38:20 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:53670)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <konrad.wilk@oracle.com>)
	id 1fOm88-0003B0-1s
	for qemu-devel@nongnu.org; Fri, 01 Jun 2018 11:38:16 -0400
From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Date: Fri,  1 Jun 2018 11:38:07 -0400
Message-Id: <20180601153809.15259-1-konrad.wilk@oracle.com>
In-Reply-To: <20180601145921.9500-1-konrad.wilk@oracle.com>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
Subject: [Qemu-devel] [PATCH QEMU] Patches for new AMD CPU bits.
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: kvm@vger.kernel.org, qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net

Hi!


I was reading the AMD whitepaper on SSBD and noticed that they have added
two new bits in the 8000_0008 CPUID. EBX:
 1) Bit[26] - similar to Intel's SSB_NO not needed anymore.
 2) Bit[24] - use SPEC_CTRL MSR (0x48) instead of VIRT SPEC_CTRL MSR
    (0xC001_011f).

See 124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf
A copy of this document is available at
        https://bugzilla.kernel.org/show_bug.cgi?id=199889

These two patches along with the kernel ones allow us to expose those
two bits to the guest.

Thank you!

 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)


Konrad Rzeszutek Wilk (2):
      i386: define the AMD 'amd-ssbd' CPUID feature bit
      i386: Define AMD's no SSB mitigation needed.
