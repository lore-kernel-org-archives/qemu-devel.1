Received: from eggs.gnu.org ([2001:4830:134:3::10]:57320)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRitX-00085u-7c
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:10:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1cRitU-0005F4-Hr
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:10:35 -0500
Received: from mx1.redhat.com ([209.132.183.28]:30456)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1cRitU-0005Ei-Bn
	for qemu-devel@nongnu.org; Thu, 12 Jan 2017 12:10:32 -0500
Date: Thu, 12 Jan 2017 15:10:29 -0200
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20170112171029.GD27893@thinpad.lan.raisama.net>
References: <1484032051-11619-1-git-send-email-he.chen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1484032051-11619-1-git-send-email-he.chen@linux.intel.com>
Subject: Re: [Qemu-devel] [PATCH] x86: add AVX512_VPOPCNTDQ features
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: He Chen <he.chen@linux.intel.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>, He Chen <he.chen@intel.com>, Richard Henderson <rth@twiddle.net>

On Tue, Jan 10, 2017 at 03:07:31PM +0800, He Chen wrote:
> AVX512_VPOPCNTDQ: Vector POPCNT instructions for word and qwords.
> variable precision.
> 
> Signed-off-by: He Chen <he.chen@linux.intel.com>
> ---
>  target/i386/cpu.c | 2 +-
>  target/i386/cpu.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index b0640f1..ae900b5 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -435,7 +435,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              NULL, "avx512vbmi", "umip", "pku",
>              "ospke", NULL, NULL, NULL,
>              NULL, NULL, NULL, NULL,
> -            NULL, NULL, NULL, NULL,
> +            NULL, NULL, "vpopcntdq", NULL,

The patches I see on linux-kernel use the "avx512_vpopcntdq"
name. Why not use "avx512-vpopcntdq" in QEMU to avoid confusion?


>              "la57", NULL, NULL, NULL,
>              NULL, NULL, "rdpid", NULL,
>              NULL, NULL, NULL, NULL,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index a7f2f60..73edc60 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -630,6 +630,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_7_0_ECX_UMIP     (1U << 2)
>  #define CPUID_7_0_ECX_PKU      (1U << 3)
>  #define CPUID_7_0_ECX_OSPKE    (1U << 4)
> +#define CPUID_7_0_ECX_VPOPCNTDQ (1U << 14) /* POPCNT for vectors of DW/QW */
>  #define CPUID_7_0_ECX_LA57     (1U << 16)
>  #define CPUID_7_0_ECX_RDPID    (1U << 22)
>  
> -- 
> 2.7.4
> 
> 

-- 
Eduardo
