Return-Path: <SRS0=KdPs=AG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A174C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:33:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E554420781
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2020 18:33:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NrdpGyZI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E554420781
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40594 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1joWgh-00053a-5r
	for qemu-devel@archiver.kernel.org; Thu, 25 Jun 2020 14:33:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36372)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joWfQ-0004Kl-3S
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:32:08 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:53207)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1joWfO-00044j-E0
 for qemu-devel@nongnu.org; Thu, 25 Jun 2020 14:32:07 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ev7so2948064pjb.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2020 11:32:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=G3EM0SFisPmd9KG5WMcg6xDeS+X1iIJU2cpUx4QPBes=;
 b=NrdpGyZIG4STilCT5wwficCBIpv082t3LbPZph0+YXDvFINiHrWvENLcMLEQCsEcl+
 WD9BWVkjEuaLYgbS5jQFbMxpBPChQEHEHRPOVNFkUW5+lBIXxuOyBFBQjF/0sFqp60Zu
 ZtrpGhZGBSQLcYOGMNMbG6V/QzBY8qaeffUN9+g4GkKYzN2X2y0Mw2QkM9IkDoVCS8cy
 XfETzSvqoDfrXrVVH8/m5BE7UWVAZowdmrVAQbEkS/nTRYa+G6sGhRmpMmWWwsOwf0Zk
 gR9UXRVsIsQ3S6iXMKkkq6n15VfFpkta4Y+P88ixDYgqrS1Ah9dHvtXui8QAAqcPybu9
 gXdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=G3EM0SFisPmd9KG5WMcg6xDeS+X1iIJU2cpUx4QPBes=;
 b=RG8ssf3c/zs/KhChef3x7DSxi9AFcC9vRpN8Y9owaQmbyhcPAE/MWkjQF5YXxys/Bl
 mtdTC5uVLDbVK6aEIPrnbobLbyI2CxPL0HxztBGNxsGJbtb+zR2XJpKHCVrWjdLFyfSf
 ibNHRS9PbQBvXyPBCSIN7fyLmjpwjeZ9egRaybqkAHqMlyFxIfxkGXLNJvZFMjULF7dF
 SQM5oNvFjq6du+qrmR00MuiMedaEm6EGYv3Yf6Oaesl1xGMAhUXNsLPEt2rdHALHIzCT
 +4SO5HNdh5WxWYxp2WrBGdWHJnsGT9JJQDp89I//Xm1a9BXUOf5sO9Q1uQ4aTe0wLK/A
 eJtg==
X-Gm-Message-State: AOAM533yppa52JEgtVx/wLz8O46CMnUYfsvXaEeubHc6ssYrJl6YDCjB
 khJe4i8LY48uKLFckd3Xwd7UzA==
X-Google-Smtp-Source: ABdhPJzpi5Bi64Iv8aCEEPcBLWhIt8l0QPfH0LAc+1xHX8Y4NJ+JUZi1UzKucXSLGY8k/IHTH000YQ==
X-Received: by 2002:a17:902:ff10:: with SMTP id
 f16mr5884292plj.277.1593109924950; 
 Thu, 25 Jun 2020 11:32:04 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id b19sm23113023pft.74.2020.06.25.11.32.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Jun 2020 11:32:04 -0700 (PDT)
Subject: Re: [PATCH v3 7/8] target/ppc: add vmulh{su}d instructions
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20200625170018.64265-1-ljp@linux.ibm.com>
 <20200625170018.64265-8-ljp@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <982746fa-15cf-3922-8743-b95a2ce7e11e@linaro.org>
Date: Thu, 25 Jun 2020 11:32:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200625170018.64265-8-ljp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
> vmulhsd: Vector Multiply High Signed Doubleword
> vmulhud: Vector Multiply High Unsigned Doubleword
> 
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
> ---
> v3: simplify helper_vmulh{su}d 
> 
>  target/ppc/helper.h                 |  2 ++
>  target/ppc/int_helper.c             | 16 ++++++++++++++++
>  target/ppc/translate/vmx-impl.inc.c |  2 ++
>  target/ppc/translate/vmx-ops.inc.c  |  2 ++
>  4 files changed, 22 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


