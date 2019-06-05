Return-Path: <SRS0=3v23=UE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6CF4C282DE
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 09:20:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF58F2075B
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2019 09:20:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF58F2075B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38148 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYS5n-0000ee-Ks
	for qemu-devel@archiver.kernel.org; Wed, 05 Jun 2019 05:20:23 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59498)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hYS4v-0000KN-4q
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:19:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <david@redhat.com>) id 1hYS4t-0005kU-Lp
	for qemu-devel@nongnu.org; Wed, 05 Jun 2019 05:19:29 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59214)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <david@redhat.com>)
	id 1hYS4t-00059n-Cb; Wed, 05 Jun 2019 05:19:27 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
	[10.5.11.16])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id C067A308AA11;
	Wed,  5 Jun 2019 09:19:15 +0000 (UTC)
Received: from [10.36.118.48] (unknown [10.36.118.48])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 135975C22C;
	Wed,  5 Jun 2019 09:19:06 +0000 (UTC)
To: qemu-devel@nongnu.org, Richard Henderson <rth@twiddle.net>
References: <20190603090635.10631-1-david@redhat.com>
	<20190603090635.10631-7-david@redhat.com>
From: David Hildenbrand <david@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=david@redhat.com; prefer-encrypt=mutual; keydata=
	xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
	dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
	QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
	XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
	Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
	PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
	WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
	UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
	jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
	B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzSREYXZpZCBIaWxk
	ZW5icmFuZCA8ZGF2aWRAcmVkaGF0LmNvbT7CwX4EEwECACgFAljj9eoCGwMFCQlmAYAGCwkI
	BwMCBhUIAgkKCwQWAgMBAh4BAheAAAoJEE3eEPcA/4Na5IIP/3T/FIQMxIfNzZshIq687qgG
	8UbspuE/YSUDdv7r5szYTK6KPTlqN8NAcSfheywbuYD9A4ZeSBWD3/NAVUdrCaRP2IvFyELj
	xoMvfJccbq45BxzgEspg/bVahNbyuBpLBVjVWwRtFCUEXkyazksSv8pdTMAs9IucChvFmmq3
	jJ2vlaz9lYt/lxN246fIVceckPMiUveimngvXZw21VOAhfQ+/sofXF8JCFv2mFcBDoa7eYob
	s0FLpmqFaeNRHAlzMWgSsP80qx5nWWEvRLdKWi533N2vC/EyunN3HcBwVrXH4hxRBMco3jvM
	m8VKLKao9wKj82qSivUnkPIwsAGNPdFoPbgghCQiBjBe6A75Z2xHFrzo7t1jg7nQfIyNC7ez
	MZBJ59sqA9EDMEJPlLNIeJmqslXPjmMFnE7Mby/+335WJYDulsRybN+W5rLT5aMvhC6x6POK
	z55fMNKrMASCzBJum2Fwjf/VnuGRYkhKCqqZ8gJ3OvmR50tInDV2jZ1DQgc3i550T5JDpToh
	dPBxZocIhzg+MBSRDXcJmHOx/7nQm3iQ6iLuwmXsRC6f5FbFefk9EjuTKcLMvBsEx+2DEx0E
	UnmJ4hVg7u1PQ+2Oy+Lh/opK/BDiqlQ8Pz2jiXv5xkECvr/3Sv59hlOCZMOaiLTTjtOIU7Tq
	7ut6OL64oAq+zsFNBFXLn5EBEADn1959INH2cwYJv0tsxf5MUCghCj/CA/lc/LMthqQ773ga
	uB9mN+F1rE9cyyXb6jyOGn+GUjMbnq1o121Vm0+neKHUCBtHyseBfDXHA6m4B3mUTWo13nid
	0e4AM71r0DS8+KYh6zvweLX/LL5kQS9GQeT+QNroXcC1NzWbitts6TZ+IrPOwT1hfB4WNC+X
	2n4AzDqp3+ILiVST2DT4VBc11Gz6jijpC/KI5Al8ZDhRwG47LUiuQmt3yqrmN63V9wzaPhC+
	xbwIsNZlLUvuRnmBPkTJwwrFRZvwu5GPHNndBjVpAfaSTOfppyKBTccu2AXJXWAE1Xjh6GOC
	8mlFjZwLxWFqdPHR1n2aPVgoiTLk34LR/bXO+e0GpzFXT7enwyvFFFyAS0Nk1q/7EChPcbRb
	hJqEBpRNZemxmg55zC3GLvgLKd5A09MOM2BrMea+l0FUR+PuTenh2YmnmLRTro6eZ/qYwWkC
	u8FFIw4pT0OUDMyLgi+GI1aMpVogTZJ70FgV0pUAlpmrzk/bLbRkF3TwgucpyPtcpmQtTkWS
	gDS50QG9DR/1As3LLLcNkwJBZzBG6PWbvcOyrwMQUF1nl4SSPV0LLH63+BrrHasfJzxKXzqg
	rW28CTAE2x8qi7e/6M/+XXhrsMYG+uaViM7n2je3qKe7ofum3s4vq7oFCPsOgwARAQABwsFl
	BBgBAgAPBQJVy5+RAhsMBQkJZgGAAAoJEE3eEPcA/4NagOsP/jPoIBb/iXVbM+fmSHOjEshl
	KMwEl/m5iLj3iHnHPVLBUWrXPdS7iQijJA/VLxjnFknhaS60hkUNWexDMxVVP/6lbOrs4bDZ
	NEWDMktAeqJaFtxackPszlcpRVkAs6Msn9tu8hlvB517pyUgvuD7ZS9gGOMmYwFQDyytpepo
	YApVV00P0u3AaE0Cj/o71STqGJKZxcVhPaZ+LR+UCBZOyKfEyq+ZN311VpOJZ1IvTExf+S/5
	lqnciDtbO3I4Wq0ArLX1gs1q1XlXLaVaA3yVqeC8E7kOchDNinD3hJS4OX0e1gdsx/e6COvy
	qNg5aL5n0Kl4fcVqM0LdIhsubVs4eiNCa5XMSYpXmVi3HAuFyg9dN+x8thSwI836FoMASwOl
	C7tHsTjnSGufB+D7F7ZBT61BffNBBIm1KdMxcxqLUVXpBQHHlGkbwI+3Ye+nE6HmZH7IwLwV
	W+Ajl7oYF+jeKaH4DZFtgLYGLtZ1LDwKPjX7VAsa4Yx7S5+EBAaZGxK510MjIx6SGrZWBrrV
	TEvdV00F2MnQoeXKzD7O4WFbL55hhyGgfWTHwZ457iN9SgYi1JLPqWkZB0JRXIEtjd4JEQcx
	+8Umfre0Xt4713VxMygW0PnQt5aSQdMD58jHFxTk092mU+yIHj5LeYgvwSgZN4airXk5yRXl
	SE+xAvmumFBY
