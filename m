Return-Path: <SRS0=rgCY=UM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24521C31E45
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:28:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9A3F42133D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2019 21:28:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZVnIpcK6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9A3F42133D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45706 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hbXGr-00035e-QE
	for qemu-devel@archiver.kernel.org; Thu, 13 Jun 2019 17:28:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48309)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hbXDm-0000gv-3X
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:25:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hbXDk-000768-JI
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:25:21 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:46988)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hbXDk-00074i-9H
 for qemu-devel@nongnu.org; Thu, 13 Jun 2019 17:25:20 -0400
Received: by mail-pf1-x444.google.com with SMTP id 81so33730pfy.13
 for <qemu-devel@nongnu.org>; Thu, 13 Jun 2019 14:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qUztuGQSty9lg5aMBAyILDQxrq01iLy2gukKWXrdxWs=;
 b=ZVnIpcK6oloY4eWsyR4UmMr+gxfpM8YKlPiIEfvqAp/E4QVUXnRq8O90OEPlm/nGA+
 lr91bTuDJQZ6kB5cVklbUOez5VREhyicO4ztQ539Jkvzcwo4P7laXOctm+kGoMtEIqqg
 Vn6RLjz87JnzWgnojhRnz00J92P60ZgIE3R0Y8dm7AoQxTESLG2thbBnHIAvFJMKYCzq
 ZQqx60aG/oMtLWRLpUTXLUHsNYIRFhBLBI4eiwJWePDeASpQ4qombjeQ8m27fscbhrYm
 /IAvM9Wotm2U6U3Fwcr0iFYGpasbI1cUYFwxhGi7A+smxYnXrUbwAsfhAMZrFZQhpC8g
 NVzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qUztuGQSty9lg5aMBAyILDQxrq01iLy2gukKWXrdxWs=;
 b=q55JwoklM94slsMND5qm7NV1d1QrOmeQc9ccTG5Vnf6CoCOiNFfr/35TC3YlpUN28J
 zMVmdPHvvfcnhTpc00QoTF3WWR2feAG490RNsjKJLb4P/PB6As8yqw5nhjk7WtafL/b0
 qbwJD4x2iAi/O7gQOCEJ/GiW/B1YpmySeewjz9uFbsNVcIkWZqba5D2jO4BLVqmbuMeB
 AQ2mSN19Qqc6I3W8j4t57dArCUOb/qdKIoluyZCPNX85Cy1QAqWrkuwMjVGP3jR6kbPc
 xfOU5y7DCO58VpGklFUO1iqfIBpG/LuG3yNqegWM0sovDpMwIlygBhtv30aLE/ITQ1Ai
 E9Hw==
X-Gm-Message-State: APjAAAWTqL+JSs2szzN/tVDXzgFRH/KF//+7q0ceoP/xfx6vRfgQRoLQ
 tsp8psqKKaZTwo+S/Byjl4pZQWoVTsQ=
X-Google-Smtp-Source: APXvYqzTtd+1cXEeRC9Ui6/nToaHfIkRZmgHxR4QXbSe55VZRBheGIzysNYaJxBSXYABOA2YwrLcIw==
X-Received: by 2002:a62:6143:: with SMTP id v64mr58324265pfb.42.1560461119008; 
 Thu, 13 Jun 2019 14:25:19 -0700 (PDT)
Received: from [10.10.150.239] ([149.199.65.200])
 by smtp.gmail.com with ESMTPSA id 139sm593175pfw.152.2019.06.13.14.25.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 13 Jun 2019 14:25:18 -0700 (PDT)
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190613163917.28589-1-peter.maydell@linaro.org>
 <20190613163917.28589-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <45d470d6-d0da-894d-475b-93cd3498a827@linaro.org>
Date: Thu, 13 Jun 2019 14:25:16 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190613163917.28589-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH 03/12] target/arm: Stop using cpu_F0s for
 NEON_2RM_VABS_F
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

On 6/13/19 9:39 AM, Peter Maydell wrote:
> Where Neon instructions are floating point operations, we
> mostly use the old VFP utility functions like gen_vfp_abs()
> which work on the TCG globals cpu_F0s and cpu_F1s. The
> Neon for-each-element loop conditionally loads the inputs
> into either a plain old TCG temporary for most operations
> or into cpu_F0s for float operations, and similarly stores
> back either cpu_F0s or the temporary.
> 
> Switch NEON_2RM_VABS_F away from using cpu_F0s, and
> update neon_2rm_is_float_op() accordingly.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/translate.c | 19 ++++++++-----------
>  1 file changed, 8 insertions(+), 11 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


