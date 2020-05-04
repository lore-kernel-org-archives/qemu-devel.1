Return-Path: <SRS0=Vgkn=6S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E85CFC3A5A9
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:02:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AF0FC206D7
	for <qemu-devel@archiver.kernel.org>; Mon,  4 May 2020 17:02:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GueWZSNv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AF0FC206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49602 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVeUX-0003U4-Pf
	for qemu-devel@archiver.kernel.org; Mon, 04 May 2020 13:02:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51218)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVeTs-0002xW-Nr
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:02:12 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35551)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jVeTr-0005R0-P3
 for qemu-devel@nongnu.org; Mon, 04 May 2020 13:02:12 -0400
Received: by mail-pg1-x542.google.com with SMTP id t11so37586pgg.2
 for <qemu-devel@nongnu.org>; Mon, 04 May 2020 10:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=06JBLAVZa5sN96JGmqVGlCxc3EcQhU2HIrajLol3cnI=;
 b=GueWZSNvXgKljp72Rdj2Cduw51RH2riNP6KVRc3jekEMECH9UifUTQ5dWeKJB4n7i9
 LCWwG5snx6FjY4u7FCSEXhfFAFMb/ornqDu37sxbECKrJgbJmqHPmQ0EcRzZ2u2Jsn7a
 0jWGa1+fYftqPIIU7JHztVdXStldwTk+uE3A1hIZNyXWoYVlnvjdC0G7DUrXFhm2HBzc
 NNhDN0t9qS/B+lF25qkRKA5aR24iovm3EyIdYgX2DaPxm5+dEucOqWBYGSlOwRc2jjNO
 JX1ZvJmx5jPLxHgppa/rwi+ao+QvTxEaICLfRa0qmaRAQi9IWHBqju+BdajJ+PwBwK+2
 yimQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=06JBLAVZa5sN96JGmqVGlCxc3EcQhU2HIrajLol3cnI=;
 b=bLzmQUDWM2EmVKpoIoOa6+5In8Od13E0vPA6BHOLfKVrfeY8ryUxizWSRbzUifMR4W
 yo65COgxp+FO1wqxQVqYSt6cS4pjE8ySm6jthrBGVTG19Up6T8Bv1CN40+uWPzvAovV6
 siqOQHgXYYL0JFc96/LbVaJ1MpryRVWEwwCdWXXXnZdGRVJ8fRinRrmyFdflcWzS9+l0
 BWbtzjDQeFxUYMu/XB3Z49j9qDp9k62UWRHPnAVD3VF09ArNv2sjuTuglGNh6gBT3fVZ
 CRH/ZgGMwJDa9NNHBCAo7s661vZ3XYB0Ktqkq8g9/N27hA60NJCSOB315Zx8ArN1EO5z
 C5Ag==
X-Gm-Message-State: AGi0PubCorUUTKJFSyC+p40txOLQRrViDrY8z9hoWePUXWjxgJQ0Lxrz
 eKYkDqnXogsyG/RQyq0++FLUog==
X-Google-Smtp-Source: APiQypJ9Kii30AryFj2zDvLcmHXDdDFekf1yCja4wfImSdpVvExA2jP3yYJDtiRfc0xsU939OCASGw==
X-Received: by 2002:a62:a504:: with SMTP id v4mr18095681pfm.117.1588611729960; 
 Mon, 04 May 2020 10:02:09 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id kb10sm40776pjb.6.2020.05.04.10.02.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 04 May 2020 10:02:09 -0700 (PDT)
Subject: Re: [PATCH 1/4] hw/arm/nrf51: Add NRF51_PERIPHERAL_SIZE definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200504072822.18799-1-f4bug@amsat.org>
 <20200504072822.18799-2-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <48f917e3-69a4-1f2f-caaa-959a1d67acde@linaro.org>
Date: Mon, 4 May 2020 10:02:07 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200504072822.18799-2-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::542;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x542.google.com
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
> On the NRF51 series, all peripherals have a fixed I/O size
> of 4KiB. Define NRF51_PERIPHERAL_SIZE and use it.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  include/hw/arm/nrf51.h        | 3 +--
>  include/hw/i2c/microbit_i2c.h | 2 +-
>  hw/arm/nrf51_soc.c            | 4 ++--
>  hw/i2c/microbit_i2c.c         | 2 +-
>  hw/timer/nrf51_timer.c        | 2 +-
>  5 files changed, 6 insertions(+), 7 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

