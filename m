Received: from eggs.gnu.org ([2001:4830:134:3::10]:49348)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gS0v7-0005A9-Gv
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:34:31 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <philmd@redhat.com>) id 1gS0v4-0002Fz-8V
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:34:29 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:37907)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <philmd@redhat.com>) id 1gS0v3-0002F6-WB
	for qemu-devel@nongnu.org; Wed, 28 Nov 2018 09:34:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id v13so23067898wrw.5
	for <qemu-devel@nongnu.org>; Wed, 28 Nov 2018 06:34:24 -0800 (PST)
References: <1543399094-2260-1-git-send-email-thuth@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <2ac07515-10f3-ed38-c022-e583cd1cd36a@redhat.com>
Date: Wed, 28 Nov 2018 15:34:21 +0100
MIME-Version: 1.0
In-Reply-To: <1543399094-2260-1-git-send-email-thuth@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Subject: Re: [Qemu-devel] [PATCH for-3.1?] target/arm/sve_helper: Fix
 compilation with clang 3.4
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
To: Thomas Huth <thuth@redhat.com>, Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Richard Henderson <rth@twiddle.net>

On 28/11/18 10:58, Thomas Huth wrote:
> Clang 3.4 does not know the "flatten" attribute yet. We've already
> introduced the QEMU_FLATTEN macro for this in commit 97ff87c0ed020c2,
> so use this macro now here, too, to fix this issue.

checkpatch candidate?

> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>

Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>

> ---
>  target/arm/sve_helper.c | 20 ++++++++++----------
>  1 file changed, 10 insertions(+), 10 deletions(-)
> 
> diff --git a/target/arm/sve_helper.c b/target/arm/sve_helper.c
> index 8cbc651..bc84725 100644
> --- a/target/arm/sve_helper.c
> +++ b/target/arm/sve_helper.c
> @@ -4382,20 +4382,20 @@ static void sve_ld4_r(CPUARMState *env, void *vg, target_ulong addr,
>  }
>  
>  #define DO_LDN_1(N) \
> -void __attribute__((flatten)) HELPER(sve_ld##N##bb_r)               \
> +void QEMU_FLATTEN HELPER(sve_ld##N##bb_r) \
>      (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)  \
>  {                                                                   \
>      sve_ld##N##_r(env, vg, addr, desc, 1, GETPC(), sve_ld1bb_tlb);  \
>  }
>  
>  #define DO_LDN_2(N, SUFF, SIZE)                                       \
> -void __attribute__((flatten)) HELPER(sve_ld##N##SUFF##_le_r)          \
> +void QEMU_FLATTEN HELPER(sve_ld##N##SUFF##_le_r)                      \
>      (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)    \
>  {                                                                     \
>      sve_ld##N##_r(env, vg, addr, desc, SIZE, GETPC(),                 \
>                    sve_ld1##SUFF##_le_tlb);                            \
>  }                                                                     \
> -void __attribute__((flatten)) HELPER(sve_ld##N##SUFF##_be_r)          \
> +void QEMU_FLATTEN HELPER(sve_ld##N##SUFF##_be_r)                      \
>      (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)    \
>  {                                                                     \
>      sve_ld##N##_r(env, vg, addr, desc, SIZE, GETPC(),                 \
> @@ -4832,7 +4832,7 @@ static void sve_st4_r(CPUARMState *env, void *vg, target_ulong addr,
>  }
>  
>  #define DO_STN_1(N, NAME, ESIZE) \
> -void __attribute__((flatten)) HELPER(sve_st##N##NAME##_r)           \
> +void QEMU_FLATTEN HELPER(sve_st##N##NAME##_r) \
>      (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)  \
>  {                                                                   \
>      sve_st##N##_r(env, vg, addr, desc, GETPC(), ESIZE, 1,           \
> @@ -4840,13 +4840,13 @@ void __attribute__((flatten)) HELPER(sve_st##N##NAME##_r)           \
>  }
>  
>  #define DO_STN_2(N, NAME, ESIZE, MSIZE) \
> -void __attribute__((flatten)) HELPER(sve_st##N##NAME##_le_r)          \
> +void QEMU_FLATTEN HELPER(sve_st##N##NAME##_le_r) \
>      (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)    \
>  {                                                                     \
>      sve_st##N##_r(env, vg, addr, desc, GETPC(), ESIZE, MSIZE,         \
>                    sve_st1##NAME##_le_tlb);                            \
>  }                                                                     \
> -void __attribute__((flatten)) HELPER(sve_st##N##NAME##_be_r)          \
> +void QEMU_FLATTEN HELPER(sve_st##N##NAME##_be_r)                      \
>      (CPUARMState *env, void *vg, target_ulong addr, uint32_t desc)    \
>  {                                                                     \
>      sve_st##N##_r(env, vg, addr, desc, GETPC(), ESIZE, MSIZE,         \
> @@ -4966,7 +4966,7 @@ static void sve_ld1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
>  }
>  
>  #define DO_LD1_ZPZ_S(MEM, OFS) \
> -void __attribute__((flatten)) HELPER(sve_ld##MEM##_##OFS)    \
> +void QEMU_FLATTEN HELPER(sve_ld##MEM##_##OFS) \
>      (CPUARMState *env, void *vd, void *vg, void *vm,         \
>       target_ulong base, uint32_t desc)                       \
>  {                                                            \
> @@ -4975,7 +4975,7 @@ void __attribute__((flatten)) HELPER(sve_ld##MEM##_##OFS)    \
>  }
>  
>  #define DO_LD1_ZPZ_D(MEM, OFS) \
> -void __attribute__((flatten)) HELPER(sve_ld##MEM##_##OFS)    \
> +void QEMU_FLATTEN HELPER(sve_ld##MEM##_##OFS) \
>      (CPUARMState *env, void *vd, void *vg, void *vm,         \
>       target_ulong base, uint32_t desc)                       \
>  {                                                            \
> @@ -5326,7 +5326,7 @@ static void sve_st1_zd(CPUARMState *env, void *vd, void *vg, void *vm,
>  }
>  
>  #define DO_ST1_ZPZ_S(MEM, OFS) \
> -void __attribute__((flatten)) HELPER(sve_st##MEM##_##OFS)    \
> +void QEMU_FLATTEN HELPER(sve_st##MEM##_##OFS) \
>      (CPUARMState *env, void *vd, void *vg, void *vm,         \
>       target_ulong base, uint32_t desc)                       \
>  {                                                            \
> @@ -5335,7 +5335,7 @@ void __attribute__((flatten)) HELPER(sve_st##MEM##_##OFS)    \
>  }
>  
>  #define DO_ST1_ZPZ_D(MEM, OFS) \
> -void __attribute__((flatten)) HELPER(sve_st##MEM##_##OFS)    \
> +void QEMU_FLATTEN HELPER(sve_st##MEM##_##OFS) \
>      (CPUARMState *env, void *vd, void *vg, void *vm,         \
>       target_ulong base, uint32_t desc)                       \
>  {                                                            \
> 
