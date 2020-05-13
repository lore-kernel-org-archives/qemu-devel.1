Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51FF4C433E1
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:30:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 59E5920575
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:30:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="keh8gorX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 59E5920575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46736 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYy11-0005b7-OF
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 16:30:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53594)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYxzv-0003uJ-LZ
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:28:59 -0400
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442]:33065)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYxzu-0005Zd-5K
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:28:59 -0400
Received: by mail-pf1-x442.google.com with SMTP id x77so259034pfc.0
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 13:28:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=dlKWQlnRe7VeGR1jc+33OUHP7qtqCYADhb8eLWTmcWE=;
 b=keh8gorXAYfnkUOpY2saXB3crcpyssrf8r0CPY/9vWTSc2X3bbzlJMITkiQ80qp1FM
 2VZPHelL5/zmkPlpYFiS8H5H/kfqZb6UIFIi55/JjA+32UqsVAASqqEU6BIgLrlXDj8Q
 1X1rpYEfoF9ibHtI0epxTYgGkeWp+K72lNfZLZsLMB0ViCao/N5xgjTnk1X8Qcz5nA5q
 5m36Y1BDPai1FuFV/AqBhVt35Kkcgt5r+W+eDO8u/eoRVN09ifZu/kDg92cKM5TRu6ta
 utKoipY/h7/69y/XdfgXcnBo+YutqjX4+gGCrlD3qSGOif/Zd+VSJA5GDJgsWZtzY01i
 XHlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=dlKWQlnRe7VeGR1jc+33OUHP7qtqCYADhb8eLWTmcWE=;
 b=Ji07oe5t9kkWc0s4+PJzFNMLstuoPuIWXh8M5Kd6HgGDdKFDW0LkWqkRvzKt3FeGC3
 +Vpq7sMTLbo1w2dURAcJwlDNx/PwbH0othSNptXsO0UdGZV4VXuhiccsdZ3U/hUTOp+P
 gF+NmyE52n5X7gBSWHH/L0d62wnCthsqQVTWU0qB0WJKKZk9SbjI2OnyAUoSaOCAPeW4
 /7LFwWItnN5yG8J/Yb2U3NA4gtTleCkgoc+jvEvBIWPOOHBH/PYIq7nzUwZhuG7Q5qpG
 HhfdPyICt/nQntRCqMXgiqXJo3XhdLbbjChwXiV+kubwTdF3FIP6uZkxHcvQdHt8NKfU
 05xQ==
X-Gm-Message-State: AOAM530XuVL0iiz6g3O2N5mRrr4GN39PXrkGhANc7/g46/kA4M1XWBNC
 Zdl5syA/n0eRvh6ubqnXYV4c25ASP7g=
X-Google-Smtp-Source: ABdhPJyvfNLW2rgxrnM+hcCme67TzhIdqtXRBk9WSph+tdJ2SP7Wsc2BxFXXBH7IzKwh7GlUUvAJBQ==
X-Received: by 2002:a62:e51a:: with SMTP id n26mr944286pff.301.1589401736449; 
 Wed, 13 May 2020 13:28:56 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id z25sm336890pfa.213.2020.05.13.13.28.55
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 13:28:55 -0700 (PDT)
Subject: Re: [PATCH v2 13/17] target/arm: Convert Neon fp VMUL, VMLA, VMLS
 3-reg-same insns to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200512163904.10918-1-peter.maydell@linaro.org>
 <20200512163904.10918-14-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e18bcf96-be43-540c-6471-1681acb4a653@linaro.org>
Date: Wed, 13 May 2020 13:28:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512163904.10918-14-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::442;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x442.google.com
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

On 5/12/20 9:39 AM, Peter Maydell wrote:
> Convert the Neon integer VMUL, VMLA, and VMLS 3-reg-same inssn to
> decodetree.
> 
> We don't have a gvec helper for multiply-accumulate, so VMLA and VMLS
> need a loop function do_3same_fp().  This takes a reads_vd parameter
> to do_3same_fp() which tells it to load the old value into vd before
> calling the callback function, in the same way that the do_vfp_3op_sp()
> and do_vfp_3op_dp() functions in translate-vfp.inc.c work. (The
> only uses in this patch pass reads_vd == true, but later commits
> will use reads_vd == false.)
> 
> This conversion fixes in passing an underdecoding for VMUL
> (originally reported by Fredrik Strupe <fredrik@strupe.net>): bit 1
> of the 'size' field must be 0.  The old decoder didn't enforce this,
> but the decodetree pattern does.
> 
> The gen_VMLA_fp_reg() function performs the addition operation
> with the operands in the opposite order to the old decoder:
> since Neon sets 'default NaN mode' float32_add operations are
> commutative so there is no behaviour difference, but putting
> them this way around matches the Arm ARM pseudocode and the
> required operation order for the subtraction in gen_VMLS_fp_reg().
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  3 ++
>  target/arm/translate-neon.inc.c | 81 +++++++++++++++++++++++++++++++++
>  target/arm/translate.c          | 17 +------
>  3 files changed, 85 insertions(+), 16 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

