Return-Path: <SRS0=Ux9P=SI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D48C10F06
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2019 09:00:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A12DA21855
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2019 09:00:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FuUnLrO0"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A12DA21855
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:52449 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hChC1-0004WM-Mn
	for qemu-devel@archiver.kernel.org; Sat, 06 Apr 2019 05:00:53 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52547)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hChB8-00044a-Hw
	for qemu-devel@nongnu.org; Sat, 06 Apr 2019 04:59:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hChB7-00072o-Jf
	for qemu-devel@nongnu.org; Sat, 06 Apr 2019 04:59:58 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:41418)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hChB6-00071j-WD
	for qemu-devel@nongnu.org; Sat, 06 Apr 2019 04:59:57 -0400
Received: by mail-pl1-x642.google.com with SMTP id d1so4344765plj.8
	for <qemu-devel@nongnu.org>; Sat, 06 Apr 2019 01:59:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=k8fMmkRO9gjH44jPQ/D16lhgb3aDjyntu9xjH7rcW6k=;
	b=FuUnLrO0OJTxjAc4c2jhu8YS8jxhx3Vqes0mniY5fWCgGyrls5r/wcDu1rz0yYm6mn
	x2zh48FoP/7vv4Te84XvjPhXw7hoWsZfaeKu9ExGDlBWn4AJIj5BmeOn3tyrf1KtYBb8
	VmQoinBxfE6dlmT7x5u0ZYPAUXB1QFS9tcOSDzP/ZeHF8mW7QAV2P3cevygIqcaM93t3
	7SdTk4VnkQNwlT6iPLqACdg+vm8lGsZosUq86wRU0imxXvH45JB0/zonGhl40kNA7JW1
	v/eRSFI768EVTuNjZ6KC6iJuburA5B8kFNFL+0YCi32be1mi8dnkyJxdIgCZ+iGH4Z18
	SCEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=k8fMmkRO9gjH44jPQ/D16lhgb3aDjyntu9xjH7rcW6k=;
	b=JqUOELqqjgRz6irA0vUs9W8p8x+6suTfBe0ju+T4EMIIUKxlG6ZKa8RCvkozfCoJxo
	/OkfrhDtc6ve8ETsHK5ehmru168XN78TnINrCJ5fe0GdZPHUlFrNFQiX1jO0AUa3S2Qi
	LOo65SiXygWnCQO/ER5eJlYemMn5/Ik9nIEuKeGX/YCUiW5mVNsGtosc8VF+IZpwTwLr
	7VNPJKGz5spl6Z2Bb6gjhlQrfxnqV9kIIvzcFw54LGNKI54SwEEM2j94khp5aqGg+Vjo
	F2j3ndEaupoV5N8KqTX7GOBTni8l1qckYKkEICtIUGfRNXSwBviyql+39bo//C6W3yv7
	on/A==
X-Gm-Message-State: APjAAAXILtL8HOLTZP/IMTJRBkE3vbEZnOa/IrnvL9924lLy6bIpfbZt
	wC/8wZa8uV0A+ae1fcy9KcBHIV9Y2DGQKg==
X-Google-Smtp-Source: APXvYqz42LJTwt8r98G2IH2bDtEAgGuX5zM/V46gIqWQiZK67dF9W5mW2AV9/gcKJ76fFTcmGfRnWw==
X-Received: by 2002:a17:902:1003:: with SMTP id
	b3mr17531463pla.306.1554541193886; 
	Sat, 06 Apr 2019 01:59:53 -0700 (PDT)
Received: from [10.59.8.239] ([61.200.20.122])
	by smtp.gmail.com with ESMTPSA id
	k9sm32141857pga.22.2019.04.06.01.59.50
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 06 Apr 2019 01:59:52 -0700 (PDT)
To: Helge Deller <deller@gmx.de>, Peter Maydell <peter.maydell@linaro.org>
References: <20190404185730.GA22512@ls3530.dellerweb.de>
	<CAFEAcA9xP8CtXEruuzPHCyuDT5EyMMHFGdCJdfFBhX+C2Jr36A@mail.gmail.com>
	<b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5c330405-d3e3-f737-91f0-fe4de3edd576@linaro.org>
Date: Sat, 6 Apr 2019 17:59:47 +0900
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <b48c6984-f0fc-a597-53a0-4869c822ce73@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
	QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190406085947.W2RsUMnzhY3VCORYmv7VvspEeuv4XbCv8W2gIIGccYk@z>

On 4/5/19 2:56 PM, Helge Deller wrote:
> Looking just at some of the debian "ports" (non-release) architectures:
> alpha, hppa, ia64, m68k, powerpc, sh4, sparc64

FWIW:

sparc64 does have a tcg backend.
(Indeed, tcg/sparc does *not* support 32-bit cpus!)

powerpc does have a tcg backend, and it has both 32 and 64-bit users.

Both hppa and ia64 used to have tcg backends, and could
be resurrected if there was a will.

I have a tcg/alpha backend that I haven't bothered to
merge, because I assumed there was little interest.


r~

