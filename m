Return-Path: <SRS0=I9ML=66=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D640C433E0
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 02:18:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 36F2420756
	for <qemu-devel@archiver.kernel.org>; Sat, 16 May 2020 02:18:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="beMzJ5sj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 36F2420756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52896 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jZmPV-00068t-Du
	for qemu-devel@archiver.kernel.org; Fri, 15 May 2020 22:18:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42616)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZmOw-0005cQ-6j
 for qemu-devel@nongnu.org; Fri, 15 May 2020 22:18:10 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:33697)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jZmOu-00088R-9h
 for qemu-devel@nongnu.org; Fri, 15 May 2020 22:18:09 -0400
Received: by mail-pf1-x441.google.com with SMTP id x77so1896312pfc.0
 for <qemu-devel@nongnu.org>; Fri, 15 May 2020 19:18:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=oexMwPmJYyEN+ltFBiBZw8MCGG7aiN1HIamlEyzyot8=;
 b=beMzJ5sjH7xSc+sRsV61mW0YlWlm5jZ4b2tqYPgJ/MBDzVlkOHv0t5lr2xuPn9/7b3
 yEPfgT9UkqiwAo6AM5MZ0zal5iR1Hwcxo6GlQik9aC/1+sZsMzi1BQs+GbjbavJPmfKF
 NNyVn78Fb/VsMQI5f086/gvrg2Xl+V1zxQYOzEtbDkavYtK6F4ksW1VmtyMhnwen27Hw
 vKaNc/TLPoA0mnmJ4osGOgpvhi8YA1QJUTaUnblMaU70KtErLh0ZIVDMiyq2/dgGehQX
 A9zWrbm8wyjzlFk2vWCuRQSaCykyZ5yjlLRSHv4ekXb6hwmkSgUwKEO4PbAfOEStask3
 l6oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=oexMwPmJYyEN+ltFBiBZw8MCGG7aiN1HIamlEyzyot8=;
 b=Q8U/VIagDCXOQ1sm8XagzTeYvPQJhy2G1/xbK5BvYoDvwArlSq1nBMFt0HKqTx1Ti5
 xOPmdNSWwnW04VXNWfHptHbQTqdqEznOhQS2c+9f/PnZ0y63j3/KoAbRHScVioBfw0NX
 FbS1SvQoPtkuX/DFzl0P+fnT39OtxhzXcBEfFgY8xFmC2WT+pxFHzu/nXZU1EeuG/QZA
 wlE5qnmbStTXM89UVJA5Zj1ChOGuHhVlnoM/Vew/bxz11bOkbIF2Y2UYfBcVXVt4TJXY
 3TlslhB/owFgmt2hNMojCLo9pNixkIUCSZ2FWFymgDcDxDEoJ4ib20YQZ+uSZunwwAtb
 UnpA==
X-Gm-Message-State: AOAM532C+FXZe1CKIs7oE6GovQ8w1+TUNhkT426Q/uIFwg9zO8Vol66m
 Fa9v5jFlbra7OpV/bYa4bfyJWaqmZHc=
X-Google-Smtp-Source: ABdhPJxFGctf++XGGXno3jXP5T7B+zYQnk0dgnyO4QqPKgtfZbExvM7qV63cezUeMjcx8eDSGujTJA==
X-Received: by 2002:a63:5812:: with SMTP id m18mr5742234pgb.407.1589595486631; 
 Fri, 15 May 2020 19:18:06 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x7sm3042633pfj.122.2020.05.15.19.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 15 May 2020 19:18:05 -0700 (PDT)
Subject: Re: [PATCH 08/10] target/arm: Convert Neon VSHLL, VMOVL to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200515142056.21346-1-peter.maydell@linaro.org>
 <20200515142056.21346-9-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <39d9c3a1-59b0-26a0-594e-d565ae77a97b@linaro.org>
Date: Fri, 15 May 2020 19:18:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200515142056.21346-9-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/15/20 7:20 AM, Peter Maydell wrote:
> Convert the VSHLL and VMOVL insns from the 2-reg-shift group
> to decodetree. Since the loop always has two passes, we unroll
> it to avoid the awkward reassignment of one TCGv to another.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       | 14 ++++++
>  target/arm/translate-neon.inc.c | 81 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 46 +------------------
>  3 files changed, 97 insertions(+), 44 deletions(-)

Modulo &2reg_shift_nq,

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

