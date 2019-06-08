Return-Path: <SRS0=KvPE=UH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD918C28CC5
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:41:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92E182166E
	for <qemu-devel@archiver.kernel.org>; Sat,  8 Jun 2019 19:41:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CLWMNRto"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92E182166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60124 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hZhDF-0000Xd-2O
	for qemu-devel@archiver.kernel.org; Sat, 08 Jun 2019 15:41:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37848)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh1y-0007OZ-Be
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:29:35 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hZh1x-0007ba-Gv
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:29:34 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:36765)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hZh1x-0007Z3-Cb
 for qemu-devel@nongnu.org; Sat, 08 Jun 2019 15:29:33 -0400
Received: by mail-ot1-x341.google.com with SMTP id r6so644073oti.3
 for <qemu-devel@nongnu.org>; Sat, 08 Jun 2019 12:29:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iNF66fVrfh+Mk6jIeUw/SWBN4Xy2b+MZYgPGAVRJdt4=;
 b=CLWMNRtoOoRCZ27bkZVHhD5Tg2U+mMnDScMBzL5CU4p9cAqBn2iyW16NgNIUoX8b8G
 FkXXm1Hq3AfYf1F609LPYN7SfYP7YDFNIXPTJtKOiSeHgCvBTDm9fNan/XX11n3VmkYR
 lCan8U4EakzwDqMekT6Eh0Ag2bEjgHQ51REy9wowWzGUnF3FgEcF5OGpUeD4ZIP5fR5S
 OTiv4pn4qATfds1HNeCxj2yr3yHWUXuz8el416WSJlnPQAFZAZmzcxfbZMhgBvABTxZZ
 zkyQcw53Ee/wDr3zPNfH9CpCxXDwaAA6H/ztb/jHDba513Kl8mGBIHNgrfzUtHTOIqM4
 d7mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iNF66fVrfh+Mk6jIeUw/SWBN4Xy2b+MZYgPGAVRJdt4=;
 b=dBLZGGeewlzOThpTWwQdbmgDYhE51KUOIDjC4DvDq9/w7lab85tKOx1lNchNGxrl2g
 WHXE0Z0jjncrcPL1dgCKw+qX0P0tMjtHF3Sj3ayGcuQaBJt53Ire8IEsUA7S3Ep5hO+V
 IqnfUiK817qhcAb+z71LB5oYqANTm4czrvbcRfUhR/a0UtnSJdhgj3wrMY8pO9kuxYQ5
 B9TNdDZbgYNmPgmWxJLnJjUXmIeygNUcWL+HdZWZFs6dwHNZsfz9nyH+B3bWcvk4lfvD
 Uq88r1La2yVSfQk4uRvXo+xhsIT0xoTuexQpK/4GppjNN4KxnicZosfxIiUcCnIxTtB7
 k8kQ==
X-Gm-Message-State: APjAAAXidTo9Q/UJ/uihg3St9OYIWrKaZMBfx++jT7qF4I8WTry1cR0b
 HYXxoZI3SVvdP8foiAVBprPlNy0hNdJ54g==
X-Google-Smtp-Source: APXvYqxNaQcDK2S0UPotisb3dgdA4gaj8YSyKCxmoPuHxlL8VVK5vwhXVnXLqpjpViilzdzgOXU6CA==
X-Received: by 2002:a9d:7:: with SMTP id 7mr24842509ota.248.1560022169781;
 Sat, 08 Jun 2019 12:29:29 -0700 (PDT)
Received: from [10.219.49.199] ([187.217.230.84])
 by smtp.gmail.com with ESMTPSA id j189sm2119278oia.2.2019.06.08.12.29.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 08 Jun 2019 12:29:29 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190606174609.20487-1-peter.maydell@linaro.org>
 <20190606174609.20487-32-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ee14ffb8-25fd-56ed-9d25-37dca0ff95ff@linaro.org>
Date: Sat, 8 Jun 2019 13:59:08 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606174609.20487-32-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH 31/42] target/arm: Convert VSQRT to
 decodetree
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

On 6/6/19 12:45 PM, Peter Maydell wrote:
> Convert the VSQRT instruction to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 20 ++++++++++++++++++++
>  target/arm/translate.c         | 14 +-------------
>  target/arm/vfp.decode          |  5 +++++
>  3 files changed, 26 insertions(+), 13 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

