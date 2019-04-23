Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99FDBC10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 19:12:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D41321773
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 19:12:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D41321773
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:58395 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ0pp-0001po-Hs
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 15:12:05 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59872)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJ0ny-0000ID-0r
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:10:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hJ0i8-0001a7-64
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:04:10 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54958)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hJ0i7-0001Ya-Sy
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 15:04:08 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id EB039C05B01E;
	Tue, 23 Apr 2019 19:04:06 +0000 (UTC)
Received: from [10.36.116.61] (ovpn-116-61.ams2.redhat.com [10.36.116.61])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 169695DA2D;
	Tue, 23 Apr 2019 19:04:05 +0000 (UTC)
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20190420073442.7488-1-richard.henderson@linaro.org>
	<20190420073442.7488-13-richard.henderson@linaro.org>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	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
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <ab0269a3-c0fd-44c4-f939-e3f073e8e2dd@redhat.com>
Date: Tue, 23 Apr 2019 21:04:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190420073442.7488-13-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.31]);
	Tue, 23 Apr 2019 19:04:07 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 12/38] tcg: Add gvec expanders for variable
 shift
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423190405.b-MeCY0gEnzjh-PrI7xQ44epFMNda2x9V-mUkJdUDC0@z>

In order to use this on s390x for VECTOR ELEMENT SHIFT, like

+static DisasJumpType op_vesv(DisasContext *s, DisasOps *o)
+{
+    const uint8_t es = get_field(s->fields, m4);
+    const uint8_t v1 = get_field(s->fields, v1);
+    const uint8_t v2 = get_field(s->fields, v2);
+    const uint8_t v3 = get_field(s->fields, v3);
+
+    if (es > ES_64) {
+        gen_program_exception(s, PGM_SPECIFICATION);
+        return DISAS_NORETURN;
+    }
+
+    switch (s->fields->op2) {
+    case 0x70:
+        gen_gvec_fn_3(shlv, es, v1, v2, v3);
+        break;
+    case 0x7a:
+        gen_gvec_fn_3(sarv, es, v1, v2, v3);
+        break;
+    case 0x78:
+        gen_gvec_fn_3(shrv, es, v1, v2, v3);
+        break;
+    default:
+        g_assert_not_reached();
+    }
+
+    return DISAS_NEXT;
+}

We need to mask of invalid bits from the shift. Can that be added?


