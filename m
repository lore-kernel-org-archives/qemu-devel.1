Return-Path: <SRS0=Huu6=TF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A62EC004C9
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:58:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F171B20578
	for <qemu-devel@archiver.kernel.org>; Sun,  5 May 2019 15:58:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="VsWFJQp4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F171B20578
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42892 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNJWb-0005hU-BO
	for qemu-devel@archiver.kernel.org; Sun, 05 May 2019 11:58:01 -0400
Received: from eggs.gnu.org ([209.51.188.92]:51257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNJVs-0005ON-BZ
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:57:17 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hNJVr-0007rW-IT
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:57:16 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:40782)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hNJVr-0007qu-AZ
	for qemu-devel@nongnu.org; Sun, 05 May 2019 11:57:15 -0400
Received: by mail-pf1-x444.google.com with SMTP id u17so5395535pfn.7
	for <qemu-devel@nongnu.org>; Sun, 05 May 2019 08:57:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=tfseUPVwJfnkM46NBjNzE/2kVrTg4W56a2JB0VNrNkw=;
	b=VsWFJQp4Ii8k+Ve/Ji6Q7GeAOXbyzj4ljNlSWVWhICTvEi0veMp6T5gg0ji8ksnpeS
	qLFsLhC/dBfwYcvRr0zlqlJLGUe1yKu5GkknHv1cEfXDpYfh1+N23qfYHrF3dKk5kmBh
	Om1+8iN2C0TiIG+u9FqEpo/t7nDjoI4X7tU0U7/IWIfUN/JdMqltt+nMXXR7SGtoND82
	uSyqTqbwsrhLp0+10Zzdm18EvvroiX7RVX7McRSybAM0j/RqbiCmq+0nQ2MsO0zIKakT
	hvnOkakSvXX66JqcdRwegrkiFgRfN3Te9SEgYcGLWRXEp1eWAbA8X4Oor2bSLQwu5pfg
	i+pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=tfseUPVwJfnkM46NBjNzE/2kVrTg4W56a2JB0VNrNkw=;
	b=kzt0yHxL9j2IMTL/x5pm9DHrJY2wOeVirjI2dWzik16LquD5R9zHRuLyKwktFtbavQ
	lkZGtwWi58i8liboKvcWZxe2rDM2/x+FzdBWLb1VFeCPFYarbigqR4YEmeu+qbwTlUW8
	Z1KnFFHwD/qqwosq8VL974Z14og7fHfZX7yXjLYNzoU8Sqt1eeeE8rEDnw2hFjxtKGsc
	GXbtxtp5OrJzSGuwf80klX4jU72R0IK+x+LeEz5+DfWVGVjyKYQfUIobfxl2sZZHxl6E
	P2NwZxUNfQoaKROw7Q+4m2/DO5zaSuIZHE3DjsaH9X0L+l8e2wXQyXWNevMFpPewDI6I
	wmkw==
X-Gm-Message-State: APjAAAUbsFAsqhAkDxjVG62JAF++0UuRt2MkkkyA/2k+iT07IjcrFgp1
	oBDMzWlQOMY8xBHJj9FcruO0cQ==
X-Google-Smtp-Source: APXvYqw3RkiQ97xzKrTD4JCj3+aKJeW+OCtZOMaeTSKN1TxV6IZ7ZH1wUKX5dPkD/38IU7AE+FMlfw==
X-Received: by 2002:aa7:8092:: with SMTP id v18mr26493902pff.35.1557071834044; 
	Sun, 05 May 2019 08:57:14 -0700 (PDT)
Received: from [192.168.1.11] (97-113-189-189.tukw.qwest.net. [97.113.189.189])
	by smtp.gmail.com with ESMTPSA id j2sm9535994pff.77.2019.05.05.08.57.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sun, 05 May 2019 08:57:13 -0700 (PDT)
To: Sarah Harris <S.E.Harris@kent.ac.uk>, qemu-devel@nongnu.org
References: <20190504083638.13380-1-S.E.Harris@kent.ac.uk>
	<20190504083638.13380-9-S.E.Harris@kent.ac.uk>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <c05b4876-c55e-fd82-46d0-83be1b128cee@linaro.org>
Date: Sun, 5 May 2019 08:57:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190504083638.13380-9-S.E.Harris@kent.ac.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH v1 8/8] target/avr: Register AVR support
 with the rest of QEMU, the build system, and the MAINTAINERS file
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
Cc: A.M.King@kent.ac.uk, mrolnik@gmail.com, E.J.C.Robbins@kent.ac.uk
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190505155711.toNp0oe9TyU8-7lPIWzAKf7LR5x6_nWgW8Rp2lMNWUc@z>

On 5/4/19 1:36 AM, Sarah Harris wrote:
> Signed-off-by: Sarah Harris <S.E.Harris@kent.ac.uk>
...
>  
> +AVR
> +M: Michael Rolnik <mrolnik@gmail.com>
> +S: Odd Fixes
> +F: target-avr/
> +F: hw/avr/
> +

This is not how things work.  Michael wasn't up to maintaining the code 2 years
ago; that's why it was never committed.

You would need to maintain this yourself, and for more than "Odd Fixes".


r~

