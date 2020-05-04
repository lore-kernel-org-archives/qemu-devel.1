Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76DF2C3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:18:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D001206D9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FU7a1Ebx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D001206D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54578 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVeji-0001rD-CI
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53670)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVef4-0004cJ-MW
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:13:46 -0400
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042]:35497)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVef3-0001ws-8M
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:13:46 -0400
Received: by mail-pj1-x1042.google.com with SMTP id ms17so167885pjb.0
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 10:13:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=exBctjxIOKZHQxJx4FgZbVtAE0UvVUSfUUwvNOm8OoI=;
 b=FU7a1EbxqVOcoAknvPbLGBV0Mx2A2OaLZ+xKBAHTz1+18Szj7umcDDoXVhFKP3FlYr
 2ZVUaMkynuefRlRT14g5MALphB1uO8WeDKYj1wz2/lJzciwuMkqmjVnoKyXgK6SHItgH
 MJNZCydIg73im8FV9ShtrxxLIiA4z/JG/HglwAL1nquPg2sZskW8IinU/nQoNhD5sqzz
 YJ0LUeqJgxaAEo46/TSSEALh+rApzg0L5/VSzRgdc3m2G+3B59koriaJA4wAf1FfG2hP
 MgCeFMMdDd/Vt4FeNd/Cb5f6CO5CH1xsUShvzInriXvUpN1I4vfjJQcU2wS8qqdpu+n3
 L0/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=exBctjxIOKZHQxJx4FgZbVtAE0UvVUSfUUwvNOm8OoI=;
 b=opvJYmzjJSprppyVgHWSZca9KaVqJmxeE1whSXCAEBuXi1Tut57YqjwuJc/SDRvUji
 VaNkXZLpV/oS3cD90IR1/VjEa3+j6e2EdKZ1Y/KSXEmWNJjfM9H7hnKKGaPaP1eKo+Hv
 Ddp3El7MIDsj+Hy8MHA5wBLXRXi+SenhE/nH0wNTiXq+pi/jGbDsmPSmNukk3EwpeP+x
 ZxG1/Fj1wA7y4eBF9sgK+eSjP5bEj0PlS/EwgqY6IcKu4DUU7tnp+eg9VJkxQ/L/I4xd
 06N1tHzD/eHo4nWkZmhyjNWQpKt6l363Fd5mTGiT7YtmrAlbSFLWi7hyN2lBgnISCB1E
 aOog==
X-Gm-Message-State: AGi0Puad1kk07bu8yPUOIt2x8BcvMJb6TtBMj6rVbkECxXwnYGDuTGC5
 m6S0M4yLG7GaouTxqLAEjzlZKQ==
X-Google-Smtp-Source: APiQypLSReHMBpA7iXYak0Sf4/QpzuQavlJMt/AR1ZxkkWMBAAf8z/JGYUEN4Y6jan2znelD7bChfg==
X-Received: by 2002:a17:90b:3751:: with SMTP id
 ne17mr215257pjb.114.1588612423358; 
 Mon, 04 May 2020 10:13:43 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id 127sm9544223pfw.72.2020.05.04.10.13.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 10:13:42 -0700 (PDT)
Subject: Re: [PATCH 2/4] hw/arm/nrf51_soc: Mark some peripherals as
 unimplemented
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200504072822.18799-1-f4bug@amsat.org>
 <20200504072822.18799-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a5278614-a9b5-f41a-53ea-f89331d6a3ca@linaro.org>
Date: Mon, 4 May 2020 10:13:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504072822.18799-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1042;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1042.google.com
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
 =?UTF-8?Q?Steffen_G=c3=b6rtz?= <contrib@steffen-goertz.de>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/4/20 12:28 AM, Philippe Mathieu-Daudé wrote:
> Map some peripherals used by Zephyr Project:
> 
> https://github.com/zephyrproject-rtos/zephyr/blob/zephyr-v2.2.0/dts/arm/nordic/nrf51822.dtsi
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/arm/nrf51.h |  4 ++++
>  hw/arm/nrf51_soc.c     | 11 +++++++++++
>  2 files changed, 15 insertions(+)

There's a fair few more devices listed in the manual, and not all of the ones
that you add here are referenced in the dts files.  So what criteria are you
using to choose?

Perhaps it would be easier to add them all?


r~



