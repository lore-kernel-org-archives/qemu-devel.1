Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41833C31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 20:55:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0802E2080A
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 20:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GUrCf+GS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0802E2080A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51920 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hcyep-0007cJ-A5
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 16:55:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42162)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hcydi-0006xV-Ts
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:54:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hcydh-0006F8-Uo
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:54:06 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:41223)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hcydh-0006El-OP
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 16:54:05 -0400
Received: by mail-pg1-x542.google.com with SMTP id 83so6424904pgg.8
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 13:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8odQlsup5KQ8CAg/xnbNhtgZ6RhosGqMsjIT1XZJfZQ=;
 b=GUrCf+GSvacgDQWGG+VFiRgbB/C6eWxrghadPs21qsIxSR2Cm5e7MnzTYCzZZ2L0ut
 HAAGJ2oDp7Vf0D7BUn1VpA35x+vtHJPvsLxpudy8UDopc4Vcs6Gavzo+Pf1b1korX0I/
 /KQNZaJrzQmTOUdotGgdAyNBNVJWaRG6x0rFwifjKzFi2VkWi0zNR7iMI8FUhMDGyrrL
 FgozkNPi9IBon/fku5+cAIAl6tS6O9Yn6h33Vpd5jG4H69Hm2zlnyyvNgydpNAqBkbOo
 UrlL8UpgjvYMEVgeBsiGDtlTtu/ubx3Mdnjp7cdVv7jFvp76TJ0TMptQz7VaBYCV0bXn
 KhQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8odQlsup5KQ8CAg/xnbNhtgZ6RhosGqMsjIT1XZJfZQ=;
 b=fTxciMd+OyEIr9PlX9t7wfZ8IN5V2EbCwLxfFfkY1zm66zzzlYPWE6l2ktU0dgFo9Y
 +IvF8CqHAilHIOo9yEpZCfdudkTtbPeWJz687vkAkRwHPNim48z75fL1ieN6fnmhJG9Q
 QPr/OguXuJkp6mS2Rnxf4nNDXsmg8bdv2kXHrQVKuCcgnPGnzaNlUOKGysQ8jAZwVx3D
 vjNkfaHo3SJMscExrNiHsue4vqM2sAJrIFvcyxSSRh6Wt8RD+Jt1d675bv2221xis+zS
 IcnMo2wE1eEr4sAdU68f/FASgV2bXg9q2yDOcPMvzFsg3Dd/ja7LQvwLxXCloAM3yNJr
 RVJg==
X-Gm-Message-State: APjAAAWrK9rvRze4OmibbXXy2KxRb3djqu6QK1H7TaA7ScRn0jYy3yb+
 DE1LDfj0RVLj1X9PCSpzax8M7w==
X-Google-Smtp-Source: APXvYqyQ2Y4ojCnYeR4iMOs4m/hXwggO0guKR7Az+tWi6ve9H8bgdJyvCsTgvRm/LE0jnVERMCQtmw==
X-Received: by 2002:aa7:8d4d:: with SMTP id s13mr840731pfe.259.1560804843799; 
 Mon, 17 Jun 2019 13:54:03 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id h26sm21451731pfq.64.2019.06.17.13.54.02
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 13:54:02 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-21-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <24e813d3-9279-8529-ce89-d7ed08545704@linaro.org>
Date: Mon, 17 Jun 2019 13:54:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-21-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v3 20/50] translate-all: notify plugin code
 of tb_flush
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, "Emilio G. Cota" <cota@braap.org>,
 Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Plugins might allocate per-TB data that then they get passed each
> time a TB is executed (via the *userdata pointer).
> 
> Notify plugin code every time a code cache flush occurs, so
> that plugins can then reclaim the memory of the per-TB data.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  accel/tcg/translate-all.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

