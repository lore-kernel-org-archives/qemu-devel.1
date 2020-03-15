Return-Path: <SRS0=WIOf=5A=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C8E1FC0044D
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 01:02:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 85A6320724
	for <qemu-devel@archiver.kernel.org>; Sun, 15 Mar 2020 01:02:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G9sYZdyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 85A6320724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49864 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDHfZ-0006Vz-Ov
	for qemu-devel@archiver.kernel.org; Sat, 14 Mar 2020 21:02:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46763)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDHeN-0005lI-PF
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 21:01:10 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDHeK-0004y2-6E
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 21:01:06 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37740)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDHeJ-0004t4-Ro
 for qemu-devel@nongnu.org; Sat, 14 Mar 2020 21:01:04 -0400
Received: by mail-pg1-x541.google.com with SMTP id a32so6513637pga.4
 for <qemu-devel@nongnu.org>; Sat, 14 Mar 2020 18:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mJrio2yQ3FQdp6Uk8MuvUAwSrkjtgtGu3mwF+57gUGg=;
 b=G9sYZdyxym0lcJqcEIIq41EteEIr3A75D4E4gQFk1nPWVtqcxIHK/vHWImaaN+jJUe
 8644//CO76tu3rZ+mhMp9RmaPaunKdBKmqBGDF2b5qYIBTIHavhGQuxyxXvsVbtSMPo8
 xezv4WJNaCfsgORP+GJ+UAN3fuvOf/zfndnswhJhIS+zuD/6jUoSWY42jWUqMI/GcUAG
 PmIPOvFxeLkn3Tk0ykdIQ+Xtb8tPwzmjKijoItf/0yPuuTsCwKMdqA3eMngZcvPUYHX8
 XWkgOLsKCiU3ZzSJt4Jx1tvQjN3EtpKKY0A9oB6fCWt3GDg9bti9kNKoAGSd5OIzh2ha
 4TuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mJrio2yQ3FQdp6Uk8MuvUAwSrkjtgtGu3mwF+57gUGg=;
 b=pMFm7o7glPYETrO5GhkrhCW2V3cndUCUn7i8g6QyWeeRsAZdR1DMra3Y0DXdV/DJOI
 5h9qwq4xx+OgOpKGSSR3fXeeQvH6e4Tvh1HulNtwax0wHXTfsivXoXG0Ji1VcG786RIl
 iEk0lW+epM6azZ8PeLPq2asiwqyl5IV9y7+GNSna2oPPQ/3ib2Y7qgV3MAuIVCrDPzIc
 gwhPnW+Wlem+yMYat8V1wn5e/G349r2DK1d9YNti9fUjXsAnKSCa4yZos3ospJHOAIEE
 nu4cUzvy2HgVMxRga+8WzRWViz9dErPPzfDRBacGKEBl8f+JkiEDIyjvCbakmUqY9mYZ
 SGaA==
X-Gm-Message-State: ANhLgQ1jQjRcfc2HLHWzbDNUhpoKVhebcBa89NcJNOlyjEZbuyKCQRXQ
 x7ijJ62fgDevB6Umkx0vofRqrw==
X-Google-Smtp-Source: ADFU+vth6gJ/NGURH0yAoekltHdAPJH/haiyNcMgrJIPCT3zDwOLP7GVUmqHaqn+3hyAttmns8KySw==
X-Received: by 2002:a63:b34c:: with SMTP id x12mr3328232pgt.213.1584234061953; 
 Sat, 14 Mar 2020 18:01:01 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 f8sm4898222pfq.178.2020.03.14.18.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 14 Mar 2020 18:01:01 -0700 (PDT)
Subject: Re: [PATCH v5 24/60] target/riscv: vector single-width averaging add
 and subtract
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, alistair23@gmail.com,
 chihmin.chao@sifive.com, palmer@dabbelt.com
References: <20200312145900.2054-1-zhiwei_liu@c-sky.com>
 <20200312145900.2054-25-zhiwei_liu@c-sky.com>
 <834922de-5107-0d00-6d4d-47bd830129a5@linaro.org>
 <2db448ea-f17f-e627-055d-fb3cdf6cfddc@linaro.org>
 <d48f77ee-ad99-26fa-a597-6cdcd2d55508@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <426e31f8-1b54-7b5a-b2a9-a2742f9c74af@linaro.org>
Date: Sat, 14 Mar 2020 18:00:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <d48f77ee-ad99-26fa-a597-6cdcd2d55508@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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

