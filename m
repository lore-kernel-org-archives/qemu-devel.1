Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89575C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 03:27:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4038A20851
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 03:27:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nctB582b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4038A20851
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36704 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbGOR-0006Dz-ML
	for qemu-devel@archiver.kernel.org; Wed, 12 Jun 2019 23:27:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:54430)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hbGNy-0005pN-BZ
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 23:26:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hbGNx-0003pN-BP
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 23:26:46 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:38538)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hbGNx-0003oa-31
 for qemu-devel@nongnu.org; Wed, 12 Jun 2019 23:26:45 -0400
Received: by mail-pg1-x543.google.com with SMTP id v11so10063859pgl.5
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2019 20:26:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=kjS5qSsLEwd1D25sPupWyYSgQGfpTwaoBp+ORcl9HXI=;
 b=nctB582bf9SOxbRev7N7J25JrGrm1mnLXIMT2oeXvhnipj4GkJu63QfJAqvi/YRwil
 /bQjrzeDT8FgGIEHE4JKhwdaLBrPOaYJAZoOQUqSf5m2YNibyFGFIs9NDL6Ldqv1s7jD
 7Bay9n6ZbNLJoZI2pgFutbb+WnS6hYztTlocXGRoGd6A+g+igeJ7ETmFQJKdKk49rZU6
 1QIofOUL4JKwFCkny591TIWkgqxokFgqToh9aXtlgIBOXL9apsjpx5VY0iqJuIbEOG3T
 1EmrlSBN3uN15HIfYd4yrfaHzG0Kf+8E+9sNGioHTBj/KFzfQ6ECs3NVdcECGr8M+ec1
 2Y9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=kjS5qSsLEwd1D25sPupWyYSgQGfpTwaoBp+ORcl9HXI=;
 b=DTFH0eOQAeb6gljwYM25sMrQ3zzWcsxtrqx8KcQMflDXsCbYzlp1KzRHoT34dhCLp2
 xkkR2vbINh6lZ0SlrKT5wTPjTtwy5qYGJJRhK+SwXLXXJMJY6oe8lGueum+Xcvlpb0be
 r/LMcyTag+/WY+J2xJxsQzNIL8p3a5tSlr1Cf+vrtyzMmh3NOU5pTJ89E7eZm6oesn5w
 WgwDwMBHSchDVBmwfY0czpt2VeXoDDLFtiDZMGvqL/70ocDyDqJD+uXq4snWr1DijC4M
 C89qIuQVHGU4r+2raw/I7QMjoE41ZkoA7F0PI/7Uj+nekoqZVlkHDhjkfPoKXQfa2w47
 OmPQ==
X-Gm-Message-State: APjAAAXho+m/MqWyg/mxt3pm87BxYZ3rDALOa3ySaWqJDzqDGGoOeeOa
 khkSlidnAFXVMUUK5dLvyX9LVw==
X-Google-Smtp-Source: APXvYqygVHP2Vs/MXmvPNZh5bRgDhXsXBi4AT7UKger88ruguAeHVzt8zSW3KHJQWVJh/0bP3IZNXg==
X-Received: by 2002:a62:778d:: with SMTP id
 s135mr18468852pfc.204.1560396403451; 
 Wed, 12 Jun 2019 20:26:43 -0700 (PDT)
Received: from [10.1.2.220] (50-247-96-158-static.hfc.comcastbusiness.net.
 [50.247.96.158])
 by smtp.gmail.com with ESMTPSA id g5sm720025pfm.54.2019.06.12.20.26.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 12 Jun 2019 20:26:42 -0700 (PDT)
To: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, qemu-devel@nongnu.org,
 atar4qemu@gmail.com, pbonzini@redhat.com
References: <20190612203916.16875-1-mark.cave-ayland@ilande.co.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <a638648c-4a1d-6508-fb42-b2fe2ec692f1@linaro.org>
Date: Wed, 12 Jun 2019 20:26:40 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190612203916.16875-1-mark.cave-ayland@ilande.co.uk>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::543
Subject: Re: [Qemu-devel] [PATCH] sun4m: set default display type to TCX
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

On 6/12/19 1:39 PM, Mark Cave-Ayland wrote:
> Commit 6807874d55 "sun4m: obey -vga none" changed the sun4m machines so that
> they could be started without a framebuffer installed, but as no default
> display type was configured the machines would start in headless mode without
> an explict -vga option.
> 
> Set the default display type for all sun4m machines to TCX so that they will
> start with a framebuffer if one is not specifically requested.
> 
> Signed-off-by: Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>
> ---
>  hw/sparc/sun4m.c | 9 +++++++++
>  1 file changed, 9 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

