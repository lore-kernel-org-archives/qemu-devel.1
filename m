Return-Path: <SRS0=ZVNi=XW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB03DC4360C
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:34:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B56B2146E
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Sep 2019 13:34:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B56B2146E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50596 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iDqOa-00061z-H9
	for qemu-devel@archiver.kernel.org; Fri, 27 Sep 2019 09:34:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58298)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <david@redhat.com>) id 1iDpww-0006lj-P4
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:06:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <david@redhat.com>) id 1iDpwu-000543-BZ
 for qemu-devel@nongnu.org; Fri, 27 Sep 2019 09:06:18 -0400
Received: from mx1.redhat.com ([209.132.183.28]:35028)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <david@redhat.com>)
 id 1iDpwr-00052u-Rw; Fri, 27 Sep 2019 09:06:15 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 458C0C065119;
 Fri, 27 Sep 2019 10:40:42 +0000 (UTC)
Received: from [10.36.116.169] (ovpn-116-169.ams2.redhat.com [10.36.116.169])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 42AB15C549;
 Fri, 27 Sep 2019 10:40:41 +0000 (UTC)
Subject: Re: [PATCH v3 05/18] target/s390x: Use tcg_s390_program_interrupt in
 TCG helpers
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190926162615.31168-1-richard.henderson@linaro.org>
 <20190926162615.31168-6-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
 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
 SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <ec58c6cf-52ad-8487-71ae-478cbeafe1ba@redhat.com>
