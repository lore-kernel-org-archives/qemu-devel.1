Return-Path: <SRS0=xKpV=2I=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65048C43603
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:32:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 273072072B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2019 20:32:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wDS+QciK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 273072072B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60330 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ihfzT-0007NQ-Ql
	for qemu-devel@archiver.kernel.org; Wed, 18 Dec 2019 15:32:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:54365)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ihfyB-0006eD-Tk
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:30:57 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ihfy7-0004Vc-UF
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:30:53 -0500
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:39938)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ihfy6-0004SF-4S
 for qemu-devel@nongnu.org; Wed, 18 Dec 2019 15:30:51 -0500
Received: by mail-pf1-x444.google.com with SMTP id q8so1847462pfh.7
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2019 12:30:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Zwl2+Ft+3Qu+jRfq+fQCSw9Ftp5WH4Fwu9KoZnjQnYQ=;
 b=wDS+QciKsWnATGZ3S7yh04TBaSWMvEFWXTR0MnNheetTSCV7jjDK9sPngID3T5UJCP
 YpefQwyT2xKKNs5Q+vNcteHdw05WCiNKWtOTDsbtob+xAy7fkkTq9IS+LCoYyfhNOixK
 8QoOmTu41zPi8aQ6Dr+7OORkEvsvApj5Yqu1lHOSV+2tAu/nTibTUGxwiunF2WA10Jak
 GGGLbL20aU8OqUbL4YuSQ1AX7qMQVaEmKyoNw/XV9buZ7MG6xpqPR46FkRpV/idI+MPJ
 YwY3hCb1WTgGa87t/RGjsTAdsOs05i9vdBqgzeY4bY+WpbfixoYaZH9DZShAo8AnXpjP
 52kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Zwl2+Ft+3Qu+jRfq+fQCSw9Ftp5WH4Fwu9KoZnjQnYQ=;
 b=gWLtfPxLid4zQzhLhqrg0Ma/FFENP4ZXiINz5/Bk/S59AIBDs3Y/dto8oyjlmRxoLQ
 terkjt+W9+gd7x8SPpbhQYHGXpOGnNL/QjeDkdbzWEPm2LJwQKVP+se/KRGHlgZafFE/
 fdYWtOw2/wnt86uyOIxpesw1sudabfD0YPvKdoaEAhNR7f3FsOkF6ewSHag3Hwb9mGh7
 Y9g312NhhvtT0zCZUyRj7zUyfSR+5CCLa8x+W2p4v2vXMgkGVHxLh4k5Xjh8lh6Q42hq
 M+zKLDkBn2hk342ADV6PbaRIuBaetj3eNLFNWxaHT1DEpw8PQJMFbbnbNK/up22LGFS1
 EzXQ==
X-Gm-Message-State: APjAAAV6W69GPgq0lrRVqnD9nP+a+Vakl00G1CipGLuJlgMyWPa3BD3w
 LRLd55E3ifLFRFEUWjvqcvofXA==
X-Google-Smtp-Source: APXvYqw7f6sHKDhQfvFjYP9hr8Za8kGh2BUH3rg5tyOj5FE3kttKTyavZ823zuh2TR+0dYElgPU0mA==
X-Received: by 2002:a62:e30f:: with SMTP id g15mr5103872pfh.124.1576701048672; 
 Wed, 18 Dec 2019 12:30:48 -0800 (PST)
Received: from ?IPv6:2605:e000:c74f:dc00:6838:d2b2:17e2:8445?
 ([2605:e000:c74f:dc00:6838:d2b2:17e2:8445])
 by smtp.gmail.com with ESMTPSA id g9sm4613637pfm.150.2019.12.18.12.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2019 12:30:47 -0800 (PST)
Subject: Re: [RFC PATCH v2 5/6] hw/net/imx_fec: Remove unuseful FALLTHROUGH
 comments
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20191218192526.13845-1-philmd@redhat.com>
 <20191218192526.13845-6-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b436a7de-45ed-d90e-9524-62261b5a0274@linaro.org>
Date: Wed, 18 Dec 2019 10:30:44 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191218192526.13845-6-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>,
 Jason Wang <jasowang@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-arm@nongnu.org, Peter Chubb <peter.chubb@nicta.com.au>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/18/19 9:25 AM, Philippe Mathieu-Daudé wrote:
> We don't need to explicit these obvious switch fall through
> comments. Stay consistent with the rest of the codebase.
> 
> Suggested-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
> Cc: Peter Chubb <peter.chubb@nicta.com.au>
> Cc: Markus Armbruster <armbru@redhat.com>
> Cc: Peter Maydell <peter.maydell@linaro.org>
> Cc: Jason Wang <jasowang@redhat.com>
> Cc: qemu-arm@nongnu.org
> ---
>  hw/net/imx_fec.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

