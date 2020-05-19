Return-Path: <SRS0=GK8b=7B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04019C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:39:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4320207D8
	for <qemu-devel@archiver.kernel.org>; Tue, 19 May 2020 15:39:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ULk/fcTB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4320207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59398 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jb4KZ-0006CA-UR
	for qemu-devel@archiver.kernel.org; Tue, 19 May 2020 11:38:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48710)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb485-0003DK-2A
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:26:05 -0400
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:43287)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jb483-0002JX-Um
 for qemu-devel@nongnu.org; Tue, 19 May 2020 11:26:04 -0400
Received: by mail-pl1-x644.google.com with SMTP id k22so6308pls.10
 for <qemu-devel@nongnu.org>; Tue, 19 May 2020 08:26:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1yOKRJBrLMOqpYn7HveRFDPZudPhxWBTAMeOFnmFlyE=;
 b=ULk/fcTBsT81MIJcEJ9Ddzsqsl0UuTpaNk2/bROU1Id7ePFtMU/jfEtl06iDb3dwBS
 NYPJtSGYwYKK3NUg43rX2YaCMNyGYwrTlYac39EGaCrOvPcClSWKze0X3Ruror6IZplm
 jFzL9Q1zCZN+G+RWQ50sjwB9BNZj9wQG1CcSAPlIY51My73iHmawhvmqLGLPeWrmKQMY
 J5MqEGrWQbehDSJo8meD2VpRVair6z6OwaWtW/wcGMu9ZL2p+xKp26olo1hWwg90L6PA
 ZMZQDrRS8WV/JlwcY2cQoXZGLNpmgstCTR3MCCZgM8j31+/GQiA7MOur2e62LtqXma3o
 3/Dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1yOKRJBrLMOqpYn7HveRFDPZudPhxWBTAMeOFnmFlyE=;
 b=oRWAwv635yjxNOxnBf8OCxQNHZKx8ARx+XDwbcsp/YhyPs7PIRUQGhkNwoJz2+YAUj
 /R4ErCG49CoYzzSIAU9ZFF1K0XY/T1kR1tlu8Ef64Q7ko7XodNvgUfO8iXele2t8L4qI
 GQSe9BGUOAeK0AgSuTesCeLHU8e7J/6JM05IkLY7kXBR/IjQ7jVKOVkOEKnq/oes9viH
 j/6rJsiVp5kmfAyc5KGjo65tiyzCBuyaMJv9cY7GY8SqJTyFGmy9WrYe2jxcoCDa6rAC
 Z++3g9feiPij78BX+J2Z4W2lXnO2+tBTIqZL3uHj9/DhdnmMTJL55FdJG0aEObbIdWqV
 7/dQ==
X-Gm-Message-State: AOAM532qgDmxeD/qEd2W6IPDN0oAD39kgICz7WmfafKc5H0651rqjwYc
 xXqYQyJch+Kr2OVOTE/0nSVbkQ==
X-Google-Smtp-Source: ABdhPJxO9moHaODU8HfiQSlOLMw7FcQjTDdUHRaJYui5wy6CPhr1zG2fZdZszxSzkeDzxuY/xdYN1g==
X-Received: by 2002:a17:902:8f8b:: with SMTP id
 z11mr78549plo.208.1589901962381; 
 Tue, 19 May 2020 08:26:02 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id r12sm10107011pgv.59.2020.05.19.08.26.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 19 May 2020 08:26:01 -0700 (PDT)
Subject: Re: [PATCH v2] tests/tcg: fix invocation of the memory record/replay
 tests
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200518162903.883-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <9c82070d-8024-9d5e-82c9-5c81fa711e20@linaro.org>
Date: Tue, 19 May 2020 08:25:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200518162903.883-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::644;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x644.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/18/20 9:29 AM, Alex Bennée wrote:
> I'm not sure when this broke but we should use EXTRA_RUNS for
> "virtual" tests which are not generated from the binary names.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - keep the PHONY's for the benefit of output
> ---
>  tests/tcg/aarch64/Makefile.softmmu-target | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

