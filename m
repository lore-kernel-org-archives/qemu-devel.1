Return-Path: <SRS0=7Ydp=CG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3BAC433E6
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:04:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC6302086A
	for <qemu-devel@archiver.kernel.org>; Fri, 28 Aug 2020 23:04:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D066cukn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC6302086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58078 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kBnPo-0006I0-T4
	for qemu-devel@archiver.kernel.org; Fri, 28 Aug 2020 19:04:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50618)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBnPA-0005go-WD
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:03:33 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:38141)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kBnP9-000425-Iw
 for qemu-devel@nongnu.org; Fri, 28 Aug 2020 19:03:32 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ls14so242827pjb.3
 for <qemu-devel@nongnu.org>; Fri, 28 Aug 2020 16:03:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=16U5h2+omcHRezP2Z+Rsbzo2H9LneSg5ccc0ODKIVOI=;
 b=D066cuknbxZ+bqyVhWCh1voX8W7WqIX5bd1ffNed6o39E3mCXtYKgBjTIfPhXHXUG/
 8zg393ke8gJluATSXFettHd2khOHkeZ6rwWw/yyzlGVkZx6dhZPeNvhsdU1pwOpH71VJ
 Nm8eulH1TJqPlYqfshGOdwNGeG1Yk1NexJKjW5l5EN8YxO8WR84K3HaBQaB+VLKWWvJN
 10nUkMQf35VebA73UW15T98U4I8GGNyBJTg9Lqfnf/U9e+0OW6LNVNWKg9Bvn+04d0+6
 lZiUcsoJ7ARUN6QkM/RRBgMskJO3Jt1FgZN6+cHZibiwWBMMcvaHEM2ng9uXj8EKNKPI
 2Ybw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=16U5h2+omcHRezP2Z+Rsbzo2H9LneSg5ccc0ODKIVOI=;
 b=EggLbYm9ETVMZKgbRx7XI6Miu2ovtCMx/AC/3aEiL7X9N6wTe8UxfMpJLoPr66HLfs
 CIwFNwuGN+srrK3X1e0yDENcinFEPWPyo+eaPEp3LJwfFciWsVVJrFgWgn3ZhXeqLBCH
 8hFUFIMTFqrc4uMs0lLjFjNoBQmtlumQ/NGjCW3En2A6kRCgOPEG/kRbVTES6bKDMlMc
 xn7vZF4a2Kf+VA+9pdOSArDZdlVn84VUh7hGio3+EVU3bU6KvkTIBAhV1+ViCX+AYzQE
 E6X0B+neZkhBkNWcgHuDn7SGMO/69ARO/5ik9BG7SRwxSjwka6DBsuET92Lva26TjwsW
 XALA==
X-Gm-Message-State: AOAM531wjQ+GvzjHq0GtR3YtF8MF9eU6RnN9e37d69B/8Gp5WVZt69n/
 1qvFmFsSuk9Jq4/WAZ1Subhlh/c8txJFbQ==
X-Google-Smtp-Source: ABdhPJxdYC4GO08TefeGvyxQ0trHUc1VZpxY2g3QJOxAHuJaAGXMObf4x85eY4DOyCBcQjgteevisw==
X-Received: by 2002:a17:902:6ac9:: with SMTP id
 i9mr909574plt.128.1598655809678; 
 Fri, 28 Aug 2020 16:03:29 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y203sm484745pfb.58.2020.08.28.16.03.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 28 Aug 2020 16:03:29 -0700 (PDT)
Subject: Re: [PATCH v2 34/45] target/arm: Implement fp16 for Neon VRSQRTS
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200828183354.27913-1-peter.maydell@linaro.org>
 <20200828183354.27913-35-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <57f2aef4-5395-f474-c56a-48e81ea0b15f@linaro.org>
Date: Fri, 28 Aug 2020 16:03:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828183354.27913-35-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.809,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/28/20 11:33 AM, Peter Maydell wrote:
> Convert the Neon VRSQRTS insn to using a gvec helper,
> and use this to implement the fp16 case.
> 
> As with VRECPS, we adjust the phrasing of the new implementation
> slightly so that the fp32 version parallels the fp16 one.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.h             |  4 +++-
>  target/arm/vec_helper.c         | 30 ++++++++++++++++++++++++++++++
>  target/arm/vfp_helper.c         | 15 ---------------
>  target/arm/translate-neon.c.inc | 21 +--------------------
>  4 files changed, 34 insertions(+), 36 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


