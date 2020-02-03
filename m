Return-Path: <SRS0=cs6B=3X=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC61C3524D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:00:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E537D2080D
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Feb 2020 08:00:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="U6ZC0s3M"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E537D2080D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35798 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iyWet-00017y-U0
	for qemu-devel@archiver.kernel.org; Mon, 03 Feb 2020 03:00:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55148)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iyWe1-0000ZA-Tk
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:59:46 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iyWe0-0007QV-SS
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:59:45 -0500
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c]:44610)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iyWe0-0007LT-Jv
 for qemu-devel@nongnu.org; Mon, 03 Feb 2020 02:59:44 -0500
Received: by mail-wr1-x42c.google.com with SMTP id m16so16614391wrx.11
 for <qemu-devel@nongnu.org>; Sun, 02 Feb 2020 23:59:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=sBdoRtr8F0Pw3FFJ8U50S8fiBe9PEVWu5K9A4Ul6qsY=;
 b=U6ZC0s3MIufiBJ5tEjwWysMaWYuaN0fim8HXSMLBm/qDPLVPMBT1RG1lqc0hEqDTpC
 g6sm5QyeycWtyciY7D7OfXrb0/Et8EK+2rDBZZ+ji5GyPydhNQ7ftzo7OEPabFvfWJGD
 A80N0r4C7Izs4a4IJCF4zp8A9HREtbu5d+OtrnZnihZ9z0gg2dEZu1726qeWVWukKnMd
 2Mo076N8her+aAF8rmSmyX+BeMSNEcwsvmbtT7VdGb2QIuc9BXgaGd4sCMgUj092ECcf
 iB5oQghuZT33+OevoiQUkpEBYCWLcwS5RaBVKuqS5OukAkb05AzLhPvGQBRygw4joEo4
 iLDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=sBdoRtr8F0Pw3FFJ8U50S8fiBe9PEVWu5K9A4Ul6qsY=;
 b=QDRWkgOuiMiaaLF0EFlhfWEZ6Lb0efQO4S5wbplc40a5qxK+YZWj+uefhIZz4K0V/o
 Zq2KkEZ/POPcmGzdPk6Y4drn6+aDEo0A4GJZLiS1OQgRF/nxoGut4nHqeqbqrEcNIK+S
 sa/C1CqDPSFuteAuIoXLxV2C2+FiB3bCT9S68WJjnZ94e2pHagIqLt5OWQ1RMfRBFfOP
 fQaFblc9hNVntWjLbHWL4ZfsGZQ/jFyNj2PJM+yM3oRgpMP5VAIwY/P3RgEDTO6vwRFT
 psFq7VPOcB9CStBhuihnWWKpUTD+PRbZ8mBDQ53w1yCe2nQT+ZEv9qHjd9myZRWb3HlR
 B0Cw==
X-Gm-Message-State: APjAAAWoZ9j8jcuVyqqaB2r8Cw8I2kMvyBL3tEn9ysWi7XswSdD6EDhB
 mMyiu8iVlenARq4g/LxTuBQVyA==
X-Google-Smtp-Source: APXvYqwNnHgzlUsrZHSZxdakwNnktqwoiBoHXGcO90TU8GtTcMqNBTEYBusMtwvQGCuxxIVeHoRqdw==
X-Received: by 2002:adf:f606:: with SMTP id t6mr7733242wrp.304.1580716783382; 
 Sun, 02 Feb 2020 23:59:43 -0800 (PST)
Received: from [10.43.13.93] ([135.196.99.211])
 by smtp.gmail.com with ESMTPSA id k10sm15968wrd.68.2020.02.02.23.59.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 02 Feb 2020 23:59:42 -0800 (PST)
Subject: Re: [PATCH] pl031: add finalize function to avoid memleaks
To: pannengyuan@huawei.com, peter.maydell@linaro.org
References: <20200203074718.37252-1-pannengyuan@huawei.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c4fdea63-0d7e-1f0a-b0f9-68bce365dc5e@linaro.org>
Date: Mon, 3 Feb 2020 07:59:41 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200203074718.37252-1-pannengyuan@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::42c
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
Cc: xuding42@huawei.com, Euler Robot <euler.robot@huawei.com>,
 qemu-arm@nongnu.org, zhang.zhanghailiang@huawei.com, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/3/20 7:47 AM, pannengyuan@huawei.com wrote:
> +static void pl031_finalize(Object *obj)
> +{
> +    PL031State *s = PL031(obj);
> +    if (s->timer) {

As far as I can see, s->timer can never be null.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

