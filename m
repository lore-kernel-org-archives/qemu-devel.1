Return-Path: <SRS0=q+n2=EF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 335F7C4741F
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:58:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8B4922072C
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2020 18:58:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Elwcv/xA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B4922072C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58592 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kYZbQ-00034U-DL
	for qemu-devel@archiver.kernel.org; Fri, 30 Oct 2020 14:58:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55346)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYZaT-0002du-Ev
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:57:21 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:35742)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kYZaR-0002yS-0q
 for qemu-devel@nongnu.org; Fri, 30 Oct 2020 14:57:20 -0400
Received: by mail-pf1-x441.google.com with SMTP id b3so6110526pfo.2
 for <qemu-devel@nongnu.org>; Fri, 30 Oct 2020 11:57:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/axkJfpIJzZ4MFZ+gLgF1F7SF23JDrKVXFO//m4K92E=;
 b=Elwcv/xA0HKv8nyWEyrqN+xVoqjU/A2YO+VHNmBpGdrh+3vySpmuQ3WkTwYnHpcXrK
 rXLKzcK/HH/iS/nP/uBpebKqX1PFM7SmrHYj5xCvK5378BJ3SoKjxAGENRmHujEohzcM
 2jUc6nWk1QK7RjIjbXpILUT2LWRqxeLYiVmnrfWBFCrkN5CnED3u8+apPxLARJP8CdAj
 iRgArSP2nM0fjQJpgnTFdwWMdIjLszoX45+y+X6QkkhyxXqmD3te1FUQ7EYFivuNuydl
 JRwOpQ1cA+xhQ/iqkHnpulxTzGRnlSyAdeHIU3kw6SE3tTQ5F7qA5SWFVLjMFkXTq7S7
 FOlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/axkJfpIJzZ4MFZ+gLgF1F7SF23JDrKVXFO//m4K92E=;
 b=hxLhC5wZ1XXIwWARv8rykm9OaEwJiszbsozv72aI5GuQbwlMOpag+L5J8J0LjpTS0v
 qdcaA2gR1vmcD2IO63AYntT9P3JQcBxtb5NI66RAvchnJ4RAQkZPVLU1dSxBmRALzyfC
 g/JcxrYc7QsuxKvtVBUmRBLQll5jwDeEJBLPqAWwzJGvQVc6wLYrjVx9rvHsn6cTIT8v
 yBcM0U2D2MV/sYDVgqZLe++O5hiSksLuT3CnIx/mzQ7R+0ClFx04UtAkAWpNOQCvwq9B
 BBUQgQ+DXDvxXSByD8R/oKycQ/h8CEULw8CWn5DyeQa8DK5ctav7JkFi7Rw1ImbxyIf1
 aeFg==
X-Gm-Message-State: AOAM5322yC5+3mKIgaOIfq3djt1OvGNVmjceEwst29AZKiH06V8bd3HJ
 GyL95nRFBh8C4yYhAEZkgmlJyw==
X-Google-Smtp-Source: ABdhPJwpACVghd0xG2zsMyawAJiMNNeg91S4qdyCHNp6nmIueIN9D7WaiVIEEii8MTZdTJb7HY3Acg==
X-Received: by 2002:aa7:9af1:0:b029:152:6101:ad17 with SMTP id
 y17-20020aa79af10000b02901526101ad17mr10783387pfp.25.1604084237753; 
 Fri, 30 Oct 2020 11:57:17 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id o65sm6326287pga.42.2020.10.30.11.57.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 30 Oct 2020 11:57:17 -0700 (PDT)
Subject: Re: [PATCH v2 00/19] Mirror map JIT memory for TCG
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
References: <20201030004921.721096-1-richard.henderson@linaro.org>
 <fb1417e8-7bd2-5304-b168-51708987279f@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <643822c6-eccb-5d49-bf2c-4c0fa254d8b1@linaro.org>
Date: Fri, 30 Oct 2020 11:57:15 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <fb1417e8-7bd2-5304-b168-51708987279f@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.253,
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
Cc: j@getutm.app, laurent@vivier.eu
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/30/20 11:26 AM, Paolo Bonzini wrote:
> On 30/10/20 01:49, Richard Henderson wrote:
>> Fourth, I have renamed the command-line parameter to "split-rwx".
> 
> Stupid observation, but wouldn't it be "split-wx"?

Um, yes.  ;-)


r~

