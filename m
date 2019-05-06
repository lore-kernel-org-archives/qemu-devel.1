Return-Path: <SRS0=msIk=TG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14EFBC04AAA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 09:43:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF7D220830
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2019 09:43:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF7D220830
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53568 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNa9W-0002a3-ML
	for qemu-devel@archiver.kernel.org; Mon, 06 May 2019 05:43:18 -0400
Received: from eggs.gnu.org ([209.51.188.92]:39686)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hNa8j-0002I6-1T
	for qemu-devel@nongnu.org; Mon, 06 May 2019 05:42:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hNa8h-0001y9-Py
	for qemu-devel@nongnu.org; Mon, 06 May 2019 05:42:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:49679)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hNa8h-0001xS-Ho; Mon, 06 May 2019 05:42:27 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2679B2D7E5;
	Mon,  6 May 2019 09:42:25 +0000 (UTC)
Received: from [10.36.116.76] (ovpn-116-76.ams2.redhat.com [10.36.116.76])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9DF93100200D;
	Mon,  6 May 2019 09:42:23 +0000 (UTC)
To: qemu-devel@nongnu.org
References: <20190502141019.6385-1-david@redhat.com>
	<20190502141019.6385-41-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	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
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <ebe872ba-52e7-aeed-6d53-2ca6f44b5c26@redhat.com>
Date: Mon, 6 May 2019 11:42:22 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190502141019.6385-41-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.30]);
	Mon, 06 May 2019 09:42:25 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v3 40/40] s390x/tcg: Implement VECTOR TEST
 UNDER MASK
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
Cc: qemu-s390x@nongnu.org, Cornelia Huck <cohuck@redhat.com>,
	Richard Henderson <richard.henderson@linaro.org>,
	Thomas Huth <thuth@redhat.com>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 02.05.19 16:10, David Hildenbrand wrote:
> Let's return the cc value directly via cpu_env. Unfortunately there
> isn't a simple way to calculate the value lazily - one would have to
> calculate and store e.g. the population count of the mask and the
> result so it can be evaluated in a cc helper.
> 
> But as VTM only sets the cc, we can assume the value will be needed soon
> either way.
> 
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  1 +
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 11 +++++++++++
>  target/s390x/vec_int_helper.c   | 18 ++++++++++++++++++
>  4 files changed, 32 insertions(+)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index 2cb1f369bd..7755a96c33 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -209,6 +209,7 @@ DEF_HELPER_FLAGS_4(gvec_vsra, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
>  DEF_HELPER_FLAGS_4(gvec_vsrl, TCG_CALL_NO_RWG, void, ptr, cptr, i64, i32)
>  DEF_HELPER_FLAGS_4(gvec_vscbi8, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
>  DEF_HELPER_FLAGS_4(gvec_vscbi16, TCG_CALL_NO_RWG, void, ptr, cptr, cptr, i32)
> +DEF_HELPER_4(gvec_vtm, void, ptr, cptr, env, i32)
>  
>  #ifndef CONFIG_USER_ONLY
>  DEF_HELPER_3(servc, i32, env, i64, i64)
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index a52db41388..e61475bdc4 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -1188,6 +1188,8 @@
>      F(0xe767, VSUMQ,   VRR_c, V,   0, 0, 0, 0, vsumq, 0, IF_VEC)
>  /* VECTOR SUM ACROSS WORD */
>      F(0xe764, VSUM,    VRR_c, V,   0, 0, 0, 0, vsum, 0, IF_VEC)
> +/* VECTOR TEST UNDER MASK */
> +    F(0xe7d8, VTM,     VRR_a, V,   0, 0, 0, 0, vtm, 0, IF_VEC)
>  
>  #ifndef CONFIG_USER_ONLY
>  /* COMPARE AND SWAP AND PURGE */
> diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
> index 23eca2b332..e12ba00a13 100644
> --- a/target/s390x/translate_vx.inc.c
> +++ b/target/s390x/translate_vx.inc.c
> @@ -191,6 +191,9 @@ static void get_vec_element_ptr_i64(TCGv_ptr ptr, uint8_t reg, TCGv_i64 enr,
>  #define gen_gvec_2i_ool(v1, v2, c, data, fn) \
>      tcg_gen_gvec_2i_ool(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
>                          c, 16, 16, data, fn)
> +#define gen_gvec_2_ptr(v1, v2, ptr, data, fn) \
> +    tcg_gen_gvec_2_ptr(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
> +                       ptr, 16, 16, data, fn)
>  #define gen_gvec_3(v1, v2, v3, gen) \
>      tcg_gen_gvec_3(vec_full_reg_offset(v1), vec_full_reg_offset(v2), \
>                     vec_full_reg_offset(v3), 16, 16, gen)
> @@ -2338,3 +2341,11 @@ static DisasJumpType op_vsum(DisasContext *s, DisasOps *o)
>      tcg_temp_free_i32(tmp);
>      return DISAS_NEXT;
>  }
> +
> +static DisasJumpType op_vtm(DisasContext *s, DisasOps *o)
> +{
> +    gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
> +                   cpu_env, 0, gen_helper_gvec_vtm);
> +    set_cc_static(s);
> +    return DISAS_NEXT;
> +}
> diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.c
> index 09137dab99..3e8837e09a 100644
> --- a/target/s390x/vec_int_helper.c
> +++ b/target/s390x/vec_int_helper.c
> @@ -583,3 +583,21 @@ void HELPER(gvec_vscbi##BITS)(void *v1, const void *v2, const void *v3,        \
>  }
>  DEF_VSCBI(8)
>  DEF_VSCBI(16)
> +
> +void HELPER(gvec_vtm)(void *v1, const void *v2, CPUS390XState *env,
> +                      uint32_t desc)
> +{
> +    S390Vector tmp;
> +
> +    s390_vec_and(&tmp, v1, v2);
> +    if (s390_vec_is_zero(&tmp)) {
> +        /* Selected bits all zeros; or all mask bits zero */
> +        env->cc_op = 0;
> +    } else if (s390_vec_equal(&tmp, v2)) {
> +        /* Selected bits all ones */
> +        env->cc_op = 3;
> +    } else {
> +        /* Selected bits a mix of zeros and ones */
> +        env->cc_op = 1;
> +    }
> +}
> 


This hunk got lost in follow-up patches:

diff --git a/target/s390x/vec_int_helper.c b/target/s390x/vec_int_helper.c
index 09137dab99..68eaae407b 100644
--- a/target/s390x/vec_int_helper.c
+++ b/target/s390x/vec_int_helper.c
@@ -28,6 +28,19 @@ static void s390_vec_xor(S390Vector *res, const
S390Vector *a,
     res->doubleword[1] = a->doubleword[1] ^ b->doubleword[1];
 }

+static void s390_vec_and(S390Vector *res, const S390Vector *a,
+                         const S390Vector *b)
+{
+    res->doubleword[0] = a->doubleword[0] & b->doubleword[0];
+    res->doubleword[1] = a->doubleword[1] & b->doubleword[1];
+}
+
+static bool s390_vec_equal(const S390Vector *a, const S390Vector *b)
+{
+    return a->doubleword[0] == b->doubleword[0] &&
+           a->doubleword[1] == b->doubleword[1];
+}
+
 static void s390_vec_shl(S390Vector *d, const S390Vector *a, uint64_t
count)
 {
     uint64_t tmp;


-- 

Thanks,

David / dhildenb

