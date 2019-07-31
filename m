Return-Path: <SRS0=/yOf=V4=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEAAC433FF
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 22:48:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06A8A20679
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2019 22:48:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pQPUGG55"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06A8A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44928 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsxO6-00027n-4u
	for qemu-devel@archiver.kernel.org; Wed, 31 Jul 2019 18:48:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42410)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hsxNg-0001as-O4
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 18:47:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hsxNf-0008Qt-I7
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 18:47:36 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hsxNf-0008QH-AU
 for qemu-devel@nongnu.org; Wed, 31 Jul 2019 18:47:35 -0400
Received: by mail-pl1-x641.google.com with SMTP id b3so31133471plr.4
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2019 15:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Yj8/e1DaY0Y8tUi5r24rXtA1g8VDx/b5LVf6n84eP40=;
 b=pQPUGG55BreEePR3myLH1Uw98L2y5tYrbioegD2LQIm2FXj7EvW0QtOxastwe3yecq
 QKB+8YHgT64vwK04IUp/zIYCaMnRxFWod4sBwgr6BWm21K4MRzrInq5V9BwAoGO3/ssG
 zQG3+JDEyBVa5ZpP5+Fbjban8DWUpoJTUHrXeSXHvEbY74RTY5jCOR2/oK+ObjgUOZPS
 YIVqqF/Y+UbQYIam2Ig1zeyRGOsAF3plu8LgWjqvknRg2zXiRlOkHmWqCkMfRjpiaGaw
 acDliJIiMWOOAtFhJT1z9I3mBSxZJW4dn38ewgUwRXvWocSl+oihPhEUnBIA36rCkXW7
 JGBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Yj8/e1DaY0Y8tUi5r24rXtA1g8VDx/b5LVf6n84eP40=;
 b=J12PFhVB75VvUONmNIZ4OepajNF3MKTK1smJbs9XJTMFmiP+EP9MF9tBwv9AypV+wO
 gLeaMqQC3p1CDNeli95Bmjjub2fXFwuC05uNlrYaINdCnpoH55P7eSqxt2htvINQzZ2A
 x1K6KJfx3LzufeeRtJf6mUr3yg4AA4plMxL79RGKn2m4hbR94SMQgD4/KeLK4xGgf3HV
 jw14N7XCPdb6jb7WL14Nrbw78PiKzdOK38N0+OicnEEKjqso8b8mSspwfJ07GX+BncAA
 T+GRTk3WbQIrt8iDh9rwjp5QVdgqXFvEb4rnfEwOAqTvgJC1bja/VLItO7ny/knCPwc4
 i0dw==
X-Gm-Message-State: APjAAAWeWdfepKzPTzFMjdQIqGIsLTaLPAzSasNmpQ8Lob+tRtfrPc2S
 p39wYPxfN3yry3RUfMfr+JSlag==
X-Google-Smtp-Source: APXvYqyDEvC/pLAvVgPNg0dyb64zK7U4F2JopwdCIKd++q31WoMjKUIM1DKlGKvhQ20aWri3WU/vCQ==
X-Received: by 2002:a17:902:324:: with SMTP id
 33mr119120037pld.340.1564613254135; 
 Wed, 31 Jul 2019 15:47:34 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id k6sm79037893pfi.12.2019.07.31.15.47.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 31 Jul 2019 15:47:33 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190731175702.4916-1-jan.bobek@gmail.com>
 <20190731175702.4916-7-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <0e38a01b-6a1b-cd18-1fd0-29faea840e69@linaro.org>
Date: Wed, 31 Jul 2019 15:47:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190731175702.4916-7-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
Subject: Re: [Qemu-devel] [RFC PATCH v1 06/22] target/i386: introduce
 gen_gvec_ld_modrm_* helpers
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/31/19 10:56 AM, Jan Bobek wrote:
> +static inline void gen_gvec_ld_modrm_2(CPUX86State *env, DisasContext *s,
> +                                       int modrm, unsigned vece,
> +                                       uint32_t oprsz, uint32_t maxsz,
> +                                       gen_ld_modrm_2_fp_t gen_ld_modrm_2_fp,
> +                                       gen_gvec_2_fp_t gen_gvec_2_fp,
> +                                       int opctl)
> +{
> +    uint32_t ofss[2];
> +
> +    const int opd = ((opctl >> 6) & 7) - 1;
> +    const int opa = ((opctl >> 3) & 7) - 1;
> +    const int opb = ((opctl >> 0) & 7) - 1;
> +
> +    assert(0 <= opd && opd < 2);
> +    assert(0 <= opa && opa < 2);
> +    assert(0 <= opb && opb < 2);
> +
> +    (*gen_ld_modrm_2_fp)(env, s, modrm, &ofss[0], &ofss[1]);
> +    (*gen_gvec_2_fp)(vece, ofss[opd], ofss[opa], ofss[opb], oprsz, maxsz);
> +}
> +
> +static inline void gen_gvec_ld_modrm_3(CPUX86State *env, DisasContext *s,
> +                                       int modrm, unsigned vece,
> +                                       uint32_t oprsz, uint32_t maxsz,
> +                                       gen_ld_modrm_3_fp_t gen_ld_modrm_3_fp,
> +                                       gen_gvec_2_fp_t gen_gvec_2_fp,
> +                                       int opctl)
> +{
> +    uint32_t ofss[3];
> +
> +    const int opd = ((opctl >> 6) & 7) - 1;
> +    const int opa = ((opctl >> 3) & 7) - 1;
> +    const int opb = ((opctl >> 0) & 7) - 1;
> +
> +    assert(0 <= opd && opd < 3);
> +    assert(0 <= opa && opa < 3);
> +    assert(0 <= opb && opb < 3);
> +
> +    (*gen_ld_modrm_3_fp)(env, s, modrm, &ofss[0], &ofss[1], &ofss[2]);
> +    (*gen_gvec_2_fp)(vece, ofss[opd], ofss[opa], ofss[opb], oprsz, maxsz);
> +}
> +> +#define gen_gvec_ld_modrm_mm(env, s, modrm, vece,                       \> +
                            gen_gvec_2_fp, opctl)                      \> +
