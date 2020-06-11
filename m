Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 382EDC433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:33:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2954206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:33:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EGMEBIj7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2954206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49652 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQ8g-0001Xc-5y
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52206)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjPsC-0001k3-Ae
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:16:12 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:40559)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjPs8-0004Bq-0n
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:16:11 -0400
Received: by mail-pg1-x542.google.com with SMTP id e18so2727588pgn.7
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:15:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=7Zu0xo3avEWbt3KpCW7LHSm4MRzPIGpUmUyz+EeUMAc=;
 b=EGMEBIj7FHF7+AJDv0qKKx0B5WDS4e+RGdrGILgCtENH8rHLZne3MX+AX1xhDKF/D1
 9p8+0Fm5uEN7Djs7o+Q00LgIUZ5McrdWGQFTLB3Mo40c2rHpawCb2DX7f83tHzkVjedf
 EiJ7o5eqGt9JyUBfkZj3TVIcDK/K0Ejip9rY+HGsoUpEhHdGOFhkdlDUCZ2FSa08Noba
 jDazNSQBAn9lJIEnKWm6TN3orOqQd7aHy2mRpZpcEaHdQljk5DBBzuPzAgoOZo7Ndx/c
 kBFEwtm+65BNMdWngxsjEKHgUtWxnrj+dS8MxKabKG0s1hGYAAR36q5IqM1f/MXgtPhh
 jK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7Zu0xo3avEWbt3KpCW7LHSm4MRzPIGpUmUyz+EeUMAc=;
 b=RlYaaVvnZT6slgzxGiwQPGcx4/2N//kGvAyBt3GCCdHZ6gWO3z2acjha+LpHRxgKin
 CSe2AUcobb/3/X+cfJVdgLHZ9WacAAkKuHEgi7nRSINWZ5X7HADMlWjfsVR2MiG0YRkS
 ogk810+lNDCY0HK7UyncocZ3GXvARIjkjbLEe9H6BcsV6ZNKRNZo/HpnI/6TstXZpxuR
 wmjecKC6+RRbvrwqfcKO1Rcx6HeLegTdU0unYQcz5S2FsgWCWOOHbZI6zRv44UJUHrkf
 Gsagx3QcFdShcyqDpeAKSLxZqpyz9fj6bVI0fbLD6TcJ9I++AyzWb5XSqFdvGELlR7RF
 o77Q==
X-Gm-Message-State: AOAM531mC/PvskPn+USa/mg7BfzHY177XE0ClSFY1++Obzn1+RAjDVNu
 Vi6yy8hf5Ej82qrq6g+OWLq/pg6T+4E=
X-Google-Smtp-Source: ABdhPJwjTvWeOq6GRs6E7Eu1EJL5Cg9cndZPefH2CICO3YIojEx5CxX/K6ZPV1zx5taIj1wGrW8ayQ==
X-Received: by 2002:a63:cc0f:: with SMTP id x15mr7111169pgf.84.1591892157542; 
 Thu, 11 Jun 2020 09:15:57 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id i63sm3305910pje.34.2020.06.11.09.15.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2020 09:15:56 -0700 (PDT)
Subject: Re: [PATCH 05/10] target/arm: Convert Neon 2-reg-scalar VQDMULH,
 VQRDMULH to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200611144529.8873-1-peter.maydell@linaro.org>
 <20200611144529.8873-6-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <771166bf-06a1-ff05-47b6-cc2fa63c66d4@linaro.org>
Date: Thu, 11 Jun 2020 09:15:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611144529.8873-6-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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

On 6/11/20 7:45 AM, Peter Maydell wrote:
> Convert the VQDMULH and VQRDMULH insns in the 2-reg-scalar group
> to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  3 +++
>  target/arm/translate-neon.inc.c | 29 +++++++++++++++++++++++
>  target/arm/translate.c          | 42 ++-------------------------------
>  3 files changed, 34 insertions(+), 40 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