On 3/14/20 4:12 PM, LIU Zhiwei wrote:
> I am not sure whether I get it. In my opinion, the code should be modified like
> 
> static inline int8_t aadd8_rnu(CPURISCVState *env, int8_t a, int8_t b)
> {
>     int16_t res = (int16_t)a + (int16_t)b;
>     uint8_t round = res & 0x1;
>     res   = (res >> 1) + round;
>     return res;
> }
> 
> static inline int8_t aadd8_rne(CPURISCVState *env, int8_t a, int8_t b)
> {
>     int16_t res = (int16_t)a + (int16_t)b;
>     uint8_t round = ((res & 0x3) == 0x3);
>     res   = (res >> 1) + round;
>     return res;
> }
> 
> static inline int8_t aadd8_rdn(CPURISCVState *env, int8_t a, int8_t b)
> {
>     int16_t res = (int16_t)a + (int16_t)b;
>     res   = (res >> 1);
>     return res;
> }
> 
> static inline int8_t aadd8_rod(CPURISCVState *env, int8_t a, int8_t b)
> {
>     int16_t res = (int16_t)a + (int16_t)b;
>     uint8_t round = ((res & 0x3) == 0x1);
>    res   = (res >> 1) + round;
>     return res;
> }
> 
> RVVCALL(OPIVV2_ENV, vaadd_vv_b_rnu, OP_SSS_B, H1, H1, H1, aadd8_rnu)
> RVVCALL(OPIVV2_ENV, vaadd_vv_b_rne, OP_SSS_B, H1, H1, H1, aadd8_rne)
> RVVCALL(OPIVV2_ENV, vaadd_vv_b_rdn, OP_SSS_B, H1, H1, H1, aadd8_rdn)
> RVVCALL(OPIVV2_ENV, vaadd_vv_b_rod, OP_SSS_B, H1, H1, H1, aadd8_rod)
> 
> void do_vext_vv_env(void *vd, void *v0, void *vs1,
>                     void *vs2, CPURISCVState *env, uint32_t desc,
>                     uint32_t esz, uint32_t dsz,
>                     opivv2_fn *fn, clear_fn *clearfn)
> {
>     uint32_t vlmax = vext_maxsz(desc) / esz;
>     uint32_t mlen = vext_mlen(desc);
>     uint32_t vm = vext_vm(desc);
>     uint32_t vl = env->vl;
>     uint32_t i;
>     for (i = 0; i < vl; i++) {
>         if (!vm && !vext_elem_mask(v0, mlen, i)) {
>             continue;
>         }
>         fn(vd, vs1, vs2, i, env);
>     }
>     if (i != 0) {
>         clear_fn(vd, vl, vl * dsz,  vlmax * dsz);
>     }
> }
> 
> #define GEN_VEXT_VV_ENV(NAME, ESZ, DSZ, CLEAR_FN)         \
> void HELPER(NAME)(void *vd, void *v0, void *vs1,          \
>                   void *vs2, CPURISCVState *env,          \
>                   uint32_t desc)                          \
> {                                                         \
>     static opivv2_fn *fns[4] = {                          \
>         NAME##_rnu, NAME##_rne,                           \
>         NAME##_rdn, NAME##_rod                            \
>     }                                                     \
>     return do_vext_vv_env(vd, v0, vs1, vs2, env, desc,    \
>                           ESZ, DSZ, fns[env->vxrm],       \
>               CLEAR_FN);                      \
> }
> 
> Is it true?

While that does look good for this case, there are many other uses of
get_round(), and it may not be quite as simple there.

My suggestion was

static inline int32_t aadd32(int vxrm, int32_t a, int32_t b)
{
    int64_t res = (int64_t)a + b;
    uint8_t round = get_round(vxrm, res, 1);

    return (res >> 1) + round;
}

static inline int64_t aadd64(int vxrm, int64_t a, int64_t b)
{
    int64_t res = a + b;
    uint8_t round = get_round(vxrm, res, 1);
    int64_t over = (res ^ a) & (res ^ b) & INT64_MIN;

    /* With signed overflow, bit 64 is inverse of bit 63. */
    return ((res >> 1) ^ over) + round;
}

RVVCALL(OPIVV2_RM, vaadd_vv_b, OP_SSS_B, H1, H1, H1, aadd32)
RVVCALL(OPIVV2_RM, vaadd_vv_h, OP_SSS_H, H2, H2, H2, aadd32)
RVVCALL(OPIVV2_RM, vaadd_vv_w, OP_SSS_W, H4, H4, H4, aadd32)
RVVCALL(OPIVV2_RM, vaadd_vv_d, OP_SSS_D, H8, H8, H8, aadd64)

static inline void
vext_vv_rm_1(void *vd, void *v0, void *vs1, void *vs2,
             uint32_t vl, uint32_t vm, uint32_t mlen, int vxrm,
             opivv2_rm_fn *fn)
{
    for (uint32_t i = 0; i < vl; i++) {
        if (!vm && !vext_elem_mask(v0, mlen, i)) {
            continue;
        }
        fn(vd, vs1, vs2, i, vxrm);
    }
}

static inline void
vext_vv_rm_2(void *vd, void *v0, void *vs1,
             void *vs2, CPURISCVState *env, uint32_t desc,
             uint32_t esz, uint32_t dsz,
             opivv2_rm_fn *fn, clear_fn *clearfn)
{
    uint32_t vlmax = vext_maxsz(desc) / esz;
    uint32_t mlen = vext_mlen(desc);
    uint32_t vm = vext_vm(desc);
    uint32_t vl = env->vl;

    if (vl == 0) {
        return;
    }

    switch (env->vxrm) {
    case 0: /* rnu */
        vext_vv_rm_1(vd, v0, vs1, vs2,
                     vl, vm, mlen, 0, fn);
        break;
    case 1: /* rne */
        vext_vv_rm_1(vd, v0, vs1, vs2,
                     vl, vm, mlen, 1, fn);
        break;
    case 2: /* rdn */
        vext_vv_rm_1(vd, v0, vs1, vs2,
                     vl, vm, mlen, 2, fn);
        break;
    default: /* rod */
        vext_vv_rm_1(vd, v0, vs1, vs2,
                     vl, vm, mlen, 3, fn);
        break;
    }

    clear_fn(vd, vl, vl * dsz,  vlmax * dsz);
}

>From vext_vv_rm_2, a constant is passed down all of the inline functions, so
that a constant arrives in get_round() at the bottom of the call chain.  At
which point all of the expressions get folded by the compiler and we *should*
get very similar generated code as to what you have above.


r~

