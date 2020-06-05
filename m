Return-Path: <SRS0=hXcz=7S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04A1DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:55:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C397E2065C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2020 17:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="I49mYqsf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C397E2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jhGYx-00024Z-3t
	for qemu-devel@archiver.kernel.org; Fri, 05 Jun 2020 13:55:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50058)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhGY6-0001ND-Hi
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:54:34 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:54317)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jhGY5-0007IR-PW
 for qemu-devel@nongnu.org; Fri, 05 Jun 2020 13:54:34 -0400
Received: by mail-pj1-x1044.google.com with SMTP id nm22so2979247pjb.4
 for <qemu-devel@nongnu.org>; Fri, 05 Jun 2020 10:54:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1fWWlCHxNNamvAiXSBO3D0fMPSUezKve2Rs84fD+14E=;
 b=I49mYqsfbYRms3npymGakgoXyzsggxYsHn1VPSM1PFoJUMcNFnD5kdIRTk5pK/5TJO
 /1tzZ81Fa6NJXiOeFf9XatRbc486nXc/0gqUJBElP3O4NkS/3WH/k/Suj7FSBwoLXOHu
 727cF6WBXZHOCV7kOPzoZ3D1N9MTY8C3r5HJkZ8p1+AYr0W/WrxbrLd6bhhYXLJtJHDb
 //x4JLnIAKVrPL5As4eNbMMB+S538ProX2L3xu+zQkQ+lsn2FhvLtjrP9OHPalHF1B2E
 UF4LER/b2yKNHcUtvQdRvaVfWaxNek7lta/wumYD2za5Rl39ouks9IqWWWb2V032zP9g
 e7Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1fWWlCHxNNamvAiXSBO3D0fMPSUezKve2Rs84fD+14E=;
 b=TOwfq3gzUHcKpu0Bycr8bJChzXk40k4l8U/yLYBwkSybvhdK/vnSyC9yYcQvSZ5h2z
 irU1xL65CEqZvenOPdFj2vZkhdIU/Jm4E/xS+/ti8IN7lF6W2pmerM5n88BfDfoSrbsm
 Hf1CWTvBvGhVO90X2Wfz5x6RKQO/VdfZpgWMSxwqDpbUOc/oiPiB3PtAHaH4OF8SEx+G
 LzzqM22qfvuLSuDL3vx159mmJvTGkJcGop69T2rST23p1FofdKza1DeSV/DELwvgAkLp
 J+gOP57Mk1RJaMIml6VTWieAZnTLmJ7r3aEJ1SwHe293Y2ZKct3KJQi2Dqc0vkSh2b6p
 y2RQ==
X-Gm-Message-State: AOAM532YSk+TY1jADu+gxi+dzz9BYzslRcZK0+CyYFjJIdMulHjHRd2m
 4632QREs7I7MyvmLjroePLiBOQ==
X-Google-Smtp-Source: ABdhPJyYHCrN/kXy0dUyNRObLQuvzqXZ5ZZaFsTmtDkOikIRiqy5f3+vULrp03LYh6lovschyHw3CA==
X-Received: by 2002:a17:902:7281:: with SMTP id
 d1mr11231627pll.78.1591379672173; 
 Fri, 05 Jun 2020 10:54:32 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id 12sm249593pfb.3.2020.06.05.10.54.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 05 Jun 2020 10:54:31 -0700 (PDT)
Subject: Re: [PATCH v2 04/17] target/riscv: Implement checks for hfence
To: Alistair Francis <alistair.francis@wdc.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <cover.1591319882.git.alistair@alistair23.me>
 <c78f245c8d1629f1bce1387ba623a0215767f804.1591319882.git.alistair@alistair23.me>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b714c7ba-802b-142f-6795-9c0227d3a462@linaro.org>
Date: Fri, 5 Jun 2020 10:54:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <c78f245c8d1629f1bce1387ba623a0215767f804.1591319882.git.alistair@alistair23.me>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
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
Cc: palmer@dabbelt.com, anup.pate@wdc.com, alistair23@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/4/20 6:20 PM, Alistair Francis wrote:
> Call the helper_hyp_tlb_flush() function on hfence instructions which
> will generate an illegal insruction execption if we don't have
> permission to flush the Hypervisor level TLBs.
> 
> Signed-off-by: Alistair Francis <alistair.francis@wdc.com>
> ---
>  target/riscv/helper.h                   |  5 ++++
>  target/riscv/insn_trans/trans_rvh.inc.c | 32 +++++--------------------
>  target/riscv/op_helper.c                | 13 ++++++++++
>  3 files changed, 24 insertions(+), 26 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


