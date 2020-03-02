Return-Path: <SRS0=YPEG=4T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9536C3F2D1
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:53:05 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AE1C217F4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2020 23:53:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eHQTuhqe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AE1C217F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39868 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8urw-0007UE-PN
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 18:53:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:37938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <philmd@redhat.com>) id 1j8urE-0006o8-9Z
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:52:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <philmd@redhat.com>) id 1j8urC-0001Re-8I
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:52:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:49348
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <philmd@redhat.com>) id 1j8urC-0001RW-2y
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 18:52:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1583193137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UP+3myxBWkIA+S8UjGW053kSyo3LrQPLfLgVHDWrg5Q=;
 b=eHQTuhqebGT9SN+t1MAs8CB078c99GLgX2lwvExJw5u1dL/sZ2euVBuUgTdyb1sCGeUAL7
 rYmKHaJW8Gp8uVwpDIt+WRLgsd/PvMPEgWYE9QswSpOdN2pdieQUeWdGYeWRPZDjjmUg7+
 pppCAZzxTyeKkGisJ71vcrvcNoEwmBg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-460-7tOZo85PP0qqLc5YsXQtVg-1; Mon, 02 Mar 2020 18:52:14 -0500
X-MC-Unique: 7tOZo85PP0qqLc5YsXQtVg-1
Received: by mail-wm1-f71.google.com with SMTP id c5so332688wmd.8
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2020 15:52:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=tC8oDoFi4V8TscyIHhna3ps1lfZr97rcJn1I7EQbTJU=;
 b=QLbE1MuDgNvRCO924iqm2IJufloXWgzlzkjxFlE0eQYUyt2a3J6ifU/ZjVfD5ruxYR
 7ni3yUPGA6BDwnDpa9BZqb1HK/3dpP03zB5nFXdIx/hriOo4v7fL1YeVKXvnKA384u38
 OLIuLBCFEitMrksCEkpPb+UWoTeG8f5RmaMMoL4ZFBACJJxBmR/GQQF2lG0k/O4lJxVk
 El8MXvFAFeLj44scDim3p9HTe7YaWqWvNqICbaAD0bgS102Z013rz7La3dix5PhTYMi+
 6Cz/OxfxMll6dpz3oRvDWrM+qPo8ptu6oA4tCCLCWHFjZRJnlDAvFjfnT1qoNKTj6rGz
 yOTg==
X-Gm-Message-State: ANhLgQ0qG9h1/yeLfeV3AIGdwOR3KbQ6O+rU+mQLUA8Zq9/nz2CF8v+w
 AWufWULdPh+uvrilC74GEahOQC3y+3txl3UvqXPV1YWluUMtP4wJozC6cWAWTyZT2xPeKd/5ysI
 A79LXV7YfAFSconw=
X-Received: by 2002:a1c:2048:: with SMTP id g69mr748762wmg.187.1583193132537; 
 Mon, 02 Mar 2020 15:52:12 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuPeSpgwuL8cUnTDeKOtP9g5cV5d5imQP6AMe3+q4D+18RTHPaK1lORT1xrf6txh7ncVFqvJg==
X-Received: by 2002:a1c:2048:: with SMTP id g69mr748732wmg.187.1583193132029; 
 Mon, 02 Mar 2020 15:52:12 -0800 (PST)
Received: from ?IPv6:2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0?
 ([2a01:e35:2fb0:49e0:3f7b:4b69:b9c:cdc0])
 by smtp.gmail.com with ESMTPSA id c16sm931557wrm.24.2020.03.02.15.52.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Mar 2020 15:52:11 -0800 (PST)
Subject: Re: [PATCH v2 5/9] target/arm: Move helper_dc_zva to helper-a64.c
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20200302175829.2183-1-richard.henderson@linaro.org>
 <20200302175829.2183-6-richard.henderson@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Message-ID: <8b3eca47-f026-04e4-72d6-a97f228ba80f@redhat.com>
