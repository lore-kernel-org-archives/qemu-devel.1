Return-Path: <SRS0=FHOf=VI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A934BC74A52
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:12:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 51F3E20872
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2019 13:12:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ANvkgU4T"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 51F3E20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41680 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hlYs1-0007OW-Lm
	for qemu-devel@archiver.kernel.org; Thu, 11 Jul 2019 09:12:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37093)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hlYr1-0005cC-Gm
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:11:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hlYr0-0002dS-Ea
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:11:19 -0400
Received: from mail-ot1-x342.google.com ([2607:f8b0:4864:20::342]:35919)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hlYr0-0002cp-8S
 for qemu-devel@nongnu.org; Thu, 11 Jul 2019 09:11:18 -0400
Received: by mail-ot1-x342.google.com with SMTP id r6so5782198oti.3
 for <qemu-devel@nongnu.org>; Thu, 11 Jul 2019 06:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=mczWfSW55ig6OvXuOUuZdsyjsyf6sl5F2LJGqmPkqHE=;
 b=ANvkgU4T8RipNgiwhDLmUYUtfGuxYGHBSkjjX/CFN5tfItiJZ9YSPBxYt3osAugeQC
 gjgT6R/TfzJprmgkAL2xvN6sWELrgwyciEgw1E0JIyytZiJqg98HoKf4ohnlX89XJksw
 CvexALKSTrIDsU28cf6L6Pm/53VQg4PHtgIAKnoPqFoTCZhGeZ7+xlJZmd3I/JKWTzUV
 ac1TqbACxH98sLMIcoMU5eryxe+hQbTAZVv9WBp8Fu7bmnkt+b97mOvz8QSMtB868IX1
 /vyhy6AguQGMwL7WczO8V4jM9hXh0715oqqo26auVlaFSLLLEOxYSnuaSOL2ImuggZZE
 7www==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=mczWfSW55ig6OvXuOUuZdsyjsyf6sl5F2LJGqmPkqHE=;
 b=JcxwwwbO+S5l7UlH86j9hOHEvl/GPD6V0lW/NpZ8X9/zgTSR1O6DG4XX1rEMMS7MxG
 aBoT84W7ZXFzPKJwtsILV1ZgBMU2EK5JvbCpJmMNlY71J/Sa3iKrYbrU4u58OngTuGLr
 rjrmXTHM8EfIUhF5cpCPC4USmMDzKBIerd0mwCX20yRtbfnl+Dqjt7k3kR9LXSWCNowg
 NtYBXdvlu7v2vxpN9UyPgCBkUCIQYMYcQzGx+3CS5TlSXCHj2B5eTb82MdrJS9gYfLaq
 g6Ou77BTIUAvrW+cTKqnj3Cja90QGdl+iHEUs+IVyfRLvHdb92MOtwd6tj3s2eE25pDH
 YoNA==
X-Gm-Message-State: APjAAAUNrz1iyPxSFl0q5rrVYiAoUKpdN2uWEwh2rI+1uqnZMvnRHEOo
 VGUijthg64WJbFQDHcfY45orGiL2+HD3ew==
X-Google-Smtp-Source: APXvYqyb4CiMXd/czrX5XwudeZnmMqAJY5P4ugVUy6IxpbvBVyT9UOUCfF5WaNH5y1H+3tXmlTC9Og==
X-Received: by 2002:a9d:5615:: with SMTP id e21mr3476569oti.152.1562850677617; 
 Thu, 11 Jul 2019 06:11:17 -0700 (PDT)
Received: from [192.168.43.94] ([208.54.86.238])
 by smtp.gmail.com with ESMTPSA id w9sm1821727otk.16.2019.07.11.06.11.14
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 11 Jul 2019 06:11:16 -0700 (PDT)
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20190711124805.26476-1-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <4f84baf9-e4ff-aa51-810b-34e2d86d8cd2@linaro.org>
Date: Thu, 11 Jul 2019 15:11:09 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.1
MIME-Version: 1.0
In-Reply-To: <20190711124805.26476-1-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::342
Subject: Re: [Qemu-devel] [PATCH-for-4.1] tests/docker: Install Ubuntu
 images noninteractively
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/11/19 2:48 PM, Philippe Mathieu-Daudé wrote:
> We correctly use the DEBIAN_FRONTEND environment variable on
> the Debian images, but forgot the Ubuntu ones are based on it.
> 
> Since building docker images is not interactive, we need to
> inform the APT tools about it using the DEBIAN_FRONTEND
> environment variable (we already use it on our Debian images).
> 
> This fixes:
> 
>   $ make docker-image-ubuntu V=1
>   [...]
>   Setting up tzdata (2019b-0ubuntu0.19.04) ...
>   debconf: unable to initialize frontend: Dialog
>   debconf: (TERM is not set, so the dialog frontend is not usable.)
>   debconf: falling back to frontend: Readline
>   Configuring tzdata
>   ------------------
> 
>   Please select the geographic area in which you live. Subsequent configuration
>   questions will narrow this down by presenting a list of cities, representing
>   the time zones in which they are located.
> 
>     1. Africa      4. Australia  7. Atlantic  10. Pacific  13. Etc
>     2. America     5. Arctic     8. Europe    11. SystemV
>     3. Antarctica  6. Asia       9. Indian    12. US
>   Geographic area: 12
>   [HANG]
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---
>  tests/docker/dockerfiles/ubuntu.docker     | 2 +-
>  tests/docker/dockerfiles/ubuntu1804.docker | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

