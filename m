Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC04C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:57:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA6AC2082F
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 13:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="asob7t7y"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA6AC2082F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59966 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jlv2V-00022m-WE
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 09:57:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53298)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlv1o-0001VV-Fb
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:56:28 -0400
Received: from mail-oo1-xc42.google.com ([2607:f8b0:4864:20::c42]:45189)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jlv1m-0004Dg-QL
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 09:56:28 -0400
Received: by mail-oo1-xc42.google.com with SMTP id k7so1178735ooo.12
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 06:56:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=PS7epBTj2+CdJfP7UuJnZaOccZQrbfZauCy4eKz7PJE=;
 b=asob7t7yyPbXfjp778IjHBZn4zZ6Qf1noB6YLgPtmtPsKkIH7MLbq01VZGx9+ds08n
 OhKhWgI9cGZLjQD75muRshZdzD3Hfa8SFCnEjoJfmexvZiYXKj7Bfj3l7iyTvmI5hWQW
 6WxIW8c8QggjrFUL4Lb0gp+9Nw002b+vykXoE652KsUiWHcEG8E4DOoWLuSh8iLYuYiJ
 2CyWrqR4P3GTH1HajDSaAmuZz/rn4YvI/XyvdFodVLRVtbJ78Pq+enhME2jVkCF/XlfK
 5eIprrL08Zv34leHou39c9xGH7SJ8VslmUpQxXCZyk8LKiHg1U6yfTL5p7t/6eotijFS
 Bc2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=PS7epBTj2+CdJfP7UuJnZaOccZQrbfZauCy4eKz7PJE=;
 b=JEhoRLC//9+klpaniQpa0RG/UgunISEunB48we83m0jyJZgvjTXW9SGbiUkDdkLywt
 PAeoE0EAMHEWUxXfRtQ8o3XXCjTHUjDvmQXR5vOKa5w8WKtbuydnWu57XFHvxRJvSCy+
 xnoGAOtcAPXqIprldoGVoc7zxd6e8TqOZgdlQqvG/SPps0N0/EXIZUhpQ56P1WCqfy37
 C9Y9wZBFw0OaZWzRP+xRBJIhS/CweoXO/Odq1edtEeFyVrOcwyL2nKbQcOi9A5DmKz3k
 xeS9FRcg5oPNNFo9Tob4c0XvnNty924DT7S76P4zVleoGsGcLlivzVdYAqTZQARUtKiY
 7w2w==
X-Gm-Message-State: AOAM5325aULYKsQfWeZExQKfyUMSiBVAB8+g0qydOWPIXeYJOk9j1BHf
 GxqyUOCNXJHJCd9hOs/mROiOfceA47NUFuoCO9Ygkw==
X-Google-Smtp-Source: ABdhPJwS2biFVQ9bLbgmQjtnjucrW6m1KbguBV28pyDKDjEi3kCUDvq1byXditC+SzKHqA4+cj01fTZhtReRYVeOP3A=
X-Received: by 2002:a4a:a20b:: with SMTP id m11mr4114391ool.20.1592488585505; 
 Thu, 18 Jun 2020 06:56:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200603011317.473934-1-richard.henderson@linaro.org>
 <20200603011317.473934-16-richard.henderson@linaro.org>
In-Reply-To: <20200603011317.473934-16-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Jun 2020 14:56:14 +0100
Message-ID: <CAFEAcA8LEApobASw-D6PMdkR2sAjJfnu5DzBeD29hjdoHtuXJg@mail.gmail.com>
Subject: Re: [PATCH v7 15/42] target/arm: Implement LDG, STG, ST2G instructions
To: Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c42;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc42.google.com
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Stephen Long <steplong@quicinc.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 02:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> v2: Split out allocation_tag_mem.  Handle atomicity of stores.
> v3: Add X[t] input to these insns; require pre-cleaned addresses.
> v5: Fix !32-byte aligned operation of st2g.
> v6: Fix op2 extract, stg pre/post-index, stores vs sp, commentary;
>     use pre-computed ata.
> v7: Fix STZG iteration (stephen long)
> ---

> +static void disas_ldst_tag(DisasContext *s, uint32_t insn)
> +{

> +    addr = read_cpu_reg_sp(s, rn, true);
> +    if (index >= 0) {
> +        /* pre-index or signed offset */
> +        tcg_gen_addi_i64(addr, addr, offset);
> +    }
> +
> +    if (is_load) {
> +        tcg_rt = cpu_reg(s, rt);
> +        if (s->ata) {
> +            gen_helper_ldg(tcg_rt, cpu_env, addr, tcg_rt);
> +        } else {
> +            clean_addr = clean_data_tbi(s, addr);
> +            gen_probe_access(s, clean_addr, MMU_DATA_LOAD, MO_8);
> +            gen_address_with_allocation_tag0(tcg_rt, addr);
> +        }

The pseudocode for LDG has an
   address = Align(address, TAG_GRANULE);
in it. I don't see where in this code is the equivalent; have I missed it?

thanks
-- PMM

