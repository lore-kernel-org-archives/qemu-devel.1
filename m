Received: from eggs.gnu.org ([2001:4830:134:3::10]:34349)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffZip-0004cV-9W
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 19:49:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffZik-0000pd-Bp
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 19:49:35 -0400
Received: from mail-ua0-x242.google.com ([2607:f8b0:400c:c08::242]:36316)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philippe.mathieu.daude@gmail.com>)
	id 1ffZik-0000pG-5x
	for qemu-devel@nongnu.org; Tue, 17 Jul 2018 19:49:30 -0400
Received: by mail-ua0-x242.google.com with SMTP id y8-v6so1815712uan.3
	for <qemu-devel@nongnu.org>; Tue, 17 Jul 2018 16:49:30 -0700 (PDT)
Sender: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?=
	<philippe.mathieu.daude@gmail.com>
References: <20180717194010.30096-1-ehabkost@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <4d551ea5-4ee7-db0d-bc15-688c70029ecc@amsat.org>
Date: Tue, 17 Jul 2018 20:49:24 -0300
MIME-Version: 1.0
In-Reply-To: <20180717194010.30096-1-ehabkost@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.0] i386: Rename enum CacheType members
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Eduardo Habkost <ehabkost@redhat.com>, qemu-devel@nongnu.org
Cc: Babu Moger <babu.moger@amd.com>, Paolo Bonzini <pbonzini@redhat.com>, Aleksandar Markovic <aleksandar.markovic@mips.com>, Aurelien Jarno <aurelien@aurel32.net>, Richard Henderson <rth@twiddle.net>

On 07/17/2018 04:40 PM, Eduardo Habkost wrote:
> Rename DCACHE to DATA_CACHE and ICACHE to INSTRUCTION_CACHE.

Effective, thanks.

> This avoids conflict with Linux asm/cachectl.h macros and fixes
> build failure on mips hosts.
> 
> Reported-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Eduardo Habkost <ehabkost@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
Tested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

