Return-Path: <SRS0=zUjA=SZ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9623C10F03
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 23:07:07 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 67A79206BA
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2019 23:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YrGLkf0P"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 67A79206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60845 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJ4VG-0008O3-M2
	for qemu-devel@archiver.kernel.org; Tue, 23 Apr 2019 19:07:06 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35632)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ4TD-0006VK-68
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:05:00 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJ4T7-0004Se-KV
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:04:58 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:45942)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJ4T7-0004Lx-1P
	for qemu-devel@nongnu.org; Tue, 23 Apr 2019 19:04:53 -0400
Received: by mail-pl1-x643.google.com with SMTP id o5so3911244pls.12
	for <qemu-devel@nongnu.org>; Tue, 23 Apr 2019 16:04:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=n/c+Bl41/wLEPFjj3s+GHe0JHiuPaOcaHyJ06oLCP8M=;
	b=YrGLkf0PurQgQijC1QKnahx75f5PH+TvVEw5HiMOP/+CsH8+3V901mepuikZD2R0CB
	dnJY2vE3AQCTEst/2TkNEQOiT1m8o9EgAyEvKuLajOIH8Jr0YelmHBHXan5jw6rcNebE
	19S4d851U60qeDzYw7XE2RP/UrlbVoIpx1ImFjxNXxPAi8fvgWUTcfqwjrKtPO2Jz9jL
	NRTGGM4KGJUNSI1Qz+Pt3JpE2KU3UJ68tV4pFYWqQz+TstB5+wsY7TxxxgZAOZbWrdvh
	0Bz3sMPorVuQtUtWqM+nsXAvORu4/z9Ng8T5mMPe63R6+ZCEZlxIUn4PO0O0CTqdgKhB
	w9lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=n/c+Bl41/wLEPFjj3s+GHe0JHiuPaOcaHyJ06oLCP8M=;
	b=ZJAWD3M4ce6nZUk9s6EBFAi7mSqT3MxPA8V0mSveFrPe0oA2hKBVznsEJWmDUugmJy
	qiSqfy+iDqN/HHDnCQb3aNCnDuywsS6CUZfPl3r2E532ukesBmCXZmBtU9XagKRq7bYG
	ErYbJX4FUx18zQ6S7inc/FOkuirdPJYAGvUvnY1Ds886MIE9pkCo2RCE6yWTTe0t5Kgx
	qWj2yNdhRPCjmyU5YL0NPgxg19RJniEt4HnW/XyOfCcEAfoLfJs7d4CDgYbHov9M365X
	L1trxMa5PQpxeKHeTlGuFRC0FNQQ8RQx1zZmlZxh4BB8BM531TWWXaxQF0hyfTBeIsVd
	37IQ==
X-Gm-Message-State: APjAAAV+hj7oVk+KazKYEEjflNWHpFXAGE9hZoO6xKeiAE9fXFwV+VFp
	vIV+3WQWwPZbE87V2DOhwx8Hg1cMRZA=
X-Google-Smtp-Source: APXvYqxmthBTBU+yIzOtNlsgbhit988Ggi2i/RTVmrsASHB6Oz6wFLT81JjSS7fVosrrArTKEZS3CQ==
X-Received: by 2002:a17:902:4501:: with SMTP id
	m1mr28924907pld.290.1556060685653; 
	Tue, 23 Apr 2019 16:04:45 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	i10sm38838352pfj.7.2019.04.23.16.04.44
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 23 Apr 2019 16:04:45 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
References: <20190416125744.27770-1-peter.maydell@linaro.org>
	<20190416125744.27770-15-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <20f5f564-6d0b-0c28-00e9-b7f2ac46a409@linaro.org>
Date: Tue, 23 Apr 2019 16:04:43 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190416125744.27770-15-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH 14/26] target/arm: Allow for floating point
 in callee stack integrity check
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190423230443.OQHARpMhhs0N0F6vvd10z6-0WBeAbm9XYUSCZNQ8pPQ@z>

On 4/16/19 5:57 AM, Peter Maydell wrote:
> The magic value pushed onto the callee stack as an integrity
> check is different if floating point is present.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/helper.c | 22 +++++++++++++++++++---
>  1 file changed, 19 insertions(+), 3 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


