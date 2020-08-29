Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5DEA8C433E6
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 20:28:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 21C282076D
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 20:28:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y5S8C3oM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 21C282076D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39386 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kC7T1-0006WC-8I
	for qemu-devel@archiver.kernel.org; Sat, 29 Aug 2020 16:28:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38754)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC7SK-00062g-Vu
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 16:28:09 -0400
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f]:40404)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kC7SI-0000LB-G1
 for qemu-devel@nongnu.org; Sat, 29 Aug 2020 16:28:08 -0400
Received: by mail-pf1-x42f.google.com with SMTP id c142so2363056pfb.7
 for <qemu-devel@nongnu.org>; Sat, 29 Aug 2020 13:28:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=gaN0h9cn4Hr/qtQs/MhN8dIp6Di8flWzfqAgpeOb3PU=;
 b=y5S8C3oMGdg7t17uTjP+8pMZmwz3nLqMUF/c8jTZEbRQpAVMHgdY9mny35qVli0bym
 bytAQRf4d2fnrK8TWB2h5PrPlf/mXT0scVvEGX4IFC7GVHGtTBg6Zsvi8F7NLd6/euj4
 h6oNFkwXRskEO8k1aZgvzdez8g5NJNNp+opXFkVvKOD+s/flLWT3tQDXniWJOfOx3fod
 kzNRp4dblytpIMsF7EoU/iylf8fEpijepgUX3ukPGAcALLT07hflbV849MfRT8Pox6Wa
 ijzvmAxRxWQSr74x+NAWdFAxyhtzqFIfKLn1Ro4HXkUStkL9U0ARPi8EpPG0uom3GVrm
 Oqqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gaN0h9cn4Hr/qtQs/MhN8dIp6Di8flWzfqAgpeOb3PU=;
 b=tyOJmvBhhHlc66O538QaxTAQ8omQKc9WI7Y806GWj2+5xZeF5PG2M8Z7k8qHMJtcJs
 eZGcSawepG7dKd/Ol/h0mXrZvv5Y4fM/zV+K1gF5k+trmxQloJ27fgcuFidO5xqNY+1V
 18uBeSZMVrh/WgrK0tZ853YmnmC77zgFlgVGIj8bSzmNKQMvAv8o5Z958s5zsAVAaUVJ
 8DB2AMnLXp2S5H1BBgWV6LVfPvFZ/O0M4c6L2p/yZNPDI+FHFU1TvqQThwwUUlft03gG
 YsoK6OdzreWPidG6/UPFHpeuegBzO2ifkbmapkMUn04IYrLTLS1hfULx5VUf4bVA1H/s
 m5aw==
X-Gm-Message-State: AOAM531HFB31daEE8pSj4Un+K2E6AJnlfShwZdfQgFzwW6b8PdDWout4
 C/0mpG81vjkC4lupFGQfQX3z4g==
X-Google-Smtp-Source: ABdhPJyrqcYnoVNg0ivWqgBej+gDLjTGYDZHP1OcFrr9D44mX+Ffc4cynFaiVjdfZstzkG+3w3EtZg==
X-Received: by 2002:a63:cb0e:: with SMTP id p14mr3367418pgg.351.1598732885182; 
 Sat, 29 Aug 2020 13:28:05 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id w16sm2975930pjd.50.2020.08.29.13.28.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 29 Aug 2020 13:28:04 -0700 (PDT)
Subject: Re: [RFC v4 52/70] target/riscv: rvv-1.0: slide instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200817084955.28793-1-frank.chang@sifive.com>
 <20200817084955.28793-53-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <334b2eb0-8a24-2971-549a-0e298e5f0404@linaro.org>
Date: Sat, 29 Aug 2020 13:28:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817084955.28793-53-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42f.google.com
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
> From: Frank Chang <frank.chang@sifive.com>
> 
> * Remove clear function from helper functions as the tail elements
>   are unchanged in RVV 1.0.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/vector_helper.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

