Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C9BCC433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:28:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3410F20781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WH14VshG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3410F20781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60954 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joWbY-0001Oz-ED
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:28:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34784)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joWa2-0000sh-UZ
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:26:34 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:54181)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joWa0-0001cx-PY
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:26:34 -0400
Received: by mail-pj1-x1043.google.com with SMTP id q90so2944760pjh.3
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5/x+2gz+Eqanums/cnWLOVdd9dAMlYD5e+S7tqobOpI=;
 b=WH14VshGfD8Aotkjx/ZeudD2lmhxH5Ux/SOnSUvfyQ5ckOun0C3P0vmYn/kMxOGnW/
 Ui0dJg+yGY6L67qpWT002HbNEBsp1EWZ83UNfUluCLE/blHUC+/CV3Q3ZGN21lU/OXny
 2UiB4rfAuUKu9/E/7j0MPKnZGd3JyMStSgy9OSkrEFIV/tUJMr73oIdKrc2XS+HN+haA
 T4iedsUyONvNGzjj90hZktbtl2cqFeqoLYjo2WiolEIMptUj5BIGdzN9jAAkMgd2si9X
 n1NU6vvo0oVdvnILBwNJzOSiDTD8GCO5EYgbOzMDTbD5dnRz/t/XjdzMVuvjdR7ROJzg
 IHkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5/x+2gz+Eqanums/cnWLOVdd9dAMlYD5e+S7tqobOpI=;
 b=V5DejChKYMJweUU0d2Yp8M/o3gJu3tBoJkVXa4yd1IlV0mTtZsWktWpc2wpgGJHIQF
 w3Yyvj+zWbGzj/ORkLaPKqqn/udr0D43BGi8mSLLa3sYbzcvx3LflYXBTqG7mddH+a3A
 mSBR6wenMkog9tVTEXvDYspxOBBf/eCXcuCwz2PE+xoRxv+NzY9WH7Q/J3qiqpwoqGeC
 WlRsCfGSBvVxOs71+zJPBHIRu2HFeaynTgRVb/RdSxJZaqXn56PUP9ZQmQZIr1e7PetD
 QTk39q+WfBA1XIcLQghqZuNczSJMtz7UgCcLs5Gn7AjaJVpu/SpNf9BEXpPAF7FVbvBI
 SHkQ==
X-Gm-Message-State: AOAM530QGse9/d+9dYrFq88cWh+OSOwvKF8BK3MMJE5rfSSRrEdrxr5+
 uWIy32MLrcskN0XX5F/FDJaB7Q==
X-Google-Smtp-Source: ABdhPJz5dauvp2D2gSh8tOhRILlzdO2XMIwYdRELT1sEE4ggVeV9cRqfsSUwxgH7YIXkYCAiTwCP9A==
X-Received: by 2002:a17:90a:d487:: with SMTP id
 s7mr4618429pju.37.1593109590329; 
 Thu, 25 Jun 2020 11:26:30 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id x29sm6261352pfj.190.2020.06.25.11.26.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 11:26:29 -0700 (PDT)
Subject: Re: [PATCH v3 5/8] target/ppc: add vmulh{su}w instructions
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20200625170018.64265-1-ljp@linux.ibm.com>
 <20200625170018.64265-6-ljp@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <529ed3f3-6be1-cd59-00e4-eb47ca9661ee@linaro.org>
Date: Thu, 25 Jun 2020 11:26:27 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200625170018.64265-6-ljp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
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
Cc: david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/25/20 10:00 AM, Lijun Pan wrote:
> vmulhsw: Vector Multiply High Signed Word
> vmulhuw: Vector Multiply High Unsigned Word
> 
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
> ---
> v3: inline the helper_vmulh{su}w multiply directly instead of using macro
> 
>  target/ppc/helper.h                 |  2 ++
>  target/ppc/int_helper.c             | 19 +++++++++++++++++++
>  target/ppc/translate/vmx-impl.inc.c |  6 ++++++
>  target/ppc/translate/vmx-ops.inc.c  |  4 ++--
>  4 files changed, 29 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

