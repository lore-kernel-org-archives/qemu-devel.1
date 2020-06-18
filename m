Return-Path: <SRS0=FaGC=77=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28C66C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 23:47:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4CAD207D8
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2020 23:47:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IL+yCckY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CAD207D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55630 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jm4Fq-0001xs-5H
	for qemu-devel@archiver.kernel.org; Thu, 18 Jun 2020 19:47:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43606)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jm4EW-0000TC-FX
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 19:46:12 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:51393)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jm4EU-0003rZ-Ej
 for qemu-devel@nongnu.org; Thu, 18 Jun 2020 19:46:12 -0400
Received: by mail-pj1-x1044.google.com with SMTP id ga6so3308582pjb.1
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2020 16:46:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:cc:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=uLtkQnH7DuuSCEmEDthGipcO+ld6NjQx6IMKmRnCHbI=;
 b=IL+yCckYvyuMAMKhWiMCibrIY6t8miA1xyXS+tAcib1gwFiCuDiBvMSskJBU6n/X/P
 VWijBzePU4ZNYN0WHLCMR0R+Q6+v0m/ybSg7p9XF2B/0TSkjKSwbIFXXPMw1Tq3Xxw0H
 +2bUR8VGRxDal1iqDLIyH+D67A+gp2nb64uIipd1M9yAQwEIEnGWSd9WeisndqHIzsnA
 NrfmvGnxxQS8PGeOk/wmg1SQrdBNZnjKBZWC6SbdIdymA90p/AaMq6Ny1TzetiZJHqs1
 v1sX8n3q1j9OwWQu2YDPwIVx1AnW8F0pzyckmq3NNA2NHh8DGaeV8Ec8r7YhZme0n0UW
 AbAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:cc:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=uLtkQnH7DuuSCEmEDthGipcO+ld6NjQx6IMKmRnCHbI=;
 b=tvUhpmUQ8yfyBr3xf1IgNmkazmYCy62hUj+4C19vDwR1gQx3Mq7zUjlp2FrFAX2cKd
 Gau1GLiOcJOVdQt+jsNayc9L22LJJXQw8Yz1LvDIrrlY5hTrrnMNN+mI2shX/jbhN/vc
 02GsmXeSlEUU/kcfqiq5ow/jlREvrYpTpN4l8pbv69b5JlCk9Tzqi27ea/IL6JYcP179
 FebMwE5hnEU4KF9Shyjdy+1VBLBPSaiTTR0STQFxF4Vf8ozJ79jPpi+++pnOpd5nIcKi
 IYHH6yAFAJ/y1UNmarHo7RurbcerApKr8AlabfqnmSHdisW8GtbcZETER5V6rffQ7rQC
 4Ojw==
X-Gm-Message-State: AOAM531rs4GYKFGgnTIdFHNYPgdvQX1SVJ83uqHOsDwM1dAxENRHoahC
 g7onPv4gUjwDu5EEWzRdCAb25Q==
X-Google-Smtp-Source: ABdhPJz5BgbxrlKRruXF84WW+rQTnYajbeoq0L2XkYTfAAZTVxynePGofR7VreypzULQNdCWXP0mLA==
X-Received: by 2002:a17:902:222:: with SMTP id 31mr5813587plc.67.1592523968754; 
 Thu, 18 Jun 2020 16:46:08 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id f29sm3649440pgf.63.2020.06.18.16.46.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2020 16:46:08 -0700 (PDT)
Subject: Re: [PATCH 5/6] fix the prototype of muls64/mulu64
To: Lijun Pan <ljp@linux.ibm.com>, qemu-ppc@nongnu.org, qemu-devel@nongnu.org
References: <20200613042029.22321-1-ljp@linux.ibm.com>
 <20200613042029.22321-6-ljp@linux.ibm.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e9e01473-251e-51ec-8f72-72ddd1a9ab2e@linaro.org>
Date: Thu, 18 Jun 2020 16:46:06 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200613042029.22321-6-ljp@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: qemu-trivial <qemu-trivial@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/12/20 9:20 PM, Lijun Pan wrote:
> The prototypes of muls64/mulu64 in host-utils.h should match the
> definitions in host-utils.c
> 
> Signed-off-by: Lijun Pan <ljp@linux.ibm.com>
> ---
>  include/qemu/host-utils.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
CC: qemu-trivial.


r~

