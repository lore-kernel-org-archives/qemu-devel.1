Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78FA4C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 08:11:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49A8120663
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 08:11:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49A8120663
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-sky.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35512 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDkqE-0004nU-5E
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 04:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47160)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jDkkE-0002qU-Vb
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:05:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <zhiwei_liu@c-sky.com>) id 1jDkkD-0006bS-6k
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 04:05:06 -0400
Received: from smtp2200-217.mail.aliyun.com ([121.197.200.217]:44748)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <zhiwei_liu@c-sky.com>)
 id 1jDkkC-0004rV-8s; Mon, 16 Mar 2020 04:05:05 -0400
X-Alimail-AntiSpam: AC=CONTINUE; BC=0.07633739|-1; CH=green; DM=||false|;
 DS=CONTINUE|ham_regular_dialog|0.0167076-0.00263636-0.980656;
 FP=0|0|0|0|0|-1|-1|-1; HT=e02c03308; MF=zhiwei_liu@c-sky.com; NM=1; PH=DS;
 RN=9; RT=9; SR=0; TI=SMTPD_---.H0EYJRp_1584345889; 
Received: from 172.16.31.150(mailfrom:zhiwei_liu@c-sky.com
 fp:SMTPD_---.H0EYJRp_1584345889)
 by smtp.aliyun-inc.com(10.147.42.241);
 Mon, 16 Mar 2020 16:04:50 +0800
Subject: Re: [PATCH v5 57/60] target/riscv: vector slide instructions
To: Richard Henderson <richard.henderson@linaro.org>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-58-zhiwei_liu@c-sky.com>
 <28063df7-bf38-d136-2d32-39651692c4c6@linaro.org>
From: LIU Zhiwei <zhiwei_liu@c-sky.com>
Message-ID: <88b87d58-5387-9d0d-b1a0-5705171f2e83@c-sky.com>
Date: Mon, 16 Mar 2020 16:04:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <28063df7-bf38-d136-2d32-39651692c4c6@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 3.x [generic] [fuzzy]
X-Received-From: 121.197.200.217
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
Cc: guoren@linux.alibaba.com, wenmeng_zhang@c-sky.com, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 2020/3/15 13:16, Richard Henderson wrote:
> On 3/12/20 7:58 AM, LIU Zhiwei wrote:
>> +#define GEN_VEXT_VSLIDEUP_VX(NAME, ETYPE, H, CLEAR_FN)                    \
>> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>> +        CPURISCVState *env, uint32_t desc)                                \
>> +{                                                                         \
>> +    uint32_t mlen = vext_mlen(desc);                                      \
>> +    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
>> +    uint32_t vm = vext_vm(desc);                                          \
>> +    uint32_t vl = env->vl;                                                \
>> +    uint32_t offset = s1, i;                                              \
>> +                                                                          \
>> +    if (offset > vl) {                                                    \
>> +        offset = vl;                                                      \
>> +    }                                                                     \
> This isn't right.
>
>> +    for (i = 0; i < vl; i++) {                                            \
>> +        if (((i < offset)) || (!vm && !vext_elem_mask(v0, mlen, i))) {    \
>> +            continue;                                                     \
>> +        }                                                                 \
>> +        *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - offset));          \
>> +    }                                                                     \
>> +    if (i == 0) {                                                         \
>> +        return;                                                           \
>> +    }                                                                     \
> You need to eliminate vl == 0 first, not last.
> Then
>
>      for (i = offset; i < vl; i++)
>
> The types of i and vl need to be extended to target_ulong, so that you don't
> incorrectly crop the input offset.
>
> It may be worth special-casing vm=1, or hoisting it out of the loop.  The
> operation becomes a memcpy (at least for little-endian) at that point.  See
> swap_memmove in arm/sve_helper.c.
>
>
>> +#define GEN_VEXT_VSLIDEDOWN_VX(NAME, ETYPE, H, CLEAR_FN)                  \
>> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>> +        CPURISCVState *env, uint32_t desc)                                \
>> +{                                                                         \
>> +    uint32_t mlen = vext_mlen(desc);                                      \
>> +    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
>> +    uint32_t vm = vext_vm(desc);                                          \
>> +    uint32_t vl = env->vl;                                                \
>> +    uint32_t offset = s1, i;                                              \
>> +                                                                          \
>> +    for (i = 0; i < vl; i++) {                                            \
>> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
>> +            continue;                                                     \
>> +        }                                                                 \
>> +        if (i + offset < vlmax) {                                         \
>> +            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i + offset));      \
> Again, eliminate vl == 0 first.  In fact, why don't we make that a global
> request for all of the patches for the next revision.  Checking for i == 0 last
> is silly, and checks for the zero twice: once in the loop bounds and again at
> the end.
>
> It is probably worth changing the loop bounds to
>
>      if (offset >= vlmax) {
>         max = 0;
>      } else {
>         max = MIN(vl, vlmax - offset);
>      }
>      for (i = 0; i < max; ++i)
>
>
>> +        } else {                                                          \
>> +            *((ETYPE *)vd + H(i)) = 0;                                    \
>> +        }
> Which lets these zeros merge into...
>
>> +    for (; i < vlmax; i++) {                                              \
>> +        CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));      \
>> +    }                                                                     \
> These zeros.
>
>> +#define GEN_VEXT_VSLIDE1UP_VX(NAME, ETYPE, H, CLEAR_FN)                   \
>> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>> +        CPURISCVState *env, uint32_t desc)                                \
>> +{                                                                         \
>> +    uint32_t mlen = vext_mlen(desc);                                      \
>> +    uint32_t vlmax = env_archcpu(env)->cfg.vlen / mlen;                   \
>> +    uint32_t vm = vext_vm(desc);                                          \
>> +    uint32_t vl = env->vl;                                                \
>> +    uint32_t i;                                                           \
>> +                                                                          \
>> +    for (i = 0; i < vl; i++) {                                            \
>> +        if (!vm && !vext_elem_mask(v0, mlen, i)) {                        \
>> +            continue;                                                     \
>> +        }                                                                 \
>> +        if (i == 0) {                                                     \
>> +            *((ETYPE *)vd + H(i)) = s1;                                   \
>> +        } else {                                                          \
>> +            *((ETYPE *)vd + H(i)) = *((ETYPE *)vs2 + H(i - 1));           \
>> +        }                                                                 \
>> +    }                                                                     \
>> +    if (i == 0) {                                                         \
>> +        return;                                                           \
>> +    }                                                                     \
>> +    for (; i < vlmax; i++) {                                              \
>> +        CLEAR_FN(vd, vl, vl * sizeof(ETYPE), vlmax * sizeof(ETYPE));      \
>> +    }                                                                     \
>> +}
> As a preference, I think you can do away with this helper.
> Simply use the slideup helper with argument 1, and then
> afterwards store the integer register into element 0.  You should be able to
> re-use code from vmv.s.x for that.
When I try it, I find it is some difficult, because  vmv.s.x will clean
the elements (0 < index < VLEN/SEW).

Zhiwei
>> +#define GEN_VEXT_VSLIDE1DOWN_VX(NAME, ETYPE, H, CLEAR_FN)                 \
>> +void HELPER(NAME)(void *vd, void *v0, target_ulong s1, void *vs2,         \
>> +        CPURISCVState *env, uint32_t desc)                                \
>> +{                                                                         \
> Likewise.
>
>
> r~