On 20.04.19 09:34, Richard Henderson wrote:
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  accel/tcg/tcg-runtime.h      |  15 ++++
>  tcg/tcg-op-gvec.h            |   7 ++
>  tcg/tcg-op.h                 |   4 ++
>  accel/tcg/tcg-runtime-gvec.c | 132 +++++++++++++++++++++++++++++++++++
>  tcg/tcg-op-gvec.c            |  87 +++++++++++++++++++++++
>  tcg/tcg-op-vec.c             |  15 ++++
>  6 files changed, 260 insertions(+)
> 
> diff --git a/accel/tcg/tcg-runtime.h b/accel/tcg/tcg-runtime.h
> index dfe325625c..ed3ce5fd91 100644
> --- a/accel/tcg/tcg-runtime.h
> +++ b/accel/tcg/tcg-runtime.h
> @@ -254,6 +254,21 @@ DEF_HELPER_FLAGS_3(gvec_sar16i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_3(gvec_sar32i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_3(gvec_sar64i, TCG_CALL_NO_RWG, void, ptr, ptr, i32)
>  
> +DEF_HELPER_FLAGS_4(gvec_shl8v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_shl16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_shl32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_shl64v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +
> +DEF_HELPER_FLAGS_4(gvec_shr8v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_shr16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_shr32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_shr64v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +
> +DEF_HELPER_FLAGS_4(gvec_sar8v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_sar16v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_sar32v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +DEF_HELPER_FLAGS_4(gvec_sar64v, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> +
>  DEF_HELPER_FLAGS_4(gvec_eq8, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_eq16, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_eq32, TCG_CALL_NO_RWG, void, ptr, ptr, ptr, i32)
> diff --git a/tcg/tcg-op-gvec.h b/tcg/tcg-op-gvec.h
> index 850da32ded..1cd18a959a 100644
> --- a/tcg/tcg-op-gvec.h
> +++ b/tcg/tcg-op-gvec.h
> @@ -294,6 +294,13 @@ void tcg_gen_gvec_shri(unsigned vece, uint32_t dofs, uint32_t aofs,
>  void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
>                         int64_t shift, uint32_t oprsz, uint32_t maxsz);
>  
> +void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> +void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz);
> +
>  void tcg_gen_gvec_cmp(TCGCond cond, unsigned vece, uint32_t dofs,
>                        uint32_t aofs, uint32_t bofs,
>                        uint32_t oprsz, uint32_t maxsz);
> diff --git a/tcg/tcg-op.h b/tcg/tcg-op.h
> index 9fff9864f6..833c6330b5 100644
> --- a/tcg/tcg-op.h
> +++ b/tcg/tcg-op.h
> @@ -986,6 +986,10 @@ void tcg_gen_shli_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
>  void tcg_gen_shri_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
>  void tcg_gen_sari_vec(unsigned vece, TCGv_vec r, TCGv_vec a, int64_t i);
>  
> +void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
> +void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
> +void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec s);
> +
>  void tcg_gen_cmp_vec(TCGCond cond, unsigned vece, TCGv_vec r,
>                       TCGv_vec a, TCGv_vec b);
>  
> diff --git a/accel/tcg/tcg-runtime-gvec.c b/accel/tcg/tcg-runtime-gvec.c
> index e2c6f24262..7b88f5590c 100644
> --- a/accel/tcg/tcg-runtime-gvec.c
> +++ b/accel/tcg/tcg-runtime-gvec.c
> @@ -725,6 +725,138 @@ void HELPER(gvec_sar64i)(void *d, void *a, uint32_t desc)
>      clear_high(d, oprsz, desc);
>  }
>  
> +void HELPER(gvec_shl8v)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
> +        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) << *(uint8_t *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_shl16v)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
> +        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) << *(uint16_t *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_shl32v)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
> +        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) << *(uint32_t *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_shl64v)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
> +        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) << *(uint64_t *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_shr8v)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(uint8_t)) {
> +        *(uint8_t *)(d + i) = *(uint8_t *)(a + i) >> *(uint8_t *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_shr16v)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(uint16_t)) {
> +        *(uint16_t *)(d + i) = *(uint16_t *)(a + i) >> *(uint16_t *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_shr32v)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(uint32_t)) {
> +        *(uint32_t *)(d + i) = *(uint32_t *)(a + i) >> *(uint32_t *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_shr64v)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(uint64_t)) {
> +        *(uint64_t *)(d + i) = *(uint64_t *)(a + i) >> *(uint64_t *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_sar8v)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec8)) {
> +        *(int8_t *)(d + i) = *(int8_t *)(a + i) >> *(int8_t *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_sar16v)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(int16_t)) {
> +        *(int16_t *)(d + i) = *(int16_t *)(a + i) >> *(int16_t *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_sar32v)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec32)) {
> +        *(int32_t *)(d + i) = *(int32_t *)(a + i) >> *(int32_t *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
> +void HELPER(gvec_sar64v)(void *d, void *a, void *b, uint32_t desc)
> +{
> +    intptr_t oprsz = simd_oprsz(desc);
> +    intptr_t i;
> +
> +    for (i = 0; i < oprsz; i += sizeof(vec64)) {
> +        *(int64_t *)(d + i) = *(int64_t *)(a + i) >> *(int64_t *)(b + i);
> +    }
> +    clear_high(d, oprsz, desc);
> +}
> +
>  /* If vectors are enabled, the compiler fills in -1 for true.
>     Otherwise, we must take care of this by hand.  */
>  #ifdef CONFIG_VECTOR16
> diff --git a/tcg/tcg-op-gvec.c b/tcg/tcg-op-gvec.c
> index f056018713..5d28184045 100644
> --- a/tcg/tcg-op-gvec.c
> +++ b/tcg/tcg-op-gvec.c
> @@ -2382,6 +2382,93 @@ void tcg_gen_gvec_sari(unsigned vece, uint32_t dofs, uint32_t aofs,
>      }
>  }
>  
> +void tcg_gen_gvec_shlv(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen3 g[4] = {
> +        { .fniv = tcg_gen_shlv_vec,
> +          .fno = gen_helper_gvec_shl8v,
> +          .opc = INDEX_op_shlv_vec,
> +          .vece = MO_8 },
> +        { .fniv = tcg_gen_shlv_vec,
> +          .fno = gen_helper_gvec_shl16v,
> +          .opc = INDEX_op_shlv_vec,
> +          .vece = MO_16 },
> +        { .fni4 = tcg_gen_shl_i32,
> +          .fniv = tcg_gen_shlv_vec,
> +          .fno = gen_helper_gvec_shl32v,
> +          .opc = INDEX_op_shlv_vec,
> +          .vece = MO_32 },
> +        { .fni8 = tcg_gen_shl_i64,
> +          .fniv = tcg_gen_shlv_vec,
> +          .fno = gen_helper_gvec_shl64v,
> +          .opc = INDEX_op_shlv_vec,
> +          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
> +          .vece = MO_64 },
> +    };
> +
> +    tcg_debug_assert(vece <= MO_64);
> +    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
> +}
> +
> +void tcg_gen_gvec_shrv(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen3 g[4] = {
> +        { .fniv = tcg_gen_shrv_vec,
> +          .fno = gen_helper_gvec_shr8v,
> +          .opc = INDEX_op_shrv_vec,
> +          .vece = MO_8 },
> +        { .fniv = tcg_gen_shrv_vec,
> +          .fno = gen_helper_gvec_shr16v,
> +          .opc = INDEX_op_shrv_vec,
> +          .vece = MO_16 },
> +        { .fni4 = tcg_gen_shr_i32,
> +          .fniv = tcg_gen_shrv_vec,
> +          .fno = gen_helper_gvec_shr32v,
> +          .opc = INDEX_op_shrv_vec,
> +          .vece = MO_32 },
> +        { .fni8 = tcg_gen_shr_i64,
> +          .fniv = tcg_gen_shrv_vec,
> +          .fno = gen_helper_gvec_shr64v,
> +          .opc = INDEX_op_shrv_vec,
> +          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
> +          .vece = MO_64 },
> +    };
> +
> +    tcg_debug_assert(vece <= MO_64);
> +    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
> +}
> +
> +void tcg_gen_gvec_sarv(unsigned vece, uint32_t dofs, uint32_t aofs,
> +                       uint32_t bofs, uint32_t oprsz, uint32_t maxsz)
> +{
> +    static const GVecGen3 g[4] = {
> +        { .fniv = tcg_gen_sarv_vec,
> +          .fno = gen_helper_gvec_sar8v,
> +          .opc = INDEX_op_sarv_vec,
> +          .vece = MO_8 },
> +        { .fniv = tcg_gen_sarv_vec,
> +          .fno = gen_helper_gvec_sar16v,
> +          .opc = INDEX_op_sarv_vec,
> +          .vece = MO_16 },
> +        { .fni4 = tcg_gen_sar_i32,
> +          .fniv = tcg_gen_sarv_vec,
> +          .fno = gen_helper_gvec_sar32v,
> +          .opc = INDEX_op_sarv_vec,
> +          .vece = MO_32 },
> +        { .fni8 = tcg_gen_sar_i64,
> +          .fniv = tcg_gen_sarv_vec,
> +          .fno = gen_helper_gvec_sar64v,
> +          .opc = INDEX_op_sarv_vec,
> +          .prefer_i64 = TCG_TARGET_REG_BITS == 64,
> +          .vece = MO_64 },
> +    };
> +
> +    tcg_debug_assert(vece <= MO_64);
> +    tcg_gen_gvec_3(dofs, aofs, bofs, oprsz, maxsz, &g[vece]);
> +}
> +
>  /* Expand OPSZ bytes worth of three-operand operations using i32 elements.  */
>  static void expand_cmp_i32(uint32_t dofs, uint32_t aofs, uint32_t bofs,
>                             uint32_t oprsz, TCGCond cond)
> diff --git a/tcg/tcg-op-vec.c b/tcg/tcg-op-vec.c
> index ce7987b858..6601cb8a8f 100644
> --- a/tcg/tcg-op-vec.c
> +++ b/tcg/tcg-op-vec.c
> @@ -481,3 +481,18 @@ void tcg_gen_umax_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
>  {
>      do_op3(vece, r, a, b, INDEX_op_umax_vec);
>  }
> +
> +void tcg_gen_shlv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    do_op3(vece, r, a, b, INDEX_op_shlv_vec);
> +}
> +
> +void tcg_gen_shrv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    do_op3(vece, r, a, b, INDEX_op_shrv_vec);
> +}
> +
> +void tcg_gen_sarv_vec(unsigned vece, TCGv_vec r, TCGv_vec a, TCGv_vec b)
> +{
> +    do_op3(vece, r, a, b, INDEX_op_sarv_vec);
> +}
> 


-- 

Thanks,

David / dhildenb

