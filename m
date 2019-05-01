Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D67DEC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83C24208C3
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 14:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SPORCtml"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83C24208C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60118 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLqXX-0003p5-OL
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 10:48:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54158)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqVK-0002Vs-Sx
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:46:41 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hLqVH-0001qK-Pa
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:46:38 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:39332)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hLqVH-0001q2-J2
	for qemu-devel@nongnu.org; Wed, 01 May 2019 10:46:35 -0400
Received: by mail-pl1-x642.google.com with SMTP id e92so8278038plb.6
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 07:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=MXeR5ucxkzn+BPA9oGPvA3bdjTpeJcJstRMgb0ixZZA=;
	b=SPORCtmlyjzoEx20Iq1dz94iilotwGaZvFrkKwVJ33VOlZpm5k0Tr8VEt7q8pka//L
	7Ky6f2Ca+qhvYDY6pDmmjA3WLEHsVY4V2wygw9SCAf7Otgvlik/0ptbQplindhAN77uj
	DwWivTrutlWN1qguEP0vVsZvEBSMcUoYGtBIxc3VtSeoRVtt2JAzTHT+lCGfloHfCl6e
	/yMknLQXesHSDeGPFJBd7hV6ieO4ttG25BiL+TArEU3C3GrsV4xqhljPiFqW9MG14N+K
	IXaj1zNGeZRbcCbWDNpsvCdw2ybodV5KD/b6m56VyM5UedwnwUIAL1oP4xLAAxMrnXkw
	+cMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=MXeR5ucxkzn+BPA9oGPvA3bdjTpeJcJstRMgb0ixZZA=;
	b=atCM6Eh1p9+hDD+D8R+8mheS1PR/TadTTfBD1gdDK+fBHSP7IVdZJ3X6i9oRFaztVb
	OeY+5cZTEhWsRYxwyW0RPZvBP1M1vfu+nckD1uc6D62lm3J3PU8HoNFeDULeyVZU6w0L
	eJsLSXe5KUQCj5WOxHiUncjwr8aUNAY4n8FXCKNdWdtitCIV6LTtcRhiPuBoYVgKmdrn
	Wxn1mD8DiRHI5JQrtk8eKFRoqxpewsJ60+iZ05MdJp4XcY6XSGNKOG2fb0OIwY7/IMkS
	53V6AVrUR7VjRZuON8mTigOu8RmDxfb262kR8dnLmcvvmW9LeK4B79cW1D6s/SXEmjiY
	7ieQ==
X-Gm-Message-State: APjAAAWqby34STiP2jjin6ziY1Hxxsp3qnN5Q0EsvFgRoOpO0qKv/msR
	63Rae80Xp5G6lELkNSJ8IqqXOw==
X-Google-Smtp-Source: APXvYqyCBrU2WNKPZRFf0OOqFS5TQFw2JS8uC8J0tCdKjdHIqb4GAsl0mEIUGJz4cM7ra79FK2E6YA==
X-Received: by 2002:a17:902:29e9:: with SMTP id
	h96mr58689711plb.258.1556721994556; 
	Wed, 01 May 2019 07:46:34 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id
	q144sm46948224pgq.76.2019.05.01.07.46.33
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 01 May 2019 07:46:33 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <357d799d-898f-3e1e-d4cb-beeac89cb528@linaro.org>
Date: Wed, 1 May 2019 07:46:31 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190430165234.32272-10-alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
Subject: Re: [Qemu-devel] [PATCH v5 09/15] accel/tcg: remove
 softmmu_template.h
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
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501144631.YdebqeK8tbDJ4P8wAq05jvhmhD-turA9roGOhVNy16k@z>

On 4/30/19 9:52 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  accel/tcg/softmmu_template.h | 454 -----------------------------------
>  1 file changed, 454 deletions(-)
>  delete mode 100644 accel/tcg/softmmu_template.h

Why is this separate from patch 7?


r~

