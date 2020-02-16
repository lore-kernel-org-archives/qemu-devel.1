Return-Path: <SRS0=HvqS=4E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA996C7114E
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 02:19:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 772E02073A
	for <qemu-devel@archiver.kernel.org>; Sun, 16 Feb 2020 02:19:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y41fwhPs"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 772E02073A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56664 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j39X2-0000pp-Mp
	for qemu-devel@archiver.kernel.org; Sat, 15 Feb 2020 21:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:44423)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j39WV-0000Iw-9g
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 21:19:08 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j39WU-00051U-8X
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 21:19:07 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43334)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j39WU-0004zg-1z
 for qemu-devel@nongnu.org; Sat, 15 Feb 2020 21:19:06 -0500
Received: by mail-pg1-x543.google.com with SMTP id u12so6819021pgb.10
 for <qemu-devel@nongnu.org>; Sat, 15 Feb 2020 18:19:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=RNSvFQNS6khDxcyYYx/hbK0MPNTtxC3ryau1m/kEWlA=;
 b=y41fwhPsUwUW5eqG4sNA8xTpJhOf1A71K77jaehZqm+KZP9xlr6WiXHJ0jsGfHfOZ3
 Nk5WVTERORPZgTGB28FWqwoIZKOZEUm1XKvrQQdKWhexmtHejq3XK4j3vWHaUXKEkfu0
 PKP0K5ks+0nBsEl9tuGCda8ai0kqM2Hnz8xniWgXP+V+CK1iFIN1VBgVDsARbeAKfOD0
 Febykjjdz5LveVXKTnOQhvtzcHdLLhrsmKZCE7rrhBtzVvKl0vB7BSBg4raxnTAMK+yc
 9mXLVT64GK8NJcP0PX6hBdUYnz8+MoKStzcbUsb5bGa0qjjt933wbOAUBJDOGDkIcjgC
 3gig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=RNSvFQNS6khDxcyYYx/hbK0MPNTtxC3ryau1m/kEWlA=;
 b=gho6Uaag6/0el8A8kg3dRDNwSmnsTnLm3hvGWT7WywGi2r4QB/k/+aa2TBomsKzLNZ
 sTSWVNEg8fxdTyFycOFHQU4lEzdUMMAzkRpYalbQlQikVhDQy5I4dKuO7IDweLRv3xsW
 87vNWyU508DsWIGhIoas2GHTLMzgj4Qt3tmTcsZjnjvBaR+fziISmv36mWslnVdmiTil
 Ju0SstYqGBfHaklt81qZ6JU3hzt8xmYvDzssKTHeEZSgQxvwUujoRjy6xUJEmiiRFhwe
 AXCn5zLZ2GTrjMI/t04+o6jva6dGSlRwx4YlmK5ArMU/nTqWxGrva66mXtWlxwoZpVlf
 wRzg==
X-Gm-Message-State: APjAAAUJ1zOaCS/HTl2lE9xp8xlGGQvClRkvT7dg8VH2DpM3ZXU7fUb/
 Xar6gsSJfCciMkpbAsmvqp0vY2EBYcA=
X-Google-Smtp-Source: APXvYqxMyRqDVUXJR1t9ZnUdhRJYZNcs/o95OI08zcsg7TgQegYVoJw5oihqz2mcdM+1EjgyZ1KKnA==
X-Received: by 2002:a63:9313:: with SMTP id b19mr10636833pge.273.1581819545123; 
 Sat, 15 Feb 2020 18:19:05 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 f81sm11394664pfa.118.2020.02.15.18.19.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 15 Feb 2020 18:19:04 -0800 (PST)
Subject: Re: [PATCH 02/12] hw/arm/raspi: Avoid using TypeInfo::class_data
 pointer
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200215191543.3235-1-f4bug@amsat.org>
 <20200215191543.3235-3-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d70ec2a2-af21-7400-c1a7-21dc872cb5f3@linaro.org>
Date: Sat, 15 Feb 2020 18:19:02 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200215191543.3235-3-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Igor Mammedov <imammedo@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/15/20 11:15 AM, Philippe Mathieu-Daudé wrote:
> Using class_data pointer to create a MachineClass is not
> the recommended way anymore. The correct way is to open-code
> the MachineClass::fields in the class_init() method.
> 
> This partly reverts commit a03bde3674e.
> 
> Suggested-by: Igor Mammedov <imammedo@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/arm/raspi.c | 32 ++++++++++++++++++++++----------
>  1 file changed, 22 insertions(+), 10 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

