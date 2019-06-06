Return-Path: <SRS0=9X/F=UF=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC39EC04AB5
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:11:59 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97EEA2083D
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Jun 2019 16:11:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h6mOQuAZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97EEA2083D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:34804 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hYuze-0008Ph-NJ
	for qemu-devel@archiver.kernel.org; Thu, 06 Jun 2019 12:11:58 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52462)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYuyx-00086v-E9
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:11:16 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hYuyw-00072J-Hb
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:11:15 -0400
Received: from mail-ot1-x343.google.com ([2607:f8b0:4864:20::343]:40497)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hYuyw-00070g-7u
	for qemu-devel@nongnu.org; Thu, 06 Jun 2019 12:11:14 -0400
Received: by mail-ot1-x343.google.com with SMTP id x24so2471056otp.7
	for <qemu-devel@nongnu.org>; Thu, 06 Jun 2019 09:11:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=k5Plzmy6lPMyUc51cIFvBpGFWuxyz7GI+DkEElIjxxU=;
	b=h6mOQuAZQpsKV9va1MS3sk0Nlg/PxwTpyWcyGrbKxYaWeYtls7Q0nSr9Z7jKKC3Dc7
	K0I/iEbjBMXhth8wjUHZrJgx44QsBcltFNC+tmV2CUv+MBO/rAEE1QzAN0ZWYKq23Mhz
	R2yzYdFn4x8nbBK4q/KoATUnH3+KDbogsC9iKRYlNnDZpH5Jse/PO3xOrrtS07cA4ywN
	VfmxkjyI+0KUUYOmK+O8CwrsqbziYR6SDcWf7IoYd88nSxIV8HjKWI4kaeCsegdvkLz3
	OIrVv7zdZ8a85LT+JJYb5dCK+NXX73T4BxDxUEqEFIUdlmiX4u/NtFMNrVR0so4DJUfn
	+8aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=k5Plzmy6lPMyUc51cIFvBpGFWuxyz7GI+DkEElIjxxU=;
	b=nNO0M6UAMIkeTgdWMuqBxHa/8Xs/+lQ1kd/hsA9p+tUtDZBNFet+DmIcOfrOShy2wa
	FcvouUilgugQj/hokRKaF65KpocOgw4Mui/V6FhAfyrxcfv75dOeBPXOEmCTe8weFE9+
	mx+ab17bAjLw1iy7rS6c3BBmjN6VyxXyC5eGJ2npuXsAlms9YzGY0bAwvcqJHc0wdzW7
	BqnB99L0HDgO6vKNCm+vxbo8l/zkrs5HrkdxwetqMJoen/qVsfeDa+s0zY8ecKgdPoFQ
	mOY2B2KDov9Cj0vTh05SqLkxRZf+So9+CDE7rpfaDwSOGWEpviRqNPcM0uolTX1oZmZR
	XftA==
X-Gm-Message-State: APjAAAU5rcDy1qNn8zw3ou/vRPM3N8N4R+j3SNfi0NI0yhrRJLB27ZQD
	wf1yaJuU73PYSAV/8ucvrTbgmX4rcBBvvQ==
X-Google-Smtp-Source: APXvYqxMeJ0C8AcoXDpw253d/YrySlLA/OtduFK0P04zBGsThAF2Ebd4tO5oGZxPo3IlSYHTcPyORA==
X-Received: by 2002:a9d:5788:: with SMTP id q8mr10074916oth.237.1559837472557; 
	Thu, 06 Jun 2019 09:11:12 -0700 (PDT)
Received: from [192.168.3.43] (200-56-192-86-cable.cybercable.net.mx.
	[200.56.192.86])
	by smtp.gmail.com with ESMTPSA id m17sm742952otl.38.2019.06.06.09.11.11
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Thu, 06 Jun 2019 09:11:11 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
	qemu-devel@nongnu.org
References: <20190606082900.6330-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <651d6e2b-a15d-cda4-78a2-700d4cbfb277@linaro.org>
Date: Thu, 6 Jun 2019 11:11:07 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190606082900.6330-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::343
Subject: Re: [Qemu-devel] [PATCH] MAINTAINERS: put myself forward for gdbstub
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/6/19 3:29 AM, Alex Bennée wrote:
> As I've been reviewing a lot of this recently and I'm going to put
> together a pull request I'd better keep an eye on it.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  MAINTAINERS | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~



