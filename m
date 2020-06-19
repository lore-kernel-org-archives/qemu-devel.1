Return-Path: <SRS0=Yszf=AA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90511C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:29:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A86B21D6C
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jun 2020 23:29:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="r5gECndQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A86B21D6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60152 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jmQRV-0003Mc-L5
	for qemu-devel@archiver.kernel.org; Fri, 19 Jun 2020 19:29:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQQt-0002rH-EE
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:28:27 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:46995)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jmQQr-0008MV-Vp
 for qemu-devel@nongnu.org; Fri, 19 Jun 2020 19:28:27 -0400
Received: by mail-pg1-x541.google.com with SMTP id u128so5145960pgu.13
 for <qemu-devel@nongnu.org>; Fri, 19 Jun 2020 16:28:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=gbQm5eWleZFDOgpM096MfYeInZ2+1uK8ASU4vAz28qw=;
 b=r5gECndQea4BnW1oWj0vT1D7qOC31GATadsIid5gX/Uhue8c4tKBiGTLS65RSkZfsd
 QKlWJoyvBc0ZeEk6rxtfGzVjhxSeQBCqgDP03NvWuJ5V8At/z0lMR/HFqGaUAHxgT7ob
 pHIqrvG+mwYTmDZqFbDYlT0GMppPDOGPxZsJDnGuKxit4UHJTfvLULSVao2oLKGlE9Dh
 EQDPTbj0acHNvqWGi/hT+t85qdWEYtkNceKFVValhjA2XNPAcNKSW3PlXmBNjCirXsjs
 gEA+TmasQs3glfl+6Y0gaNhg7HxeMrFBUrTZxY6kMNjZcbpT+2Y7ef4vDj4zsHQ7wyYM
 /hpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=gbQm5eWleZFDOgpM096MfYeInZ2+1uK8ASU4vAz28qw=;
 b=imB1sN3vpGFJSxMnKvAtevWxZ7+/PQcQfJEp4JudiHzNAbIpiMf0mWUgq/vBo4Wx7P
 MNvwlyZ4J+BNR2fR5QDqoUCsm9xi0LBPowx1fXtAhGtso+8q4z4TNTTZHs8odgRuvfXr
 n91iQZdJAEx1oHXP14l85i5w2qOJnodkWPzFAge2EETiB8zrknxibd5+9YiTCx08qtLt
 13Ih+uwtV0bxRIObGZ/6v1Ile5Z0ObgnCpWHe7nZUXeoGNSX2hliyfycUwSjgJioZ5jS
 BhOjoNkVfQ/wHu2ZtH/ZfZa0VZNL5uyKvdm42KXJ2sJ7Duww8e3fP0RkEth2WJKL3DhR
 ZeAw==
X-Gm-Message-State: AOAM533CQx0/7eNMB0tex0dGQGxSl7RrSzxO1zYboUNJ6cAtM71IhpV/
 lOAij0nzEnBfdfDfyErwuT6yx8dvEqo=
X-Google-Smtp-Source: ABdhPJzxJYcXvJVronSVPuRcqnVbjS9Lwhf0HBIf4I5bZpcBZ5bgTtbd52CVCus0MN4DVOzbr/smQQ==
X-Received: by 2002:a63:6c49:: with SMTP id h70mr4821331pgc.150.1592609304152; 
 Fri, 19 Jun 2020 16:28:24 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x2sm6957202pfr.186.2020.06.19.16.28.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Jun 2020 16:28:23 -0700 (PDT)
Subject: Re: [PATCH 09/21] target/arm: Rename NeonGenOneOpFn to
 NeonGenOne64OpFn
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200616170844.13318-1-peter.maydell@linaro.org>
 <20200616170844.13318-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b42edc59-7bd4-9f65-66f8-1cb718a8c722@linaro.org>
Date: Fri, 19 Jun 2020 16:28:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200616170844.13318-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/16/20 10:08 AM, Peter Maydell wrote:
> The NeonGenOneOpFn typedef breaks with the pattern of the other
> NeonGen*Fn typedefs, because it is a TCGv_i64 -> TCGv_i64 operation
> but it does not have '64' in its name. Rename it to NeonGenOne64OpFn,
> so that the old name is available for a TCGv_i32 -> TCGv_i32 operation
> (which we will need in a subsequent commit).
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.h     | 2 +-
>  target/arm/translate-a64.c | 4 ++--
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