Date: Tue, 3 Mar 2020 00:52:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302175829.2183-6-richard.henderson@linaro.org>
Content-Language: en-US
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 205.139.110.61
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: peter.maydell@linaro.org, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/2/20 6:58 PM, Richard Henderson wrote:
> This is an aarch64-only function.  Move it out of the shared file.
> This patch is code movement only.
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/arm/helper-a64.h |  1 +
>   target/arm/helper.h     |  1 -
>   target/arm/helper-a64.c | 91 ++++++++++++++++++++++++++++++++++++++++
>   target/arm/op_helper.c  | 93 -----------------------------------------
>   4 files changed, 92 insertions(+), 94 deletions(-)
>=20
> diff --git a/target/arm/helper-a64.h b/target/arm/helper-a64.h
> index a915c1247f..b1a5935f61 100644
> --- a/target/arm/helper-a64.h
> +++ b/target/arm/helper-a64.h
> @@ -90,6 +90,7 @@ DEF_HELPER_2(advsimd_f16touinth, i32, f16, ptr)
>   DEF_HELPER_2(sqrt_f16, f16, f16, ptr)
>  =20
>   DEF_HELPER_2(exception_return, void, env, i64)
> +DEF_HELPER_2(dc_zva, void, env, i64)
>  =20
>   DEF_HELPER_FLAGS_3(pacia, TCG_CALL_NO_WG, i64, env, i64, i64)
>   DEF_HELPER_FLAGS_3(pacib, TCG_CALL_NO_WG, i64, env, i64, i64)
> diff --git a/target/arm/helper.h b/target/arm/helper.h
> index fcbf504121..72eb9e6a1a 100644
> --- a/target/arm/helper.h
> +++ b/target/arm/helper.h
> @@ -559,7 +559,6 @@ DEF_HELPER_FLAGS_3(crypto_sm4ekey, TCG_CALL_NO_RWG, v=
oid, ptr, ptr, ptr)
>  =20
>   DEF_HELPER_FLAGS_3(crc32, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
>   DEF_HELPER_FLAGS_3(crc32c, TCG_CALL_NO_RWG_SE, i32, i32, i32, i32)
> -DEF_HELPER_2(dc_zva, void, env, i64)
>  =20
>   DEF_HELPER_FLAGS_5(gvec_qrdmlah_s16, TCG_CALL_NO_RWG,
>                      void, ptr, ptr, ptr, ptr, i32)
> diff --git a/target/arm/helper-a64.c b/target/arm/helper-a64.c
> index 123ce50e7a..bc0649a44a 100644
> --- a/target/arm/helper-a64.c
> +++ b/target/arm/helper-a64.c
> @@ -18,6 +18,7 @@
>    */
>  =20
>   #include "qemu/osdep.h"
> +#include "qemu/units.h"
>   #include "cpu.h"
>   #include "exec/gdbstub.h"
>   #include "exec/helper-proto.h"
> @@ -1109,4 +1110,94 @@ uint32_t HELPER(sqrt_f16)(uint32_t a, void *fpstp)
>       return float16_sqrt(a, s);
>   }
>  =20
> +void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
> +{
> +    /*
> +     * Implement DC ZVA, which zeroes a fixed-length block of memory.
> +     * Note that we do not implement the (architecturally mandated)
> +     * alignment fault for attempts to use this on Device memory
> +     * (which matches the usual QEMU behaviour of not implementing eithe=
r
> +     * alignment faults or any memory attribute handling).
> +     */
>  =20
> +    ARMCPU *cpu =3D env_archcpu(env);
> +    uint64_t blocklen =3D 4 << cpu->dcz_blocksize;
> +    uint64_t vaddr =3D vaddr_in & ~(blocklen - 1);
> +
> +#ifndef CONFIG_USER_ONLY
> +    {
> +        /*
> +         * Slightly awkwardly, QEMU's TARGET_PAGE_SIZE may be less than
> +         * the block size so we might have to do more than one TLB looku=
p.
> +         * We know that in fact for any v8 CPU the page size is at least=
 4K
> +         * and the block size must be 2K or less, but TARGET_PAGE_SIZE i=
s only
> +         * 1K as an artefact of legacy v5 subpage support being present =
in the
> +         * same QEMU executable. So in practice the hostaddr[] array has
> +         * two entries, given the current setting of TARGET_PAGE_BITS_MI=
N.
> +         */
> +        int maxidx =3D DIV_ROUND_UP(blocklen, TARGET_PAGE_SIZE);
> +        void *hostaddr[DIV_ROUND_UP(2 * KiB, 1 << TARGET_PAGE_BITS_MIN)]=
;
> +        int try, i;
> +        unsigned mmu_idx =3D cpu_mmu_index(env, false);
> +        TCGMemOpIdx oi =3D make_memop_idx(MO_UB, mmu_idx);
> +
> +        assert(maxidx <=3D ARRAY_SIZE(hostaddr));
> +
> +        for (try =3D 0; try < 2; try++) {
> +
> +            for (i =3D 0; i < maxidx; i++) {
> +                hostaddr[i] =3D tlb_vaddr_to_host(env,
> +                                                vaddr + TARGET_PAGE_SIZE=
 * i,
> +                                                1, mmu_idx);
> +                if (!hostaddr[i]) {
> +                    break;
> +                }
> +            }
> +            if (i =3D=3D maxidx) {
> +                /*
> +                 * If it's all in the TLB it's fair game for just writin=
g to;
> +                 * we know we don't need to update dirty status, etc.
> +                 */
> +                for (i =3D 0; i < maxidx - 1; i++) {
> +                    memset(hostaddr[i], 0, TARGET_PAGE_SIZE);
> +                }
> +                memset(hostaddr[i], 0, blocklen - (i * TARGET_PAGE_SIZE)=
);
> +                return;
> +            }
> +            /*
> +             * OK, try a store and see if we can populate the tlb. This
> +             * might cause an exception if the memory isn't writable,
> +             * in which case we will longjmp out of here. We must for
> +             * this purpose use the actual register value passed to us
> +             * so that we get the fault address right.
> +             */
> +            helper_ret_stb_mmu(env, vaddr_in, 0, oi, GETPC());
> +            /* Now we can populate the other TLB entries, if any */
> +            for (i =3D 0; i < maxidx; i++) {
> +                uint64_t va =3D vaddr + TARGET_PAGE_SIZE * i;
> +                if (va !=3D (vaddr_in & TARGET_PAGE_MASK)) {
> +                    helper_ret_stb_mmu(env, va, 0, oi, GETPC());
> +                }
> +            }
> +        }
> +
> +        /*
> +         * Slow path (probably attempt to do this to an I/O device or
> +         * similar, or clearing of a block of code we have translations
> +         * cached for). Just do a series of byte writes as the architect=
ure
> +         * demands. It's not worth trying to use a cpu_physical_memory_m=
ap(),
> +         * memset(), unmap() sequence here because:
> +         *  + we'd need to account for the blocksize being larger than a=
 page
> +         *  + the direct-RAM access case is almost always going to be de=
alt
> +         *    with in the fastpath code above, so there's no speed benef=
it
> +         *  + we would have to deal with the map returning NULL because =
the
> +         *    bounce buffer was in use
> +         */
> +        for (i =3D 0; i < blocklen; i++) {
> +            helper_ret_stb_mmu(env, vaddr + i, 0, oi, GETPC());
> +        }
> +    }
> +#else
> +    memset(g2h(vaddr), 0, blocklen);
> +#endif
> +}
> diff --git a/target/arm/op_helper.c b/target/arm/op_helper.c
> index af3020b78f..eb0de080f1 100644
> --- a/target/arm/op_helper.c
> +++ b/target/arm/op_helper.c
> @@ -17,7 +17,6 @@
>    * License along with this library; if not, see <http://www.gnu.org/lic=
enses/>.
>    */
>   #include "qemu/osdep.h"
> -#include "qemu/units.h"
>   #include "qemu/log.h"
>   #include "qemu/main-loop.h"
>   #include "cpu.h"
> @@ -936,95 +935,3 @@ uint32_t HELPER(ror_cc)(CPUARMState *env, uint32_t x=
, uint32_t i)
>           return ((uint32_t)x >> shift) | (x << (32 - shift));
>       }
>   }
> -
> -void HELPER(dc_zva)(CPUARMState *env, uint64_t vaddr_in)
> -{
> -    /*
> -     * Implement DC ZVA, which zeroes a fixed-length block of memory.
> -     * Note that we do not implement the (architecturally mandated)
> -     * alignment fault for attempts to use this on Device memory
> -     * (which matches the usual QEMU behaviour of not implementing eithe=
r
> -     * alignment faults or any memory attribute handling).
> -     */
> -
> -    ARMCPU *cpu =3D env_archcpu(env);
> -    uint64_t blocklen =3D 4 << cpu->dcz_blocksize;
> -    uint64_t vaddr =3D vaddr_in & ~(blocklen - 1);
> -
> -#ifndef CONFIG_USER_ONLY
> -    {
> -        /*
> -         * Slightly awkwardly, QEMU's TARGET_PAGE_SIZE may be less than
> -         * the block size so we might have to do more than one TLB looku=
p.
> -         * We know that in fact for any v8 CPU the page size is at least=
 4K
> -         * and the block size must be 2K or less, but TARGET_PAGE_SIZE i=
s only
> -         * 1K as an artefact of legacy v5 subpage support being present =
in the
> -         * same QEMU executable. So in practice the hostaddr[] array has
> -         * two entries, given the current setting of TARGET_PAGE_BITS_MI=
N.
> -         */
> -        int maxidx =3D DIV_ROUND_UP(blocklen, TARGET_PAGE_SIZE);
> -        void *hostaddr[DIV_ROUND_UP(2 * KiB, 1 << TARGET_PAGE_BITS_MIN)]=
;
> -        int try, i;
> -        unsigned mmu_idx =3D cpu_mmu_index(env, false);
> -        TCGMemOpIdx oi =3D make_memop_idx(MO_UB, mmu_idx);
> -
> -        assert(maxidx <=3D ARRAY_SIZE(hostaddr));
> -
> -        for (try =3D 0; try < 2; try++) {
> -
> -            for (i =3D 0; i < maxidx; i++) {
> -                hostaddr[i] =3D tlb_vaddr_to_host(env,
> -                                                vaddr + TARGET_PAGE_SIZE=
 * i,
> -                                                1, mmu_idx);
> -                if (!hostaddr[i]) {
> -                    break;
> -                }
> -            }
> -            if (i =3D=3D maxidx) {
> -                /*
> -                 * If it's all in the TLB it's fair game for just writin=
g to;
> -                 * we know we don't need to update dirty status, etc.
> -                 */
> -                for (i =3D 0; i < maxidx - 1; i++) {
> -                    memset(hostaddr[i], 0, TARGET_PAGE_SIZE);
> -                }
> -                memset(hostaddr[i], 0, blocklen - (i * TARGET_PAGE_SIZE)=
);
> -                return;
> -            }
> -            /*
> -             * OK, try a store and see if we can populate the tlb. This
> -             * might cause an exception if the memory isn't writable,
> -             * in which case we will longjmp out of here. We must for
> -             * this purpose use the actual register value passed to us
> -             * so that we get the fault address right.
> -             */
> -            helper_ret_stb_mmu(env, vaddr_in, 0, oi, GETPC());
> -            /* Now we can populate the other TLB entries, if any */
> -            for (i =3D 0; i < maxidx; i++) {
> -                uint64_t va =3D vaddr + TARGET_PAGE_SIZE * i;
> -                if (va !=3D (vaddr_in & TARGET_PAGE_MASK)) {
> -                    helper_ret_stb_mmu(env, va, 0, oi, GETPC());
> -                }
> -            }
> -        }
> -
> -        /*
> -         * Slow path (probably attempt to do this to an I/O device or
> -         * similar, or clearing of a block of code we have translations
> -         * cached for). Just do a series of byte writes as the architect=
ure
> -         * demands. It's not worth trying to use a cpu_physical_memory_m=
ap(),
> -         * memset(), unmap() sequence here because:
> -         *  + we'd need to account for the blocksize being larger than a=
 page
> -         *  + the direct-RAM access case is almost always going to be de=
alt
> -         *    with in the fastpath code above, so there's no speed benef=
it
> -         *  + we would have to deal with the map returning NULL because =
the
> -         *    bounce buffer was in use
> -         */
> -        for (i =3D 0; i < blocklen; i++) {
> -            helper_ret_stb_mmu(env, vaddr + i, 0, oi, GETPC());
> -        }
> -    }
> -#else
> -    memset(g2h(vaddr), 0, blocklen);
> -#endif
> -}
>=20

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@redhat.com>


