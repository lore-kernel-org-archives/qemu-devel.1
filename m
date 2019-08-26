Return-Path: <SRS0=7Gz3=WW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FAC3C3A59F
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 17:15:11 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277C320850
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Aug 2019 17:15:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UTunD5kC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277C320850
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56048 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2IaE-0007vR-4i
	for qemu-devel@archiver.kernel.org; Mon, 26 Aug 2019 13:15:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46864)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1i2IYZ-0007QK-5n
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 13:13:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1i2IYY-0008KY-2o
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 13:13:26 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:35411)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1i2IYX-0008KL-SW
 for qemu-devel@nongnu.org; Mon, 26 Aug 2019 13:13:26 -0400
Received: by mail-pl1-x642.google.com with SMTP id gn20so10336704plb.2
 for <qemu-devel@nongnu.org>; Mon, 26 Aug 2019 10:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Ca+IpT5i+prkZAlkEeaEW+56pUypymlKpfVpo5lTzNQ=;
 b=UTunD5kC3wdGAtjKDGXIMiyc3YHE7cfd2TByyhGZ/5X8zxp7tlFwiFQ03ZEkmJUB7D
 lBQ/GwWoLnFFuP5CBrUiy6aBDwaIcepkqiReP1JtfrlBfbMeFGGZzQtFC8ClsDuYdOvL
 E9UG+vlvz3Vuuor+x3XjS0DycjeT2njqhTAT8zPOE54uWSV+G1DjkkcgyCsOzBzh6nyK
 TCa9BpeeSfj+ZlIoU7lC7MruhYEArm7Wnrf+Y6XYBn6/w9TkM8ZiG/gDrRCYQA9+J6SV
 MhJgKDIy4QgArq8Y9Uy/l+KJ5fhyKRhl2g2Jw2ABJIC5sTvOX60BF2Gwh8E7f32TmTJ2
 4xeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Ca+IpT5i+prkZAlkEeaEW+56pUypymlKpfVpo5lTzNQ=;
 b=dMHQbJEuANs8gioFTl2DmyHyCXj1tcfLH0CqFAXmFDJXLPeTtewYi3i9uCIlFj4Sg0
 35qAYselikjq/ubw3bzpSxCbdBlXmIu1sXwghn7uUN+OVHkvRj2/sJSFBozuSyr8PGKQ
 tN127MIBZiNIwlUG4j/orrShC5Hw4Hj1DyCRxLx7/CfzqVvwDUeH69/VAJZ43WzQrQNs
 JkU1kmZ0LteE8d7AjmzzskI/W7y13rfKiXv8MyFs1OryqdRfOpIcE+RZF7FDjx1sizhc
 1uuNndtrGhY6XkFEU9D0GKwRb7tuMjLSJ5Ku09XWMhkavb4xKc6BLRRJBsjNSG1vXAae
 Po7Q==
X-Gm-Message-State: APjAAAVVbZqmxat3+joOCihvgOrXC/J/aDtZsazu7TrcOam2Kkw0Q/Q3
 bFUjTkTtMVgBDpByJ22gxpyw9Q==
X-Google-Smtp-Source: APXvYqyxSMyhHiLrTmakBwLv711Pt/M5FBb85rTLlMaPi3I2XCBSsI8XW/CC+woh+wWFUixEJqBtxQ==
X-Received: by 2002:a17:902:9698:: with SMTP id
 n24mr4643538plp.14.1566839604488; 
 Mon, 26 Aug 2019 10:13:24 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id j9sm5504928pfi.128.2019.08.26.10.13.22
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 26 Aug 2019 10:13:23 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190824184635.34192-1-mrolnik@gmail.com>
 <20190824184635.34192-9-mrolnik@gmail.com> <87mufwz3e0.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <6c7f5897-e7ed-b5f3-f167-78073a9e5b67@linaro.org>
Date: Mon, 26 Aug 2019 10:13:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <87mufwz3e0.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v29 8/8] target/avr: Add tests
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
Cc: Michael Rolnik <mrolnik@gmail.com>, thuth@redhat.com, philmd@redhat.com,
 dovgaluk@ispras.ru, imammedo@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/26/19 2:23 AM, Alex Bennée wrote:
> Are there any compilers available so we can add the multiarch tests to "check-tcg"?

Debian has a gcc-avr package.


r~

