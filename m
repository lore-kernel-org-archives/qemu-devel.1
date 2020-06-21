Return-Path: <SRS0=M+f9=AC=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D86C433E0
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 21:06:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1B3B92137B
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Jun 2020 21:06:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DTAM1LMy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1B3B92137B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43230 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jn7AH-0004s1-AJ
	for qemu-devel@archiver.kernel.org; Sun, 21 Jun 2020 17:06:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39862)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jn79a-0003w6-BS
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 17:05:26 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:34869)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jn79Y-0006Iu-Hv
 for qemu-devel@nongnu.org; Sun, 21 Jun 2020 17:05:25 -0400
Received: by mail-pj1-x1044.google.com with SMTP id i4so7483179pjd.0
 for <qemu-devel@nongnu.org>; Sun, 21 Jun 2020 14:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=XY+g9fia9UMdBfz+AClix5XSepcx2vCfiUo2SbKunXI=;
 b=DTAM1LMyZX7L06IW5TJ6oVAepdmBwY8evZHFkDnENZjYMDt+gmEsPSrWc+JYq1L/v6
 Tc4MaVeT6Q53XCxYN51Ej+XAukSZrCqSQ/BH8EaZiDV8Zvui1+qGWn8qOC5j7LSlDYMb
 0U8EyvrEISktCJ6Fw7nq+B4Oa4VlAfA4kNwDb5FA0hlgvV2IwWDM3KzLjJsKI6P0u+uf
 POz3IzkMHaLkGdIh2e+vLBd1sIAn3m2v1urujVaMnfQmx+VBGM/1koXQrKzfKdzW8rL+
 8QuBfRefJZdnQXB4JMpLOwusyZXR1uP9IQ58ODEm9nCDSVlr49tzJigx7LyXpZV/jcTw
 s+2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=XY+g9fia9UMdBfz+AClix5XSepcx2vCfiUo2SbKunXI=;
 b=tF4wy3/BH1ESgw2qA/QDlE8epSylcDA8gs1unX+kXSa0iTGkd+EKE0gTWjk0fWdQkr
 IaqpmnpPQpxuIpEVK8enoVmhhp3bDB2RPtKyL7GxIRz4tYSJidr9bYc6+PUYf8sWAP6G
 3H/elut5DOG7qHexP9YSxHd3WQdS27NtkXk44LL2JsW7dLdoXnlKDo9E3twKFYBL3LPh
 ENuo8VJqCuPUWkrjVNjgfUpUq8HXwO5nevrjHBVOUKvvEMLpEn66vEp43Bc+Gu85CTWA
 H/SnL+4YD9pVtGUsn1MPzS1GVuJJd3eUPyqC1etwjPPYD9VUabSzbtR97yqT04aNaSzX
 Mm/A==
X-Gm-Message-State: AOAM531Jcu2vg27FJQyxITpGg6kBOqdJWMiVYGtvNtwUvFHt8ouvBATU
 X0Kof8M4Wj+Yvkwt/ZmyBzkQEw==
X-Google-Smtp-Source: ABdhPJxWKe+nnV/uZvKTr43pj9hE8L3IXBKRlNBlTbkY7okUcM6F2QJ5AJHxCjXY6v9jvjwLMh60Zw==
X-Received: by 2002:a17:90a:7648:: with SMTP id
 s8mr6575000pjl.205.1592773522348; 
 Sun, 21 Jun 2020 14:05:22 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id w203sm1971890pfc.128.2020.06.21.14.05.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 21 Jun 2020 14:05:21 -0700 (PDT)
Subject: Re: [PATCH v3 6/7] hw/misc/mps2-scc: Use the LED device
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200620230719.32139-1-f4bug@amsat.org>
 <20200620230719.32139-7-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <39e9d17b-041a-2976-3188-9134e07a7ef5@linaro.org>
Date: Sun, 21 Jun 2020 14:05:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200620230719.32139-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
> @@ -25,6 +25,7 @@ typedef struct {
>  
>      /*< public >*/
>      MemoryRegion iomem;
> +    DeviceState *led[8];

LEDState?

> +        for (size_t i = 0; i < ARRAY_SIZE(s->led); i++) {
> +            led_set_state(LED(s->led[i]), !!extract32(value, i, 1));
> +        }

No need for !!.


r~

