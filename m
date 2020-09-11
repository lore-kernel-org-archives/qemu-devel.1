Return-Path: <SRS0=/zFi=CU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 959EBC43461
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 22:47:13 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5E24221EB
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Sep 2020 22:47:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="puAMFbFg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5E24221EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kGrp2-0003ip-2C
	for qemu-devel@archiver.kernel.org; Fri, 11 Sep 2020 18:47:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53344)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGroQ-0003BN-9Q
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 18:46:34 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:34210)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kGroO-0000mS-DU
 for qemu-devel@nongnu.org; Fri, 11 Sep 2020 18:46:33 -0400
Received: by mail-pl1-x641.google.com with SMTP id g21so238728plq.1
 for <qemu-devel@nongnu.org>; Fri, 11 Sep 2020 15:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=a5s99WJ6mjD+4VkGpoNBYJN9rvrJZfcckqPPJKiN9NE=;
 b=puAMFbFglv9PjZbL1V8YSNYiBrDcC+2PKXeLYA0a+3IDEYKLX37wDeTbNxngKuC8r9
 c10Nwt/IXBpU6lLPZIldvyxkNAuA3g7cZRQtpzbFH1hi0IWWYHPeA5u5PfmKvpECRZtU
 /glsThquFRykYwfW60RhYoV6idjxluMQoa+k78ZVrqTG21X4/sJtAxItAGhr9JknoKBf
 7JSxSkyqToUFsona32TT9mphDD8Ofv7VF5r7/j41CMC1OR94/EbokRLHt1/Oi9UQfBpm
 aydhhBip8qO2paV9GKdwQi+nEEyHLRXJAG28t9hPwlN51NYAI7y9AIvY61eKDh+8/Qhw
 og2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=a5s99WJ6mjD+4VkGpoNBYJN9rvrJZfcckqPPJKiN9NE=;
 b=gbeOEYqTCvurmpSYOEezzdGbe55O1/jZ7uj/2FG+MkB5YtZ/qNlTBqaVa1MDA/JkL/
 mL2drbo0QRCcPa74rOkXYv03P5FLDrAkyIQPfIjJwmfYOY+YM16UYgYP7VKdeWOViBHT
 lqaXA7325upNZTs6tvYgtxuDP1zvn1xK/40vG+siWdCo57hPFIJjMuKMDls4/W+FMjyS
 1jQWveMwretNAOWLNYFasm/xkCzNOTbCuKVRr9JKDrxxnb5vBdX05hOhotChE6exVZRB
 h6upFzzA5wnGeEi/c+XU2ApmxH4RXt5+xzJP8+VtRK587C09/i9aYgmScW0W77jLAGe9
 irqQ==
X-Gm-Message-State: AOAM5319gLlfVNMM0q4Jscb/tWNnLCqHuzUO7anASIwKd8MsVvNNXI/y
 hHXdJZo79NcJdV5T2Ylr47YBsA==
X-Google-Smtp-Source: ABdhPJw6UjFs4Oz2KqiPXdItJ170RyjP72U5mixDI2QDQuYaiNVGhZYPSkqMfJacQgwdajlyy+NH9w==
X-Received: by 2002:a17:90a:a005:: with SMTP id
 q5mr3875889pjp.152.1599864390826; 
 Fri, 11 Sep 2020 15:46:30 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id o17sm2623613pgb.46.2020.09.11.15.46.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Sep 2020 15:46:29 -0700 (PDT)
Subject: Re: [PATCH v5 5/7] hw/misc/mps2-fpgaio: Use the LED device
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200910205429.727766-1-f4bug@amsat.org>
 <20200910205429.727766-6-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c21dff67-b771-30b2-339c-2f38795b2bc0@linaro.org>
Date: Fri, 11 Sep 2020 15:46:26 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200910205429.727766-6-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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
> Add the 2 LEDs connected to the FPGA.
> 
> This remplaces the 'mps2_fpgaio_leds' trace events by the generic
> 'led_set_intensity' event.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


