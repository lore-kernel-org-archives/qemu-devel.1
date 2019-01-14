Received: from eggs.gnu.org ([209.51.188.92]:35795)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj75S-0007aQ-3E
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:35:50 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1gj75R-0006JS-Ac
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:35:50 -0500
Received: from mx1.redhat.com ([209.132.183.28]:33564)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1gj75R-0006IT-48
	for qemu-devel@nongnu.org; Mon, 14 Jan 2019 13:35:49 -0500
Date: Mon, 14 Jan 2019 16:35:45 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20190114183545.GB28115@habkost.net>
References: <20181227024304.12182-1-tao3.xu@intel.com>
	<20181227024304.12182-3-tao3.xu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181227024304.12182-3-tao3.xu@intel.com>
Subject: Re: [Qemu-devel] [PATCH 2/2] i386: Add some MSR based features on
 Cascadelake-Server CPU model
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Tao Xu <tao3.xu@intel.com>
Cc: pbonzini@redhat.com, rth@twiddle.net, qemu-devel@nongnu.org, robert.hu@linux.intel.com, thomas.lendacky@amd.com

Sorry, we do have a problem here:

On Thu, Dec 27, 2018 at 10:43:04AM +0800, Tao Xu wrote:
[...]
>  #define PC_COMPAT_3_0 \
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index 09706ad51a..5296c73cd5 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -2499,7 +2499,8 @@ static X86CPUDefinition builtin_x86_defs[] = {
>              CPUID_7_0_ECX_PKU | CPUID_7_0_ECX_OSPKE |
>              CPUID_7_0_ECX_AVX512VNNI,
>          .features[FEAT_7_0_EDX] =
> -            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD,
> +            CPUID_7_0_EDX_SPEC_CTRL | CPUID_7_0_EDX_SPEC_CTRL_SSBD |
> +            CPUID_7_0_EDX_ARCH_CAPABILITIES,

CPUID_7_0_EDX_ARCH_CAPABILITIES is still set on
unmigratable_flags.  We need to make it migratable before adding
it by default to a named CPU model.

Also, why are you setting this only on Cascadelake-Server and not
on all the other Intel CPUs?

I'm queueing only patch 1/2 until we sort this out.

-- 
Eduardo
