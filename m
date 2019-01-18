Received: from eggs.gnu.org ([209.51.188.92]:35239)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkWnN-0000IA-6M
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:15:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gkWnH-0004nY-9p
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:15:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:52684)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gkWnH-0004kn-42
	for qemu-devel@nongnu.org; Fri, 18 Jan 2019 11:14:55 -0500
Date: Fri, 18 Jan 2019 14:14:51 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190118161451.GB4136@habkost.net>
References: <20181221140321.7750-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181221140321.7750-1-vkuznets@redhat.com>
Subject: Re: [Qemu-devel] [PATCH RFC] i386: Enable NPT and NRIPSAVE for Epyc
 CPUs
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

On Fri, Dec 21, 2018 at 03:03:21PM +0100, Vitaly Kuznetsov wrote:
> Epyc CPUs support NPT and NRIPSAVE features and KVM exposes these when
> present. Add them to EPYC and EPYC-IBPB cpu models.
> 
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>

Sorry for taking so long to reply:

> ---
> - RFC part: I'm not sure when these features first appeared, we may want to
>   modify some Opteron_* models too.
> ---
>  target/i386/cpu.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 677a3bd5fb..0a10fbeccc 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2843,6 +2843,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_XSAVE_XGETBV1,
>          .features[FEAT_6_EAX] =
>              CPUID_6_EAX_ARAT,
> +        .features[FEAT_SVM] =
> +            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,

You'll need to add EPYC*.ntp=off and EPYC*.nripsave=off to
pc_compat_3_1.

>          .xlevel = 0x8000001E,
>          .model_id = "AMD EPYC Processor",
>          .cache_info = &epyc_cache_info,
> @@ -2891,6 +2893,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_XSAVE_XGETBV1,
>          .features[FEAT_6_EAX] =
>              CPUID_6_EAX_ARAT,
> +        .features[FEAT_SVM] =
> +            CPUID_SVM_NPT | CPUID_SVM_NRIPSAVE,
>          .xlevel = 0x8000001E,
>          .model_id = "AMD EPYC Processor (with IBPB)",
>          .cache_info = &epyc_cache_info,
> -- 
> 2.19.2
> 

-- 
Eduardo
