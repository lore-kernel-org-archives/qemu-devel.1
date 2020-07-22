Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3CD8C433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 20:01:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B01342086A
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 20:01:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OsJF43Bp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B01342086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50958 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyKvl-00056c-0M
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 16:01:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57662)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyKuj-0004Ur-71
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 16:00:29 -0400
Received: from mail-pf1-x431.google.com ([2607:f8b0:4864:20::431]:38171)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyKug-0001hR-NF
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 16:00:28 -0400
Received: by mail-pf1-x431.google.com with SMTP id j20so1848580pfe.5
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 13:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5yY29WyUtcGMg3JYJpZWK5m4IoAUzfnBRUjC+PL25w4=;
 b=OsJF43BpX6CJtaQ59W5l7TqJMMYOB02EXB1rcNNQyPrkGWHpzN/y8Bc86uz65TO4uJ
 eAXcNVGC/C1AijGSlud7/4I2YE1K3Yp6LERTlZK8Rx6jv6C0/0xOhjcdtaDTadIienF7
 AEXTeeLnmVHxyZQr7p66XqfZ1eA1skt8KVFau7kiMT8Hh97C5G7lvtNd1u92kofqbB/l
 mWk0NESHpVOU8LPCk4x0hrzHtYo5rmEzQX3h3FuD9Yg4HD4mERoErcO4TLY3nulAOgMy
 ELW9cOb4Ok7xLG23Q6X3U7+iYDRHLEPlm7Zkwe38riUldVXB+h2HjdlMtWHB8cVhjOp3
 MGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5yY29WyUtcGMg3JYJpZWK5m4IoAUzfnBRUjC+PL25w4=;
 b=KWYfyMaBYX/SfRUuu7upgmEItkO/CUqH1X3+KBcB9vVpUOn4Qop3KfKNdLg15Zhh75
 mDNS1WYubjPLQvgei1HR+GBpP7E8oFxH6e7wjec2tzs8++3DU1vPzAm6Q4WXnshRG6in
 l3gbY/heFYmVvaMv1kdFUYhXO9fFFexad7yfc8yMBGARddwET8pAkqSrB8AaSh5J8lUD
 yhEZZH/coUPVxcO6WrZ3TUW72AjLUH2+YJLo17X8WWYvGIVijlLdtEft0TQ3Lx/gxdDf
 oQUElqxANQbLDdylfbtBfPdqAvag5KTQIztNAsF9TO6q5ZeRxYEs6GDPi1jwOPPdnDQ1
 MtvA==
X-Gm-Message-State: AOAM530Uifkav1DZWIkplDWhEhy/3doMHIM5kIuvkdqS5feanCP9Nwu8
 6MLzkQHWjsTEecPpZC2gXQvS1g==
X-Google-Smtp-Source: ABdhPJz/jpxoDW5biKBULRnhl/SVGUvJyfblsaFRwa7tLJS0Uw2k7atU78iLwZusSnfGkhSu+V2K1Q==
X-Received: by 2002:aa7:9708:: with SMTP id a8mr1117991pfg.234.1595448024880; 
 Wed, 22 Jul 2020 13:00:24 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 p5sm383662pgi.83.2020.07.22.13.00.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 13:00:24 -0700 (PDT)
Subject: Re: [RFC v2 21/76] target/riscv: rvv-0.9: configure instructions
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-22-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <0a1f78bf-a844-06df-e76d-56a113464727@linaro.org>
Date: Wed, 22 Jul 2020 13:00:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-22-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::431;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x431.google.com
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

On 7/22/20 2:15 AM, frank.chang@sifive.com wrote:
> +    float vflmul = flmul_table[lmul];
> +
> +    if ((sew > cpu->cfg.elen)
> +        || vill
> +        || vflmul < ((float)sew / cpu->cfg.elen)

Hmm.  I suppose this is fairly compact.

Expanding this to integer code would take something like

    if (vflmul & 4) {
        /* Fractional LMUL. */
        if (vflmul == 4 ||
            cpu->cfg.elen >> (8 - vflmul) < sew) {
            vill = 1;
        }
    }


r~

