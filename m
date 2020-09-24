Return-Path: <SRS0=QZTr=DB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79320C4363D
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:35:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB00A22208
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2020 19:34:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Edln/4lj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB00A22208
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44246 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kLX18-0006wO-VT
	for qemu-devel@archiver.kernel.org; Thu, 24 Sep 2020 15:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50976)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLWw7-0002FO-3X
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:29:48 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:35133)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kLWw5-0006kc-9E
 for qemu-devel@nongnu.org; Thu, 24 Sep 2020 15:29:46 -0400
Received: by mail-pf1-x444.google.com with SMTP id k8so378330pfk.2
 for <qemu-devel@nongnu.org>; Thu, 24 Sep 2020 12:29:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=NCytGQGmjWFcOdd3bWSEdLErliyS4JMKDrthtWMFdzo=;
 b=Edln/4ljlxro7T6tIBhfCKjcnoyd4C+kBmFYEWhKRtPWROaJyUgAI3NbLQPgiTHfkZ
 WNd36hhliiFk0FCyq59V/iAVOCY3ZdPZw3LXfVzCWdMm58auWcIqyAREHlt2W+plAa9S
 kqZ3U1Ik+1TscNzZtm80ke1LLr9+wOpVsPHszSspgaYFwk3VONDh+oZHA+iqetlDbY58
 0zlyu3zxPUhgYzrNWEcHL1u7aeOLjxZ2hSNbKaUMlc36dP6xonbN42SQRfmz8KkgHDHK
 WFVRwm3Hda8N4ZIJJ49Fk2aqF4B9E9vqNCEBsJEDTWkaQ0AZSGKU6Qr3ycdSubBa7wr1
 aUzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=NCytGQGmjWFcOdd3bWSEdLErliyS4JMKDrthtWMFdzo=;
 b=CfH5AZcFARUp5ej4LWcJCCVeTlphHOSwADEZ1yo9sjfujYDKgCljnS8bwh6N8yoBnZ
 UmeTDH10d8BLEqWwOUrkH5d3/wi4eVp4JygBMvfzM2c+br+BSf8ygyVEbPxL/VfKV0op
 D0qsDzshiIfSY0Fbcq5h5GKaCiS9akTUrBW5JW+ozDO5rbViQ7Sk/pvRqXSizvsT4Akq
 KdHeD8UERyzxHWHXfJRCk7hTbNCNKEES065BE2AcLi7Rg1XhN08cgjSOS+/JwVNoZ01O
 9YEM7QlGVJOjHW5KBHcftiUgeE4MYlGpBGcBR32XS+ayWBHjuT2+9FgNGb0bs4ljDTIo
 zApg==
X-Gm-Message-State: AOAM530/VjWn0RfRQp9/RxcmWja9c+0q29XvmxJXevH1UD8wRVzwEU33
 4O+6ora1OZd7BSNJcHjsyjUCLFj1gJfhjA==
X-Google-Smtp-Source: ABdhPJzN5iOEjn5v1iJ1kpObxx3toAgTp1wY1zDBij7eb/SwMN9mLVGsiKgcG3ctR2cMwxdTScNePQ==
X-Received: by 2002:a17:902:267:b029:d2:6180:4a46 with SMTP id
 94-20020a1709020267b02900d261804a46mr703053plc.26.1600975783137; 
 Thu, 24 Sep 2020 12:29:43 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id y25sm259790pfn.71.2020.09.24.12.29.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 24 Sep 2020 12:29:42 -0700 (PDT)
Subject: Re: [PATCH 4/4] qemu/bswap: Remove <byteswap.h> dependency
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200923100220.674903-1-philmd@redhat.com>
 <20200923100220.674903-5-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <8e5a49ca-bf95-078f-5a28-e7682297ce43@linaro.org>
Date: Thu, 24 Sep 2020 12:29:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200923100220.674903-5-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::444;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x444.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.214,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/23/20 3:02 AM, Philippe Mathieu-Daudé wrote:
> All our supported compilers provide the __builtin_bswap()
> functions. Drop the <byteswap.h> dependency.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  configure            | 13 -------------
>  include/qemu/bswap.h | 17 -----------------
>  2 files changed, 30 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

