Received: from eggs.gnu.org ([2001:4830:134:3::10]:36425)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFl8Y-0004Y7-Oz
	for qemu-devel@nongnu.org; Mon, 07 May 2018 14:45:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <ehabkost@redhat.com>) id 1fFl8V-0002iD-Hs
	for qemu-devel@nongnu.org; Mon, 07 May 2018 14:45:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:47382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <ehabkost@redhat.com>) id 1fFl8V-0002hd-CI
	for qemu-devel@nongnu.org; Mon, 07 May 2018 14:45:23 -0400
Date: Mon, 7 May 2018 15:45:20 -0300
From: Eduardo Habkost <ehabkost@redhat.com>
Message-ID: <20180507184520.GD25013@localhost.localdomain>
References: <1525406253-54846-1-git-send-email-jingqi.liu@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1525406253-54846-1-git-send-email-jingqi.liu@intel.com>
Subject: Re: [Qemu-devel] [PATCH] x86/cpu: Enable CLDEMOTE(Demote Cache
 Line) cpu feature
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Jingqi Liu <jingqi.liu@intel.com>
Cc: qemu-devel@nongnu.org, pbonzini@redhat.com, rth@twiddle.net

On Fri, May 04, 2018 at 11:57:33AM +0800, Jingqi Liu wrote:
> The CLDEMOTE instruction hints to hardware that the cache line that
> contains the linear address should be moved("demoted") from
> the cache(s) closest to the processor core to a level more distant
> from the processor core. This may accelerate subsequent accesses
> to the line by other cores in the same coherence domain,
> especially if the line was written by the core that demotes the line.
> 
> Intel Snow Ridge has added new cpu feature, CLDEMOTE.
> The new cpu feature needs to be exposed to guest VM.
> 
> The bit definition:
> CPUID.(EAX=7,ECX=0):ECX[bit 25] CLDEMOTE
> 
> The release document ref below link:
> https://software.intel.com/sites/default/files/managed/c5/15/\
> architecture-instruction-set-extensions-programming-reference.pdf
> 
> Signed-off-by: Jingqi Liu <jingqi.liu@intel.com>

Reviewed-by: Eduardo Habkost <ehabkost@redhat.com>

Queued, thanks.

> ---
>  target/i386/cpu.c | 2 +-
>  target/i386/cpu.h | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index ec1efd3..d5a5abf 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -483,7 +483,7 @@ static FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
>              "avx512bitalg", NULL, "avx512-vpopcntdq", NULL,
>              "la57", NULL, NULL, NULL,
>              NULL, NULL, "rdpid", NULL,
> -            NULL, NULL, NULL, NULL,
> +            NULL, "cldemote", NULL, NULL,
>              NULL, NULL, NULL, NULL,
>          },
>          .cpuid_eax = 7,
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 0c3f514..3ef90e0 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -678,6 +678,7 @@ typedef uint32_t FeatureWordArray[FEATURE_WORDS];
>  #define CPUID_7_0_ECX_AVX512_VPOPCNTDQ (1U << 14) /* POPCNT for vectors of DW/QW */
>  #define CPUID_7_0_ECX_LA57     (1U << 16)
>  #define CPUID_7_0_ECX_RDPID    (1U << 22)
> +#define CPUID_7_0_ECX_CLDEMOTE (1U << 25)  /* CLDEMOTE Instruction */
>  
>  #define CPUID_7_0_EDX_AVX512_4VNNIW (1U << 2) /* AVX512 Neural Network Instructions */
>  #define CPUID_7_0_EDX_AVX512_4FMAPS (1U << 3) /* AVX512 Multiply Accumulation Single Precision */
> -- 
> 1.8.3.1
> 
> 

-- 
Eduardo
