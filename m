Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD7AEC4CEC6
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 16:54:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 723DE206A5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 16:54:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zYlrYzLB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 723DE206A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8SMz-0007Te-Fv
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 12:54:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35249)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i8SMF-000738-73
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:54:12 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i8SME-0001DG-0Q
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:54:10 -0400
Received: from mail-qt1-x841.google.com ([2607:f8b0:4864:20::841]:37485)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i8SMD-0001Cs-Q2
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 12:54:09 -0400
Received: by mail-qt1-x841.google.com with SMTP id g13so30017586qtj.4
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 09:54:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bLZSpIJioQpc3lEns+9rQMU3UCzhpeXvbrAurWZ61PM=;
 b=zYlrYzLBWJ/YHP3SVxNGiOaQtFH8T1GW2HAa4RvydrhhLzsYcHgY+hx/9jhPJEjcO0
 G4EcAb0w/4vg728qq06wBqyzJADC2vnWdByDyXcFYrmI0fNvuHBJ0thbcIjnPiqABSGm
 eLsUG9laW1LKM/rDbWhj/OuO2h9yMhNSLm3txkT7bzYM57r/a9jQkSe4YFyonkIlbmn2
 /COKxl9DZKlGk+2eMBO6HwuMzg/ku6FXDnu0d/zD2EPc3icYm72XLD3FnngLViS/1rxi
 0rmS3PY6jetv3pMVlvR5Nmcn4uHqTxBl9R2gtv3eRScoPFP0TveL5pEX5YkSGp17rmq0
 h3vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bLZSpIJioQpc3lEns+9rQMU3UCzhpeXvbrAurWZ61PM=;
 b=GFX0sSwUG7Y+iMgpaUXcffnjQR4IJ5wvAptyujl2/CgK3ypq0GHEmDxOGalNj5HqqQ
 HdqeVJ/dh0U/Yi3hrE243mjj/pLkbN6Oua1bwG/WpQzDgtoAu1cv0SfU6p/xkf7LYiv7
 zxyBiMwZgJDxwEhNKNZrrx8gGa+7cNJjrI+okzWkUDaZxktI93P+pAi5prgoXepVjSoJ
 sijPNb75jIEufLK41u2OrewfYMrQP454JSr6XZx1QUwPBssL6zcm0iWu76yEufcmttL5
 tlkz8DccVA3M2Tb/kRnCFoQJ/wkDa2dG2NACHGJMLUSnPPl1Vc9YdbUinFqiZCkGYrNF
 WgLw==
X-Gm-Message-State: APjAAAUodXaiYCnhRbaV/yMDhFr6/tCTQhmMe18HU1SYosEKMuxOj4xx
 OdxkOMcwdLQnmQmgdkyx7bZAZw==
X-Google-Smtp-Source: APXvYqzz0MkkbNZbdfD7+PQbxBB2CXu1ocQ0Grp0cuz4bFIu7FS9Jvughaa4ZW2kJLTvagjp35ROVQ==
X-Received: by 2002:a0c:a988:: with SMTP id a8mr8595365qvb.34.1568307248511;
 Thu, 12 Sep 2019 09:54:08 -0700 (PDT)
Received: from [172.20.5.51] ([67.69.50.154])
 by smtp.gmail.com with ESMTPSA id 200sm12429267qkf.65.2019.09.12.09.54.07
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 12 Sep 2019 09:54:07 -0700 (PDT)
To: liuzhiwei <zhiwei_liu@c-sky.com>, Alistair.Francis@wdc.com,
 palmer@sifive.com, sagark@eecs.berkeley.edu, kbastian@mail.uni-paderborn.de,
 riku.voipio@iki.fi, laurent@vivier.eu, wenmeng_zhang@c-sky.com
References: <1568183141-67641-1-git-send-email-zhiwei_liu@c-sky.com>
 <1568183141-67641-16-git-send-email-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5e0f09a9-7f5a-efbc-762d-56a94bb837e0@linaro.org>
Date: Thu, 12 Sep 2019 12:54:05 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <1568183141-67641-16-git-send-email-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::841
Subject: Re: [Qemu-devel] [PATCH v2 15/17] RISC-V: add vector extension
 reduction instructions
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
Cc: qemu-riscv@nongnu.org, qemu-devel@nongnu.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/11/19 2:25 AM, liuzhiwei wrote:
> +/* vredsum.vs vd, vs2, vs1, vm # vd[0] = sum(vs1[0] , vs2[*]) */
> +void VECTOR_HELPER(vredsum_vs)(CPURISCVState *env, uint32_t vm, uint32_t rs1,
> +    uint32_t rs2, uint32_t rd)
> +{
>  
> +    int width, lmul, vl, vlmax;
> +    int i, j, src2;
> +    uint64_t sum = 0;
> +
> +    lmul = vector_get_lmul(env);
> +    vector_lmul_check_reg(env, lmul, rs2, false);
> +
> +    if (vector_vtype_ill(env) || vector_overlap_vm_common(lmul, vm, rd)) {
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        return;
> +    }
> +    if (env->vfp.vstart != 0) {
> +        riscv_raise_exception(env, RISCV_EXCP_ILLEGAL_INST, GETPC());
> +        return;
> +    }
> +
> +    vl = env->vfp.vl;
> +    if (vl == 0) {
> +        return;
> +    }
> +
> +    width = vector_get_width(env);
> +    vlmax = vector_get_vlmax(env);
> +
> +    for (i = 0; i < VLEN / 64; i++) {
> +        env->vfp.vreg[rd].u64[i] = 0;
> +    }
> +

There is no requirement that I see for vd != vs1 && vd != vs2.  Thus clearing
vd before the operation may clobber the inputs.

> +        if (i < vl) {
> +            switch (width) {
> +            case 8:
> +                if (vector_elem_mask(env, vm, width, lmul, i)) {
> +                    sum += env->vfp.vreg[src2].u8[j];
> +                }
> +                if (i == 0) {
> +                    sum += env->vfp.vreg[rs1].u8[0];
> +                }

Hoist the rs1 case outside the loop.


r~

