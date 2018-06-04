Received: from eggs.gnu.org ([2001:4830:134:3::10]:51671)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fPvkv-0005ku-L0
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 16:07:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fPvku-000852-Nh
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 16:07:05 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50220)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fPvku-00084p-HQ
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 16:07:04 -0400
Date: Mon, 4 Jun 2018 17:07:01 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180604200701.GB3184@localhost.localdomain>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
	<20180601153809.15259-1-konrad.wilk@oracle.com>
	<20180601153809.15259-2-konrad.wilk@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180601153809.15259-2-konrad.wilk@oracle.com>
Subject: Re: [Qemu-devel] [PATCH 1/2] i386: define the AMD 'amd-ssbd' CPUID
 feature bit
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

On Fri, Jun 01, 2018 at 11:38:08AM -0400, Konrad Rzeszutek Wilk wrote:
> AMD future CPUs expose _two_ ways to utilize the Intel equivalant
> of the Speculative Store Bypass Disable. The first is via
> the virtualized VIRT_SPEC CTRL MSR (0xC001_011f) and the second
> is via the SPEC_CTRL MSR (0x48). The document titled:
> 124441_AMD64_SpeculativeStoreBypassDisable_Whitepaper_final.pdf
> 
> gives priority of SPEC CTRL MSR over the VIRT SPEC CTRL MSR.
> 
> A copy of this document is available at
>       https://bugzilla.kernel.org/show_bug.cgi?id=199889
> 
> Anyhow, this means that on future AMD CPUs there will be  _two_ ways to
> deal with SSBD.

Does anybody know if there are AMD CPUs where virt-ssbd won't
work and would require amd-ssbd to mitigate vulnerabilities?

Also, do we have kernel arch/x86/kvm/cpuid.c patches, already?
I prefer to add new CPUID flag names only after the flag name is
already agreed upon on the kernel side.


> 
> Signed-off-by: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
> ---
>  target/i386/cpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 52d334a..f91990c 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -490,7 +490,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              "ibpb", NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
> -            NULL, "virt-ssbd", NULL, NULL,
> +            "amd-ssbd", "virt-ssbd", NULL, NULL,
>              NULL, NULL, NULL, NULL,
>          },
>          .cpuid_eax = 0x80000008,
> -- 
> 1.8.3.1
> 
> 

-- 
Eduardo
