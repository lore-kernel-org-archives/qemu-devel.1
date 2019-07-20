Return-Path: <SRS0=lwXe=VR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD8CDC76186
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 22:35:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9C0992082A
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Jul 2019 22:35:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AwSe7F8Z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9C0992082A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53820 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hoxwq-0000Hp-Qc
	for qemu-devel@archiver.kernel.org; Sat, 20 Jul 2019 18:35:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48914)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hoxwg-0008G0-PW
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 18:35:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hoxwf-0006et-So
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 18:35:14 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41856)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hoxwf-0006e2-LP
 for qemu-devel@nongnu.org; Sat, 20 Jul 2019 18:35:13 -0400
Received: by mail-pl1-x642.google.com with SMTP id m9so17248993pls.8
 for <qemu-devel@nongnu.org>; Sat, 20 Jul 2019 15:35:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=ioD9LxVserrnfnVtYx4cpHL9L1OyLZAnvklEXh7G9GM=;
 b=AwSe7F8ZamxCdRvSDcLeW2LiZWkzg9xbqCmdPIN4i3r7QluHreMMnTWFFIIC1Vt+yU
 nrJTPqYgWTLxU6hWKnyhzbZJ0V8crW4cJ62R/rE7G3AgnTwWnqDIVnnVTvWSdk3Twg/t
 pDNzIMnFDWZetarveVMYUTEvOu+GIZKvXiITA0NjGRGrKRJKW6GRucn3LmxgfZ1jOc1c
 FkbjCgKDMxBa9EKYkgFAt5vwHXltIUaujjNhbnaIw8Bqp/pCX5PIlXyE2ly5tl8KXZ13
 KkmhkmkkI/8aIkOeePaNloNjkfuHg/74pvyUfoXa/NhwHopPbpKhiCZjBNjPpaRl+hsq
 ZsJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=ioD9LxVserrnfnVtYx4cpHL9L1OyLZAnvklEXh7G9GM=;
 b=hIIXencwetPNQSvr4unvScx/ph6Dy8ytCpf7TujMBLZQxR5G6GNiO0bnG2JZPU9khs
 yPdfSRuiBxIQ6KQRBzhAydwfAvGBkoG5T8eVIXEGCzR/sAj+eSGJBFYN7CU7YhA0ANe5
 BcI7TlVguzouud2M9GtvjliNwt9VKfEAaoApo4cMzM42nlb+sPjCG34xrylS2GHvnUIv
 81v9X5Rllg8o0LDnrzBsq6TmicSRpwlrXJuoPJNUd/bWSPopte2lBat9nTGJAmAx2gWR
 tGnsIphIfisSpQ5W2cFCjb9G8hlGAb+TujDrrZL18zoEsXWYP0nG7g1gRJ6tDJ19bG8F
 58oA==
X-Gm-Message-State: APjAAAXgnxlwVYo0jb1GF3Znygcxq6h+QxRIDGU3Cr/fj4RROSdkocBU
 PvU9zcuw7SSP+CYtAXBJnpknJg==
X-Google-Smtp-Source: APXvYqyw6GyHjv4a0zXPzMZ9k3AUhFcGB69V1/50oAWaGpitAIo2K7LzfNhl+vDZeyuvXq9NJ5o6Mw==
X-Received: by 2002:a17:902:1004:: with SMTP id
 b4mr66632342pla.325.1563662112497; 
 Sat, 20 Jul 2019 15:35:12 -0700 (PDT)
Received: from [192.168.1.11] (97-126-117-207.tukw.qwest.net. [97.126.117.207])
 by smtp.gmail.com with ESMTPSA id s6sm52970645pfs.122.2019.07.20.15.35.11
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Sat, 20 Jul 2019 15:35:11 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190711223300.6061-1-jan.bobek@gmail.com>
 <20190711223300.6061-17-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <e15b9d25-62c2-80f2-ac3b-c21054068b87@linaro.org>
Date: Sat, 20 Jul 2019 15:35:09 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20190711223300.6061-17-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [RISU PATCH v3 16/18] x86.risu: add AES and
 PCLMULQDQ instructions
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/19 3:32 PM, Jan Bobek wrote:
> Add AES-NI and PCLMULQDQ instructions to the x86 configuration file.
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  x86.risu | 45 +++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 45 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

