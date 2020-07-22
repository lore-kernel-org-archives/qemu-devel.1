Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 866EEC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:19:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CCF120771
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 16:19:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SzOxPDfI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CCF120771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47726 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyHSd-0005CT-JY
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 12:19:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34062)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyHRp-0004IX-H5
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:18:25 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:39729)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyHRn-00046q-RZ
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:18:25 -0400
Received: by mail-pl1-x643.google.com with SMTP id b9so1233454plx.6
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 09:18:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YFbJtf+CWRuJjCYVVs58KiD6YIYaIJ2Jgoffj9BqBZs=;
 b=SzOxPDfIIsM8njGBz12plZUz3qDAawbhWqAl+g2/IVeTkXXiw8dOCowMICATnhlLbX
 X/c0Ys7xfI6yXKHvx1n78q9u5b7/0YoAX2SHv/dGeQheiysbgHHYcSVItZ60K74sE0Iw
 zQh16qIhhRFX6b9rNM3TNHj+MSJllQbt87kaurkZix0duMJarAuAxHyuenACQHIDCR0C
 qKhrFYoJUw6/P72HWqNvamHflYD/Ja0sOZPsL9C+vctl9ul0L8ez9GRg9FeXRfsZJbLz
 D+gzIXyHH/+nBg8vkJnscrDVDdOBivoa748OGYMbdeYws//ZQGcnYpFsNG1pBTsqajeh
 Irig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YFbJtf+CWRuJjCYVVs58KiD6YIYaIJ2Jgoffj9BqBZs=;
 b=hBvh3x9RTzkujfCBIuhipfB/YvQ9SjW65fbjvB9pFdflQ4UFOGB8UyTx6Tnh2AuIdR
 gXSPos8I95T001FZ1s7pisKhgHca1f+fUtGCkvgiLndvk//d4QA88+Rjifje0GWYaC7F
 MbypNOVkU8YAUo/bVM9WKs51kDAu+qs1iBHQpmtVPpkpewQZzXdKXhHupbIKRATKx1Ev
 gUKZawRGfwDLurVcKVGxcIbj1nJHNO2Yu7+D0m+chRBIUvd/WlNDZNULObD2luWpUlom
 PvazMm9bjNYKengKEcoPyy1Y6rzTRX4UDOmtLnWXxIvOCdn+D8gM1w4vxnfVDHONQMGV
 /wqw==
X-Gm-Message-State: AOAM530VPWbOysEOVmvEnRRL2+IHcGeJH2yZp2RuS6tji5qxsnbn+PSI
 3OoRV6xhX2O+Fr+T/EHOe9qqzA==
X-Google-Smtp-Source: ABdhPJzXoxlee68xLMKdNuUSVt2d2zMCgO9JRYwxjQI1xnU1YNovMqzqtcIuPsifz+j9BEMyGV750w==
X-Received: by 2002:a17:90b:1296:: with SMTP id
 fw22mr206796pjb.20.1595434702221; 
 Wed, 22 Jul 2020 09:18:22 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 y19sm64390pgj.35.2020.07.22.09.18.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 09:18:21 -0700 (PDT)
Subject: Re: [RFC v2 03/76] target/riscv: fix rsub gvec
 tcg_assert_listed_vecop assertion
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-4-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7db64384-920d-b96e-ee95-5f5ec989bd2f@linaro.org>
Date: Wed, 22 Jul 2020 09:18:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-4-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
> gvec should provide vecop_list to avoid:
> "tcg_tcg_assert_listed_vecop: code should not be reached bug" assertion.
> 
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/insn_trans/trans_rvv.inc.c | 5 +++++
>  1 file changed, 5 insertions(+)

It would be handy if you would rebase on master when you re-post, since this
patch and the 4 following were merged to master on July 14.


r~

