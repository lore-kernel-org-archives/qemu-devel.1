Return-Path: <SRS0=afRr=CX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E23BEC433E2
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 01:47:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 84982208C7
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2020 01:47:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flF+uah8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 84982208C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55700 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kHdaP-00087W-OA
	for qemu-devel@archiver.kernel.org; Sun, 13 Sep 2020 21:47:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57842)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHdZo-0007J5-A6
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 21:46:40 -0400
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441]:38810)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kHdZm-00077R-Ud
 for qemu-devel@nongnu.org; Sun, 13 Sep 2020 21:46:40 -0400
Received: by mail-pf1-x441.google.com with SMTP id l126so11223722pfd.5
 for <qemu-devel@nongnu.org>; Sun, 13 Sep 2020 18:46:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=IprehSuAYTMjwyuJSUvS4u+1YaptMi5itIJb0dN/3Ec=;
 b=flF+uah8fLu/B7cgmRzCm9kR1VYXxPnXJdp1eWyaKdZiWmBxRPm+k4+Sa/YQ3qegYl
 P7JsETEjHa/Dgofj2rcAtJOTtMfpc89DXtVX/pQZj3/HXMxP6/YmCmkKr6dnnnyZE9gG
 5/FTonceJYtg6QVa7914BjyCbO/7rXGYzW7l4nyq+NNjfRpw5zAxxHVDgglAdn9a8beS
 4B7YH1Wb70pKNsViDNHjlHBAoCZbBCWAEPPabK3A9BtKnVyfFedDsdw7ix9Gph9K/JKm
 Bx7N2XQRc6vd1pwJNgWlnBYnsF/Ac6sdvVoR8a92WXyc1hjxT7g+0NmxqxSr8PI2aKke
 JkcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=IprehSuAYTMjwyuJSUvS4u+1YaptMi5itIJb0dN/3Ec=;
 b=Y5TpPWsxcz2GBQmGFQ/er7d3rPzP/oZwopqD3G3tmErVR3AFmcGICbp4qDv1IFTMFm
 V6g0WJrIrfHcfAfIkwXSPizpF/6cVBJ5KEADVbR3st7oda4KSx8UVjkoubs1d6moPjuY
 DBJbrDlUoyKK4C2mHyvDOYelefqhJlggUkvPBq3QEPsGlQFSJBKsQnMILzdveXGK4fAS
 Cr06CwpG86QeZqdGLRxpOnhNjBSdfmVFvvovcekfVRzoA8wWJWVrSib4Igmw2I85NAQv
 6tEGvOuaOleglrxWfhP9Yjyra+PYK04JhR4DJrliohZ+J9bGWFUdradjWCCx7L55Oxt+
 NAKw==
X-Gm-Message-State: AOAM531RJnz+9zcQv9hsbcrfBELt5djO/EL1kntksNTk8Oy13vk+wixP
 T9VyOgbuVHhJv94qby7z1AdORQ==
X-Google-Smtp-Source: ABdhPJwyyX61Secv4ie7koUULKScHrdAJFA4Y5IqQrtJdVHqAZrNTiPxQLwqrdVlB1QFgfR63ip4uQ==
X-Received: by 2002:a17:902:eb4a:: with SMTP id
 i10mr11784241pli.109.1600047997647; 
 Sun, 13 Sep 2020 18:46:37 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id j11sm6709263pgh.8.2020.09.13.18.46.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Sep 2020 18:46:37 -0700 (PDT)
Subject: Re: [PATCH v6 2/7] hw/misc/led: Allow connecting from GPIO output
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200912134041.946260-1-f4bug@amsat.org>
 <20200912134041.946260-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d7d511a2-1a94-c602-39f7-e3ce733917a9@linaro.org>
Date: Sun, 13 Sep 2020 18:46:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200912134041.946260-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::441;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x441.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
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

On 9/12/20 6:40 AM, Philippe Mathieu-Daudé wrote:
> Some devices expose GPIO lines.
> 
> Add a GPIO qdev input to our LED device, so we can
> connect a GPIO output using qdev_connect_gpio_out().
> 
> When used with GPIOs, the intensity can only be either
> minium or maximum. This depends of the polarity of the
> GPIO (which can be inverted).
> Declare the GpioPolarity type to model the polarity.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/misc/led.h  | 10 ++++++++++
>  include/hw/qdev-core.h | 16 ++++++++++++++++
>  hw/misc/led.c          | 17 ++++++++++++++++-
>  3 files changed, 42 insertions(+), 1 deletion(-)

Oops.  Failed to have r-b in paste-buffer.
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

