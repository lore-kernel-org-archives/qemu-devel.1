Return-Path: <SRS0=5nOY=BY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 969ABC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:03:52 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F94A20774
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Aug 2020 17:03:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LDAxjfyq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F94A20774
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51286 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6d7P-0004FH-LZ
	for qemu-devel@archiver.kernel.org; Fri, 14 Aug 2020 13:03:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52048)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6d48-0007ct-KA
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:00:28 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:37167)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6d45-0004y3-P1
 for qemu-devel@nongnu.org; Fri, 14 Aug 2020 13:00:28 -0400
Received: by mail-pj1-x1043.google.com with SMTP id mw10so4666064pjb.2
 for <qemu-devel@nongnu.org>; Fri, 14 Aug 2020 10:00:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=LaQnMd/v1rT6PcQaUnfYZD4JQvrryfBQS7qC7ebCMu0=;
 b=LDAxjfyqvqPDAbHmgKE9N4t7reU/Cmy4UWpKaUZjk0qVdRrelZZQS7ai+ENfrl3SOU
 Wp5Og9RNctezt6KAqOQl/88wt7WobMfxZantpcTDho2OYE+54zsGZSJh6MRnQ/2L3XRU
 tek+rpy5oKY8JnXjyKva++5bv3MqiNYQs3RQdoRnPVETv5BUmDm4UgycMZLduEw/XsUt
 EPcFOxbjPTpDo0L9iRxgqZDQytqX/0P/mj4R+IF1FHGp0S1W5m9R6AQGXNyg8XKJzc/T
 OpMLcvptvGA/GF5htbLzkDgUcg7V/ksWzW7BSgePaDWqWSw2y+Eyjrg4jrT6L+juXID+
 ibvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=LaQnMd/v1rT6PcQaUnfYZD4JQvrryfBQS7qC7ebCMu0=;
 b=o9Q/8pQr68+E0NomFhegd39Il68S+UVglM7h0DJcm/AxhMmpFxgKQd3y6QwfNinCCq
 L8/lhRUhqTAhOy1yttAsgMgvatONu3rlVxIDulxZ3afMsRiF0gpDCEFKm5r8va/mLnr/
 JDiJP+ZiVResgfhZ9W8hkY+10h8Po68AD/yaVTuia+DX5ttn9peIhtCBEdA3yK/beSd7
 pA/rrTevTofTiHjtE1EFT0WVAGooHrFB7hvDhqPxdggcv6TYWDHEDNgYwIyLEUmE5QYw
 Sn65R3jZF5oRNDCj5+Y53o6OnAMMhjq/7r82szSdR2a+gjCP7bxPklgqUPCVive+RJo9
 EYvQ==
X-Gm-Message-State: AOAM5302C6/kiPdvoBYaUZcrk+z3qhZKrbQpvdXkewAHH64yC456Myz2
 acrN1JMmY8LoUW91uz/BmOAtBg==
X-Google-Smtp-Source: ABdhPJxOrp3oykmB2RaLSNOARvd8uTLaZNqlB57kCzG7OE2wE5Gko9YatqPQTpr2U6UV9aGNWBuiPQ==
X-Received: by 2002:a17:90a:c505:: with SMTP id
 k5mr2881905pjt.188.1597424424396; 
 Fri, 14 Aug 2020 10:00:24 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id x127sm9933590pfd.86.2020.08.14.10.00.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 14 Aug 2020 10:00:23 -0700 (PDT)
Subject: Re: [PATCH 6/7] hw/ide/pci: Replace magic '512' value by
 BDRV_SECTOR_SIZE
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>,
 qemu-devel@nongnu.org
References: <20200814082841.27000-1-f4bug@amsat.org>
 <20200814082841.27000-7-f4bug@amsat.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b22d8f32-7bb2-74b7-cc92-9f1ca53ba77b@linaro.org>
Date: Fri, 14 Aug 2020 10:00:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200814082841.27000-7-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, Laurent Vivier <laurent@vivier.eu>,
 Max Reitz <mreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/14/20 1:28 AM, Philippe Mathieu-Daudé wrote:
> Use self-explicit definitions instead of magic '512' value.
> 
> Signed-off-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> ---
>  hw/ide/pci.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


