Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 403C4C43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 22:48:29 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDF9F221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 22:48:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Yq6VJMGo"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDF9F221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55642 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGrqF-0004oa-Rh
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 18:48:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53636)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGrpE-00040i-Vb
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 18:47:24 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43345)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGrpD-00011X-23
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 18:47:24 -0400
Received: by mail-pg1-x543.google.com with SMTP id t14so7547785pgl.10
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 15:47:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=V6WaJlTZUc6e/j6lXXyh92+LR+6Qs2Lu7woOTUQ8szE=;
 b=Yq6VJMGobB30S2Nf6/+1Ege5Fd1MnhYxC2l6yxjhA+wv/qH1o6lPV4mfxirsnbGbNN
 WYDvU9+NxmoByLZvlm5+vUAZdgDErlVlWGIC6bwG8ZGb7oRhD/G+7AEmvR5XXPFHCQol
 WgaJ/OS7GynvTBvgwXowyyo4fcAixtjzgztLjkZiOziW2Pgex63tg272puy59/WmInxi
 QPGX4a5EjxX5IkAFFib0lXDGyi7otOw6ZSJ80ijWqSa0cFQUdhV1WPf8b8dXwNcEFx6T
 1DXHYKEaYcJ2NT34KLjdVOV74D0w6z4vCbJIvfniOGOcF/F3dYva9f+pmoe/vWA7wbM7
 ux7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=V6WaJlTZUc6e/j6lXXyh92+LR+6Qs2Lu7woOTUQ8szE=;
 b=lztnYuuW7NW1UDkkexyxKfVzYeyX2ztcGf5X4zvEsk9quplzv6fXOvFJZNYq8owhV4
 4okZfHLxZ862w+ITadL9C1cLoe7r1UWrfZCdNnxs4cHGlCxsxEqy6l6rDmNzy0J4zziV
 L47rBty07RK1amcVxi8MlZE3yQEUeVzU8/HNLUx5hkK9HYgBSSTZQ90E50FzGBgMoG9Q
 ya4rIK1Nw18cqwB619aPKMgND1AIVQzUXmqR6qyD/ZfMJOneg6fNdKCWPD/w6QzTOJyA
 Vf0ArABYJ6jObNz8O7JMbPE2ez9znbWdzv+1VF4ulGfITkARSOHEmWnKXZAc7s/dcxAR
 CLUA==
X-Gm-Message-State: AOAM5301uz7qjvpj2M8R7nswf20Y00gKKMyrNW7kpIxa6fKhfJTj7tXa
 7Ww1lZpmfKXmrYg8l0TBnZEddQ==
X-Google-Smtp-Source: ABdhPJzvHF9+wN/7LjDbKP01RAdISH72JpDqO7NoI8beY/d5j7HznXoiHkSqizPqtIkL5np198wPdQ==
X-Received: by 2002:a62:52ce:0:b029:13e:50c8:499b with SMTP id
 g197-20020a6252ce0000b029013e50c8499bmr4106208pfb.14.1599864441322; 
 Fri, 11 Sep 2020 15:47:21 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id v5sm3183153pfv.199.2020.09.11.15.47.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 15:47:20 -0700 (PDT)
Subject: Re: [PATCH v5 6/7] hw/misc/mps2-scc: Use the LED device
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200910205429.727766-1-f4bug@amsat.org>
 <20200910205429.727766-7-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d337ce10-a7f3-671a-46c6-5201b004ad6d@linaro.org>
Date: Fri, 11 Sep 2020 15:47:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910205429.727766-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -45
X-Spam_score: -4.6
X-Spam_bar: ----
X-Spam_report: (-4.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-2.469,
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
Cc: Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?= <berrange@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Luc Michel <luc.michel@greensocs.com>,
 Joel Stanley <joel@jms.id.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/10/20 1:54 PM, Philippe Mathieu-Daudé wrote:
> Per the 'ARM MPS2 and MPS2+ FPGA Prototyping Boards Technical
> Reference Manual' (100112_0200_07_en):
> 
>   2.1  Overview of the MPS2 and MPS2+ hardware
> 
>        The MPS2 and MPS2+ FPGA Prototyping Boards contain the
>        following components and interfaces:
> 
>        * User switches and user LEDs:
> 
>          - Two green LEDs and two push buttons that connect to
>            the FPGA.
>          - Eight green LEDs and one 8-way dip switch that connect
>            to the MCC.
> 
> Add the 8 LEDs connected to the MCC.
> 
> This remplaces the 'mps2_scc_leds' trace events by the generic
> 'led_set_intensity' event.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


