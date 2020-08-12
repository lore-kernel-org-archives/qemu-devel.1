Return-Path: <SRS0=vd3Y=BW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C4EC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:34:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAFD520774
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2020 17:34:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gywh/AwV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAFD520774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33640 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5udc-00038b-4g
	for qemu-devel@archiver.kernel.org; Wed, 12 Aug 2020 13:34:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5uct-0002Te-8J
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:33:23 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630]:42778)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k5ucr-0002qF-KG
 for qemu-devel@nongnu.org; Wed, 12 Aug 2020 13:33:22 -0400
Received: by mail-pl1-x630.google.com with SMTP id f5so1416998plr.9
 for <qemu-devel@nongnu.org>; Wed, 12 Aug 2020 10:33:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=PuNakaeXKHJnaqs/+kLHMvoPDosqd3osy9qLdP18adc=;
 b=gywh/AwV8ifwk15mvTttKactV7e0fJHuDfpiitL22psgLb+G9W9XXnk3bHSGwkEQo6
 iuSpTTCgKJbagg+G5QsV4XIb8ZKI4hrWovfB9p+bSb+0HRR1Za7CwsN+bwtXGo99+v6F
 BBBJmozui8xBI7CT2OT1a5pf1Xre1zrT/Wk6frQMIssF5HR+BfVMVmGciSLvmnQLVDHa
 mVpmUbJK17+J6W+J/8WYA8GbQxJsu1Prce3fy5cTXCOWvUGgOvtRlAYAE81Swoaow/Nr
 bsdxETgTn1OVrSCrsGO8SfpXHRbMGN7RFxTW6Eiksc1U5o6Omj59snwyX8UenuomqIjV
 7vmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=PuNakaeXKHJnaqs/+kLHMvoPDosqd3osy9qLdP18adc=;
 b=Iv9MffoMGEGIwRTKvxZ4YqGfJrdxCLnbcI5kTBUmbQ8PmB2ZyPNBjBMz7L3LNG/mCt
 ZPJSLK9NaoCbda/WqOevnkIgd0aKDldfBSj2KWxXfqpoRkzTD2h1C979o5SgExWTRI53
 aOHOxxxNKcq2o4Q27jvY7ic/X1DPQTEHlgxY/3khGIcmEva0KybVOoS1Y8/7Twk2cRWI
 9MaCx0KGuh0Ev2KqIbUk+KUKgYaJS8gM2J1xE4wsjE+uPOB8gelwZza2jM9gfA19glxA
 u5IPf9U4WOf1IOYqrB+XZORgLz7+XaKxwaQ2ynF5BS+/YbErf3z4tBFbYKn1kY0BW4bb
 5EGQ==
X-Gm-Message-State: AOAM533r5LIY5mHHiurbjGZd73nzKsjc/5+o0WGvUeUZIYJJRgvJCSKp
 BP2ebOt+jtj7q3oc4xjcfZ3FJw==
X-Google-Smtp-Source: ABdhPJziDPd915Ld20R+EDhto0O4TSLoxeDBYB5pCMu6VwQVzUi1/nyvTQpFkUSWhNfpYeFItI+I8g==
X-Received: by 2002:a17:90a:8904:: with SMTP id
 u4mr1140155pjn.87.1597253600004; 
 Wed, 12 Aug 2020 10:33:20 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id o15sm3078374pfu.167.2020.08.12.10.33.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 12 Aug 2020 10:33:19 -0700 (PDT)
Subject: Re: [PATCH-for-5.2 1/3] hw/misc/unimp: Display value after offset
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200807143705.30066-1-f4bug@amsat.org>
 <20200807143705.30066-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <24c51106-03ef-d58e-b5a8-9180b42d55b1@linaro.org>
Date: Wed, 12 Aug 2020 10:33:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200807143705.30066-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x630.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/7/20 7:37 AM, Philippe Mathieu-Daudé wrote:
> To better align the read/write accesses, display the value after
> the offset (read accesses only display the offset).
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

