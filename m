Return-Path: <SRS0=+Hf+=3G=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B472AC33CAF
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 00:51:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80BAD20684
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Jan 2020 00:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MlcF60V6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80BAD20684
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50766 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1isFrh-0008CJ-Np
	for qemu-devel@archiver.kernel.org; Thu, 16 Jan 2020 19:51:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1isFqv-0007Kt-VU
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:51:11 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1isFqu-0008Cq-Or
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:51:09 -0500
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:43410)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1isFqu-0008C5-9F
 for qemu-devel@nongnu.org; Thu, 16 Jan 2020 19:51:08 -0500
Received: by mail-pg1-x543.google.com with SMTP id k197so10777235pga.10
 for <qemu-devel@nongnu.org>; Thu, 16 Jan 2020 16:51:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=/bRgCqf8dXM5+HUXnDbTAsx03inkApGhpfnqYonvv2Q=;
 b=MlcF60V6LOeLu2rbPdIpdA2lx8BCiBjcbHVXo9+t4SA8uLfR3ygtMnrl6I8GQQ2nVq
 mgl3A89BfTnjQipzxXP4C95pS23IpvMaC2uHtioqFf30D/5aJeguiByzpQ5+JE4o1Mdh
 BvlI8VydRN/+5CNlj+qEf3jGtz9A5JNdgRACf8KtXaUfP22DjMrIFRJJhRQv/rnwzjOw
 EwCi9TvIaEmJI7pyq9O6/V6pRvmgQAwIJSrZ7UTgjKu0qJfceUPlBHelvTqCbYcvAEiQ
 oEcWp3XPjPW2BX0pXBt8of18DHy1530phD0mU9vGUCgLsUkipqbUSUhHqLFBHlzAhOo8
 F/ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=/bRgCqf8dXM5+HUXnDbTAsx03inkApGhpfnqYonvv2Q=;
 b=WGotQg7TKli6GzP7xR/pRkbma+RvsW6HFMdCSgHY2YYA1ofCrxq6pZrC37MeD5Cjc0
 VPn3qVUS3ysvPKxgUAh799NCEilcUS0zseJMDD4Ima9zTmsm/Qqey1HnbtCR5hrvlu93
 YO42xDekm3EZjVyIhqFPb92GIHK74I6RYdyr8dscB7nm2I7CSbZ9JSUD/wbFGFwPf7Hl
 ho9BOotM8G/vhKY70xhUNlTJN7uYikDYSxj/WVZcolm0JsTx/opBLF8shDwQF00V/o97
 PyYSiVbQaxYHVpbthmowkEtcuag6LPptmyfUGbNsDKmqQtTLBdeilEo6LSuQBQUspgfb
 qXJw==
X-Gm-Message-State: APjAAAU3wXQmo/4r0cWxqKnpEMX63fUj/NnLIVDqP6ijonRsAxbfLtPt
 d6vH5LLQUYTTaN9OHBi5VQK5yQ==
X-Google-Smtp-Source: APXvYqzbgl3U9kQNwhNdTd46vNLrzL1IYp5lCP9i/MZjDuevpIPbKoL6VtLftp5XHNyRVerCE6fziQ==
X-Received: by 2002:a62:ac03:: with SMTP id v3mr288815pfe.17.1579222267014;
 Thu, 16 Jan 2020 16:51:07 -0800 (PST)
Received: from [192.168.3.43] (rrcs-66-91-136-155.west.biz.rr.com.
 [66.91.136.155])
 by smtp.gmail.com with ESMTPSA id d26sm25240249pgv.66.2020.01.16.16.51.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Jan 2020 16:51:06 -0800 (PST)
Subject: Re: [PATCH] target/openrisc: Fix FPCSR mask to allow setting DZF
To: Stafford Horne <shorne@gmail.com>
References: <20200110212843.27335-1-shorne@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7cbf0cfa-2fa7-ed78-d0b4-5b93d012f265@linaro.org>
Date: Thu, 16 Jan 2020 14:51:02 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110212843.27335-1-shorne@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: Openrisc <openrisc@lists.librecores.org>,
 QEMU Development <qemu-devel@nongnu.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 1/10/20 11:28 AM, Stafford Horne wrote:
> The mask used when setting FPCSR allows setting bits 10 to 1.  However,
> OpenRISC has flags and config bits in 11 to 1, 11 being Divide by Zero
> Flag (DZF).  This seems like an off-by-one bug.
> 
> This was found when testing the GLIBC test suite which has test cases to
> set and clear all bits.
> 
> Signed-off-by: Stafford Horne <shorne@gmail.com>
> ---
>  target/openrisc/fpu_helper.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, queued.


r~

