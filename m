Return-Path: <SRS0=FSHi=DM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DE4CC4363A
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:02:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ADF892085B
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2020 14:02:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="aw/jiLU7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org ADF892085B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37760 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPR4V-0004ak-1V
	for qemu-devel@archiver.kernel.org; Mon, 05 Oct 2020 10:02:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55236)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kPR29-0002zk-TG
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:00:09 -0400
Received: from mail-ot1-x32e.google.com ([2607:f8b0:4864:20::32e]:39575)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kPR27-0000rK-2h
 for qemu-devel@nongnu.org; Mon, 05 Oct 2020 10:00:09 -0400
Received: by mail-ot1-x32e.google.com with SMTP id f10so143752otb.6
 for <qemu-devel@nongnu.org>; Mon, 05 Oct 2020 07:00:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mp4z0rSmsXlN+OOt21MS8v4a21HEfCBoRgQTLy+F3jw=;
 b=aw/jiLU7mCW1tuWfyenb5QIjqzegQrwyKBNaa/9PZSwTHfXIvrSTpFG5uT+KGoHBIK
 wMV6mmu75LWOtcOqwbO20v0FAJjtrVI+1XIIll05ellCA9JWN0PlKytxgnPCPREF+snw
 ppBo6Dy0TZJ2aftUVMJKLNSy6f5vhLSFmXtaoKRphOMqOybgZmn9+UekHY6nohmmj5Ke
 haCxnKGioWUBz3DG6NiBUTC3wxMikI1iAR82F/Ko4GR2LcrgD11fM9mptq6/DHJVtfa6
 E6EvGd25tBwZaFWoYlEQM1i4lGTkOd353NMrvz5GuZce1Har37ydJ0nhStI9DZ1HaUYH
 ETmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mp4z0rSmsXlN+OOt21MS8v4a21HEfCBoRgQTLy+F3jw=;
 b=OBajXM54iFMiLUzfEdryeNh0+EWe1rk5Zp6qj75GIiJP5jvxRrs2XIMM50BTXzoz4N
 9TSriZr+fXxDGTpNaZMCHnGkzuDNTg88s96WxERAlr7od1Rrn/Fw0Xtq7Rl5CGcjQsaA
 vISfpBqTVADF/CZr9xj5hUAS6ywLZL5ZtcQjADtkMo2mH+XZNpVBTV3JOGsDm3umCHjX
 6WNl8wJvzwJFF6qvNjhWwFtOcTCGtWcvJ+ZCg/GZ8yAnJWTTRY1wFe7X3xlvHU+co2ad
 3IFeMt52+1SRkyc8OLfhw7sCa4nuQAo5VPaTvPLXLZoMPjI5W+jG68QMtV70TKErUAyZ
 dksQ==
X-Gm-Message-State: AOAM530TSgjKlnRuz+qSwm42nUe5wVHXQVDLVT3HMJs8ImsDO6hd5fyd
 N91ohl5HrRvfkhGllVVsFMC15Q==
X-Google-Smtp-Source: ABdhPJzVlba0SQcC2gmuHyZFMcNcAPcfy7uxH1q1nx4vF3nl3RedUdhQN+M/rdNMsuI4hzpqRbFXJg==
X-Received: by 2002:a9d:6c19:: with SMTP id f25mr12059193otq.25.1601906405482; 
 Mon, 05 Oct 2020 07:00:05 -0700 (PDT)
Received: from [10.10.73.179] (fixed-187-189-51-144.totalplay.net.
 [187.189.51.144])
 by smtp.gmail.com with ESMTPSA id p8sm8488oot.29.2020.10.05.07.00.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 05 Oct 2020 07:00:04 -0700 (PDT)
Subject: Re: [RFC v5 06/68] target/riscv: rvv-1.0: add translation-time vector
 context status
To: Frank Chang <frank.chang@sifive.com>
References: <20200929190448.31116-1-frank.chang@sifive.com>
 <20200929190448.31116-7-frank.chang@sifive.com>
 <ad28385b-3e36-e33a-03c2-dabaaaea80bc@linaro.org>
 <CAE_xrPgK0ROiWo+Evan9uGFoBo8t0hV8vt0A2DxDb_Sws55-Ng@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <246985bc-98ff-0975-20d4-66c5864abc63@linaro.org>
Date: Mon, 5 Oct 2020 09:00:01 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAE_xrPgK0ROiWo+Evan9uGFoBo8t0hV8vt0A2DxDb_Sws55-Ng@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::32e;
 envelope-from=richard.henderson@linaro.org; helo=mail-ot1-x32e.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: "open list:RISC-V" <qemu-riscv@nongnu.org>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 "qemu-devel@nongnu.org Developers" <qemu-devel@nongnu.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <Alistair.Francis@wdc.com>, LIU Zhiwei <zhiwei_liu@c-sky.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/5/20 2:12 AM, Frank Chang wrote:
>     I think you want to be sharing the code between vsetvl and vsetvli now.  Just
>     pass in a TCGv value to a common helper.
> 
> 
> The only difference now between vsetvl and vsetvli is the format of zimm and s2
> fields.
> But they have different formats and are queried by different functions,
> i.e. s2 = tcg_const_tl(a->zimm); and gen_get_gpr(s2, a->rs2);
> 
> Is there any elegant way to retrieve the values of zimm and s2 by shared common
> codes?

Yes, like I (too briefly) described:

static bool do_vsetvl(DisasContext *ctx,
                      int rd, int rs1, TCGv s2)
{
    // existing contents of trans_vsetvl
    // do continue to free s2.
}

static bool trans_vsetvl(DisasContext *ctx, arg_vsetvl *a)
{
    TCGv s2 = tcg_temp_new();
    gen_get_gpr(s2, a->rs2);
    return do_vsetvl(ctx, a->rd, a->rs1, s2);
}

static bool trans_vsetvli(DisasContext *ctx, arg_vsetvli *a)
{
    TCGv s2 = tcg_const_tl(a->zimm);
    return do_vsetvl(ctx, a->rd, a->rs1, s2);
}


r~

