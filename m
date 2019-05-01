Return-Path: <SRS0=aVj3=TB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11FABC43219
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:11:45 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D05E82085A
	for <qemu-devel@archiver.kernel.org>; Wed,  1 May 2019 15:11:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wcGcqyy7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D05E82085A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:60735 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLqtb-0006Ay-W4
	for qemu-devel@archiver.kernel.org; Wed, 01 May 2019 11:11:44 -0400
Received: from eggs.gnu.org ([209.51.188.92]:58852)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLqsi-0005aS-9M
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:10:51 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <alex.bennee@linaro.org>) id 1hLqsY-0007KX-OM
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:10:42 -0400
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342]:36812)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
	id 1hLqsT-00078n-U4
	for qemu-devel@nongnu.org; Wed, 01 May 2019 11:10:36 -0400
Received: by mail-wm1-x342.google.com with SMTP id p16so1510011wma.1
	for <qemu-devel@nongnu.org>; Wed, 01 May 2019 08:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=references:user-agent:from:to:cc:subject:in-reply-to:date
	:message-id:mime-version:content-transfer-encoding;
	bh=iPcSwdIk5zRfbUnJrAY/oIDWp/1DnjIB1UCWao1h0Dw=;
	b=wcGcqyy7OZg3OBYCTAO2hSMCTapj7i519cZlCJCckpYkqD17oTJJDdeWUKMaAK7mOl
	6xIVkP4Mxy44PHWf6OLW7F90Qozt+g8YOg5A7XEw8TVLqKkT2w7NQKuiZErDKxzWYTAQ
	NAioJA/23rK/Zrzku9LY+Mi+in7mzpv666JwLj1yRczcJs/VZnfF4e++7tlX/4AxjiQy
	Eg/IMoV7TV536UENJVSYVZgX1ACsnIEb3AAWYogGCIIa4bvYEdreKrXGuGfsVm4o3SJV
	wBFB4hbF4eQMUUlQ4Zx+Wn5j13xEWsfgDCU6KJ72+kk6FxlwUdSXk8HgtKKFNLf5BHVE
	EuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:references:user-agent:from:to:cc:subject
	:in-reply-to:date:message-id:mime-version:content-transfer-encoding;
	bh=iPcSwdIk5zRfbUnJrAY/oIDWp/1DnjIB1UCWao1h0Dw=;
	b=Sm+zkCceErO3nB0QTO5ZJISVLON8F33HwcjC3uE95IYNMUtok3/V1+xn6vyIFp0b0U
	+nPRzVxLY/s760pDhYW+25KecW/ilLO2rI5UDOMa4jmPixZH5pTINu6QT3xKg9HcPvVf
	jC4jxdTplsIhwjmoVnEEFtoweGnGuEEVYd+Uar5gpcjMS3gUU0V7B0U1F0RhyzbB+M1A
	2l9sIz1QxIhw0cHe8WnCWMdVyMJZWeNOfJByHbVMHsGH1Nf9gBu51W8m0WlmZvGr79JA
	EchqwZvfw28GaRpSQm4FrxDCsDwwr8IHZlNceJhChszW91Gv2U3XFUXZpXzyaepnyCUN
	HfoA==
X-Gm-Message-State: APjAAAVNnXRCuDKG9ysdqbvSqFMGn9sLOKsZ330LnEb9bldoe5I6fyVG
	jbT78MdZpGR3Yllu8fmpjXmsEVMxfoo=
X-Google-Smtp-Source: APXvYqwyhxV11gPEn7wxLAn91J1KBbcOHPNAFxVixk310hj7ABYpHGFaCwuznKAnVFgf9WIfh0D71w==
X-Received: by 2002:a05:600c:29a:: with SMTP id
	26mr3604735wmk.112.1556723413228; 
	Wed, 01 May 2019 08:10:13 -0700 (PDT)
Received: from zen.linaroharston ([81.128.185.34])
	by smtp.gmail.com with ESMTPSA id
	r2sm15739134wrr.65.2019.05.01.08.10.12
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Wed, 01 May 2019 08:10:12 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
	by zen.linaroharston (Postfix) with ESMTP id 4DA111FF87;
	Wed,  1 May 2019 16:10:12 +0100 (BST)
References: <20190430165234.32272-1-alex.bennee@linaro.org>
	<20190430165234.32272-10-alex.bennee@linaro.org>
	<357d799d-898f-3e1e-d4cb-beeac89cb528@linaro.org>
User-agent: mu4e 1.3.1; emacs 26.1
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
In-reply-to: <357d799d-898f-3e1e-d4cb-beeac89cb528@linaro.org>
Date: Wed, 01 May 2019 16:10:12 +0100
Message-ID: <87zho65hyj.fsf@zen.linaroharston>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2a00:1450:4864:20::342
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
Cc: qemu-arm@nongnu.org, mark.cave-ayland@ilande.co.uk, qemu-devel@nongnu.org,
	cota@braap.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190501151012.Qk3jWmnl178QGs0GqgwfRpnNsTDtgCYRDYWvjEP4VAE@z>


Richard Henderson <richard.henderson@linaro.org> writes:

> On 4/30/19 9:52 AM, Alex Benn=C3=A9e wrote:
>> Signed-off-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>
>> ---
>>  accel/tcg/softmmu_template.h | 454 -----------------------------------
>>  1 file changed, 454 deletions(-)
>>  delete mode 100644 accel/tcg/softmmu_template.h
>
> Why is this separate from patch 7?

No particular reason, we can certainly merge them.

>
>
> r~


--
Alex Benn=C3=A9e

