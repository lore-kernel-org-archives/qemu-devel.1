Return-Path: <SRS0=l4AY=XG=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42763ECDE20
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:28:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 128F12084D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2019 15:28:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="co80VYVM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 128F12084D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52528 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i84YD-0007PH-OE
	for qemu-devel@archiver.kernel.org; Wed, 11 Sep 2019 11:28:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50163)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i84BJ-0004N5-8t
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:05:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i84BC-0005gQ-E2
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:05:15 -0400
Received: from mail-qk1-x744.google.com ([2607:f8b0:4864:20::744]:40094)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i84BC-0005fR-6x
 for qemu-devel@nongnu.org; Wed, 11 Sep 2019 11:05:10 -0400
Received: by mail-qk1-x744.google.com with SMTP id y144so13054809qkb.7
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2019 08:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Hj/GTxjogi2J1qasGymy2QlQ81XcbDBjcvV3NzA9c3c=;
 b=co80VYVMnqhLxQcIqqHAmJKJFNuGgIrmLGGFVi6DsWqvfcd/cKcTi+ZiWc/hysvlCB
 p7S5tW02JZbZORY/IbGDqNtF8g08+oXf6/m3ZeFuhUvjdUR4R2pKWaWZPFbUlVcP9Uvd
 5QQvCTpHKG9PzjRfpYp030PKcepYZ2QFi6PU6LwIR7Y6l5Zsajd+f6wela5iq28xq1tk
 bdAobf5xblPUzruXUZeNKKiyByFn5lfgpauVJ6UIezPWP28BO1zKtfuRnumtq8//EzIN
 9NE5RW2Q5t/Q7dFpleQNXGRmmSEGZSJdmCpE9sg0wvPiK0ePmS1BNbAqoyf4Pl4HaBPt
 +CFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Hj/GTxjogi2J1qasGymy2QlQ81XcbDBjcvV3NzA9c3c=;
 b=q0v+6C9LOn+yqUMmaWQs0i85MOLW1sK43Dw/tsrqbNlaVCoJGOmtw0Pj1UtQWb4mkt
 ZEscDU5HXcBRtGWywiue+qMDGoKeL+SXa/KVq3XVGihUeB6psJKS+dcNFhA3nUZprgW6
 werfI9BzqreWVEq/Jbmq4sZ4U0wdIN7RxhT1m9POkfv4sRK9kS6WwOVF3EHUBcnTGNLY
 mVazEB4viZm9awuidRI9y26Qnir/fssAVMV5FysuqhU8GjhAlJ4v1DE2miiNr5TNa1go
 zWEvpwsCv4AGP5q/2SXY7pLx532aG8/oUejmchx+ODwJKG+XGqwSrkjPcP4xcOkSsXLr
 ePTw==
X-Gm-Message-State: APjAAAUPMTLOxYwFskKvD38ONgdFYAsqjX1LjrUsgDocoX/6Ht9+iAHz
 50GtuQbLIO4K3z0Yc4RmCiuNIQ==
X-Google-Smtp-Source: APXvYqxBhQhCUxO0skINsJZ7+GM5l+DiuaG1bkQLX0L2I8T0teydRrRaAzQ8B1fo/OHHzwL9UYF/Tw==
X-Received: by 2002:a37:9bcb:: with SMTP id d194mr1343818qke.86.1568214308042; 
 Wed, 11 Sep 2019 08:05:08 -0700 (PDT)
Received: from [192.168.5.185] (otwaon236nw-grc-01-64-229-69-35.dsl.bell.ca.
 [64.229.69.35])
 by smtp.gmail.com with ESMTPSA id w25sm9241681qkf.30.2019.09.11.08.05.06
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 11 Sep 2019 08:05:07 -0700 (PDT)
To: David Hildenbrand <david@redhat.com>, qemu-devel@nongnu.org
References: <20190906075750.14791-1-david@redhat.com>
 <20190906075750.14791-10-david@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <b4737d33-201f-7b0c-2d15-7b83778e75f7@linaro.org>
Date: Wed, 11 Sep 2019 11:05:04 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190906075750.14791-10-david@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::744
Subject: Re: [Qemu-devel] [PATCH v2 09/28] s390x/tcg: MVCLU/MVCLE: Process
 max 4k bytes at a time
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
Cc: Florian Weimer <fweimer@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Stefano Brivio <sbrivio@redhat.com>,
 qemu-s390x@nongnu.org, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/6/19 3:57 AM, David Hildenbrand wrote:
> +    if (*srclen) {
> +        /* Copy the src array */
> +        len = MIN(len, *srclen);
> +        *destlen -= len;
> +        *srclen -= len;
> +        fast_memmove(env, *dest, *src, len, ra);
> +        *src = wrap_address(env, *src + len);
> +        *dest = wrap_address(env, *dest + len);
> +    } else if (wordsize == 1) {
> +        /* Pad the remaining area */
> +        *destlen -= len;
> +        fast_memset(env, *dest, pad, len, ra);
> +        *dest = wrap_address(env, *dest + len);

Again, I'm not sure fast_memmove actually handles wrap, yet.
Would it be easier to split at page boundaries rather than a
fixed 4k length?


r~

