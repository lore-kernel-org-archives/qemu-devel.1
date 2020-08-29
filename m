Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9719CC433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 18:51:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6790E2076D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 18:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="a9zoILvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6790E2076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC5wr-0002z9-Kr
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 14:51:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52262)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC5vl-0002Ky-J6
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 14:50:26 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031]:54989)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC5vh-0006J0-Pq
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 14:50:25 -0400
Received: by mail-pj1-x1031.google.com with SMTP id mt12so1053955pjb.4
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 11:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=VCZOcskORWKnMglI/hHMrkHWQr5rJTv1J15iAIy58Z0=;
 b=a9zoILvSJ1NDqFbWM4u5YfSdfe3HiTwLPllhyziuUqDdmoO8kd3lTgna0zSKjhh9jP
 ljIQgzfVphIWNrV814tcjcTmohcrd4/uDLMgpMA/ycxSh5p7fDP9EZU00nPNcmt5FELk
 r1URXZKN46GFn4thrQ6z2ZplHsuivQHjt00rA5FNMr1EalqTTgY204oLmwE/o0X9zATw
 IQjPfMAvYF4cpRRFW6Qp/IfD2B/rSy9sfKYuxFFVWOotBM+A+fWMlvWalQdehIm86Pym
 uDOGl+vSOPXlrPg9kdWTyM6jKcXTP0rBbE0gKiUDVBjrk9indUDNs+UlJy5kgRefKnHc
 OH4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=VCZOcskORWKnMglI/hHMrkHWQr5rJTv1J15iAIy58Z0=;
 b=q2NdFCTcabIf/2VB4QB+tkzjaCHWCV9PtDi3gFCO2BmQJs6146O1hZ3i/Ebh3nctF6
 hc/6FxtLWVYaPb9qvaSuYPGsF0Cu/d8cubWTFHvTkkqGnaLQ/Wu/WWbPo79AqoGi31dS
 MPLoPsQnCaAGpCZWLNKSy9BgqFO3XQ/GEQdZN9eZqyJloFp4PYXnkSO3bIhGb7gR181m
 L/rUSQdGxsyCkLGAewo4TaVj4xaFrHubwtAMz2RUkLdcmAJdE6/q7jpTGkpvPYsbVK2B
 ysT3wrUAzdYa9ajdQfKoRkDKKHtsLC85HHhHX6xmY4yfbkNCls5G4TPGpACnWRk+CqdE
 5WmA==
X-Gm-Message-State: AOAM532P65OnmQ3SfpzZEpTVIGtiGISd+MYuZYSLU+jXtfy5mpWxRwnv
 pV0Dyxre13fAzJk9n+zubbtGXg==
X-Google-Smtp-Source: ABdhPJwrOgqc/Ql5VQoDDTOGUOhIKitbSIC7oe/dIV2K219/gCO0J7/wKjLYtymmVbWSEpoNdmNrRg==
X-Received: by 2002:a17:90b:4acd:: with SMTP id
 mh13mr4056856pjb.147.1598727020062; 
 Sat, 29 Aug 2020 11:50:20 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l20sm3659353pfc.72.2020.08.29.11.50.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 11:50:19 -0700 (PDT)
Subject: Re: [RFC v4 22/70] target/riscv: rvv-1.0: amo operations
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-23-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <30dcedd1-84e3-70c4-7b8b-d985608b81c5@linaro.org>
Date: Sat, 29 Aug 2020 11:50:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-23-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1031.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/17/20 1:49 AM, frank.chang@sifive.com wrote:
> +static bool vext_check_amo(DisasContext *s, int vd, int vs2,
> +                           int wd, int vm, uint8_t eew)
> +{
> +    int8_t emul = ctzl(eew) - (s->sew + 3) + s->lmul;
> +    bool ret = has_ext(s, RVA) &&
> +               (1 << s->sew >= 4) &&
> +               (1 << s->sew <= sizeof(target_ulong)) &&
> +               (eew <= (sizeof(target_ulong) << 3))  &&
> +               require_align(vd, 1 << s->lmul) &&
> +               require_align(vs2, 1 << emul) &&
> +               (emul >= -3 && emul <= 3);
> +    if (wd) {
> +        ret &= require_vm(vm, vd);
> +        if (eew > (1 << (s->sew + 3))) {
> +            if (vd != vs2) {
> +                ret &= require_noover(vd, 1 << s->lmul, vs2, 1 << emul);
> +            }
> +        } else if (eew < (1 << (s->sew + 3))) {
> +            if (emul < 0) {
> +                ret &= require_noover(vd, 1 << s->lmul, vs2, 1 << emul);
> +            } else {
> +                ret &= require_noover_widen(vd, 1 << s->lmul, vs2, 1 << emul);
> +            }
> +        }
> +    }
> +    return ret;
> +}

Same comments for EEW and require_noover.

r~

