Return-Path: <SRS0=mXWu=UK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2FFAC4321A
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 15:17:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3C761212F5
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Jun 2019 15:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FRqjsDKn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3C761212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60104 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haiWC-0008PC-OQ
	for qemu-devel@archiver.kernel.org; Tue, 11 Jun 2019 11:17:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51378)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1haiO0-0005FF-IK
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:08:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1haiNy-000159-OA
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:08:32 -0400
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542]:35942)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1haiNy-000146-EG
 for qemu-devel@nongnu.org; Tue, 11 Jun 2019 11:08:30 -0400
Received: by mail-pg1-x542.google.com with SMTP id f21so1118994pgi.3
 for <qemu-devel@nongnu.org>; Tue, 11 Jun 2019 08:08:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=5hhOTa9j+6PbeJA576fNKK+wBlbYayOk4gc+6fEirqY=;
 b=FRqjsDKnDkxVsvLzgJKc0WRHEL3qClm9d/cCyMvRlqtOJz1+aTu5+XUJT0KrRL81FV
 EEEBeKQ4oiNE4BC2E3JgspIJ7E9P02v6chSYELphpnJvs6kKdKOmIiBU+MxoJ6e3jYCb
 lCK8nDH+VxyJ063Qh7nii2FFeW1fp3zcefBTkGDpPKE1iF4QmFO6G63PPpXdB+S6Bunf
 LB0uXTBnR0ZDfHpdNFVJfqfp6b53mYHyWCHgIUgTaH7L1EFwkLa+Kof2jfLrIwMe+Kgk
 Npl6yRKO3zvVNdRlvmogIENdk7k4FVzUaceYdj1JO2jBLkH7JT/vBr81y5hv6EMVgbv/
 Tiug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=5hhOTa9j+6PbeJA576fNKK+wBlbYayOk4gc+6fEirqY=;
 b=ECJTwTNWnvROUOtyKYWBC4JopMUB929XQhWMYbPV0dIidNrJW7rUBmVdAeynwPm9fQ
 81s36LoAI4OY+2Ey0v7X3P7sNIbvF8pt70kvyt+pGUN+g0kCFuKSB/I2DDDe/nF71Xqo
 SELsXTEtA5AcBJvtjhx4Taro1T4C+KKfWGn1L3L6Hhj05M+tMNW9K7GPYQlBqZiwUVbi
 SUH5SzvFE4C7t4G6aLN3meLJ5I47O/5aOOyO17ue2SXgOnFaEmqpOIWhyPwuax7ni9mC
 A6ADC/JShor7uxNxpjBEIFUCOC9vcfwY5lpEFkBN+MPy4oY0Ld6EQiVH0HJ3NyEeP0v5
 ZS+Q==
X-Gm-Message-State: APjAAAU2OZFrirGtZP4P6VKIsb20RtPDUuilssVsKrV4vYvBACZOIOjZ
 oT+xijSPuO+M2GZbLlnYkHBkbt1hUX0=
X-Google-Smtp-Source: APXvYqwv+Xm4zazR7khsjbZ1n4gECExXyQRvAzM+9g6T0y7g9Ga4e+wdAdxgOuztUgZgQzFLmmmHMw==
X-Received: by 2002:a17:90a:db08:: with SMTP id
 g8mr26518267pjv.39.1560265708026; 
 Tue, 11 Jun 2019 08:08:28 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
 by smtp.gmail.com with ESMTPSA id s7sm29470pgm.8.2019.06.11.08.08.26
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 11 Jun 2019 08:08:27 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190611105351.9871-1-peter.maydell@linaro.org>
 <20190611105351.9871-40-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <10e56723-82a1-c87e-a84b-37ee4698fb83@linaro.org>
Date: Tue, 11 Jun 2019 08:08:25 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190611105351.9871-40-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::542
Subject: Re: [Qemu-devel] [PATCH v2 39/42] target/arm: Convert VJCVT to
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

On 6/11/19 3:53 AM, Peter Maydell wrote:
> Convert the VJCVT instruction to decodetree.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate-vfp.inc.c | 28 ++++++++++++++++++++++++++++
>  target/arm/translate.c         | 12 +-----------
>  target/arm/vfp.decode          |  4 ++++
>  3 files changed, 33 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

