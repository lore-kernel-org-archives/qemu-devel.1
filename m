Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39D9EC04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:46:18 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEFC220645
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:46:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="RbMZZKAi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEFC220645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35525 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS1XL-0004eQ-NO
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 11:46:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1Ve-0003U3-O5
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1OU-00029z-MT
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:37:07 -0400
Received: from mail-pf1-x42d.google.com ([2607:f8b0:4864:20::42d]:43330)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS1OU-00028Z-F6
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:37:06 -0400
Received: by mail-pf1-x42d.google.com with SMTP id c6so5105340pfa.10
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 08:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=zlyFgfYdeS1FGq186HwsOn9aOzq61BXXf4OG1vtQC78=;
	b=RbMZZKAi62K1+p58PwHkRRGg28ZPqnczKOIh3LHR08U2mTxp4WIJnjIVa3bDDIDjAR
	sxjO/c2vApTXMhn/ect+1dj+rAveTtG+v0QtYQ8LBEpS/1dN3/hZxHMk+mXauuPRQvu0
	3L77TvFKrY34PoGk/58oUj7TZhfjXLY32SCezneWZtX2cGIaYRSPX8vgz7F+eqLPFoAM
	zaXu7aRFKRBmWlX1aA5cPAy9SKWj30qm9c1S5DKhYkkJYeUZj1h6RmFTRHQ8bJ8ohaY0
	nWHsMQ87ZnRjQUeKBfzQn3lIaFURDhTC9GNvRHB87YktoD6FICM64P8HpUHtPvTviQkf
	D3ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=zlyFgfYdeS1FGq186HwsOn9aOzq61BXXf4OG1vtQC78=;
	b=HSYew9Z+yTeN+8kehulO9I10a2L5oOdyNhW/2aX9RCRklQzHCrlBwdOHhTk0k0CT2O
	/W1cIHU2pbEnV+UWVb4Pi8AiKOsQzxG28QRsFl/xuZ867ep/iQv5eb+CyK7PrzTu0b8U
	B9RbmqiMwy8DlO9P5Pzh8ehAvREBunnk+sAlw/f/qb+RhSToZW2htD9F9HgRJPzA65bx
	fCMo405nNuBoxLELwaFNBFEOSgyj+jfunwtWBVCHw2Jo8B2RA9uzbRQIS3X6HdWRqO/v
	ei1GKoFZcm1gfj5cYto1lHhjBqJX4Ecc+pr304RZVYwVyK3L9jzn1POmIGlasShLQo8I
	JJZg==
X-Gm-Message-State: APjAAAUyl59dpsEAB0EWJdbxo1faTqSWDJQggTq0ijxg5No15f0QRVA9
	fDHb3HfjnuplHrRV4n4JI9pfcQ==
X-Google-Smtp-Source: APXvYqyUYZcLMzfpCb1c5QLto2OzTWEva9aQh07FzEk7VW/SjQJN9070KsYsc6jOoj3Hi4xjLdcCXQ==
X-Received: by 2002:a63:6f06:: with SMTP id k6mr63048462pgc.170.1558193825278; 
	Sat, 18 May 2019 08:37:05 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	e6sm20450686pfl.115.2019.05.18.08.37.03
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 08:37:04 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-8-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <115e3e78-bc20-82f2-34d3-5f9c9d0fdd4b@linaro.org>
Date: Sat, 18 May 2019 08:37:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517224450.15566-8-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::42d
Subject: Re: [Qemu-devel] [RISU v2 07/11] test_i386: change syntax from nasm
 to gas
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 3:44 PM, Jan Bobek wrote:
> This allows us to drop dependency on NASM and build the test image
> with GCC only. Adds support for x86_64, too.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  Makefile    |  3 +++
>  test_i386.S | 41 +++++++++++++++++++++++++++++++++++++++++
>  test_i386.s | 27 ---------------------------
>  3 files changed, 44 insertions(+), 27 deletions(-)
>  create mode 100644 test_i386.S
>  delete mode 100644 test_i386.s

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


