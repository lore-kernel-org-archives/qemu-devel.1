Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 955B2C433E4
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:07:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 619892065F
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:07:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j6i3Awyx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 619892065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50894 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyIDc-00021e-Mp
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 13:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48032)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyIAb-0007UR-B8
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 13:04:41 -0400
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e]:34682)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyIAX-0003gc-58
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 13:04:40 -0400
Received: by mail-pf1-x42e.google.com with SMTP id u185so1623083pfu.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 10:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/TYHx8t4is69BJObheL0xYgdcc2FOv3loz3Uv+BXTJE=;
 b=j6i3AwyxpKTUpWsUv/LiQDhnzTTuBhCOrI+khU8l31xeeBs2mFirshDnRKs+EpepIS
 +avdpCvtiwiVTPAbOYF3QwHtqbcgPLKiieYmhfyLiwQZGOB1AeAiRktbeMI4OZL4I2h4
 pN2Zua3defgG4Obfrte5LpwNtWRzygcjrLXmXNxbIC5ivMBwFgWmWLhkJKSqjopjChSC
 aSpsQ4F8mAN6/xag3xEi62OixK2PH0J5u2B4gbVE8rNU27Uz7EaZ2qi4nDeNwJ4t9j65
 E3W8Z2GOfu7lHmDWYm8VCsw9GeY/O3+toUq8F9cIFNTp+lLTz1buROXw+tCFafbA9XFU
 zn1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/TYHx8t4is69BJObheL0xYgdcc2FOv3loz3Uv+BXTJE=;
 b=HI+PXScUmymchMcd1BIuQsffOmaDE6Y+RCLTpuh7YUKtiPlJ6UAgtdM7rf1QMDwi+T
 LGFHIlYFTvs5OcQP1sKbeWSCJMk+m6BtUux8R9AJJLh9/HvXyYXTnh9eamgzdItc5EFx
 73Bpz3/q1YyE36/nDeMNY03xbpNYTEmRW4HpDPXZgS51bPKWo3B9GR+AhxnSFQtBCpqO
 jqnvHcLZ7fBNIKyueCLCOIpfl2CB8QV365Ty6x4nPxM7fhwkvqNxGAYAujGFL3ZphfRD
 PePP+vLq964klRF4LtoFtU3ISgpUDpq96irecNYYBU7BQu9xr5Z4IO2BMCMtdeNMbYAT
 vLEQ==
X-Gm-Message-State: AOAM530YVXZuU07MCGOnMK1lODzIGIBmY4v9RqPWxD9TcUr6TzK/xc3B
 dL5ll21nlxnCyr4RJYp1n/rbJg==
X-Google-Smtp-Source: ABdhPJxSbdiL3FUCGizZfXQx/W68uo1wcIOeu2giAH81YpOxL+fsY+jYW99Jew3W6Z5b50Nw6kR8Wg==
X-Received: by 2002:a62:ce83:: with SMTP id y125mr505388pfg.181.1595437475522; 
 Wed, 22 Jul 2020 10:04:35 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 y24sm126000pfp.217.2020.07.22.10.04.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 10:04:34 -0700 (PDT)
Subject: Re: [RFC v2 14/76] target/riscv: rvv-0.9: remove MLEN calculations
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-15-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <dcc23f74-59a1-38ed-f545-d7e4d118f71b@linaro.org>
Date: Wed, 22 Jul 2020 10:04:32 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-15-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x42e.google.com
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
> From: Frank Chang <frank.chang@sifive.com>
> 
> As in RVV 0.9 design, MLEN is hardcoded with value 1 (Section 4.5).
> Thus, remove all MLEN related calculations.

It's section 4.6.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


