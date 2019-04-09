Return-Path: <SRS0=I56D=SL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDC14C10F0E
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 20:40:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A15802084B
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2019 20:40:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CgfTnrLz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15802084B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:48868 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hDxXp-0002qG-Og
	for qemu-devel@archiver.kernel.org; Tue, 09 Apr 2019 16:40:37 -0400
Received: from eggs.gnu.org ([209.51.188.92]:53255)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDxWX-0002GI-Dc
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:39:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hDxWW-0003Ik-1C
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:39:17 -0400
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444]:45816)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hDxWV-0003Bw-Ci
	for qemu-devel@nongnu.org; Tue, 09 Apr 2019 16:39:15 -0400
Received: by mail-pf1-x444.google.com with SMTP id e24so10409479pfi.12
	for <qemu-devel@nongnu.org>; Tue, 09 Apr 2019 13:39:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=ON7nVGQd1U92Uq9TPVlwfIR/ndaITgSTUa6S+xHUEHA=;
	b=CgfTnrLzuj3y6ZFtSILE/T968TiWC4Qox9dttTCmjs/9MiAookuoLncEJaMXrO5svs
	JVpm6isVzesGzM71aDdM9WAInaH8tGar54XaM/IhbOovLwyr6tQzrIXlxDiPKZA9TqAp
	BfGjQpFh95ZBJ7SvyZXpDzkQMZ6OhpGdiz09vKz22r8gDWcY8jpsf6nh0Bsl3FrRxFh+
	/5Cp0APrQCrFNGSGIEGyNwbrZusJqZL4/LN6/iwDfHyjx4/cbfUxDry7bVKTQvHSorM7
	kVOPyAZ+ED/WeVBaw9Ljt2v8EH/HaX21pROnVgWn3ug4LVbkDh3OYN12zjlPaT5ZC8Kf
	mctA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=ON7nVGQd1U92Uq9TPVlwfIR/ndaITgSTUa6S+xHUEHA=;
	b=rT3ADv38FmlYh/tS2T0kA5c5yKMyguD8uQfehkBSrJ+MZjPWUbcdAtJ4lwYNzK3vvS
	CAbGHRr/B1+NHG1HW+2RsNze8DhJOfDtKT8rQ4m+MU+baekzIc8NmD11pcM9l/qZ4N4Z
	odx4LiYbw++CTo0vB79kfMe/SEDz9dhk+u/9M15GR6pbsbHyKV3lUASfBuyuOBtINncR
	uLoHfjryTR3RhugIV7enEgvRxkXl69tCPpHJspKGMGH7vYmpbC77WRMDihkQRV1ryG2y
	vKMNO6Vz0i9XvpFsyOWoukWJHmFvB0D1AOm9CvkHrAa19rJB033eWlbBCBSH07Z4jx2M
	WHFw==
X-Gm-Message-State: APjAAAU9wIeUzm/3atTb4uNOeesrXwwpsa9O7Je5l5K3hewdM+S9hvUF
	bX0VbeP7HpUEGWUKr4wNN7GvsQ==
X-Google-Smtp-Source: APXvYqzw1Dlo5EJq1Wo8fPrTqnKkZSB0DIR4ejCV6JXRVOej94tE4HHi7GxBdNCM3A05mwam4/ihIg==
X-Received: by 2002:a63:6193:: with SMTP id
	v141mr37185072pgb.392.1554842354006; 
	Tue, 09 Apr 2019 13:39:14 -0700 (PDT)
Received: from [192.168.3.43] (rrcs-173-198-79-114.west.biz.rr.com.
	[173.198.79.114]) by smtp.gmail.com with ESMTPSA id
	p14sm22905439pfa.26.2019.04.09.13.39.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Tue, 09 Apr 2019 13:39:12 -0700 (PDT)
To: Stefan Weil <sw@weilnetz.de>, =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?=
	<philmd@redhat.com>, =?UTF-8?Q?Daniel_P=2e_Berrang=c3=a9?=
	<berrange@redhat.com>, Thomas Huth <thuth@redhat.com>
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
	<068f4832-7e0b-8850-ffa0-fcf1ecd50295@redhat.com>
	<20190405090212.GF6105@redhat.com>
	<740ce541-c92d-5369-1191-eb73fc861fdd@redhat.com>
	<a53b3bab-5aa4-b37f-f194-7788bce1d04b@weilnetz.de>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <35359e2b-7f07-8815-4f2b-f1435abc4e63@linaro.org>
Date: Tue, 9 Apr 2019 10:39:08 -1000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <a53b3bab-5aa4-b37f-f194-7788bce1d04b@weilnetz.de>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::444
Subject: Re: [Qemu-devel] [PATCH] configure: Automatically fall back to TCI
 on non-release architectures
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
Cc: Peter Maydell <peter.maydell@linaro.org>, Helge Deller <deller@gmx.de>,
	Michael Tokarev <mjt@tls.msk.ru>, QEMU Developers <qemu-devel@nongnu.org>,
	Samuel Thibault <samuel.thibault@ens-lyon.org>,
	Aurelien Jarno <aurelien@aurel32.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190409203908.Bwyo98Zc7W1VuYpx2f1V5A5hL-AAn1BOCqZ4GCfrZ0k@z>

On 4/9/19 9:46 AM, Stefan Weil wrote:
> * Calling conventions. The current implementation works on many hosts,
> but for example not on Sparc. A fix would require simple calling
> conventions for all helper functions (for example stack based argument
> passing, can this be enforced?), or it needs to know the signature of
> each helper function at runtime. I'm afraid that fixing this would
> require much work. A runtime test whether calls of helper functions work
> correctly could be implemented easily and could abort the program
> execution when calls fail to pass the right arguments. Would such a
> runtime test help a little bit?

In the rewrite of tci that I proposed some years ago,
I used libffi for this.

Those patches could probably be recovered...

https://patchwork.ozlabs.org/patch/348528/
https://patchwork.ozlabs.org/patch/348527/


r~

