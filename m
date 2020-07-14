Return-Path: <SRS0=DUFB=AZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27135C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:38:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E63702065D
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jul 2020 13:38:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DK2aHHJ1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E63702065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:58588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jvL8L-0002L1-7A
	for qemu-devel@archiver.kernel.org; Tue, 14 Jul 2020 09:38:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvL7j-0001pN-Sx; Tue, 14 Jul 2020 09:37:31 -0400
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444]:33824)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jvL7i-0000ja-8H; Tue, 14 Jul 2020 09:37:31 -0400
Received: by mail-wr1-x444.google.com with SMTP id f7so21664183wrw.1;
 Tue, 14 Jul 2020 06:37:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JihWOU6Xg61nh/bJmLLfRTzI1GgkHW1vHeJkEqqtmXw=;
 b=DK2aHHJ1w9mR9SZp8DydhqiHGAc9nd7PLe/zT22aZ7E/bhmaylS8l2t4NaNhjazUtG
 gmiYC297xxccRByMd3QW0dlnHji2KyKoPTRz3W4/6StCn68TPaU0coAH0uO6tkoDIk+y
 0UBYLg6XfOy8x5PazBPcABt+4yxPbxyJACaikrMXL6waT0N2jE8BaYOSTZaPvXOzrwYY
 tB7qbA7MisLHIGsFJSDmY7VCApuRX8JkzXTmRfxx+ksYjJ7LIcHiv+DIxJvmgxWNSPQ8
 ugne21rSNmrzJrXfgJALmQb2l5ItHhRurZXtRWYUF8RwrDswXMGkgtaLn6qFqgLD4xug
 4cjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JihWOU6Xg61nh/bJmLLfRTzI1GgkHW1vHeJkEqqtmXw=;
 b=Mjv5vaPZTHGZggyZovgVflcMBJGDHltLRhpWm56jPgKCESU5OskZI2Q8L88JEn3MQJ
 lDOu5sothb7Ih1oaYxzZwjRvdF0vh5MLnEHzNE9bab5Ik19kbS6ZfokWYminQ1jWMbmb
 Qu7s5JrsLkWV7ERzP/iarauaEs71NTPCnk6sSO6ya5avbaM4Z6rhUgh+cWErcxF3cGEm
 cRUW92CBSUNwcH4hfOBr1DejtMwMmoOYfTqGIu7Ea9C9Lwyi8nOhG07N/LKee4Ij1rh2
 FdFd3aBEO8O/UNNAIHVHaPcdWnOIR9ypcz6uPHmlNYQLAlaujAz47UOvkcc5MsAJfFD7
 UsEg==
X-Gm-Message-State: AOAM533IQtdGE0JoZ32YKx941iLGsGlJjUkkIX1aQFS/F77UJyPofT3N
 BrF7bO1xG7U3znIMbdvfugo=
X-Google-Smtp-Source: ABdhPJzTjjGqPEIuUcEJlZKrRP4ww1/bN+W0/lUWdrJuZUMKeZg6pGbXMI5t+RUiZKBcoHW3zQjs5Q==
X-Received: by 2002:a5d:4751:: with SMTP id o17mr5703159wrs.345.1594733848081; 
 Tue, 14 Jul 2020 06:37:28 -0700 (PDT)
Received: from [192.168.1.37] (138.red-83-57-170.dynamicip.rima-tde.net.
 [83.57.170.138])
 by smtp.gmail.com with ESMTPSA id h5sm31407502wrc.97.2020.07.14.06.37.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jul 2020 06:37:27 -0700 (PDT)
Subject: Re: [PATCH v2 0/9] hw/sd/sdcard: Fix CVE-2020-13253
To: qemu-devel@nongnu.org
References: <20200713183209.26308-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f31820f7-06bf-4f9f-3ea3-7e690642c62d@amsat.org>
Date: Tue, 14 Jul 2020 15:37:26 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <20200713183209.26308-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::444;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: 0
X-Spam_score: 0.0
X-Spam_bar: /
X-Spam_report: (0.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=1, FREEMAIL_FROM=0.001,
 HEADER_FROM_DIFFERENT_DOMAINS=1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=no autolearn_force=no
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
 Prasad J Pandit <pjp@fedoraproject.org>, qemu-block@nongnu.org,
 Alistair Francis <alistair@alistair23.me>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Alexander Bulekov <alxndr@bu.edu>, Niek Linnenbank <nieklinnenbank@gmail.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/13/20 8:32 PM, Philippe Mathieu-Daudé wrote:
> This series fixes CVE-2020-13253 by only allowing SD card image
> sizes power of 2, and not switching to SEND_DATA state when the
> address is invalid (out of range).
> 
> Patches missing review:
>  3: boot_linux: Tag tests using a SD card with 'device:sd'
>  4: boot_linux: Expand SD card image to power of 2
>  7: hw/sd/sdcard: Do not allow invalid SD card sizes
> 
> Since v1:
> Fixes issue due to image not power of 2:
> https://www.mail-archive.com/qemu-devel@nongnu.org/msg720737.html
> 
> Supersedes: <20200707132116.26207-1-f4bug@amsat.org>
> 
> Niek Linnenbank (1):
>   docs/orangepi: Add instructions for resizing SD image to power of two
> 
> Philippe Mathieu-Daudé (8):
>   MAINTAINERS: Cc qemu-block mailing list
>   tests/acceptance/boot_linux: Tag tests using a SD card with
>     'device:sd'
>   tests/acceptance/boot_linux: Expand SD card image to power of 2
>   hw/sd/sdcard: Restrict Class 6 commands to SCSD cards
>   hw/sd/sdcard: Simplify realize() a bit
>   hw/sd/sdcard: Do not allow invalid SD card sizes
>   hw/sd/sdcard: Update coding style to make checkpatch.pl happy
>   hw/sd/sdcard: Do not switch to ReceivingData if address is invalid
> 
>  docs/system/arm/orangepi.rst           | 16 ++++-
>  hw/sd/sd.c                             | 86 ++++++++++++++++++++------
>  MAINTAINERS                            |  1 +
>  tests/acceptance/boot_linux_console.py | 30 ++++++---
>  4 files changed, 102 insertions(+), 31 deletions(-)

Thanks for the reviews.

I addressed Cleber minor comment and will send a pull request shortly.

Phil.

