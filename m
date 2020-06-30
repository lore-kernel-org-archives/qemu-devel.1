Return-Path: <SRS0=gXk/=AL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 853DEC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 21:52:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4AEFB2073E
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2020 21:52:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uESyiMUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4AEFB2073E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47824 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jqOB5-0005nI-H4
	for qemu-devel@archiver.kernel.org; Tue, 30 Jun 2020 17:52:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54316)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jqOAI-0005K2-Qt
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 17:51:42 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34680)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jqOAH-0006CI-BP
 for qemu-devel@nongnu.org; Tue, 30 Jun 2020 17:51:42 -0400
Received: by mail-pg1-x541.google.com with SMTP id t6so10600380pgq.1
 for <qemu-devel@nongnu.org>; Tue, 30 Jun 2020 14:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1BqupEbN28P4bm3ZpuxQUWzbq9AhUg448YYrGECG1r0=;
 b=uESyiMUQZBgbriZB2EtwcFkhEbeOI1IEya63w5rII2qyfRGuVUvdY6C2holhBb8mUF
 EtUJJ2IGW2f1/MndxDDHBPhxp7EqYskyNk93WgHJBJisaTx8N3fRUxAHCKOlj4S6my4I
 8qX317STsMlAKrb9hSkPsVB15BR6dIH+Kn4nwKknVknjmAHwJ6pNDAF+jo5Q/vuB+97m
 MfPHXCq28XKvCa9etXnU8j5mT5AxmWnuJUVvVagdfdRkiLRsyPewgpH8dL8pV/RMYFoY
 9ddYepaTdCmvXpfywu8DtLnDhY0uBZp8+X3rX0194Ka8ErzefJc5nCBMjHX+P/dHmByb
 Vqbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1BqupEbN28P4bm3ZpuxQUWzbq9AhUg448YYrGECG1r0=;
 b=FrgJ4IL/ik0GtdaoRb9t3k34gbchpCefoK/KBfCTdZ7/+CatDvOtn1SWn5S/+8sjAL
 zPzV2N+s/gdoExvj26QebN7ekRzwYXsumMMVJGxqCNpujBuhJtWOD1jSalhPr62foTjZ
 2354tB6x87dDUcjdthXSO6sQ7uYLxii1DI3uO4JB5Z1gzzVlHixJo+r9zRyf1KPJDV+l
 TnIAxGWmRxoClKIAckalIBI93k+eRg3qgA1fKErerqa11TizF9ngHe25rJrFbubh8tB2
 xiwEQQNq9BjTYfFJSochnAEn6OPyKPdrUdftVcDnnSMCT08os9A/xTUTW7fMPuHrGTGV
 1bvA==
X-Gm-Message-State: AOAM530rB6NlxTKpj9Kn0j3o1ezOlGj296W6vkOyckxSC/GSPRyYGa90
 lqYLkl4sgyEGGdOlRmbke5xaiQ==
X-Google-Smtp-Source: ABdhPJzohh8iAnEaN/GCsu9rckp+ZmH/F40Ab7WnK4kqcWbNKdKfvGUEKctLbxBTONNjxK/HGjE06g==
X-Received: by 2002:a65:6883:: with SMTP id e3mr16911778pgt.5.1593553898982;
 Tue, 30 Jun 2020 14:51:38 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x23sm3293717pfn.4.2020.06.30.14.51.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Jun 2020 14:51:38 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] target/riscv: Regen floating point rounding mode
 in dynamic mode
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1593547870.git.alistair.francis@wdc.com>
 <ea4f280e6f77e734c8e555e3c98d10085ce9f5b6.1593547870.git.alistair.francis@wdc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <cd66f31b-2c07-da29-c14c-5f1079e016e3@linaro.org>
Date: Tue, 30 Jun 2020 14:51:36 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <ea4f280e6f77e734c8e555e3c98d10085ce9f5b6.1593547870.git.alistair.francis@wdc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: alistair23@gmail.com, palmer@dabbelt.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/30/20 1:12 PM, Alistair Francis wrote:
> When a guest specificies the the rounding mode should be dynamic 0b111
> then we want to re-caclulate the rounding mode on each instruction. The
> gen_helper_set_rounding_mode() function will correctly check the
> rounding mode and handle a dynamic rounding, we just need to make sure
> it's always called if dynamic rounding is selected.
> 
> Fixes: 1885350 ("RISCV dynamic rounding mode is not behaving correctly")
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/riscv/translate.c b/target/riscv/translate.c
> index ce71ca7a92..a39eba679a 100644
> --- a/target/riscv/translate.c
> +++ b/target/riscv/translate.c
> @@ -490,7 +490,7 @@ static void gen_set_rm(DisasContext *ctx, int rm)
>  {
>      TCGv_i32 t0;
>  
> -    if (ctx->frm == rm) {
> +    if (ctx->frm == rm && rm != 7) {
>          return;

This should not be necessary.

It was my understanding that after the set to the csr, that we would end the
TB.  That's certainly what I see in RISCV_OP_CSR_POST.

The next TB will begin wiht ctx->frm = -1, so we will reset the rounding mode
with 7.  It would be good to understand what's really going on here.


r~

