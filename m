Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 81463C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 18:11:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 46350206B5
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 18:11:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ihbDZjbj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 46350206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC5KG-0007fr-Er
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 14:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44942)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC5JX-0006zB-3L
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 14:10:55 -0400
Received: from mail-pj1-x1034.google.com ([2607:f8b0:4864:20::1034]:33179)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC5JV-0001Z9-9q
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 14:10:54 -0400
Received: by mail-pj1-x1034.google.com with SMTP id q93so879872pjq.0
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 11:10:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AGHnYE8KAa39c/PAM96Bal83tQmqCn57OrcCtmW9Kb8=;
 b=ihbDZjbjuea7qcW3JqipDGPB+X6C8mu/+wmyMJc5a2UFqtJ45z1hKBLRhPsgqoXdBY
 1067d0yms2Ltk2HmY3mz1lJq49uMX6enqospiT6q4ex9Pl4Qal6ijmk7fmyp2RNuDZbd
 XPnNVhhaeFcPIh5Z4b5UojJWfyWefeA/tT/s3nTq+bATO7USwvAlLmxqT+7VHzWSrvfC
 gNv/ROTdLGhDRoSTDwZZK5DAiP2xn1xBbuyuYLaaHWylaOQyBwwS5s7lqiHDkiTlr5DR
 pILvfNqZ61SX9+ncj0uLdwJjN/VshTy69XluNp1blRrWIQiZcXLXbLfcylCWidLKzxqB
 qiJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AGHnYE8KAa39c/PAM96Bal83tQmqCn57OrcCtmW9Kb8=;
 b=nZwck/WR6OHsaQ5bAXYBPdIvJs4Pfo2kXD40266qYcYzJeNJ81FF3dxBhBn+EK7bJk
 3eo3NFTAUbsckx8j3cfekjoSeoZ0Ly/Nb21Y49yWlDVIflWjZYLF08+Ujyy32CFzvZVH
 j+U/rtveu2IFtr3IrbfDAMHULhzbIviGsxMEyVEQnl5GVIW9RO8r2srlUahFdzsWumlZ
 rMsAmNh0XlrGoZIkz5Qq4DhBjqDSNjKv187NdncL6/L1CcBlL0k5VqRLnjupUDTRddAe
 yqzOxFXlI+tvS/MHK0b1sT2kKfUgNySi6mujuK+aRUsANhXtaj9ZA5nB8zWid4a8+Mv8
 tHhg==
X-Gm-Message-State: AOAM532nwhxS/plsKFGb0FJUnpPv13yVDVQL7YKlNvTh77VWCHLFqW/9
 /1KyWf2hhMgiCm/67g8Ro/MF+g==
X-Google-Smtp-Source: ABdhPJynwdaoMap/n/lASBCOBResrUc6BllDP4wO3AUMdidH7OUFfWNQvzAiJNFBhMMbeP0MU6ccGw==
X-Received: by 2002:a17:902:b789:: with SMTP id
 e9mr1392252pls.146.1598724651689; 
 Sat, 29 Aug 2020 11:10:51 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id c2sm2945029pgb.52.2020.08.29.11.10.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 11:10:50 -0700 (PDT)
Subject: Re: [RFC v4 18/70] target/riscv: rvv-1.0: stride load and store
 instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-19-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bc367efb-1b7b-4be8-4a1e-9e3515ed98d4@linaro.org>
Date: Sat, 29 Aug 2020 11:10:48 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-19-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1034;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1034.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:49 AM, frank.chang@sifive.com wrote:
>  /*
> + * Vector unit-stride, strided, unit-stride segment, strided segment
> + * store check function.
> + *
> + * Rules to be checked here:
> + *   1. EMUL must within the range: 1/8 <= EMUL <= 8. (Section 7.3)
> + *   2. Destination vector register number is multiples of EMUL.
> + *      (Section 3.3.2, 7.3)
> + *   3. The EMUL setting must be such that EMUL * NFIELDS ≤ 8. (Section 7.8)
> + *   4. Vector register numbers accessed by the segment load or store
> + *      cannot increment past 31. (Section 7.8)
> + */
> +static bool vext_check_store(DisasContext *s, int vd, int nf, uint8_t eew)
> +{
> +    int8_t emul = ctzl(eew) - (s->sew + 3) + s->lmul;

I think eew should be passed as log, as MemOp and MO_{8,16,32,64} constants.
This is already the scale used by sew.

> +#define GEN_VEXT_TRANS(NAME, EEW, SEQ, ARGTYPE, OP, CHECK)   \
> +static bool trans_##NAME(DisasContext *s, arg_##ARGTYPE * a) \
> +{                                                            \
> +    if (CHECK(s, a, EEW)) {                                  \
> +        return OP(s, a, SEQ);                                \
> +    }                                                        \
> +    return false;                                            \

That also makes EEW and SEQ identical, so that...

> +GEN_VEXT_TRANS(vlse8_v,  8,  0, rnfvm, ld_stride_op, ld_stride_check)
> +GEN_VEXT_TRANS(vlse16_v, 16, 1, rnfvm, ld_stride_op, ld_stride_check)
> +GEN_VEXT_TRANS(vlse32_v, 32, 2, rnfvm, ld_stride_op, ld_stride_check)
> +GEN_VEXT_TRANS(vlse64_v, 64, 3, rnfvm, ld_stride_op, ld_stride_check)

... this does not need to replicate those constants.

> -#define GEN_VEXT_LD_ELEM(NAME, MTYPE, ETYPE, H, LDSUF)     \
> +#define GEN_VEXT_LD_ELEM(NAME, ETYPE, H, LDSUF)            \
>  static void NAME(CPURISCVState *env, abi_ptr addr,         \
>                   uint32_t idx, void *vd, uintptr_t retaddr)\
>  {                                                          \
> -    MTYPE data;                                            \
> +    ETYPE data;                                            \
>      ETYPE *cur = ((ETYPE *)vd + H(idx));                   \
>      data = cpu_##LDSUF##_data_ra(env, addr, retaddr);      \
>      *cur = data;                                           \
>  }                                                          \

Since there's no extension to be done between MTYPE and ETYPE anymore, you can
also drop the "data" variable completely and store directly into *cur.


r~

