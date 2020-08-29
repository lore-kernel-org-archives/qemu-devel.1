Return-Path: <SRS0=OYoK=CH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF92C433E2
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 02:59:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B825C208CA
	for <qemu-devel@archiver.kernel.org>; Sat, 29 Aug 2020 02:59:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HGLTei5l"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B825C208CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33232 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBr5v-000087-U2
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 22:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52178)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBr5Q-00089g-UG
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 22:59:24 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:33802)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBr5P-0006ms-Ap
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 22:59:24 -0400
Received: by mail-pl1-x641.google.com with SMTP id v16so525317plo.1
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 19:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=opQefAA4NTAdDH36EP305N6VJ35Rn2Nt8M5rBoQapRw=;
 b=HGLTei5lywkd9giMzKtFcNH/xNDcQkqPp146Nc2DeWKjv6v9Xs1ffS2BW9z+lG+SVA
 U+LzQcFZEegL+9vRVYI7/QsBoYGU4hhwyDaS6C5YRGjejPvHZVGZQraAHzkkBV6Cf4aR
 zgvRyhwwhTxWwzgoR+hGHwaoIIwu7zoq9Sj7gBYEqe0WuSPAn0EKOyNL3MzZKZIHyw8C
 W0uX7BnJFZTlWZ19lFRwILRKkT27+U/OL7kMSGwKHIGUA/+Ng+SwDoQ9R/1iRgwjSdPY
 9jSQUt4M7l/15FVCNor4t6dWXx+mIWjK5uEsFcLbMbgpn8HGih7ZEJ4IRG3juMv+mWgM
 zvKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=opQefAA4NTAdDH36EP305N6VJ35Rn2Nt8M5rBoQapRw=;
 b=iSExsXggZNnVopGCn7N818B4cGUPl+RiX1e9/WLAaQUo3sSLg9QcVyl8aFX4fp2b90
 /uwoZCLLgFThHAvCeYMI4rip1lKsSITvT8DhWCBlzO2N/TFmH9RfdXU1jXTGK44JXaAl
 7ZoPKASMvhrZqeKGJY49UVMSUI37HwFtukE6Wt8i0Dwd9mqsgGJVM5tMJwjIEWHoKo2A
 NLIK8kY2iNDmIcbaXfwZdB/iITM56x6kdWvoaYmzyJ6zh9W6XBfVsULisjxA4aRt7vIG
 45kfPBiWX0CI9b750OFZwQZa5UzscPJvAlPn/50FT9CdCQE3x7Pd7uhB5+ibKjWm9QXn
 PFPQ==
X-Gm-Message-State: AOAM5315dKnF4/YUAazZIPFAtdoAOk/cgJnzMZYV85/91MDt9/3aNjw7
 VNtQB/YGO+GXMNwafQJiRj+HHw==
X-Google-Smtp-Source: ABdhPJyU5Pc17xchIykcypR4bPNF+xYC9ToCq+OCcI2EiyM5UcCTOW9VfsG7fZY8cV4usGENHr1iSA==
X-Received: by 2002:a17:902:8d89:: with SMTP id
 v9mr1356389plo.289.1598669962065; 
 Fri, 28 Aug 2020 19:59:22 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id b12sm806216pgr.34.2020.08.28.19.59.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 19:59:21 -0700 (PDT)
Subject: Re: [RFC PATCH v3 32/34] Hexagon (linux-user/hexagon) Linux user
 emulation
To: Taylor Simpson <tsimpson@quicinc.com>, qemu-devel@nongnu.org
References: <1597765847-16637-1-git-send-email-tsimpson@quicinc.com>
 <1597765847-16637-33-git-send-email-tsimpson@quicinc.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ea1f844e-0efb-6d98-e799-6dd00c16d9fb@linaro.org>
Date: Fri, 28 Aug 2020 19:59:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <1597765847-16637-33-git-send-email-tsimpson@quicinc.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Cc: ale@rev.ng, riku.voipio@iki.fi, philmd@redhat.com, laurent@vivier.eu,
 aleksandar.m.mail@gmail.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/18/20 8:50 AM, Taylor Simpson wrote:
> Implementation of Linux user emulation for Hexagon
> Some common files modified in addition to new files in linux-user/hexagon
> 
> Signed-off-by: Taylor Simpson <tsimpson@quicinc.com>
> ---

Looks plausible.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

