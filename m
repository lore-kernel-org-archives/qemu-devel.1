Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBEFBC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:12:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A868F2175B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 20:12:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="flzOO2aE"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A868F2175B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42748 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTu4N-0007XK-W3
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 16:12:08 -0400
Received: from eggs.gnu.org ([209.51.188.92]:57302)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTtwL-0000HL-MO
	for qemu-devel@nongnu.org; Thu, 23 May 2019 16:03:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTto4-0004HM-Rm
	for qemu-devel@nongnu.org; Thu, 23 May 2019 15:55:18 -0400
Received: from mail-vs1-xe42.google.com ([2607:f8b0:4864:20::e42]:34851)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTto4-0004FE-MY
	for qemu-devel@nongnu.org; Thu, 23 May 2019 15:55:16 -0400
Received: by mail-vs1-xe42.google.com with SMTP id q13so4345052vso.2
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 12:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=qsIKb18q22GErxgGewiJ8YfUggOdSI4elyKnL4ns8qI=;
	b=flzOO2aEgW8SRa9Ioan/8OlfMTq3Kg5JehRBdW2q0AfpWDzJ+plMVoxuz3hooqArwm
	Fqlbe86fk2tdaws/OBTMacVToU2BS+v7LWkh35IIKTZyYO9yY7W+CY1HNTe8DySS/T7Z
	Cq6jvMgrHJCJnvXUiR0fG3dajZt2SuKUYuWAVWkdzM2pbsJQhDJctPSo4jEUd2DFpP4s
	zqimQYlJ7Cfv2m7d6RnaNQ7n/p5QlBdhAAbXvskmRL3Pa9VX8esnJl0OW9vm69kedlnQ
	gQTjub80ULtO0NW0J347+2E2okW1r3pNS0AXzXdgjVvFgUdazt39k7ZWXHtBnbak92Lh
	/JhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=qsIKb18q22GErxgGewiJ8YfUggOdSI4elyKnL4ns8qI=;
	b=NWm2zxwUAExW2iOqgtDBsSozqVOtBhq5TC1uiyZsGq5B0YsaFxHYtjm6w5E5yXB26K
	RknPE/24I8dNiKnot+GEK/AsoHkokxQQH9bIO6EKPgozt8V/Xg67TsS6NjM9E9plyHO9
	HOkt773Yunt/fOu2aI3x3TwcwZMUaxjHEXvhIQP576+awVnRH+0WC3RGDUWMO5CqPBOM
	sgFZshlHmqWULdbPQY7KlPXmKowurlozVhrsePp29V3sM7lFoHKc+4xJQPYf3Km8eGd4
	vrhYCU7K/MmbveamXxn6+n2kgn3tw4H/gQKJbsphmOMCg/udDeYGf1+yjqWnxzcuAIMp
	bLAA==
X-Gm-Message-State: APjAAAXJkGc9+FRywiaRruPuiGFsrQNuU+NIVl/U1Zt/fRYZhCNYCwsy
	ml2rjBKY1UmePh8G3siEbrSWZw==
X-Google-Smtp-Source: APXvYqzRVZAT0oI1HDdfa48GiPy3r65nVHpEuTRGojO1WN9JSyi3w5MJTI4njT/BcmgDZiL46SBMgw==
X-Received: by 2002:a67:f655:: with SMTP id u21mr14030773vso.192.1558641314318;
	Thu, 23 May 2019 12:55:14 -0700 (PDT)
Received: from [192.168.43.94] (ip-173-130-172-85.orldfl.spcsdns.net.
	[173.130.172.85])
	by smtp.gmail.com with ESMTPSA id n68sm470563vkd.0.2019.05.23.12.55.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 12:55:13 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190523102532.10486-1-alex.bennee@linaro.org>
	<20190523102532.10486-12-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d603d45d-4da9-bdc1-68ab-4f87c5b19a81@linaro.org>
Date: Thu, 23 May 2019 15:55:10 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523102532.10486-12-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::e42
Subject: Re: [Qemu-devel] [PATCH v2 11/28] MAINTAINERS: update for
 semihostings new home
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
Cc: qemu-arm@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 6:25 AM, Alex Bennée wrote:
> Seeing as I touched it I should at least keep an eye on it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  MAINTAINERS | 7 +++++++
>  1 file changed, 7 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

