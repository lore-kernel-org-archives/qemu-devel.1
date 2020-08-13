Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66F48C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:22:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25C7620716
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 17:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WGdp7DvS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25C7620716
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49656 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Gvw-0008Nf-CE
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 13:22:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6GvJ-0007tB-Ub
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:21:53 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:45374)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6GvI-0007Qk-6u
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 13:21:53 -0400
Received: by mail-pf1-x443.google.com with SMTP id f193so3135835pfa.12
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 10:21:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qJ0HzUlhmjx7FC9F4faLGWxSwitdxfgfm6ZHbCn97Is=;
 b=WGdp7DvSotSdlv4Ni5V+Tcly8bf61U62Uqr7d3O5FDsJOHE3yVH9poMMZjenGhxf+/
 ixpk1AaopseuSDnbWT0JBlUG49+jHuSBtjludYJFV1HePkNtVwF1VUU2ThXV5xnFaH/H
 0D7Rtj9SmU9mwMnq5GH2jXZZ34FXpMPrE8DfZbGOndJD6c1FEbnggNK+ZVTJhuNt9LmD
 hlIkjDsa2B04CevR+jIFsLmtbOWhrFxtqslW7G2FpWBVfNQ1mGZRnXOQBnInzvLtOQ+M
 EFStj0LZGKjLMSArf/iIly19xRiOGsa0MamL/aj9vgLlWnkVAuBOhhEChuyMqc1dUeul
 v+ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qJ0HzUlhmjx7FC9F4faLGWxSwitdxfgfm6ZHbCn97Is=;
 b=FIRGdvCwicLlkDmME4pUAZV5g0CfCSy8u0JtuldEl3fIbX8l9PS2mv0R68CPVEfV/R
 /Upof1tlb8NQTMgtHPZkz45qNjwiEBvVt7DHydp7wmPVoWy7PYh1lGltH18+jt0tvUpA
 Dx+LTift2BPY/MyRhJlnhAYsB1JpilaW9zNogpem1GcV/EMmxdvn2DCAhMPw+kZW8Ydz
 2dD9mKOeSn89hG0H8la1szg7hetrjboJCupfRXVFEeaYd0BI+OlrjD8cuNRlG/x/I707
 SvIXZm01alOZPg0ujRaFLR4DwJWjWBh368LDAjTGyJKhRnxA0ZB6giOuYXELyrn8kO/e
 Wrrg==
X-Gm-Message-State: AOAM531agv6hXCDXQRnQpobrafVcf68UEhhBx+aDfLQZDR1OdmGRB6c3
 xJTqqFVMKg6ik1UM44MUU5eFJA==
X-Google-Smtp-Source: ABdhPJwjl3gGG8MXbBGAFzThF9RQzZyGOw4Xi0AsHkChE/ntxy30YVwLv+EK08kkhwEVUITDIrjY+Q==
X-Received: by 2002:aa7:9096:: with SMTP id i22mr1691774pfa.310.1597339310507; 
 Thu, 13 Aug 2020 10:21:50 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j13sm6533431pfa.149.2020.08.13.10.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 10:21:49 -0700 (PDT)
Subject: Re: [PATCH 2/3] softfloat: add APIs to handle alternative sNaN
 propagation
To: Chih-Min Chao <chihmin.chao@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
References: <1596102747-20226-1-git-send-email-chihmin.chao@sifive.com>
 <1596102747-20226-3-git-send-email-chihmin.chao@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <aa334be5-e325-8d96-a3ee-00c82cfe2c4d@linaro.org>
Date: Thu, 13 Aug 2020 10:21:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1596102747-20226-3-git-send-email-chihmin.chao@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::443;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/30/20 2:52 AM, Chih-Min Chao wrote:
> For "fmax/fmin ft0, ft1, ft2" and if one of the inputs is sNaN,
>   The original logic
>     return NaN and set invalid flag if ft1 == sNaN || ft2 == sNan
> 
>   The alternative path
>     set invalid flag if ft1 == sNaN || ft2 == sNaN
>     return NaN if ft1 == sNaN && ft2 == sNaN
> 
>    The ieee754 spec allows both implementation and some architecture such
>    as riscv choose differenct defintion in two spec versions.
>    (riscv-spec-v2.2 use original version, riscv-spec-20191213 changes to
>     alternative)
> 
> Signed-off-by: Chih-Min Chao <chihmin.chao@sifive.com>

If both ft1 and ft2 are SNaN, surely the returned result is silenced?  That is
something that is handled by pick_nan, but is not handled here.

Also, the patch subject should be modified to emphasize that this only applies
to min/max and not propagation of all SNaN.


r~



