Return-Path: <SRS0=bvyN=TX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B756CC282DD
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:23:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7C732206BA
	for <qemu-devel@archiver.kernel.org>; Thu, 23 May 2019 15:23:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="j8D98lrr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7C732206BA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38764 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTpYt-0002JL-JL
	for qemu-devel@archiver.kernel.org; Thu, 23 May 2019 11:23:19 -0400
Received: from eggs.gnu.org ([209.51.188.92]:43048)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpUb-0007rC-SM
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:18:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hTpUb-0002E4-1U
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:18:53 -0400
Received: from mail-ua1-x944.google.com ([2607:f8b0:4864:20::944]:36975)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hTpUa-0002DU-Se
	for qemu-devel@nongnu.org; Thu, 23 May 2019 11:18:52 -0400
Received: by mail-ua1-x944.google.com with SMTP id t18so2314833uar.4
	for <qemu-devel@nongnu.org>; Thu, 23 May 2019 08:18:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=f5vBD+FZ7NuANb7Oj2G0VgFK4oUSAX1dsfmXQ+9pWww=;
	b=j8D98lrr7plfFBABsOmxS5xX7trs1QqQSdlOqzwWPN9mWm5ghh9m2y6m21F9s7RhoY
	XIaaFuUN3DY5pZnL3Bm88z82oDXBCEFTquwIWFiRnMmSKGX/8Mp4x8+2ujbqCz4i5Dk3
	0Vp8vCjT8jx2xNmT42zIxd7Hi0e0zEoyx28FXRm01jxQvu10GdjTz26BvC1M/rG0L73b
	+yot6Z6DHLnP2lr0XmaOU3tGYznyq7B9vckoK0A5GZ8zB+BmTEYn0I1i47Zicd/ml+bz
	NJ7+zPgHR77G5RmBlLD9jG6gv+gVBgEdaTaDKOQ8yoUQbDQhtIQRUyGvODuMFjAhEOq8
	Alnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=f5vBD+FZ7NuANb7Oj2G0VgFK4oUSAX1dsfmXQ+9pWww=;
	b=jX3xhte41rtjVa3qTnTKjnd/llgI3Ur0wAAZpDNewAOhrIAY9hsmcBwtaWcPwww9/j
	sZj1xZGNJe/v1RL4XM/C2WuH5A3UH+a1RE/0Ef4MOvVFdWW38TMJVU8h7XdnHlIxd06E
	ekC8fYjDYJtDxx3wXDh9UZgWTXQqkZDGy9QJYmxyKSxSX4RMSxiiLgcXXkHiRsqYEBPk
	lO6FkcGLOAm87En4oXRZsv7+m9boav2k13UZBtXg24z9VxIpQJy3UeL5TZXiAvq7AM1i
	ZIq5rH3tlCB9+2mFq9HC9Nkpxl2bzejKsXGijVLwo5r0u1LtPhNTvxeRWI6pUdtZY1kO
	qM6w==
X-Gm-Message-State: APjAAAWMrN4TWJ9twDRJIwWGJ8tnQS2lIiZ7nzTRKvRk6px/KM4RrSIB
	ACJ44aDM+tJjU7cslVURH3085w==
X-Google-Smtp-Source: APXvYqxwhUUD66VWpXBmmCn+G/Vt4f4iVXZb/jSee01l1dm/Ls0BMUf8X7lNSmkMlD7vq+p7Kb23Sw==
X-Received: by 2002:ab0:3406:: with SMTP id z6mr7825767uap.102.1558624732090; 
	Thu, 23 May 2019 08:18:52 -0700 (PDT)
Received: from [192.168.43.94] (ip-173-130-215-183.orldfl.spcsdns.net.
	[173.130.215.183]) by smtp.gmail.com with ESMTPSA id
	x10sm5989669vke.49.2019.05.23.08.18.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 23 May 2019 08:18:51 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190523102532.10486-1-alex.bennee@linaro.org>
	<20190523102532.10486-8-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ac9074a9-0560-e83a-4118-faaf4a228a04@linaro.org>
Date: Thu, 23 May 2019 11:18:48 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190523102532.10486-8-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::944
Subject: Re: [Qemu-devel] [PATCH v2 07/28] target/arm: add LOG_UNIMP
 messages to arm-semi
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
	=?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/23/19 6:25 AM, Alex Bennée wrote:
> Clean-up our unimplemented bits with a proper message.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  target/arm/arm-semi.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

