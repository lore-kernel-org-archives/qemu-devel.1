Received: from eggs.gnu.org ([209.51.188.92]:41074)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkXAb-0001iK-TZ
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:39:02 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkXAb-00061j-6n
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:39:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:59388)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gkXAb-0005wE-0u
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:39:01 -0500
Date: Fri, 18 Jan 2019 14:38:56 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190118163856.GE4136@habkost.net>
References: <20190103100234.450-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190103100234.450-1-vkuznets@redhat.com>
Subject: Re: [Qemu-devel] [PATCH] i386: Enable NPT and NRIPSAVE for AMD CPUs
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, Richard Henderson <rth@twiddle.net>, Marcelo Tosatti <mtosatti@redhat.com>, Radim =?utf-8?B?S3LEjW3DocWZ?= <rkrcmar@redhat.com>

On Thu, Jan 03, 2019 at 11:02:34AM +0100, Vitaly Kuznetsov wrote:
> Modern AMD CPUs support NPT and NRIPSAVE features and KVM exposes these
> when present. NRIPSAVE apeared somewhere in Opteron_G3 lifetime (e.g.
> QuadCore AMD Opteron 2378 has is but QuadCore AMD Opteron HE 2344 doesn't),
> NPT was introduced a bit earlier.
> 
> Add the FEAT_SVM leaf to Opteron_G4/G5 and EPYC/EPYC-IBPB cpu models.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> ---
>  target/i386/cpu.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 677a3bd5fb..eb8f9079a6 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2766,6 +2766,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_EXT3_3DNOWPREFETCH | CPUID_EXT3_MISALIGNSSE |
>              CPUID_EXT3_SSE4A | CPUID_EXT3_ABM | CPUID_EXT3_SVM |
>              CPUID_EXT3_LAHF_LM,
> +        .features[FEAT_SVM] =
> +            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,

Same issue as the previous EPYC patch: you need npt=off and
nrip-save=off on pc_compat_3_1.

(Sorry again for taking so long to review this)

> [...]

-- 
Eduardo
