Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 571FCC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:07:15 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB1EC2065C
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:07:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ECXQPJus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB1EC2065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42296 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYxes-0002de-6V
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 16:07:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50242)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYxdo-0001mc-IL
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:06:08 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:37876)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYxdn-0008M2-22
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:06:08 -0400
Received: by mail-pg1-x541.google.com with SMTP id f23so231848pgj.4
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 13:06:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=7WZ8pWLFWQvaCWy30zSAb5qUGWZ4Ome3x2SKEpwa7PE=;
 b=ECXQPJushlKKIgd9qJXm0WPg9Ka0Ry9iC4lsAo5Z4mQzlBKfkCQcDL1SZxUTWYdWL9
 imLW/12CGX7kUEpBioYoKrTsMzcMGjO+xr7s+XMZypXOZ6oOCL9BHHx/6tyncSUq9CPB
 odAs29gumARzCheSgoBcPX0dwwHswYipwEXrhDySezgeqdkzKfUW9s7L9I8E/Myst43F
 5obAJfr8Dsl2Yyy/3Vvpe/ZI4H/M0EMnY/rVp8qUqNDemgSaHIz6CoQ0FgCYZ95zbI7H
 +jPG+su0XM77VijcvPZkO9LKnEnYvNQrqfu8oQmmbH3wH3SwXOBWOfB38h4xdrfA6TFX
 RN1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7WZ8pWLFWQvaCWy30zSAb5qUGWZ4Ome3x2SKEpwa7PE=;
 b=ZZicqNemUSIA8C98AMUfBpvmcDcxPKve48WtEiik/3KRHiUEAlcEt7bJtECwqt7/y+
 c+7eztn5Fzf3KU+ytyC3Ob8KbLEubymLpI3Q0rgWctgl43fZzTVnxpCaJ74PLs4x21Al
 IrNUgRKSVqsxhZxwIZdPEFw11zRxJryJTCp2fX6/A5sfXddu+AAMyaWcXYuSwbZlvaDU
 jxHxI1zSkeE/po+AvJt3UNW2NHJiWWUpqov70o30om135Xh2RELwjM6FHR2Y39+AF5bs
 GRzeY3VJW3T+E6UHNCFDpOLrAQAjj2XaoFRjC27KYbV6goATMpoWsRG8hUGvFETR6t2R
 +nGg==
X-Gm-Message-State: AOAM530+7Swt9sYnjw6fLcV5F9cLKbGk5kenCI6T3zNzxx1bJfqyZEfS
 b0zK+YVbry4Uayo86Is6QgtpFABEXlI=
X-Google-Smtp-Source: ABdhPJzrAXFuD3oPp6TkzIiO17OB+T9oPgI9cEvD/KOz6Y48okjKRJpTiRbG7yE3NUzrfMwQ8j6rEg==
X-Received: by 2002:a63:c241:: with SMTP id l1mr965086pgg.42.1589400365103;
 Wed, 13 May 2020 13:06:05 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id gb6sm2462009pjb.56.2020.05.13.13.06.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 13:06:04 -0700 (PDT)
Subject: Re: [PATCH v2 11/17] target/arm: Convert Neon VADD, VSUB, VABD
 3-reg-same insns to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200512163904.10918-1-peter.maydell@linaro.org>
 <20200512163904.10918-12-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c852cc48-339a-c316-4782-daa941f2bc30@linaro.org>
Date: Wed, 13 May 2020 13:06:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512163904.10918-12-peter.maydell@linaro.org>
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

On 5/12/20 9:38 AM, Peter Maydell wrote:
> Convert the Neon VADD, VSUB, VABD 3-reg-same insns to decodetree.
> We already have gvec helpers for addition and subtraction, but must
> add one for fabd.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h             |  3 ++-
>  target/arm/neon-dp.decode       |  8 ++++++++
>  target/arm/neon_helper.c        |  7 -------
>  target/arm/translate-neon.inc.c | 28 ++++++++++++++++++++++++++++
>  target/arm/translate.c          | 10 +++-------
>  target/arm/vec_helper.c         |  7 +++++++
>  6 files changed, 48 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

