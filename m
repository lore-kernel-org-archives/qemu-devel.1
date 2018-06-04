Received: from eggs.gnu.org ([2001:4830:134:3::10]:60915)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPlGK-0001MT-VT
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:54:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <berrange@redhat.com>) id 1fPlGH-0007a7-8d
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:54:49 -0400
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:46992 helo=mx1.redhat.com)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <berrange@redhat.com>) id 1fPlGH-0007YI-1Q
	for qemu-devel@nongnu.org; Mon, 04 Jun 2018 04:54:45 -0400
Date: Mon, 4 Jun 2018 09:54:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Message-ID: <20180604085440.GB19749@redhat.com>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
References: <20180601145921.9500-1-konrad.wilk@oracle.com>
	<20180601153809.15259-1-konrad.wilk@oracle.com>
	<20180601153809.15259-2-konrad.wilk@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
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
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, pbonzini@redhat.com, ehabkost@redhat.com, rth@twiddle.net

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

Oh what fun ;-)

Unless I'm mistaken the current Linux kernel doesn't know about these
new amd-ssbd / amd-no-ssb flags either. Will you also be sending patches
for that half of the problem ?

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

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|
