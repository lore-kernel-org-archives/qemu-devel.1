Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70066C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 16:00:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3788A20872
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 16:00:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="L+lja4TQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3788A20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35671 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS1l2-00033H-4q
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 12:00:24 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38476)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1k6-0002ek-SB
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:59:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1k6-0002O7-0l
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:59:26 -0400
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433]:43363)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS1k5-0002N5-Q1
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:59:25 -0400
Received: by mail-pf1-x433.google.com with SMTP id c6so5119595pfa.10
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 08:59:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=3Z4z1UXsTwSc5PYfr51o34HXQESGgVAfIkpLjeRueKY=;
	b=L+lja4TQbKSsLWGr6kUmMNqeZDck+0EE+j9paDt6cfgjouOV2axUOHX/AKApaWzxCX
	xim6lhAB4RGpDQd180a2SDEWWtnT5LWfIeHag7cZBXIaorHLN9yFTOFHsMb4VaBVNY3O
	KM39Nvsee7Yj+qN6C7DBmPp3qfdVdNZnozuF5Hp9cUWGxPHzgmp2Ak1qoHKao/8KWGRO
	65qIGpTVsnDkA9+wLPqJ7quF/8clkZ0FowPRBeeaD/NC20e4wBSEabl6lBmF7FClkilW
	QcHm2QF2MiG37CUDs85YKfR72JEzHdfPaWpVW8OTC+EETyJSY86zFUAubusp4G/yUrXU
	9bAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=3Z4z1UXsTwSc5PYfr51o34HXQESGgVAfIkpLjeRueKY=;
	b=NclaCJvs5Uwiuyxce2hLm8nqqo7I5X0VJBWc9iBgGVr7ckwSybD5a6zfwsspGQSZq2
	mCha8EfAy4zOWAOfW7qcoFT732eRO+UKzJGynRip73YeN1u9aaQt4p49J+4W79HJ8EwD
	pt7qsfVVc95a+ujOun9yLepwbNbGvYLAad/9AZGZEsz7z/0UYlANzHtUijVF5zmCPPd5
	Vgb3an9ZNhE8DIpESulgJjjz54Q2Cd1n1cFAzBbAY1rlLJo5bbCsAH8cZzrrllejw7so
	2x/QAHTK639FQHY7xC+uVQz+4bJW6yr+Zuou1xNJanYnjUS6OBeqP4aPBBNYUF1Q5x00
	a/2A==
X-Gm-Message-State: APjAAAWpozPTYvsu3q8kXYag0H3kJyhTSbQWTWT+jsjtudgDEvOc9g6J
	LXyDQiR15x0eFQFpuIOYPPni8g==
X-Google-Smtp-Source: APXvYqxLR+CssAvmEPMDIoOfgcGdpC0h9dcnI9ELMrT4Cf3zh5Hw5PON8GT21kw9dv+uaZZ/cVQx9w==
X-Received: by 2002:aa7:81d1:: with SMTP id c17mr48761595pfn.174.1558195164480;
	Sat, 18 May 2019 08:59:24 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	x18sm16883929pfj.17.2019.05.18.08.59.23
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 08:59:23 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-11-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <7144a83a-9b2d-462c-0797-fbd4584cf186@linaro.org>
Date: Sat, 18 May 2019 08:59:21 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517224450.15566-11-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::433
Subject: Re: [Qemu-devel] [RISU v2 10/11] risu_reginfo_i386: replace
 xfeature constants with symbolic names
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
> The original code used "magic numbers", which made it unclear in
> some places. Include a reference to the Intel manual where the
> constants' meaning is discussed.
> 
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  risu_reginfo_i386.c | 48 +++++++++++++++++++++++++++++++--------------
>  1 file changed, 33 insertions(+), 15 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


