Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41548C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 19:23:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0EEBA25231
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 19:23:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="M3oMXUJI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0EEBA25231
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41556 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jn5ZF-0008Jj-7X
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 15:23:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52768)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jn5Ya-0007lt-PQ
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 15:23:09 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45359)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jn5YZ-0007jM-35
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 15:23:08 -0400
Received: by mail-pl1-x643.google.com with SMTP id d8so6544481plo.12
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 12:23:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=YHE/jaU21Fb5bQ7ZfHntr+xzvvFVHxN+La52awWcvb0=;
 b=M3oMXUJIIJ5RFy7fn4LaUm4tdpow4Jd3fTDcQuMlCm9xXBvZsoPIJsegrFTXscnUtP
 9JUCz7483vJPGOLlSG7x4xL79GF6+QNCRPToHO1OSUz4kcjLW/hOggXZ7XT5bJwruiUq
 bFuldQTzMe+SFE0xEezCTrRp5o6dXO6tO2vUgbv5ckp/q0AH+preNuSMX8rMvUG58A7X
 3rgZ1Ut6Vp0wJNB4/Qw9d1SUHQ42HZG4mxH1npco0KX0MguLwImOOCkyVjUlEFOqv/PA
 ekUzRyOr5J1KsIxqlXo6AJ+wTGsS3eoFNnuGufPWsivyBj71UJm9fAlov1+OTmd/obp3
 yKfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=YHE/jaU21Fb5bQ7ZfHntr+xzvvFVHxN+La52awWcvb0=;
 b=RrRyEiJc605Q2TsO0lF+eqL82aITpqBjbQr5H3y+ljrLMW0Syt2uS7gLCBeFViXuF1
 b5Mtv4BlOGjblXkHIgG6HGxPxWbAlSZudr1vg7Ht+lz+7DCw1B9w+ggTN02wxAkVXYBr
 wAQXH5ccE/REzwyAMTAHR7Dl+8muKGATuu9g/ZHTroLlVULO9fkOjxZmXNaQZbTrXsXO
 vMFJGewgF+TuAGKeY1upcd8xVkY24CTIlbqB8BM3Y/PE9Ubu4ox6bomcmckTBW1TnoxJ
 s/LHiXMWUqPAj1fU1dkU7ptjW/tpcmYMfTE+LTyHFieHo9FTSlzOE+cpuonZzd71If8h
 1GkQ==
X-Gm-Message-State: AOAM533RwBVGvLUKdLzZOrMDVWB+Rt7mAXXjzSMnQGYvRiu3dCCXuF9a
 OwY7dDaEBAqxw2Hard9q3yw90g==
X-Google-Smtp-Source: ABdhPJxjgjRQv/0GVEqGgyKdeIOE/6O6bEiSZvBQNeOUyYAP08mBnpyBBOm+yjQvQUB5P2w2E879UQ==
X-Received: by 2002:a17:90a:cf17:: with SMTP id
 h23mr14806026pju.139.1592767385285; 
 Sun, 21 Jun 2020 12:23:05 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id p16sm9219770pgj.53.2020.06.21.12.23.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2020 12:23:04 -0700 (PDT)
Subject: Re: [PATCH v3 3/7] hw/misc/led: Emit a trace event when LED intensity
 has changed
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200620230719.32139-1-f4bug@amsat.org>
 <20200620230719.32139-4-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <ae4a7411-7042-3530-3faf-e25368080820@linaro.org>
Date: Sun, 21 Jun 2020 12:23:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200620230719.32139-4-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::643;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x643.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Andrew Jeffery <andrew@aj.id.au>,
 qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/20/20 4:07 PM, Philippe Mathieu-Daudé wrote:
> Track the LED intensity, and emit a trace event when it changes.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/misc/led.h | 1 +
>  hw/misc/led.c         | 5 +++++
>  hw/misc/trace-events  | 1 +
>  3 files changed, 7 insertions(+)
> 
> diff --git a/include/hw/misc/led.h b/include/hw/misc/led.h
> index 883006bb8f..df5b32a2db 100644
> --- a/include/hw/misc/led.h
> +++ b/include/hw/misc/led.h
> @@ -35,6 +35,7 @@ typedef struct LEDState {
>      DeviceState parent_obj;
>      /* Public */
>  
> +    uint16_t current_intensity;
>      qemu_irq irq;

Why not sort this new field next to the other uint16_t and (partially) fill the
hole?

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