> ---
>  target/i386/cpu.h |   4 +-
>  target/i386/cpu.c | 128 +++++++++++++++++++++++-----------------------
>  2 files changed, 66 insertions(+), 66 deletions(-)
> 
> diff --git a/target/i386/cpu.h b/target/i386/cpu.h
> index 2c5a0d90a6..194e2e6b92 100644
> --- a/target/i386/cpu.h
> +++ b/target/i386/cpu.h
> @@ -1050,8 +1050,8 @@ typedef enum TPRAccess {
>  /* Cache information data structures: */
>  
>  enum CacheType {
> -    DCACHE,
> -    ICACHE,
> +    DATA_CACHE,
> +    INSTRUCTION_CACHE,
>      UNIFIED_CACHE
>  };
>  
> diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> index e0e2f2eea1..f454d4beb3 100644
> --- a/target/i386/cpu.c
> +++ b/target/i386/cpu.c
> @@ -71,123 +71,123 @@ struct CPUID2CacheDescriptorInfo {
>   * From Intel SDM Volume 2A, CPUID instruction
>   */
>  struct CPUID2CacheDescriptorInfo cpuid2_cache_descriptors[] = {
> -    [0x06] = { .level = 1, .type = ICACHE,        .size =   8 * KiB,
> +    [0x06] = { .level = 1, .type = INSTRUCTION_CACHE, .size =   8 * KiB,
>                 .associativity = 4,  .line_size = 32, },
> -    [0x08] = { .level = 1, .type = ICACHE,        .size =  16 * KiB,
> +    [0x08] = { .level = 1, .type = INSTRUCTION_CACHE, .size =  16 * KiB,
>                 .associativity = 4,  .line_size = 32, },
> -    [0x09] = { .level = 1, .type = ICACHE,        .size =  32 * KiB,
> +    [0x09] = { .level = 1, .type = INSTRUCTION_CACHE, .size =  32 * KiB,
>                 .associativity = 4,  .line_size = 64, },
> -    [0x0A] = { .level = 1, .type = DCACHE,        .size =   8 * KiB,
> +    [0x0A] = { .level = 1, .type = DATA_CACHE,        .size =   8 * KiB,
>                 .associativity = 2,  .line_size = 32, },
> -    [0x0C] = { .level = 1, .type = DCACHE,        .size =  16 * KiB,
> +    [0x0C] = { .level = 1, .type = DATA_CACHE,        .size =  16 * KiB,
>                 .associativity = 4,  .line_size = 32, },
> -    [0x0D] = { .level = 1, .type = DCACHE,        .size =  16 * KiB,
> +    [0x0D] = { .level = 1, .type = DATA_CACHE,        .size =  16 * KiB,
>                 .associativity = 4,  .line_size = 64, },
> -    [0x0E] = { .level = 1, .type = DCACHE,        .size =  24 * KiB,
> +    [0x0E] = { .level = 1, .type = DATA_CACHE,        .size =  24 * KiB,
>                 .associativity = 6,  .line_size = 64, },
> -    [0x1D] = { .level = 2, .type = UNIFIED_CACHE, .size = 128 * KiB,
> +    [0x1D] = { .level = 2, .type = UNIFIED_CACHE,     .size = 128 * KiB,
>                 .associativity = 2,  .line_size = 64, },
> -    [0x21] = { .level = 2, .type = UNIFIED_CACHE, .size = 256 * KiB,
> +    [0x21] = { .level = 2, .type = UNIFIED_CACHE,     .size = 256 * KiB,
>                 .associativity = 8,  .line_size = 64, },
>      /* lines per sector is not supported cpuid2_cache_descriptor(),
>      * so descriptors 0x22, 0x23 are not included
>      */
> -    [0x24] = { .level = 2, .type = UNIFIED_CACHE, .size =   1 * MiB,
> +    [0x24] = { .level = 2, .type = UNIFIED_CACHE,     .size =   1 * MiB,
>                 .associativity = 16, .line_size = 64, },
>      /* lines per sector is not supported cpuid2_cache_descriptor(),
>      * so descriptors 0x25, 0x20 are not included
>      */
> -    [0x2C] = { .level = 1, .type = DCACHE,        .size =  32 * KiB,
> +    [0x2C] = { .level = 1, .type = DATA_CACHE,        .size =  32 * KiB,
>                 .associativity = 8,  .line_size = 64, },
> -    [0x30] = { .level = 1, .type = ICACHE,        .size =  32 * KiB,
> +    [0x30] = { .level = 1, .type = INSTRUCTION_CACHE, .size =  32 * KiB,
>                 .associativity = 8,  .line_size = 64, },
> -    [0x41] = { .level = 2, .type = UNIFIED_CACHE, .size = 128 * KiB,
> +    [0x41] = { .level = 2, .type = UNIFIED_CACHE,     .size = 128 * KiB,
>                 .associativity = 4,  .line_size = 32, },
> -    [0x42] = { .level = 2, .type = UNIFIED_CACHE, .size = 256 * KiB,
> +    [0x42] = { .level = 2, .type = UNIFIED_CACHE,     .size = 256 * KiB,
>                 .associativity = 4,  .line_size = 32, },
> -    [0x43] = { .level = 2, .type = UNIFIED_CACHE, .size = 512 * KiB,
> +    [0x43] = { .level = 2, .type = UNIFIED_CACHE,     .size = 512 * KiB,
>                 .associativity = 4,  .line_size = 32, },
> -    [0x44] = { .level = 2, .type = UNIFIED_CACHE, .size =   1 * MiB,
> +    [0x44] = { .level = 2, .type = UNIFIED_CACHE,     .size =   1 * MiB,
>                 .associativity = 4,  .line_size = 32, },
> -    [0x45] = { .level = 2, .type = UNIFIED_CACHE, .size =   2 * MiB,
> +    [0x45] = { .level = 2, .type = UNIFIED_CACHE,     .size =   2 * MiB,
>                 .associativity = 4,  .line_size = 32, },
> -    [0x46] = { .level = 3, .type = UNIFIED_CACHE, .size =   4 * MiB,
> +    [0x46] = { .level = 3, .type = UNIFIED_CACHE,     .size =   4 * MiB,
>                 .associativity = 4,  .line_size = 64, },
> -    [0x47] = { .level = 3, .type = UNIFIED_CACHE, .size =   8 * MiB,
> +    [0x47] = { .level = 3, .type = UNIFIED_CACHE,     .size =   8 * MiB,
>                 .associativity = 8,  .line_size = 64, },
> -    [0x48] = { .level = 2, .type = UNIFIED_CACHE, .size =   3 * MiB,
> +    [0x48] = { .level = 2, .type = UNIFIED_CACHE,     .size =   3 * MiB,
>                 .associativity = 12, .line_size = 64, },
>      /* Descriptor 0x49 depends on CPU family/model, so it is not included */
> -    [0x4A] = { .level = 3, .type = UNIFIED_CACHE, .size =   6 * MiB,
> +    [0x4A] = { .level = 3, .type = UNIFIED_CACHE,     .size =   6 * MiB,
>                 .associativity = 12, .line_size = 64, },
> -    [0x4B] = { .level = 3, .type = UNIFIED_CACHE, .size =   8 * MiB,
> +    [0x4B] = { .level = 3, .type = UNIFIED_CACHE,     .size =   8 * MiB,
>                 .associativity = 16, .line_size = 64, },
> -    [0x4C] = { .level = 3, .type = UNIFIED_CACHE, .size =  12 * MiB,
> +    [0x4C] = { .level = 3, .type = UNIFIED_CACHE,     .size =  12 * MiB,
>                 .associativity = 12, .line_size = 64, },
> -    [0x4D] = { .level = 3, .type = UNIFIED_CACHE, .size =  16 * MiB,
> +    [0x4D] = { .level = 3, .type = UNIFIED_CACHE,     .size =  16 * MiB,
>                 .associativity = 16, .line_size = 64, },
> -    [0x4E] = { .level = 2, .type = UNIFIED_CACHE, .size =   6 * MiB,
> +    [0x4E] = { .level = 2, .type = UNIFIED_CACHE,     .size =   6 * MiB,
>                 .associativity = 24, .line_size = 64, },
> -    [0x60] = { .level = 1, .type = DCACHE,        .size =  16 * KiB,
> +    [0x60] = { .level = 1, .type = DATA_CACHE,        .size =  16 * KiB,
>                 .associativity = 8,  .line_size = 64, },
> -    [0x66] = { .level = 1, .type = DCACHE,        .size =   8 * KiB,
> +    [0x66] = { .level = 1, .type = DATA_CACHE,        .size =   8 * KiB,
>                 .associativity = 4,  .line_size = 64, },
> -    [0x67] = { .level = 1, .type = DCACHE,        .size =  16 * KiB,
> +    [0x67] = { .level = 1, .type = DATA_CACHE,        .size =  16 * KiB,
>                 .associativity = 4,  .line_size = 64, },
> -    [0x68] = { .level = 1, .type = DCACHE,        .size =  32 * KiB,
> +    [0x68] = { .level = 1, .type = DATA_CACHE,        .size =  32 * KiB,
>                 .associativity = 4,  .line_size = 64, },
> -    [0x78] = { .level = 2, .type = UNIFIED_CACHE, .size =   1 * MiB,
> +    [0x78] = { .level = 2, .type = UNIFIED_CACHE,     .size =   1 * MiB,
>                 .associativity = 4,  .line_size = 64, },
>      /* lines per sector is not supported cpuid2_cache_descriptor(),
>      * so descriptors 0x79, 0x7A, 0x7B, 0x7C are not included.
>      */
> -    [0x7D] = { .level = 2, .type = UNIFIED_CACHE, .size =   2 * MiB,
> +    [0x7D] = { .level = 2, .type = UNIFIED_CACHE,     .size =   2 * MiB,
>                 .associativity = 8,  .line_size = 64, },
> -    [0x7F] = { .level = 2, .type = UNIFIED_CACHE, .size = 512 * KiB,
> +    [0x7F] = { .level = 2, .type = UNIFIED_CACHE,     .size = 512 * KiB,
>                 .associativity = 2,  .line_size = 64, },
> -    [0x80] = { .level = 2, .type = UNIFIED_CACHE, .size = 512 * KiB,
> +    [0x80] = { .level = 2, .type = UNIFIED_CACHE,     .size = 512 * KiB,
>                 .associativity = 8,  .line_size = 64, },
> -    [0x82] = { .level = 2, .type = UNIFIED_CACHE, .size = 256 * KiB,
> +    [0x82] = { .level = 2, .type = UNIFIED_CACHE,     .size = 256 * KiB,
>                 .associativity = 8,  .line_size = 32, },
> -    [0x83] = { .level = 2, .type = UNIFIED_CACHE, .size = 512 * KiB,
> +    [0x83] = { .level = 2, .type = UNIFIED_CACHE,     .size = 512 * KiB,
>                 .associativity = 8,  .line_size = 32, },
> -    [0x84] = { .level = 2, .type = UNIFIED_CACHE, .size =   1 * MiB,
> +    [0x84] = { .level = 2, .type = UNIFIED_CACHE,     .size =   1 * MiB,
>                 .associativity = 8,  .line_size = 32, },
> -    [0x85] = { .level = 2, .type = UNIFIED_CACHE, .size =   2 * MiB,
> +    [0x85] = { .level = 2, .type = UNIFIED_CACHE,     .size =   2 * MiB,
>                 .associativity = 8,  .line_size = 32, },
> -    [0x86] = { .level = 2, .type = UNIFIED_CACHE, .size = 512 * KiB,
> +    [0x86] = { .level = 2, .type = UNIFIED_CACHE,     .size = 512 * KiB,
>                 .associativity = 4,  .line_size = 64, },
> -    [0x87] = { .level = 2, .type = UNIFIED_CACHE, .size =   1 * MiB,
> +    [0x87] = { .level = 2, .type = UNIFIED_CACHE,     .size =   1 * MiB,
>                 .associativity = 8,  .line_size = 64, },
> -    [0xD0] = { .level = 3, .type = UNIFIED_CACHE, .size = 512 * KiB,
> +    [0xD0] = { .level = 3, .type = UNIFIED_CACHE,     .size = 512 * KiB,
>                 .associativity = 4,  .line_size = 64, },
> -    [0xD1] = { .level = 3, .type = UNIFIED_CACHE, .size =   1 * MiB,
> +    [0xD1] = { .level = 3, .type = UNIFIED_CACHE,     .size =   1 * MiB,
>                 .associativity = 4,  .line_size = 64, },
> -    [0xD2] = { .level = 3, .type = UNIFIED_CACHE, .size =   2 * MiB,
> +    [0xD2] = { .level = 3, .type = UNIFIED_CACHE,     .size =   2 * MiB,
>                 .associativity = 4,  .line_size = 64, },
> -    [0xD6] = { .level = 3, .type = UNIFIED_CACHE, .size =   1 * MiB,
> +    [0xD6] = { .level = 3, .type = UNIFIED_CACHE,     .size =   1 * MiB,
>                 .associativity = 8,  .line_size = 64, },
> -    [0xD7] = { .level = 3, .type = UNIFIED_CACHE, .size =   2 * MiB,
> +    [0xD7] = { .level = 3, .type = UNIFIED_CACHE,     .size =   2 * MiB,
>                 .associativity = 8,  .line_size = 64, },
> -    [0xD8] = { .level = 3, .type = UNIFIED_CACHE, .size =   4 * MiB,
> +    [0xD8] = { .level = 3, .type = UNIFIED_CACHE,     .size =   4 * MiB,
>                 .associativity = 8,  .line_size = 64, },
> -    [0xDC] = { .level = 3, .type = UNIFIED_CACHE, .size = 1.5 * MiB,
> +    [0xDC] = { .level = 3, .type = UNIFIED_CACHE,     .size = 1.5 * MiB,
>                 .associativity = 12, .line_size = 64, },
> -    [0xDD] = { .level = 3, .type = UNIFIED_CACHE, .size =   3 * MiB,
> +    [0xDD] = { .level = 3, .type = UNIFIED_CACHE,     .size =   3 * MiB,
>                 .associativity = 12, .line_size = 64, },
> -    [0xDE] = { .level = 3, .type = UNIFIED_CACHE, .size =   6 * MiB,
> +    [0xDE] = { .level = 3, .type = UNIFIED_CACHE,     .size =   6 * MiB,
>                 .associativity = 12, .line_size = 64, },
> -    [0xE2] = { .level = 3, .type = UNIFIED_CACHE, .size =   2 * MiB,
> +    [0xE2] = { .level = 3, .type = UNIFIED_CACHE,     .size =   2 * MiB,
>                 .associativity = 16, .line_size = 64, },
> -    [0xE3] = { .level = 3, .type = UNIFIED_CACHE, .size =   4 * MiB,
> +    [0xE3] = { .level = 3, .type = UNIFIED_CACHE,     .size =   4 * MiB,
>                 .associativity = 16, .line_size = 64, },
> -    [0xE4] = { .level = 3, .type = UNIFIED_CACHE, .size =   8 * MiB,
> +    [0xE4] = { .level = 3, .type = UNIFIED_CACHE,     .size =   8 * MiB,
>                 .associativity = 16, .line_size = 64, },
> -    [0xEA] = { .level = 3, .type = UNIFIED_CACHE, .size =  12 * MiB,
> +    [0xEA] = { .level = 3, .type = UNIFIED_CACHE,     .size =  12 * MiB,
>                 .associativity = 24, .line_size = 64, },
> -    [0xEB] = { .level = 3, .type = UNIFIED_CACHE, .size =  18 * MiB,
> +    [0xEB] = { .level = 3, .type = UNIFIED_CACHE,     .size =  18 * MiB,
>                 .associativity = 24, .line_size = 64, },
> -    [0xEC] = { .level = 3, .type = UNIFIED_CACHE, .size =  24 * MiB,
> +    [0xEC] = { .level = 3, .type = UNIFIED_CACHE,     .size =  24 * MiB,
>                 .associativity = 24, .line_size = 64, },
>  };
>  
> @@ -238,10 +238,10 @@ static uint8_t cpuid2_cache_descriptor(CPUCacheInfo *cache)
>  #define CACHE_COMPLEX_IDX     (1 << 2)
>  
>  /* Encode CacheType for CPUID[4].EAX */
> -#define CACHE_TYPE(t) (((t) == DCACHE)  ? CACHE_TYPE_D  : \
> -                         ((t) == ICACHE)  ? CACHE_TYPE_I  : \
> -                         ((t) == UNIFIED_CACHE) ? CACHE_TYPE_UNIFIED : \
> -                         0 /* Invalid value */)
> +#define CACHE_TYPE(t) (((t) == DATA_CACHE) ? CACHE_TYPE_D : \
> +                       ((t) == INSTRUCTION_CACHE) ? CACHE_TYPE_I : \
> +                       ((t) == UNIFIED_CACHE) ? CACHE_TYPE_UNIFIED : \
> +                       0 /* Invalid value */)
>  
>  
>  /* Encode cache info for CPUID[4] */
> @@ -538,7 +538,7 @@ static void encode_topo_cpuid8000001e(CPUState *cs, X86CPU *cpu,
>  
>  /* L1 data cache: */
>  static CPUCacheInfo legacy_l1d_cache = {
> -    .type = DCACHE,
> +    .type = DATA_CACHE,
>      .level = 1,
>      .size = 32 * KiB,
>      .self_init = 1,
> @@ -551,7 +551,7 @@ static CPUCacheInfo legacy_l1d_cache = {
>  
>  /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
>  static CPUCacheInfo legacy_l1d_cache_amd = {
> -    .type = DCACHE,
> +    .type = DATA_CACHE,
>      .level = 1,
>      .size = 64 * KiB,
>      .self_init = 1,
> @@ -565,7 +565,7 @@ static CPUCacheInfo legacy_l1d_cache_amd = {
>  
>  /* L1 instruction cache: */
>  static CPUCacheInfo legacy_l1i_cache = {
> -    .type = ICACHE,
> +    .type = INSTRUCTION_CACHE,
>      .level = 1,
>      .size = 32 * KiB,
>      .self_init = 1,
> @@ -578,7 +578,7 @@ static CPUCacheInfo legacy_l1i_cache = {
>  
>  /*FIXME: CPUID leaf 0x80000005 is inconsistent with leaves 2 & 4 */
>  static CPUCacheInfo legacy_l1i_cache_amd = {
> -    .type = ICACHE,
> +    .type = INSTRUCTION_CACHE,
>      .level = 1,
>      .size = 64 * KiB,
>      .self_init = 1,
> @@ -1310,7 +1310,7 @@ struct X86CPUDefinition {
>  
>  static CPUCaches epyc_cache_info = {
>      .l1d_cache = &(CPUCacheInfo) {
> -        .type = DCACHE,
> +        .type = DATA_CACHE,
>          .level = 1,
>          .size = 32 * KiB,
>          .line_size = 64,
> @@ -1322,7 +1322,7 @@ static CPUCaches epyc_cache_info = {
>          .no_invd_sharing = true,
>      },
>      .l1i_cache = &(CPUCacheInfo) {
> -        .type = ICACHE,
> +        .type = INSTRUCTION_CACHE,
>          .level = 1,
>          .size = 64 * KiB,
>          .line_size = 64,
> 