Date: Fri, 27 Sep 2019 12:40:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190926162615.31168-6-richard.henderson@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.31]); Fri, 27 Sep 2019 10:40:42 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 26.09.19 18:26, Richard Henderson wrote:
> Replace all uses of s390_program_interrupt within files
> that are marked CONFIG_TCG.  These are necessarily tcg-only.
> 
> This lets each of these users benefit from the QEMU_NORETURN
> attribute on tcg_s390_program_interrupt.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  target/s390x/cc_helper.c     |  4 ++--
>  target/s390x/crypto_helper.c |  7 +++----
>  target/s390x/excp_helper.c   |  2 +-
>  target/s390x/fpu_helper.c    |  6 +++---
>  target/s390x/int_helper.c    | 15 +++++++-------
>  target/s390x/mem_helper.c    | 40 ++++++++++++++++++------------------
>  target/s390x/misc_helper.c   | 18 ++++++++--------
>  7 files changed, 46 insertions(+), 46 deletions(-)
> 
> diff --git a/target/s390x/cc_helper.c b/target/s390x/cc_helper.c
> index 3cb00bcb09..44731e4a85 100644
> --- a/target/s390x/cc_helper.c
> +++ b/target/s390x/cc_helper.c
> @@ -21,6 +21,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "internal.h"
> +#include "tcg_s390x.h"
>  #include "exec/exec-all.h"
>  #include "exec/helper-proto.h"
>  #include "qemu/host-utils.h"
> @@ -588,8 +589,7 @@ void HELPER(sacf)(CPUS390XState *env, uint64_t a1)
>          break;
>      default:
>          HELPER_LOG("unknown sacf mode: %" PRIx64 "\n", a1);
> -        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
> -        break;
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
>      }
>  }
>  #endif
> diff --git a/target/s390x/crypto_helper.c b/target/s390x/crypto_helper.c
> index 1f83987e9d..ff3fbc3950 100644
> --- a/target/s390x/crypto_helper.c
> +++ b/target/s390x/crypto_helper.c
> @@ -13,6 +13,7 @@
>  #include "qemu/osdep.h"
>  #include "qemu/main-loop.h"
>  #include "internal.h"
> +#include "tcg_s390x.h"
>  #include "exec/helper-proto.h"
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
> @@ -34,16 +35,14 @@ uint32_t HELPER(msa)(CPUS390XState *env, uint32_t r1, uint32_t r2, uint32_t r3,
>      case S390_FEAT_TYPE_PCKMO:
>      case S390_FEAT_TYPE_PCC:
>          if (mod) {
> -            s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> -            return 0;
> +            tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>          }
>          break;
>      }
>  
>      s390_get_feat_block(type, subfunc);
>      if (!test_be_bit(fc, subfunc)) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> -        return 0;
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>      }
>  
>      switch (fc) {
> diff --git a/target/s390x/excp_helper.c b/target/s390x/excp_helper.c
> index 089623a248..dbff772d34 100644
> --- a/target/s390x/excp_helper.c
> +++ b/target/s390x/excp_helper.c
> @@ -614,7 +614,7 @@ void s390x_cpu_do_unaligned_access(CPUState *cs, vaddr addr,
>      S390CPU *cpu = S390_CPU(cs);
>      CPUS390XState *env = &cpu->env;
>  
> -    s390_program_interrupt(env, PGM_SPECIFICATION, retaddr);
> +    tcg_s390_program_interrupt(env, PGM_SPECIFICATION, retaddr);
>  }
>  
>  #endif /* CONFIG_USER_ONLY */
> diff --git a/target/s390x/fpu_helper.c b/target/s390x/fpu_helper.c
> index 7228eb96e2..8bb9f54fd0 100644
> --- a/target/s390x/fpu_helper.c
> +++ b/target/s390x/fpu_helper.c
> @@ -825,7 +825,7 @@ void HELPER(sfpc)(CPUS390XState *env, uint64_t fpc)
>  {
>      if (fpc_to_rnd[fpc & 0x7] == -1 || fpc & 0x03030088u ||
>          (!s390_has_feat(S390_FEAT_FLOATING_POINT_EXT) && fpc & 0x4)) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
>      }
>  
>      /* Install everything in the main FPC.  */
> @@ -843,7 +843,7 @@ void HELPER(sfas)(CPUS390XState *env, uint64_t fpc)
>  
>      if (fpc_to_rnd[fpc & 0x7] == -1 || fpc & 0x03030088u ||
>          (!s390_has_feat(S390_FEAT_FLOATING_POINT_EXT) && fpc & 0x4)) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
>      }
>  
>      /*
> @@ -880,7 +880,7 @@ void HELPER(sfas)(CPUS390XState *env, uint64_t fpc)
>  void HELPER(srnm)(CPUS390XState *env, uint64_t rnd)
>  {
>      if (rnd > 0x7 || fpc_to_rnd[rnd & 0x7] == -1) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
>      }
>  
>      env->fpc = deposit32(env->fpc, 0, 3, rnd);
> diff --git a/target/s390x/int_helper.c b/target/s390x/int_helper.c
> index 1d29a1fc1f..658507dd6d 100644
> --- a/target/s390x/int_helper.c
> +++ b/target/s390x/int_helper.c
> @@ -21,6 +21,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "internal.h"
> +#include "tcg_s390x.h"
>  #include "exec/exec-all.h"
>  #include "qemu/host-utils.h"
>  #include "exec/helper-proto.h"
> @@ -39,7 +40,7 @@ int64_t HELPER(divs32)(CPUS390XState *env, int64_t a, int64_t b64)
>      int64_t q;
>  
>      if (b == 0) {
> -        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
> +        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
>      }
>  
>      ret = q = a / b;
> @@ -47,7 +48,7 @@ int64_t HELPER(divs32)(CPUS390XState *env, int64_t a, int64_t b64)
>  
>      /* Catch non-representable quotient.  */
>      if (ret != q) {
> -        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
> +        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
>      }
>  
>      return ret;
> @@ -60,7 +61,7 @@ uint64_t HELPER(divu32)(CPUS390XState *env, uint64_t a, uint64_t b64)
>      uint64_t q;
>  
>      if (b == 0) {
> -        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
> +        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
>      }
>  
>      ret = q = a / b;
> @@ -68,7 +69,7 @@ uint64_t HELPER(divu32)(CPUS390XState *env, uint64_t a, uint64_t b64)
>  
>      /* Catch non-representable quotient.  */
>      if (ret != q) {
> -        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
> +        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
>      }
>  
>      return ret;
> @@ -79,7 +80,7 @@ int64_t HELPER(divs64)(CPUS390XState *env, int64_t a, int64_t b)
>  {
>      /* Catch divide by zero, and non-representable quotient (MIN / -1).  */
>      if (b == 0 || (b == -1 && a == (1ll << 63))) {
> -        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
> +        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
>      }
>      env->retxl = a % b;
>      return a / b;
> @@ -92,7 +93,7 @@ uint64_t HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al,
>      uint64_t ret;
>      /* Signal divide by zero.  */
>      if (b == 0) {
> -        s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
> +        tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
>      }
>      if (ah == 0) {
>          /* 64 -> 64/64 case */
> @@ -106,7 +107,7 @@ uint64_t HELPER(divu64)(CPUS390XState *env, uint64_t ah, uint64_t al,
>          env->retxl = a % b;
>          ret = q;
>          if (ret != q) {
> -            s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
> +            tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
>          }
>  #else
>          /* 32-bit hosts would need special wrapper functionality - just abort if
> diff --git a/target/s390x/mem_helper.c b/target/s390x/mem_helper.c
> index 77d2eb96d4..7d2a652823 100644
> --- a/target/s390x/mem_helper.c
> +++ b/target/s390x/mem_helper.c
> @@ -21,6 +21,7 @@
>  #include "qemu/osdep.h"
>  #include "cpu.h"
>  #include "internal.h"
> +#include "tcg_s390x.h"
>  #include "exec/helper-proto.h"
>  #include "exec/exec-all.h"
>  #include "exec/cpu_ldst.h"
> @@ -71,7 +72,7 @@ static inline void check_alignment(CPUS390XState *env, uint64_t v,
>                                     int wordsize, uintptr_t ra)
>  {
>      if (v % wordsize) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>      }
>  }
>  
> @@ -730,7 +731,7 @@ void HELPER(srst)(CPUS390XState *env, uint32_t r1, uint32_t r2)
>  
>      /* Bits 32-55 must contain all 0.  */
>      if (env->regs[0] & 0xffffff00u) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>      }
>  
>      str = get_address(env, r2);
> @@ -767,7 +768,7 @@ void HELPER(srstu)(CPUS390XState *env, uint32_t r1, uint32_t r2)
>  
>      /* Bits 32-47 of R0 must be zero.  */
>      if (env->regs[0] & 0xffff0000u) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>      }
>  
>      str = get_address(env, r2);
> @@ -846,7 +847,7 @@ uint32_t HELPER(mvpg)(CPUS390XState *env, uint64_t r0, uint64_t r1, uint64_t r2)
>      S390Access srca, desta;
>  
>      if ((f && s) || extract64(r0, 12, 4)) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
>      }
>  
>      r1 = wrap_address(env, r1 & TARGET_PAGE_MASK);
> @@ -879,7 +880,7 @@ uint32_t HELPER(mvst)(CPUS390XState *env, uint32_t r1, uint32_t r2)
>      int i;
>  
>      if (env->regs[0] & 0xffffff00ull) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>      }
>  
>      /*
> @@ -911,7 +912,7 @@ void HELPER(lam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>      int i;
>  
>      if (a2 & 0x3) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>      }
>  
>      for (i = r1;; i = (i + 1) % 16) {
> @@ -931,7 +932,7 @@ void HELPER(stam)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>      int i;
>  
>      if (a2 & 0x3) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>      }
>  
>      for (i = r1;; i = (i + 1) % 16) {
> @@ -1887,8 +1888,7 @@ static uint32_t do_csst(CPUS390XState *env, uint32_t r3, uint64_t a1,
>      return cc;
>  
>   spec_exception:
> -    s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> -    g_assert_not_reached();
> +    tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>  }
>  
>  uint32_t HELPER(csst)(CPUS390XState *env, uint32_t r3, uint64_t a1, uint64_t a2)
> @@ -1911,7 +1911,7 @@ void HELPER(lctlg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>      uint32_t i;
>  
>      if (src & 0x7) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>      }
>  
>      for (i = r1;; i = (i + 1) % 16) {
> @@ -1944,7 +1944,7 @@ void HELPER(lctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>      uint32_t i;
>  
>      if (src & 0x3) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>      }
>  
>      for (i = r1;; i = (i + 1) % 16) {
> @@ -1975,7 +1975,7 @@ void HELPER(stctg)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>      uint32_t i;
>  
>      if (dest & 0x7) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>      }
>  
>      for (i = r1;; i = (i + 1) % 16) {
> @@ -1995,7 +1995,7 @@ void HELPER(stctl)(CPUS390XState *env, uint32_t r1, uint64_t a2, uint32_t r3)
>      uint32_t i;
>  
>      if (dest & 0x3) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>      }
>  
>      for (i = r1;; i = (i + 1) % 16) {
> @@ -2225,7 +2225,7 @@ void HELPER(idte)(CPUS390XState *env, uint64_t r1, uint64_t r2, uint32_t m4)
>      uint16_t entries, i, index = 0;
>  
>      if (r2 & 0xff000) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>      }
>  
>      if (!(r2 & 0x800)) {
> @@ -2369,7 +2369,7 @@ uint64_t HELPER(lra)(CPUS390XState *env, uint64_t addr)
>  
>      /* XXX incomplete - has more corner cases */
>      if (!(env->psw.mask & PSW_MASK_64) && (addr >> 32)) {
> -        s390_program_interrupt(env, PGM_SPECIAL_OP, GETPC());
> +        tcg_s390_program_interrupt(env, PGM_SPECIAL_OP, GETPC());
>      }
>  
>      old_exc = cs->exception_index;
> @@ -2538,7 +2538,7 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
>                 __func__, dest, src, len);
>  
>      if (!(env->psw.mask & PSW_MASK_DAT)) {
> -        s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
> +        tcg_s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
>      }
>  
>      /* OAC (operand access control) for the first operand -> dest */
> @@ -2569,14 +2569,14 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
>      }
>  
>      if (dest_a && dest_as == AS_HOME && (env->psw.mask & PSW_MASK_PSTATE)) {
> -        s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
> +        tcg_s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
>      }
>      if (!(env->cregs[0] & CR0_SECONDARY) &&
>          (dest_as == AS_SECONDARY || src_as == AS_SECONDARY)) {
> -        s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
> +        tcg_s390_program_interrupt(env, PGM_SPECIAL_OP, ra);
>      }
>      if (!psw_key_valid(env, dest_key) || !psw_key_valid(env, src_key)) {
> -        s390_program_interrupt(env, PGM_PRIVILEGED, ra);
> +        tcg_s390_program_interrupt(env, PGM_PRIVILEGED, ra);
>      }
>  
>      len = wrap_length32(env, len);
> @@ -2590,7 +2590,7 @@ uint32_t HELPER(mvcos)(CPUS390XState *env, uint64_t dest, uint64_t src,
>          (env->psw.mask & PSW_MASK_PSTATE)) {
>          qemu_log_mask(LOG_UNIMP, "%s: AR-mode and PSTATE support missing\n",
>                        __func__);
> -        s390_program_interrupt(env, PGM_ADDRESSING, ra);
> +        tcg_s390_program_interrupt(env, PGM_ADDRESSING, ra);
>      }
>  
>      /* FIXME: Access using correct keys and AR-mode */
> diff --git a/target/s390x/misc_helper.c b/target/s390x/misc_helper.c
> index 9fbb37cfb9..bfb457fb63 100644
> --- a/target/s390x/misc_helper.c
> +++ b/target/s390x/misc_helper.c
> @@ -106,7 +106,7 @@ uint32_t HELPER(servc)(CPUS390XState *env, uint64_t r1, uint64_t r2)
>      int r = sclp_service_call(env, r1, r2);
>      qemu_mutex_unlock_iothread();
>      if (r < 0) {
> -        s390_program_interrupt(env, -r, GETPC());
> +        tcg_s390_program_interrupt(env, -r, GETPC());
>      }
>      return r;
>  }
> @@ -143,7 +143,7 @@ void HELPER(diag)(CPUS390XState *env, uint32_t r1, uint32_t r3, uint32_t num)
>      }
>  
>      if (r) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
>      }
>  }
>  
> @@ -222,7 +222,7 @@ void HELPER(sckpf)(CPUS390XState *env, uint64_t r0)
>      uint32_t val = r0;
>  
>      if (val & 0xffff0000) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, GETPC());
>      }
>      env->todpr = val;
>  }
> @@ -266,7 +266,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0, uint64_t r0, uint64_t r1)
>      }
>  
>      if ((r0 & STSI_R0_RESERVED_MASK) || (r1 & STSI_R1_RESERVED_MASK)) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>      }
>  
>      if ((r0 & STSI_R0_FC_MASK) == STSI_R0_FC_CURRENT) {
> @@ -276,7 +276,7 @@ uint32_t HELPER(stsi)(CPUS390XState *env, uint64_t a0, uint64_t r0, uint64_t r1)
>      }
>  
>      if (a0 & ~TARGET_PAGE_MASK) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>      }
>  
>      /* count the cpus and split them into configured and reserved ones */
> @@ -509,7 +509,7 @@ uint32_t HELPER(tpi)(CPUS390XState *env, uint64_t addr)
>      LowCore *lowcore;
>  
>      if (addr & 0x3) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>      }
>  
>      qemu_mutex_lock_iothread();
> @@ -574,7 +574,7 @@ void HELPER(chsc)(CPUS390XState *env, uint64_t inst)
>  void HELPER(per_check_exception)(CPUS390XState *env)
>  {
>      if (env->per_perc_atmid) {
> -        s390_program_interrupt(env, PGM_PER, GETPC());
> +        tcg_s390_program_interrupt(env, PGM_PER, GETPC());
>      }
>  }
>  
> @@ -664,7 +664,7 @@ uint32_t HELPER(stfle)(CPUS390XState *env, uint64_t addr)
>      int i;
>  
>      if (addr & 0x7) {
> -        s390_program_interrupt(env, PGM_SPECIFICATION, ra);
> +        tcg_s390_program_interrupt(env, PGM_SPECIFICATION, ra);
>      }
>  
>      prepare_stfl();
> @@ -737,7 +737,7 @@ void HELPER(sic)(CPUS390XState *env, uint64_t r1, uint64_t r3)
>      qemu_mutex_unlock_iothread();
>      /* css_do_sic() may actually return a PGM_xxx value to inject */
>      if (r) {
> -        s390_program_interrupt(env, -r, GETPC());
> +        tcg_s390_program_interrupt(env, -r, GETPC());
>      }
>  }
>  
> 

Acked-by: David Hildenbrand <david@redhat.com>

-- 

Thanks,

David / dhildenb

