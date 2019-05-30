Return-Path: <SRS0=r6E1=T6=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C273AC28CC0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 18:43:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 92FC025FD3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 May 2019 18:43:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zFOsRW6q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 92FC025FD3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:57807 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hWQ1s-0001Uu-V4
	for qemu-devel@archiver.kernel.org; Thu, 30 May 2019 14:43:56 -0400
Received: from eggs.gnu.org ([209.51.188.92]:55131)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWQ15-00019n-J8
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:43:08 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hWQ13-0008Lc-RN
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:43:06 -0400
Received: from mail-ot1-x341.google.com ([2607:f8b0:4864:20::341]:34085)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hWQ13-0008Jv-Mo
	for qemu-devel@nongnu.org; Thu, 30 May 2019 14:43:05 -0400
Received: by mail-ot1-x341.google.com with SMTP id l17so6662930otq.1
	for <qemu-devel@nongnu.org>; Thu, 30 May 2019 11:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=BzQbAEVYQQ/EvpEMayssEDYjmMmjWAgbwkBBSAO5pVY=;
	b=zFOsRW6qKGXt1jzlc2rVkC8jSXzEOlmdMSxiNh2cj/OQVB7zDXYVjh39LcDdOE10Oa
	cHXpldkdmqaL1TaXtz+9dXnDcmOiXY6ZifpUAqdty3DehLzk58B2c7ImRzAMn1FSyamn
	bST3ugG3jaSh3Czyek7s5pCyE228P3oE3/WkHx5gCVG1bcjmFJdSbORQogkUY8hy6TxA
	zJ66qkC/tzqUW3RvXJr0V7YkSUmG3YImumlYKENrtYqye4chLZF6ninmktrrOoVFDQG2
	hGHgt9TuD2SYoNthwkDIJdibTrr5hnvddvDt1IFrWbrNZFkgPdsQj750N5v4XyI6MvSR
	CRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=BzQbAEVYQQ/EvpEMayssEDYjmMmjWAgbwkBBSAO5pVY=;
	b=MJ8BMUg7WFtewZUXmSTOhFPPF9Pm9Vg48fgRJo6dF22gRIIXdcnKDRJgWUMDUEeqOy
	aWFPtC3Ef3Fe6s+0SjZ8TSHT80IHTWWg7ebSbdq2bngDkESPIh09uBJ2asxTu2mLJDfx
	OhOpSD9Au0VCm39Owcfjnob8wz31OFjZfHnUp/JXeRN36y6Jpjjmb04oAoCX3+WDsOvF
	4jkAFHWbmnSuVrnvO0y8GkVUMDEoNJTyb2JvJJDgqgwcIO+c3k6t1UYE17qcLEzQ/cfJ
	ewH0W/lAoUT5ugorbkfW2L6vEDqh8ty/aEjYzeVaM2XkyfoN4SZfT66ZXSSaNmC0K6dI
	afqQ==
X-Gm-Message-State: APjAAAXmA5emNC6x2lDlUkQHT8fDMANBKvsqAtfu0VU8Xc/wydgmPMpv
	mkVgl/stVbLq7PDLO9p4dHqrlKyp7K/Kow==
X-Google-Smtp-Source: APXvYqxbDbS2yA4Z66vdlfdg94HApbLOYHCbYzD3TZpDvQ9a3AmSG/RZ7ygfgX3q1gzd4yAZAB5hqQ==
X-Received: by 2002:a9d:17e1:: with SMTP id j88mr1910559otj.369.1559241783691; 
	Thu, 30 May 2019 11:43:03 -0700 (PDT)
Received: from [172.24.12.210] (168.189-204-159.bestelclientes.com.mx.
	[189.204.159.168])
	by smtp.gmail.com with ESMTPSA id 63sm1876147otx.35.2019.05.30.11.43.02
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 30 May 2019 11:43:02 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190530101603.22254-1-alex.bennee@linaro.org>
	<20190530101603.22254-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <9662b983-7a38-fd55-ca86-bdc9d17f9ee5@linaro.org>
Date: Thu, 30 May 2019 13:43:00 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190530101603.22254-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::341
Subject: Re: [Qemu-devel] [PATCH v1 05/26] tests/docker: Update the Fedora
 cross compile images to 30
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
Cc: Fam Zheng <fam@euphon.net>,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/30/19 5:15 AM, Alex Bennée wrote:
> While at it remove the bogus :latest tag for cris cross compiler. It
> tends to break caching and cause confusion.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/docker/dockerfiles/fedora-cris-cross.docker | 2 +-
>  tests/docker/dockerfiles/fedora-i386-cross.docker | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

