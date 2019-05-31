Return-Path: <SRS0=hY9S=T7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B006C04AB6
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:41:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E224C26D4A
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2019 17:41:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E224C26D4A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47067 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWlXA-0002jt-1M
	for qemu-devel@archiver.kernel.org; Fri, 31 May 2019 13:41:40 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54382)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hWlWQ-0002I0-WB
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:40:56 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hWlWP-0006jC-4M
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:40:54 -0400
Received: from mx1.redhat.com ([209.132.183.28]:44340)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>) id 1hWlWK-0006Z0-U8
	for qemu-devel@nongnu.org; Fri, 31 May 2019 13:40:52 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 51EF230832EE;
	Fri, 31 May 2019 17:40:43 +0000 (UTC)
Received: from [10.36.116.233] (ovpn-116-233.ams2.redhat.com [10.36.116.233])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 72D051001F54;
	Fri, 31 May 2019 17:40:42 +0000 (UTC)
To: qemu-devel@nongnu.org
References: <20190531104432.29379-1-david@redhat.com>
	<20190531104432.29379-21-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	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
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <1a9adf87-5bbf-0c8f-6049-4140ede0800f@redhat.com>
Date: Fri, 31 May 2019 19:40:41 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190531104432.29379-21-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.44]);
	Fri, 31 May 2019 17:40:43 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v1 20/23] s390x/tcg: Implement VECTOR FP
 TEST DATA CLASS IMMEDIATE
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
Cc: Christian Borntraeger <borntraeger@de.ibm.com>,
	Denys Vlasenko <dvlasenk@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 31.05.19 12:44, David Hildenbrand wrote:
> We can reuse float64_dcmask().
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  2 ++
>  target/s390x/insn-data.def      |  2 ++
>  target/s390x/translate_vx.inc.c | 21 ++++++++++++++++++
>  target/s390x/vec_fpu_helper.c   | 39 +++++++++++++++++++++++++++++++++
>  4 files changed, 64 insertions(+)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index c788fc1b7f..e9aff83b05 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -292,6 +292,8 @@ DEF_HELPER_FLAGS_4(gvec_vfsq64, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
>  DEF_HELPER_FLAGS_4(gvec_vfsq64s, TCG_CALL_NO_WG, void, ptr, cptr, env, i32)
>  DEF_HELPER_FLAGS_5(gvec_vfs64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
>  DEF_HELPER_FLAGS_5(gvec_vfs64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
> +DEF_HELPER_4(gvec_vftci64, void, ptr, cptr, env, i32)
> +DEF_HELPER_4(gvec_vftci64s, void, ptr, cptr, env, i32)
>  
>  #ifndef CONFIG_USER_ONLY
>  DEF_HELPER_3(servc, i32, env, i64, i64)
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index 4426f40250..f421184fcd 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -1246,6 +1246,8 @@
>      F(0xe7ce, VFSQ,    VRR_a, V,   0, 0, 0, 0, vfsq, 0, IF_VEC)
>  /* VECTOR FP SUBTRACT */
>      F(0xe7e2, VFS,     VRR_c, V,   0, 0, 0, 0, vfa, 0, IF_VEC)
> +/* VECTOR FP TEST DATA CLASS IMMEDIATE */
> +    F(0xe74a, VFTCI,   VRI_e, V,   0, 0, 0, 0, vftci, 0, IF_VEC)
>  
>  #ifndef CONFIG_USER_ONLY
>  /* COMPARE AND SWAP AND PURGE */
> diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
> index bc75a147b6..715fcb2cb5 100644
> --- a/target/s390x/translate_vx.inc.c
> +++ b/target/s390x/translate_vx.inc.c
> @@ -2791,3 +2791,24 @@ static DisasJumpType op_vfsq(DisasContext *s, DisasOps *o)
>                     0, fn);
>      return DISAS_NEXT;
>  }
> +
> +static DisasJumpType op_vftci(DisasContext *s, DisasOps *o)
> +{
> +    const uint16_t i3 = get_field(s->fields, i3);
> +    const uint8_t fpf = get_field(s->fields, m4);
> +    const uint8_t m5 = get_field(s->fields, m5);
> +    gen_helper_gvec_2_ptr *fn = gen_helper_gvec_vftci64;
> +
> +    if (fpf != FPF_LONG || extract32(m5, 0, 3)) {
> +        gen_program_exception(s, PGM_SPECIFICATION);
> +        return DISAS_NORETURN;
> +    }
> +
> +    if (extract32(m5, 3, 1)) {
> +        fn = gen_helper_gvec_vftci64s;
> +    }
> +    gen_gvec_2_ptr(get_field(s->fields, v1), get_field(s->fields, v2), cpu_env,
> +                   i3, fn);
> +    set_cc_static(s);
> +    return DISAS_NEXT;
> +}
> diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.c
> index 10249c5105..930b6d1db4 100644
> --- a/target/s390x/vec_fpu_helper.c
> +++ b/target/s390x/vec_fpu_helper.c
> @@ -603,3 +603,42 @@ void HELPER(gvec_vfs64s)(void *v1, const void *v2, const void *v3,
>  {
>      vop64_3(v1, v2, v3, env, true, vfs64, GETPC());
>  }
> +
> +static int vftci64(S390Vector *v1, const S390Vector *v2, CPUS390XState *env,
> +                   bool s, uint16_t i3)
> +{
> +    int i, match = 0;
> +
> +    for (i = 0; i < 2; i++) {
> +        float64 a = make_float64(s390_vec_read_element64(v2, i));
> +
> +        if (float64_dcmask(env, a) & i3) {
> +            match++;
> +            s390_vec_write_element64(v1, i, -1ull);
> +        } else {
> +            s390_vec_write_element64(v1, i, 0);
> +        }
> +        if (s) {
> +            break;
> +        }
> +    }
> +
> +    if (match == i + 1) {
> +        return 0;
> +    } else if (match) {
> +        return 1;
> +    }

This is also wrong, similar to the other function.


-- 

Thanks,

David / dhildenb

