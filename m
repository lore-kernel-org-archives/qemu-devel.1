Return-Path: <SRS0=qJMs=D2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D82AC43467
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:08:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 177562224D
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2020 16:08:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fczoxVaK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 177562224D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50476 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kUXhk-0005fW-VY
	for qemu-devel@archiver.kernel.org; Mon, 19 Oct 2020 12:08:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:52554)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUXXM-0005fG-4l
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:57:28 -0400
Received: from mail-pj1-x1043.google.com ([2607:f8b0:4864:20::1043]:36200)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kUXXK-0000Vp-L9
 for qemu-devel@nongnu.org; Mon, 19 Oct 2020 11:57:27 -0400
Received: by mail-pj1-x1043.google.com with SMTP id a1so10852pjd.1
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2020 08:57:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=vAhVBxMYUODQU0vjWNSBtUAbQfWsvWH/MyQUcKmeFEQ=;
 b=fczoxVaKF7j5Ka5EDrEBV9cOTLcrAO5BIuSKGcLzG3/qMNvRB23ZP8Mr7hOLNncUE8
 Lo5oEvXAVMxXclZEl0qCsW8RGsUb3+0nas4Zmqt17z6gaZJaF1Y+TF8os5OcPv9G0V2R
 KF+Dn80cwfLwJakoVSpeNOhfGAR6QlT9IkHfOZP7JSb+j8EM4waxBI5DY3ZgzFYN2ARb
 8DuRr4mmlixVOHbW/fx7KwCHbAZjm5r9r1dVxFQv4i+qrA/EXTdCYdEbIte32WrzUuXq
 ypo21isluuuGJEWuhCh+Zu+YYqC6bklZasWowJPxmsyqmtb5uXEe6vD2rC1/WRuKz31x
 v6Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vAhVBxMYUODQU0vjWNSBtUAbQfWsvWH/MyQUcKmeFEQ=;
 b=LjMzeRG+cctR6oYcBxxp7nxdVMCvQfLMekytgEo1VdjZINUaCgtgE64FzoUNs7fFda
 KRkNk/7fkG0LDuKL3NFxez7iCXtStDNkHKUeqvuA+5j/rqhyZgPLHCFLpvy7tmfp9wWU
 KoXc8GwReJjZNrI95MVC6K8dseX/7++k9dQo7DBCPkT/XsL+qIfa+PLaEMKuMXi8Qeiy
 BMLmP/IGFeCl78VxpjHyGqZsWyS8o7dWH2Uiaanv2Yydef4INA1YmgrcuWlIcTAdDlRv
 pUh+ZpVLWEtHCyTAgzbnJ2WpDOs2zgM8bo17J5022pl13kRnioHTMeWIoP1Gn0drYA/s
 vhhw==
X-Gm-Message-State: AOAM531CdwjsSy5vw9Y0LjEN0BDSmgCDbt6fEahz2qwvUI7YM0KvrlKS
 EZaATmvJNUeHJuvgbwwMeoA0RFbOzEYpEg==
X-Google-Smtp-Source: ABdhPJybzXf7/bGbnnD6vIdSDYa5pfbWpcs/+3OeSonndu1x2tftfkbCVeqv3hjW4iJyIgoQZNFd0g==
X-Received: by 2002:a17:902:8205:b029:d5:dc92:a1d4 with SMTP id
 x5-20020a1709028205b02900d5dc92a1d4mr271567pln.41.1603123044644; 
 Mon, 19 Oct 2020 08:57:24 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id n18sm254382pff.129.2020.10.19.08.57.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 19 Oct 2020 08:57:23 -0700 (PDT)
Subject: Re: [PATCH v2 09/10] target/arm: Allow M-profile CPUs with FP16 to
 set FPSCR.FP16
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20201019151301.2046-1-peter.maydell@linaro.org>
 <20201019151301.2046-10-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e3fc4b0e-d6c1-05e3-451e-e17419a02858@linaro.org>
Date: Mon, 19 Oct 2020 08:57:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201019151301.2046-10-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1043;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1043.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/19/20 8:13 AM, Peter Maydell wrote:
> M-profile CPUs with half-precision floating point support should
> be able to write to FPSCR.FZ16, but an M-profile specific masking
> of the value at the top of vfp_set_fpscr() currently prevents that.
> This is not yet an active bug because we have no M-profile
> FP16 CPUs, but needs to be fixed before we can add any.
> 
> The bits that the masking is effectively preventing from being
> set are the A-profile only short-vector Len and Stride fields,
> plus the Neon QC bit. Rearrange the order of the function so
> that those fields are handled earlier and only under a suitable
> guard; this allows us to drop the M-profile specific masking,
> making FZ16 writeable.
> 
> This change also makes the QC bit correctly RAZ/WI for older
> no-Neon A-profile cores.
> 
> This refactoring also paves the way for the low-overhead-branch
> LTPSIZE field, which uses some of the bits that are used for
> A-profile Stride and Len.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/vfp_helper.c | 47 ++++++++++++++++++++++++-----------------
>  1 file changed, 28 insertions(+), 19 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


