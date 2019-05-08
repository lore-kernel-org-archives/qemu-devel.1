Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1603C04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:34:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA72121726
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 17:34:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oqttuYVe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA72121726
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:40866 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOQSW-0005HA-Vo
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 13:34:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40527)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQQD-0003rM-3i
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:32:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hOQQC-0002X5-8X
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:32:01 -0400
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443]:46003)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hOQQC-0002WY-0Z
	for qemu-devel@nongnu.org; Wed, 08 May 2019 13:32:00 -0400
Received: by mail-pf1-x443.google.com with SMTP id s11so528634pfm.12
	for <qemu-devel@nongnu.org>; Wed, 08 May 2019 10:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=AiI3Ike1DeWIoX3llZ9znAoxhzLZmoLiTUmKAjFMy7s=;
	b=oqttuYVeREWpZ731wF4TZ+KK34SGqd7A/dcqm+KiPIILC48VNFHV5gzhlpZ5miVANN
	P97Ssf/eP0T/oBGj9yRl9Y+v6p0oVF0cnFHn845AGjrt4S0rOEJysoPFdn+mEwu9p+YC
	PMPgJ/TmYJ0oHvug6n4/z+Xi19STQtEc5kWcxRw4dKnCBUTYlZ6LNPpwsbiUh402G5nt
	4pPXdXQvUsrvLKsrjKxf6RPWYkog7o9fGCQQGqrVdHSGbAzYONPvTyAuGG9hhN6Ecc2w
	S0xMGm68gwoZ9mLVcZLGK4QLKZTcWPeqCW9CgA8ZRdFJsB4XpyfPHQPeTaM0YHjX2AUP
	uwAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=AiI3Ike1DeWIoX3llZ9znAoxhzLZmoLiTUmKAjFMy7s=;
	b=X8uXbiSAfJpslEthWI61Lgi5k87SQXSBxjxCdN9ynYJz7xUfZ8EhVSRb8dPLsgnUfS
	NPizQi7S8hsVza/MHULFboptFjyBjFqySAK1iHB+nxARocOY9lj+akG0w87m8Ri8L6lZ
	q9u6ipDnoVCW4+BMFtJsfTri6wNYIWGdCvNiSSXOL5MSkTebWmbWoI8qiDP3a29rYKZu
	jjH/KA/kOUjP4XUikYZlxFH73rKPOhdef65RDgl2vQBIsxdbmGJ/S8QWzd0Sc4do18L1
	wq2/OZjCaGTRjv8cGqPyCrosNKdnAqjuf2HUkW5Dy9H+g7P6qMPFtOyiLct1dQWsinx8
	IpZw==
X-Gm-Message-State: APjAAAVIJDB1ZTCZGwOmsFgJMqClmmToKpqm7+NHFEYFwNkfRgFVHFK6
	pNYGlYO1QCZeN0bzJs5v7xYjsA==
X-Google-Smtp-Source: APXvYqwFiglb2xnzosarH2g3oDuj2WBfeFWeX8MQ3rurPogQOjxrM3uGd9VuGC80a++HSkHErbmPiQ==
X-Received: by 2002:a62:fb0f:: with SMTP id x15mr51149208pfm.30.1557336718696; 
	Wed, 08 May 2019 10:31:58 -0700 (PDT)
Received: from [192.168.1.11] (97-113-27-95.tukw.qwest.net. [97.113.27.95])
	by smtp.gmail.com with ESMTPSA id
	u11sm120681pfh.130.2019.05.08.10.31.57
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 08 May 2019 10:31:58 -0700 (PDT)
To: Yoshinori Sato <ysato@users.sourceforge.jp>, qemu-devel@nongnu.org
References: <20190508145611.107133-1-ysato@users.sourceforge.jp>
	<20190508145611.107133-11-ysato@users.sourceforge.jp>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a4cc6255-cf0c-1cbe-907e-a84ae6df380b@linaro.org>
Date: Wed, 8 May 2019 10:31:56 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190508145611.107133-11-ysato@users.sourceforge.jp>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::443
Subject: Re: [Qemu-devel] [PATCH v10 10/13] Add rx-softmmu
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/8/19 7:56 AM, Yoshinori Sato wrote:
> Signed-off-by: Yoshinori Sato <ysato@users.sourceforge.jp>
> ---
>  configure                      | 8 ++++++++
>  default-configs/rx-softmmu.mak | 7 +++++++
>  include/sysemu/arch_init.h     | 1 +
>  arch_init.c                    | 2 ++
>  hw/Kconfig                     | 1 +
>  5 files changed, 19 insertions(+)
>  create mode 100644 default-configs/rx-softmmu.mak

This patch must be last (aside from MAINTAINERS, which doesn't have code).

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


