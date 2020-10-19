Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E2C0C433DF
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:10:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A53D52224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:10:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QFKkLNj4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A53D52224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55644 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUXjo-00085U-K1
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 12:10:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54638)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUXeK-0001iA-1H; Mon, 19 Oct 2020 12:04:40 -0400
Received: from mail-wr1-x442.google.com ([2a00:1450:4864:20::442]:36576)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kUXeH-0001TT-VN; Mon, 19 Oct 2020 12:04:39 -0400
Received: by mail-wr1-x442.google.com with SMTP id x7so361797wrl.3;
 Mon, 19 Oct 2020 09:04:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=D4ItctQ3TsnRGygDCoAL5T8+QFcunk3G8AXUmBowc5k=;
 b=QFKkLNj4aMP7jjBxXjdXABcjpTaYrIhP8IYYjCRbONsgPhsWbJTLtC6AlLF5NZ0WNR
 EQaXJ15z/ijVGWKyu/hAa8v9SiZK+sdja6zVXAWK8kaCX0mad3uSRBPpD7ZAJigIehIK
 VnwHK0wlXmajD6hbu/9gWAUld0kGVynNscfswtwBadtUCGATKi5Ol0tRveLZRo2nA3/p
 7twTuxNuUDY1gHIUkpAy8mx86j/vaOpX+8497FTpfcwie2hJbEw/8gvJr9z0DTPbxNsk
 kWMZ2x3Ksm4Bc5UxjchR6tqEOfVnrxFSfnjtmGDq7c3tRrghgABJxjima8xqOcXeBO3T
 TQnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=D4ItctQ3TsnRGygDCoAL5T8+QFcunk3G8AXUmBowc5k=;
 b=LvkCmAwNb2y3jI2u2MTshBiuo1IuDR2gndUWEzK+Zu/JXVasYJiNigIPY8vb3/r1RM
 DsosE+RcYdemg0X4XCOFYrmu/dcRbSEmGwmJ7BfiVUHxgOvNZoisCvd6cv1CKs6XpQMz
 tfDnZ8bo1ns/oKiYX+1tnmdJlTGJi1EeuSlYOMQq9nxBsojA+4Vrk4dkrY5jkLlIo3q6
 IbYHK5/t6CgBMm/NnFoJv+bjDMTh1IDFAvlI/y+PFavbFbP5eoHKmy5TmbUdXyFCjiif
 ozlAY6d5F/RNGtcA1XHxPKJNX0+PkoGvmuVRZkHC2DR07afThWxlCY4lVHLr8HJ3nH7i
 1y1Q==
X-Gm-Message-State: AOAM53068OxIO+3oSA/E2YWK+rS5q7kwkZ7ICRTGJXv4A+dWaQw8bZzk
 25to4Xgbkusph042gHbW2yU=
X-Google-Smtp-Source: ABdhPJzq7VNLtWgzwHejjvCDCz+H63OFS8YRI3QHXSv5lJ5FhGf8EsZpszyYVcmlXyfVMR1ZJWp48A==
X-Received: by 2002:adf:e744:: with SMTP id c4mr285219wrn.222.1603123475133;
 Mon, 19 Oct 2020 09:04:35 -0700 (PDT)
Received: from [192.168.1.36] (237.red-88-18-140.staticip.rima-tde.net.
 [88.18.140.237])
 by smtp.gmail.com with ESMTPSA id s11sm204154wrm.56.2020.10.19.09.04.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 09:04:34 -0700 (PDT)
Subject: Re: [PATCH v2 0/3] hw/ssi: Rename SSI 'slave' as 'peripheral'
To: qemu-devel@nongnu.org
References: <20201012124955.3409127-1-f4bug@amsat.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <e15493bf-f31e-daf2-d216-b9d67ea638b1@amsat.org>
Date: Mon, 19 Oct 2020 18:04:33 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201012124955.3409127-1-f4bug@amsat.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::442;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x442.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.249,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.25, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 qemu-block@nongnu.org, Andrew Jeffery <andrew@aj.id.au>,
 Alistair Francis <alistair@alistair23.me>, Max Reitz <mreitz@redhat.com>,
 qemu-trivial@nongnu.org, qemu-arm@nongnu.org, Joel Stanley <joel@jms.id.au>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?C=c3=a9dric_Le_Goater?= <clg@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Ping for review?

On 10/12/20 2:49 PM, Philippe Mathieu-Daudé wrote:
> Since v1:
> - Fixed patch #1 subject (Kevin)
> 
> In order to use inclusive terminology, rename SSI 'slave' as
> 'peripheral', following the resolution Paolo pointed in [*]:
> https://www.oshwa.org/a-resolution-to-redefine-spi-signal-names/
> 
> Candidate to be merged via the ARM or Trivial trees.
> 
> [*] https://www.mail-archive.com/qemu-devel@nongnu.org/msg739108.html
> 
> Philippe Mathieu-Daudé (3):
>    hw/ssi/aspeed_smc: Rename 'max_slaves' variable as 'max_peripherals'
>    hw/ssi: Update coding style to make checkpatch.pl happy
>    hw/ssi: Rename SSI 'slave' as 'peripheral'
> 
>   include/hw/misc/max111x.h   |  2 +-
>   include/hw/ssi/aspeed_smc.h |  2 +-
>   include/hw/ssi/ssi.h        | 56 +++++++++++++++++++------------------
>   hw/arm/spitz.c              | 32 ++++++++++-----------
>   hw/arm/stellaris.c          |  4 +--
>   hw/arm/tosa.c               | 12 ++++----
>   hw/arm/z2.c                 | 14 +++++-----
>   hw/block/m25p80.c           | 14 +++++-----
>   hw/display/ads7846.c        | 12 ++++----
>   hw/display/ssd0323.c        | 12 ++++----
>   hw/misc/max111x.c           | 18 ++++++------
>   hw/sd/ssi-sd.c              | 12 ++++----
>   hw/ssi/aspeed_smc.c         | 53 ++++++++++++++++++-----------------
>   hw/ssi/pl022.c              |  2 +-
>   hw/ssi/ssi.c                | 48 +++++++++++++++----------------
>   hw/ssi/xilinx_spips.c       |  7 +++--
>   16 files changed, 152 insertions(+), 148 deletions(-)
> 

