Return-Path: <SRS0=zezO=BB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7349CC433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:06:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A552206F5
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Jul 2020 17:06:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AkF/ct3u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A552206F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47922 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jyICR-0000nk-G7
	for qemu-devel@archiver.kernel.org; Wed, 22 Jul 2020 13:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46202)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyI5A-0006rO-0v
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:59:04 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f]:39100)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jyI57-0002va-SP
 for qemu-devel@nongnu.org; Wed, 22 Jul 2020 12:59:03 -0400
Received: by mail-pg1-x52f.google.com with SMTP id z5so1604541pgb.6
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2020 09:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/405If9znH2nDBiwwUGt+7Wbc0uDgVSVGXkSO0lV39E=;
 b=AkF/ct3u9TAGRUWEk1N9IfzmjNhjiHhaeQzhJWscQdX29wvksZlx61WtKY4js9nAWE
 cligGstfIHl1whHhhsO0Vt/9V4YjXccVzRPOhLCW4BtMuL/mabjXotA4W0bt2LFQl7g0
 1OY6JPKew5dyaHbBXbOuVH8qo5fobd1jWdfheYadF9aaUOAN3nSjYRsbmJXz8vCYpAXx
 Aw3YpPrLj4wXAylnUclzDG7K3WBCdjHCUQ+GoHe590f+g68CY1d1HT7mXyQYz7inXU3t
 7ZIrvitMt3X1z36yK+hxMCZ+Jj/9DXHNiT2jInImje6lTDy/6TVSElVfBgVx/pcRvYqV
 tRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/405If9znH2nDBiwwUGt+7Wbc0uDgVSVGXkSO0lV39E=;
 b=YqZAfFdlnverAd2hpiaaLN/vMvbAVEu9cjTDIwIk7Pga//Sk2/oCoKt2hO4Fp2nXjR
 dsLGZ4btMxqYSDppRNYQAQjMFJfXatCEFBujwS8coCXlCzQxA/oUx7OBiA1HY/4lV0aD
 gij6LEXaPKNp3cL3z7kBnudccSVZbvHAZq35rNtdb49Mi+U22jLjI1NlVcN1Xsna4G7M
 f7zgYlFQb/3NAV+n/3ngTdSNGJ+/rrowu2mJwun7CFMkaAdNGZTWKeIxObVmqk2z0AZJ
 dqyobEcYdf24Kw8NawvsrHwcyWK1fGasJ9f8s6UrlB6ecQyc882FLkt+9LaToC2CBKKD
 ytRQ==
X-Gm-Message-State: AOAM531JrJ3wL7LmBmujPK9k1VW4/pztWO8tUjkXaceVRSQ0G/a0NFK8
 q6YHESbYuZqtnIveTQqvx1RtCQ==
X-Google-Smtp-Source: ABdhPJzmH4cceTfd6Otx7Ktru6vdaR8X+jflXNGqRI0Kr7/togmQ+YGCIvY17Mo2wFkd7kOKbm93Ig==
X-Received: by 2002:a63:a119:: with SMTP id b25mr680721pgf.10.1595437140328;
 Wed, 22 Jul 2020 09:59:00 -0700 (PDT)
Received: from [192.168.1.11] (216-160-65-90.tukw.qwest.net. [216.160.65.90])
 by smtp.gmail.com with ESMTPSA id
 x9sm178394pfq.11.2020.07.22.09.58.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2020 09:58:59 -0700 (PDT)
Subject: Re: [RFC v2 13/76] target/riscv: rvv-0.9: add vlenb register
To: frank.chang@sifive.com, qemu-devel@nongnu.org, qemu-riscv@nongnu.org
References: <20200722091641.8834-1-frank.chang@sifive.com>
 <20200722091641.8834-14-frank.chang@sifive.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d47835e5-6eb2-9a91-f958-2aa145e5d693@linaro.org>
Date: Wed, 22 Jul 2020 09:58:57 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200722091641.8834-14-frank.chang@sifive.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52f.google.com
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
Cc: Bastian Koppelmann <kbastian@mail.uni-paderborn.de>,
 Alistair Francis <Alistair.Francis@wdc.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Sagar Karandikar <sagark@eecs.berkeley.edu>,
 Greentime Hu <greentime.hu@sifive.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/22/20 2:15 AM, frank.chang@sifive.com wrote:
> From: Greentime Hu <greentime.hu@sifive.com>
> 
> Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
> Signed-off-by: Frank Chang <frank.chang@sifive.com>
> ---
>  target/riscv/cpu_bits.h | 1 +
>  target/riscv/csr.c      | 7 +++++++
>  2 files changed, 8 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