gen_gvec_ld_modrm_2((env), (s), (modrm), (vece),                    \> +
                 sizeof(MMXReg), sizeof(MMXReg),                 \> +
              gen_ld_modrm_PqQq,                              \> +
           gen_gvec_2_fp, (opctl))> +> +#define gen_gvec_ld_modrm_xmm(env, s,
modrm, vece,                      \> +
gen_gvec_2_fp, opctl)                     \> +    gen_gvec_ld_modrm_2((env),
(s), (modrm), (vece),                    \> +
sizeof(XMMReg), sizeof(XMMReg),                 \> +
gen_ld_modrm_VxWx,                              \> +
gen_gvec_2_fp, (opctl))> +> +#define gen_gvec_ld_modrm_vxmm(env, s, modrm,
vece,                     \> +                               gen_gvec_2_fp,
opctl)                    \> +    gen_gvec_ld_modrm_3((env), (s), (modrm),
(vece),                    \> +                        sizeof(XMMReg),
sizeof(ZMMReg),                 \> +
gen_ld_modrm_VxHxWx,                            \> +
gen_gvec_2_fp, (opctl))> +> +#define gen_gvec_ld_modrm_vymm(env, s, modrm,
vece,                     \> +                               gen_gvec_2_fp,
opctl)                    \> +    gen_gvec_ld_modrm_3((env), (s), (modrm),
(vece),                    \> +                        sizeof(YMMReg),
sizeof(ZMMReg),                 \> +
gen_ld_modrm_VxHxWx,                            \> +
gen_gvec_2_fp, (opctl))

I suppose there aren't so many different combinations, but did you consider
separate callbacks per operand?  If you have

typedef unsigned (*gen_offset)(CPUX86State *, DisasContext *, int);

static unsigned offset_Pq(CPUX86State *env, DisasContext *s, int modrm)
{
    int reg = (modrm >> 3) & 7; /* Ignore REX_R */
    return offsetof(CPUX86State, fpregs[reg].mmx);
}

static unsigned offset_Qq(CPUX86State *env, DisasContext *s, int modrm)
{
    int mod = (modrm >> 6) & 3;
    unsigned ret;

    if (mod == 3) {
        int rm = modrm & 7; /* Ignore REX_B */
        ret = offsetof(CPUX86State, fpregs[rm].mmx);
    } else {
        ret = offsetof(CPUX86State, mmx_t0);
        gen_lea_modrm(env, s, modrm);
        gen_ldq_env_A0(s, ret);
    }
    return ret;
}

static unsigned offset_Vx(CPUX86State *env, DisasContext *s, int modrm)
{
    int reg = ((modrm >> 3) & 7) | REX_R(s);
    return offsetof(CPUX86State, xmm_regs[reg]);
}

static unsigned offset_Wx(CPUX86State *env, DisasContext *s, int modrm)
{
    int mod = (modrm >> 6) & 3;
    unsigned ret;

    if (mod == 3) {
        int rm = (modrm & 7) | REX_B(s);
        ret = offsetof(CPUX86State, xmm_regs[rm]);
    } else {
        ret = offsetof(CPUX86State, xmm_t0);
        gen_lea_modrm(env, s, modrm);
        gen_ldo_env_A0(s, ret);
    }
    return ret;
}

static unsigned offset_Hx(CPUX86State *env, DisasContext *s, int modrm)
{
    return offsetof(CPUX86State, xmm_regs[s->vex_v]);
}

Then you can have

#define GEN_GVEC_3(OP0, OP1, OP2, OPRSZ, MAXSZ)
static void gen_gvec_ld_modrm_##OP0##OP1##OP2(CPUX86State *env,      \
    DisasContext *s, int modrm, unsigned vece,  gen_gvec_2_fp_t gen) \
{                                               \
    int ofd = offset_##OP0(env, s, modrm);      \
    int of1 = offset_##OP1(env, s, modrm);      \
    int of2 = offset_##OP2(env, s, modrm);      \
    gen(vece, opd, opa, opb, OPRSZ, MAXSZ);     \
}

GEN_GVEC_3(Pq, Pq, Qq, sizeof(MMXReg), sizeof(MMXReg))
GEN_GVEC_3(Vx, Vx, Wx, sizeof(XMMReg), max_vec_size(s))
GEN_GVEC_3(Vx, Hx, Wx, sizeof(XMMReg), max_vec_size(s))

The PqPqQq and VxVxWx sub-strings aren't quite canonical, but imo a better fit
to the actual format of the instruction, with 2 inputs and 1 output.

You can also do

GEN_GVEC_3(Pq, Qq, Pq, sizeof(MMXReg), sizeof(MMXReg))

for those rare "reversed" operations like PANDN.  Now you don't need to carry
around the OPCTL argument, which I initially found non-obvious.

I initially thought you'd be able to infer maxsz from the set of arguments, but
since there are vex encoded operations that do not use vex.vvvv that is not
always the case.  Thus I suggest

static size_t max_vec_size(DisasContext *s)
{
    if (s->prefixes & PREFIX_VEX) {
        /*
         * TODO: When avx512 is supported and enabled, sizeof(ZMMReg).
         * In the meantime don't waste time zeroing data that is not
         * architecturally present.
         */
        return sizeof(YMMReg);
    } else {
        /* Without vex encoding, only the low 128 bits are modified. */
        return sizeof(XMMReg);
    }
}


r~