Organization: Red Hat GmbH
Message-ID: <ab465abb-4a36-8155-218e-450cfd8d5434@redhat.com>
Date: Wed, 5 Jun 2019 11:19:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190603090635.10631-7-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.41]);
	Wed, 05 Jun 2019 09:19:15 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 06/22] s390x/tcg: Implement VECTOR FP
 COMPARE (EQUAL|HIGH|HIGH OR EQUAL)
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
Cc: Thomas Huth <thuth@redhat.com>, Denys Vlasenko <dvlasenk@redhat.com>,
	Cornelia Huck <cohuck@redhat.com>, Pino Toscano <ptoscano@redhat.com>,
	Christian Borntraeger <borntraeger@de.ibm.com>, qemu-s390x@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 03.06.19 11:06, David Hildenbrand wrote:
> Provide for all three instructions all four combinations of cc bit and
> s bit.
> 
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---
>  target/s390x/helper.h           |  12 ++++
>  target/s390x/insn-data.def      |   6 ++
>  target/s390x/translate_vx.inc.c |  51 ++++++++++++++++
>  target/s390x/vec_fpu_helper.c   | 104 ++++++++++++++++++++++++++++++++
>  4 files changed, 173 insertions(+)
> 
> diff --git a/target/s390x/helper.h b/target/s390x/helper.h
> index d34d6802a6..33d3bacf74 100644
> --- a/target/s390x/helper.h
> +++ b/target/s390x/helper.h
> @@ -254,6 +254,18 @@ DEF_HELPER_FLAGS_5(gvec_vfa64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
>  DEF_HELPER_FLAGS_5(gvec_vfa64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
>  DEF_HELPER_4(gvec_wfc64, void, cptr, cptr, env, i32)
>  DEF_HELPER_4(gvec_wfk64, void, cptr, cptr, env, i32)
> +DEF_HELPER_FLAGS_5(gvec_vfce64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
> +DEF_HELPER_FLAGS_5(gvec_vfce64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
> +DEF_HELPER_5(gvec_vfce64_cc, void, ptr, cptr, cptr, env, i32)
> +DEF_HELPER_5(gvec_vfce64s_cc, void, ptr, cptr, cptr, env, i32)
> +DEF_HELPER_FLAGS_5(gvec_vfch64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
> +DEF_HELPER_FLAGS_5(gvec_vfch64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
> +DEF_HELPER_5(gvec_vfch64_cc, void, ptr, cptr, cptr, env, i32)
> +DEF_HELPER_5(gvec_vfch64s_cc, void, ptr, cptr, cptr, env, i32)
> +DEF_HELPER_FLAGS_5(gvec_vfche64, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
> +DEF_HELPER_FLAGS_5(gvec_vfche64s, TCG_CALL_NO_WG, void, ptr, cptr, cptr, env, i32)
> +DEF_HELPER_5(gvec_vfche64_cc, void, ptr, cptr, cptr, env, i32)
> +DEF_HELPER_5(gvec_vfche64s_cc, void, ptr, cptr, cptr, env, i32)
>  
>  #ifndef CONFIG_USER_ONLY
>  DEF_HELPER_3(servc, i32, env, i64, i64)
> diff --git a/target/s390x/insn-data.def b/target/s390x/insn-data.def
> index c45e101b10..446552f251 100644
> --- a/target/s390x/insn-data.def
> +++ b/target/s390x/insn-data.def
> @@ -1212,6 +1212,12 @@
>      F(0xe7cb, WFC,     VRR_a, V,   0, 0, 0, 0, wfc, 0, IF_VEC)
>  /* VECTOR FP COMPARE AND SIGNAL SCALAR */
>      F(0xe7ca, WFK,     VRR_a, V,   0, 0, 0, 0, wfc, 0, IF_VEC)
> +/* VECTOR FP COMPARE EQUAL */
> +    F(0xe7e8, VFCE,    VRR_c, V,   0, 0, 0, 0, vfc, 0, IF_VEC)
> +/* VECTOR FP COMPARE HIGH */
> +    F(0xe7eb, VFCH,    VRR_c, V,   0, 0, 0, 0, vfc, 0, IF_VEC)
> +/* VECTOR FP COMPARE HIGH OR EQUAL */
> +    F(0xe7ea, VFCHE,   VRR_c, V,   0, 0, 0, 0, vfc, 0, IF_VEC)
>  
>  #ifndef CONFIG_USER_ONLY
>  /* COMPARE AND SWAP AND PURGE */
> diff --git a/target/s390x/translate_vx.inc.c b/target/s390x/translate_vx.inc.c
> index 283e8aa07a..5571a71e1a 100644
> --- a/target/s390x/translate_vx.inc.c
> +++ b/target/s390x/translate_vx.inc.c
> @@ -2588,3 +2588,54 @@ static DisasJumpType op_wfc(DisasContext *s, DisasOps *o)
>      set_cc_static(s);
>      return DISAS_NEXT;
>  }
> +
> +static DisasJumpType op_vfc(DisasContext *s, DisasOps *o)
> +{
> +    const uint8_t fpf = get_field(s->fields, m4);
> +    const uint8_t m5 = get_field(s->fields, m5);
> +    const uint8_t m6 = get_field(s->fields, m6);
> +    const bool se = extract32(m5, 3, 1);
> +    const bool cs = extract32(m6, 0, 1);
> +    gen_helper_gvec_3_ptr *fn;
> +
> +    if (fpf != FPF_LONG || extract32(m5, 0, 3) || extract32(m6, 1, 3)) {
> +        gen_program_exception(s, PGM_SPECIFICATION);
> +        return DISAS_NORETURN;
> +    }
> +
> +    if (cs) {
> +        switch (s->fields->op2) {
> +        case 0xe8:
> +            fn = se ? gen_helper_gvec_vfce64s_cc : gen_helper_gvec_vfce64_cc;
> +            break;
> +        case 0xeb:
> +            fn = se ? gen_helper_gvec_vfch64s_cc : gen_helper_gvec_vfch64_cc;
> +            break;
> +        case 0xea:
> +            fn = se ? gen_helper_gvec_vfche64s_cc : gen_helper_gvec_vfche64_cc;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    } else {
> +        switch (s->fields->op2) {
> +        case 0xe8:
> +            fn = se ? gen_helper_gvec_vfce64s : gen_helper_gvec_vfce64;
> +            break;
> +        case 0xeb:
> +            fn = se ? gen_helper_gvec_vfch64s : gen_helper_gvec_vfch64;
> +            break;
> +        case 0xea:
> +            fn = se ? gen_helper_gvec_vfche64s : gen_helper_gvec_vfche64;
> +            break;
> +        default:
> +            g_assert_not_reached();
> +        }
> +    }
> +    gen_gvec_3_ptr(get_field(s->fields, v1), get_field(s->fields, v2),
> +                   get_field(s->fields, v3), cpu_env, 0, fn);
> +    if (cs) {
> +        set_cc_static(s);
> +    }
> +    return DISAS_NEXT;
> +}
> diff --git a/target/s390x/vec_fpu_helper.c b/target/s390x/vec_fpu_helper.c
> index f9357d9221..e72500d4d5 100644
> --- a/target/s390x/vec_fpu_helper.c
> +++ b/target/s390x/vec_fpu_helper.c
> @@ -149,3 +149,107 @@ void HELPER(gvec_wfk64)(const void *v1, const void *v2, CPUS390XState *env,
>  {
>      env->cc_op = wfc64(v1, v2, env, true, GETPC());
>  }
> +
> +typedef int (*vfc64_fn)(float64 a, float64 b, float_status *status);
> +static int vfc64(S390Vector *v1, const S390Vector *v2, const S390Vector *v3,
> +                 CPUS390XState *env, bool s, vfc64_fn fn, uintptr_t retaddr)
> +{
> +    uint8_t vxc, vec_exc = 0;
> +    S390Vector tmp = {};
> +    int match = 0;
> +    int i;
> +
> +    for (i = 0; i < 2; i++) {
> +        const float64 a = s390_vec_read_element64(v2, i);
> +        const float64 b = s390_vec_read_element64(v3, i);
> +
> +        /* swap the order of the parameters, so we can use existing functions */
> +        if (fn(b, a, &env->fpu_status)) {
> +            match++;
> +            s390_vec_write_element64(&tmp, i, -1ull);
> +        }
> +        vxc = check_ieee_exc(env, i, false, &vec_exc);
> +        if (s || vxc) {
> +            break;
> +        }
> +    }
> +
> +    handle_ieee_exc(env, vxc, vec_exc, retaddr);
> +    *v1 = tmp;
> +    if (match) {
> +        return s || match == 2 ? 0 : 1;
> +    }
> +    return 3;
> +}
> +
> +void HELPER(gvec_vfce64)(void *v1, const void *v2, const void *v3,
> +                         CPUS390XState *env, uint32_t desc)
> +{
> +    vfc64(v1, v2, v3, env, false, float64_eq_quiet, GETPC());
> +}
> +
> +void HELPER(gvec_vfce64s)(void *v1, const void *v2, const void *v3,
> +                          CPUS390XState *env, uint32_t desc)
> +{
> +    vfc64(v1, v2, v3, env, true, float64_eq_quiet, GETPC());
> +}
> +
> +void HELPER(gvec_vfce64_cc)(void *v1, const void *v2, const void *v3,
> +                            CPUS390XState *env, uint32_t desc)
> +{
> +    env->cc_op = vfc64(v1, v2, v3, env, false, float64_eq_quiet, GETPC());
> +}
> +
> +void HELPER(gvec_vfce64s_cc)(void *v1, const void *v2, const void *v3,
> +                            CPUS390XState *env, uint32_t desc)
> +{
> +    env->cc_op = vfc64(v1, v2, v3, env, true, float64_eq_quiet, GETPC());
> +}
> +
> +void HELPER(gvec_vfch64)(void *v1, const void *v2, const void *v3,
> +                         CPUS390XState *env, uint32_t desc)
> +{
> +    vfc64(v1, v2, v3, env, false, float64_lt_quiet, GETPC());
> +}
> +
> +void HELPER(gvec_vfch64s)(void *v1, const void *v2, const void *v3,
> +                          CPUS390XState *env, uint32_t desc)
> +{
> +    vfc64(v1, v2, v3, env, true, float64_lt_quiet, GETPC());
> +}
> +
> +void HELPER(gvec_vfch64_cc)(void *v1, const void *v2, const void *v3,
> +                            CPUS390XState *env, uint32_t desc)
> +{
> +    env->cc_op = vfc64(v1, v2, v3, env, false, float64_lt_quiet, GETPC());
> +}
> +
> +void HELPER(gvec_vfch64s_cc)(void *v1, const void *v2, const void *v3,
> +                             CPUS390XState *env, uint32_t desc)
> +{
> +    env->cc_op = vfc64(v1, v2, v3, env, true, float64_lt_quiet, GETPC());
> +}
> +
> +void HELPER(gvec_vfche64)(void *v1, const void *v2, const void *v3,
> +                          CPUS390XState *env, uint32_t desc)
> +{
> +    vfc64(v1, v2, v3, env, false, float64_le_quiet, GETPC());
> +}
> +
> +void HELPER(gvec_vfche64s)(void *v1, const void *v2, const void *v3,
> +                           CPUS390XState *env, uint32_t desc)
> +{
> +    vfc64(v1, v2, v3, env, true, float64_le_quiet, GETPC());
> +}
> +
> +void HELPER(gvec_vfche64_cc)(void *v1, const void *v2, const void *v3,
> +                             CPUS390XState *env, uint32_t desc)
> +{
> +    env->cc_op = vfc64(v1, v2, v3, env, false, float64_le_quiet, GETPC());
> +}
> +
> +void HELPER(gvec_vfche64s_cc)(void *v1, const void *v2, const void *v3,
> +                              CPUS390XState *env, uint32_t desc)
> +{
> +    env->cc_op = vfc64(v1, v2, v3, env, true, float64_le_quiet, GETPC());
> +}
> 

Richard, still want to review this patch? I'm planning to send a pull
request soon.

-- 

Thanks,

David / dhildenb

