Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A1A9C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:26:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4A0E207FC
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:26:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="S479QgiN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4A0E207FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joWZb-0000Oq-7V
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:26:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joWYl-0008Ce-Ux
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:25:15 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39934)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joWYj-0001Ih-Oe
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:25:15 -0400
Received: by mail-pl1-x643.google.com with SMTP id s14so3144462plq.6
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:25:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=WVf/8xR/ldKoshJUEaqkj/m4hOkMWMl3nmRzohjNg70=;
 b=S479QgiNHyWkjENZ9k88iV8HCY4hShla/XJXbMzPua3qQrxbti+7ey1eS7d7vMip9y
 5yW/bRBfFuYRhD+uCPCLq7B+zHrjVVTnC5ON0/yyP/Ajly9ypWxlS9JMUvwy+3IETSIX
 PbE1zn1QQA2jTdkoMVHDXnX00dft97z7G50GyjR6FqCyjSV64lCDCXfBPbDUtolqun8k
 xUaxDTa4mfvYFd4oqiuRQRbdzecrbhZGVR3A5D3qUb7zLbarj5dMR5IOALN+SZz34dfW
 hjy2MJMyH6cjINh1PfMOWuQSCmwyO+h8fFlc5iG4n8/9IEWYBbhtMXuT0Jkv9VQNj5uV
 BCoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WVf/8xR/ldKoshJUEaqkj/m4hOkMWMl3nmRzohjNg70=;
 b=owAgmDfJEEbMTwErEuqlDE+Z3t/0xvCbdYVKd6eXS7y+3J6Tmag2jv75wtDq72vhCH
 2KVg8pLaUygNtdGwdNoDpp1Sac7cmj0a2oRUK37N1Aka08aFiDZSBMu/L7f35wF4eDsL
 57hQIfYlCNW52AG/OKboNNBg4/g4rEve8POfadwr4UhOWMCf2mfQYlUO4jcmQ0EVU2X/
 dCbl5cdosgGK6cwosNwsW/r13s7nza8fRFDKpBv22L2kOUWfMSUDLf3XPBdQ8Lop2xNP
 TXzDomC2q3Y+QLxhvQBnVqFG0Cf/UNqEsaNN1C8gsVFRZYzfq+89VDMW4G9Hygt2lB7m
 IPFA==
X-Gm-Message-State: AOAM531CTfiyWNiBxqdJj7HsF9m4oYAJsk0xwDMjAyHoQ05MF+yvrtHi
 nOIzPmGFvykfa5CdBqI30nC9DA==
X-Google-Smtp-Source: ABdhPJyYDHCAY/0wjL91L25YP19abunUJtB1ezlA944LBoeq55XkhcanfznVfEUE+pd6nHMaBluX/w==
X-Received: by 2002:a17:902:d701:: with SMTP id
 w1mr15038801ply.72.1593109512113; 
 Thu, 25 Jun 2020 11:25:12 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id z11sm24434313pfk.141.2020.06.25.11.25.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 11:25:11 -0700 (PDT)
Subject: Re: [PATCH v3 4/8] target/ppc: add vmulld instruction
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20200625170018.64265-1-ljp@linux.ibm.com>
 <20200625170018.64265-5-ljp@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b97971e5-43ea-26e4-bd75-7af8d5ae992b@linaro.org>
Date: Thu, 25 Jun 2020 11:25:08 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200625170018.64265-5-ljp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 10:00 AM, Lijun Pan wrote:
> vmulld: Vector Multiply Low Doubleword.
> 
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
> ---
> v3: use tcg_gen_gvec_mul()
> 
>  target/ppc/translate/vmx-impl.inc.c | 1 +
>  target/ppc/translate/vmx-ops.inc.c  | 4 ++++

This part looks fine.

>  tcg/ppc/tcg-target.h                | 2 ++
>  tcg/ppc/tcg-target.inc.c            | 7 +++++--

This part must be a separate patch.


> @@ -3149,6 +3150,7 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>      static const uint32_t
>          add_op[4] = { VADDUBM, VADDUHM, VADDUWM, VADDUDM },
>          sub_op[4] = { VSUBUBM, VSUBUHM, VSUBUWM, VSUBUDM },
> +        mul_op[4] = { 0, 0, VMULUWM, VMULLD },
>          neg_op[4] = { 0, 0, VNEGW, VNEGD },
>          eq_op[4]  = { VCMPEQUB, VCMPEQUH, VCMPEQUW, VCMPEQUD },
>          ne_op[4]  = { VCMPNEB, VCMPNEH, VCMPNEW, 0 },
> @@ -3199,8 +3201,9 @@ static void tcg_out_vec_op(TCGContext *s, TCGOpcode opc,
>          a1 = 0;
>          break;
>      case INDEX_op_mul_vec:
> -        tcg_debug_assert(vece == MO_32 && have_isa_2_07);
> -        insn = VMULUWM;
> +        tcg_debug_assert((vece == MO_32 && have_isa_2_07) ||
> +                         (vece == MO_64 && have_isa_3_10));
> +        insn = mul_op[vece];

I think it would be ok to just index mul_op here, since the real isa check is
to be done elsewhere.

Missing a change to tcg_can_emit_vec_op to do that isa check, and allow
INDEX_op_mul_vec to be used for MO_64.

Missing a change to tcg_target_init to test for PPC_FEATURE2_ARCH_3_1.


r~

