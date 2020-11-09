Return-Path: <SRS0=6joO=EP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D4BDC2D0A3
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:48:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 797902067D
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Nov 2020 17:48:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hnfa5G0M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 797902067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kcBGz-0000iT-Fb
	for qemu-devel@archiver.kernel.org; Mon, 09 Nov 2020 12:48:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:41116)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kcB8c-0007Fq-25
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:39:30 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:35929)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kcB8Y-0000YX-G5
 for qemu-devel@nongnu.org; Mon, 09 Nov 2020 12:39:29 -0500
Received: by mail-pg1-x541.google.com with SMTP id z24so7760817pgk.3
 for <qemu-devel@nongnu.org>; Mon, 09 Nov 2020 09:39:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=bxGSpxqz5gfJA5y+CmmeqJWTTmSR1+LIUw/z99Hpc7M=;
 b=hnfa5G0MoTBKNbyI6RmaJH7+P8gaORmCf6orfqcUyq9K0pXuKxIBCl2Zu+xPM/4nc7
 6rOmLtyBvkh5i4Wzkj3AymDZxblT1wkLD0C++AtgzJdWxuWvn8wTTYhCDHubtAi0G9e8
 tnZSVRfmjAdNoPJ6+b/h2Ddgg0qGtG5oV/DaJ1VOyIPf8vTspBPIgvffEGx77r/3Mw2r
 CRgibJFJUeKB5JJCrhhmWqwMrOxuYylNZAJgjs8WCcujL+DvzYIf8voxQ1EqyLD6yB08
 jMMwIPE4raeBwDZ1MQYTwfTUVSUmardqFbl7UJOvVRtbqjiNOiY7lm/ARWDSgfkH4nnz
 3TnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=bxGSpxqz5gfJA5y+CmmeqJWTTmSR1+LIUw/z99Hpc7M=;
 b=fJP/0Z6w1w7GN5ZQqf3MNxHGsNaS65r9evuB4HaQCFpi1AsB36bFIdlEas7bH2kQmz
 aEvjlNF5mFHHY8m9M5WfUbyb1bAzJ3jo7t+e77wO9E0oPbiQQHG63AgrxotuouvwuQPT
 7kFNg6YkNgmbtTszkZD9eIZU+YvPJBHODNqV9AD8LFYORubSIl5IwcC6AEvl4CiTDnMf
 Nd4oo63beMf6MLR6PwAZ+R3f3gLmAAoqSKCNwHSfR+B5BvTIKBOb2vf6zMejBmlbvJJT
 F5XK3HI50sbw+kNpGrIlMFoS5wEja4rE+gGeqBEH1yjjlK+7Ej9GAQsbNu1O0p9FX5Q+
 2j/Q==
X-Gm-Message-State: AOAM531qHCZkBlibRO4F/iqJo9EBjkNo2UUJTe95RJCuFhYDSbYOrrH4
 4DEWLDizhfKNIaUJoFbcXpT+AA==
X-Google-Smtp-Source: ABdhPJxQSgRYbczGMk8A6+NlIPst7lLEgbRirvw+PmEZAKdLCACF3SdcyD2YsD7AhJ99Au/mMzlMQw==
X-Received: by 2002:a17:90a:7e81:: with SMTP id
 j1mr269211pjl.150.1604943563470; 
 Mon, 09 Nov 2020 09:39:23 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id d1sm73314pjx.51.2020.11.09.09.39.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Nov 2020 09:39:21 -0800 (PST)
Subject: Re: [PATCH 1/2] ppc/translate: Implement lxvwsx opcode
To: LemonBoy <thatlemon@gmail.com>, qemu-devel@nongnu.org
References: <d7d533e18c2bc10d924ee3e09907ff2b41fddb3a.1604912739.git.thatlemon@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a1c67758-7b2c-725c-67b6-e0c52a971d67@linaro.org>
Date: Mon, 9 Nov 2020 09:39:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <d7d533e18c2bc10d924ee3e09907ff2b41fddb3a.1604912739.git.thatlemon@gmail.com>
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
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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
Cc: qemu-ppc@nongnu.org, david@gibson.dropbear.id.au
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/9/20 1:17 AM, LemonBoy wrote:
> Implement the "Load VSX Vector Word & Splat Indexed" opcode, introduced
> in Power ISA v3.0.
> 
> Buglink: https://bugs.launchpad.net/qemu/+bug/1793608
> Signed-off-by: Giuseppe Musacchio <thatlemon@gmail.com>
> ---
>  target/ppc/translate/vsx-impl.c.inc | 30 +++++++++++++++++++++++++++++
>  target/ppc/translate/vsx-ops.c.inc  |  1 +
>  2 files changed, 31 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

