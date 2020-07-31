Return-Path: <SRS0=FShu=BK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17EB6C433E0
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:01:24 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D611E2083B
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Jul 2020 17:01:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTXSuh7Q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D611E2083B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:38572 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1YPL-0005r7-4k
	for qemu-devel@archiver.kernel.org; Fri, 31 Jul 2020 13:01:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43158)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1YO4-0005Fw-Pc
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:00:04 -0400
Received: from mail-pg1-x529.google.com ([2607:f8b0:4864:20::529]:44929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k1YO1-00043Q-Nz
 for qemu-devel@nongnu.org; Fri, 31 Jul 2020 13:00:04 -0400
Received: by mail-pg1-x529.google.com with SMTP id j19so16332738pgm.11
 for <qemu-devel@nongnu.org>; Fri, 31 Jul 2020 10:00:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=P0uDl581Zx7OtJgsG9JCwHqkp4s42eRukweVPsz3aNg=;
 b=UTXSuh7QsRiqy/8dgJxsUDXNJwJP2asVwsENfhhfey1FYhoslsM98xx/VIBCcZZVQj
 pokn4WF3S6ccOmcPUX8OWJ+79SSBolZAOMwAi1P7H7dFSGZ8iNEwnBcOqVhb/iPGLkAt
 3rAXF+YQgIfpyFeQYVnQ8EZqxmd1sgRJPRq8RFggfvy7WBZBRTUqSs3YOPPTSXv57Wxj
 hVmQOqLNcBk0Lc3a+NpM88M6+K+p7dLa5tvr82fodrBs2pLhYNL/WxewMMyg/bwxgIYV
 Mm24FYRNzXN0URy2TrX51WSy1dH6yKWPWSMwNfbSjdJM5OQzFyuOokZletFr+fr9yJya
 xDgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=P0uDl581Zx7OtJgsG9JCwHqkp4s42eRukweVPsz3aNg=;
 b=BOv9pyBztJdqmMmpsrl5HOMIXZxPr0W1IlEOtwuooBbT0aGsXfXUXTrwxNrOozPZBf
 5UseKx03pMzRRsCBGDtYAFMNGCM7NsLCXYE9ZpqZmKucGESqA4bWd6qiC6+SyUPareGc
 BK5nROSV4sVyYDtZQJ9DM3l2IbDJL4OQ5Uk5e9ylYUXmKhgTL8g8IaF21ylUM+7II1Xy
 F3bbMxtt2RS8NI5b0ZQnn4mQXOh38PNtP63Icy3QhCasQTJzdMcx2CcgiJXfBGNZdrcG
 3guWtZoHqyZHz/sT35vFt5AST8VC9EfzNMRm2u09RHw3igDTvrBCqU5opgV7RGADTcV3
 lskQ==
X-Gm-Message-State: AOAM5322iubeckf7c4koFbxNwIQ8h43kYyqfvCP7nyYK0LuRe3cLfHiL
 j+lqtMeUftwiCzLBf8RYpJ5sEg==
X-Google-Smtp-Source: ABdhPJxmPecNRUE2hk1+YOll/MsGtydRb+1jMZ6JH2tIAeNDyaQhejmubjTsOA99Exn++vmIjnlwXg==
X-Received: by 2002:a62:a21e:: with SMTP id m30mr4329433pff.11.1596214799918; 
 Fri, 31 Jul 2020 09:59:59 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id d17sm1899444pjr.40.2020.07.31.09.59.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 31 Jul 2020 09:59:59 -0700 (PDT)
Subject: Re: [RFC v2 64/76] target/riscv: rvv-0.9: single-width scaling shift
 instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-65-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7ebc7527-65e2-8fac-c744-0aac857a40f3@linaro.org>
Date: Fri, 31 Jul 2020 09:59:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-65-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::529;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x529.google.com
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
>  GEN_OPIVI_TRANS(vssrl_vi, IMM_ZX, vssrl_vx, opivx_check)
> -GEN_OPIVI_TRANS(vssra_vi, IMM_SX, vssra_vx, opivx_check)
> +GEN_OPIVI_TRANS(vssra_vi, IMM_ZX, vssra_vx, opivx_check)
>  

I think both vssrl and vssra should use IMM_TRUNC_SEW.


r~

