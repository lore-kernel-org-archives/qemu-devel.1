Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D6DFC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:57:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57AFB20656
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 19:57:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="pD0/l/0l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57AFB20656
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58956 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1EgY-0002dx-LL
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 15:57:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34720)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1Efz-0002C3-FE
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:57:15 -0400
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a]:52987)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1Efx-0008Hj-Mb
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 15:57:15 -0400
Received: by mail-pj1-x102a.google.com with SMTP id kr4so3238561pjb.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 12:57:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=q+OQZH0A78/893P2XM6/uHhB7U4385gH1+4XgbrDow4=;
 b=pD0/l/0l8ch4e8msk92NdUOwhDn2qveoG6B63qXgpWkUckCMh3/k7uKM4Ojzk47CnL
 Ek6p3IHo2oAvwxL3/B6M/XYuwqFm+iqHfO9E5cB3Dh6zBv3OM9yUA7qA3priI1ddeqoe
 bb7K8A5cJ/4guV7U12vnTg/Pjw7xjIj3NNo61HO3vkOHWytkCcpSAGevGVgdNll+o2WE
 beUAn3JpIHXuvhZSCCfK4/Gdwd2AUQo2OHm3Pz5v18I+BIrPsLB5JS458YEDfELah+OH
 mJl/J7aWudwq5gzqb8TaO0WAA91ccYcDh8EQtJ5lMt7kV1kozPWksGopK0lLlo5oS9hz
 hHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=q+OQZH0A78/893P2XM6/uHhB7U4385gH1+4XgbrDow4=;
 b=VdnEroy9YdJpChMUobMo0Uy7uNeXqmc2P3oPEQHnjrYTqg93BYEDFM+2izEkLslScW
 /EEDbJ5eM/+fu+3ZXN8fMgvZJiwAedZrremB4BLFCkfZiD0bIYiCJW8uvfd/JnKzQT1F
 Ff51TiX2jAy1+gwqL2G3y6cZQf4KENmQdVus5NMplBXnRjUhkso6MypXTtjetjQrRlQ+
 WoTxPgn48yAroKDzcMHxUdqKhrpSWfVogx0eVd/B5KdOhmtcmso2PawC3G7EFHscHx9o
 L4MRxcfBMrDmOKL6vaa/20oRbfZZ/lKFTUqSkQn+5G5YaoCai9BQVVX2T1Tzdl9Gf/u/
 hW3g==
X-Gm-Message-State: AOAM531SscizQuAeZZu8Tuq0vgJ75eRTqknbxT3wP6iUxWwTrKKiIE+o
 PNef2ETac9qBuGw/ksJQi4jirQ==
X-Google-Smtp-Source: ABdhPJwQFT7s+ZuHX3CrxvRdNIXrdGrZtvqFUcgy5aJBE5RXTrZbq2AX/JzPtNxoTQBT/Uw9hhINwg==
X-Received: by 2002:a62:1d90:: with SMTP id d138mr535919pfd.159.1596139031359; 
 Thu, 30 Jul 2020 12:57:11 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q2sm6500584pff.107.2020.07.30.12.57.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2020 12:57:10 -0700 (PDT)
Subject: Re: [RFC v2 40/76] target/riscv: rvv-0.9: floating-point move
 instruction
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-41-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <45dc44af-55d4-5254-4476-75b35e249d2c@linaro.org>
Date: Thu, 30 Jul 2020 12:57:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-41-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102a.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Cc: Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:16 AM, frank.chang@sifive.com wrote:
> From: Frank Chang <frank.chang@sifive.com>
> 
> NaN-boxed the scalar floating-point register based on RVV 0.9's rules.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvv.inc.c | 16 +++++++++++++++-
>  1 file changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/target/riscv/insn_trans/trans_rvv.inc.c b/target/riscv/insn_trans/trans_rvv.inc.c
> index 780f8660bf..54c08ea1f8 100644
> --- a/target/riscv/insn_trans/trans_rvv.inc.c
> +++ b/target/riscv/insn_trans/trans_rvv.inc.c
> @@ -2722,6 +2722,7 @@ GEN_OPFVF_TRANS(vfmerge_vfm,  opfvf_check)
>  static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
>  {
>      if (require_rvv(s) &&
> +        has_ext(s, RVF) &&
>          vext_check_isa_ill(s) &&
>          require_align(a->rd, s->flmul) &&
>          (s->sew != 0)) {
> @@ -2744,7 +2745,20 @@ static bool trans_vfmv_v_f(DisasContext *s, arg_vfmv_v_f *a)
>              dest = tcg_temp_new_ptr();
>              desc = tcg_const_i32(simd_desc(0, s->vlen / 8, data));
>              tcg_gen_addi_ptr(dest, cpu_env, vreg_ofs(s, a->rd));
> -            fns[s->sew - 1](dest, cpu_fpr[a->rs1], cpu_env, desc);
> +
> +            if ((s->sew < MO_64 && has_ext(s, RVD)) ||

Bearing in mind my nanboxing patch set that Alistair picked up (for 5.2, I
assume), wherein you would not check RVD, but allow the nanboxing to 64-bits to
happen always.

But this also isn't the correct place to do this.  You need to move it up above

        if (s->vl_eq_vlmax) {
            tcg_gen_gvec_dup_i64(s->sew, vreg_ofs(s, a->rd),
                                 MAXSZ(s), MAXSZ(s),
                                 cpu_fpr[a->rs1]);


> +                (s->sew < MO_32)) {
> +                /* SEW < FLEN */
> +                TCGv_i64 t1 = tcg_temp_new_i64();
> +                TCGv_i32 sew = tcg_const_i32(1 << (s->sew + 3));
> +                gen_helper_narrower_nanbox_fpr(t1, cpu_fpr[a->rs1],
> +                                               sew, cpu_env);

Also, while there is currently one function, gen_nanbox_s, you'll want to add
gen_nanbox_h to match.


r~


> +                fns[s->sew - 1](dest, t1, cpu_env, desc);
> +                tcg_temp_free_i64(t1);
> +                tcg_temp_free_i32(sew);
> +            } else {
> +                fns[s->sew - 1](dest, cpu_fpr[a->rs1], cpu_env, desc);
> +            }
>  
>              tcg_temp_free_ptr(dest);
>              tcg_temp_free_i32(desc);
> 


