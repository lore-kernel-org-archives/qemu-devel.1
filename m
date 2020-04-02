Return-Path: <SRS0=DsKm=5S=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F10BC2D0F3
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:20:19 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BB802078B
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Apr 2020 17:20:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Q48eN1qI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9BB802078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jK3Vp-0002Km-RD
	for qemu-devel@archiver.kernel.org; Thu, 02 Apr 2020 13:20:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45064)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jK3Ta-0000PY-Dt
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:17:59 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jK3TZ-0007Ip-7p
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:17:58 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:32911)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jK3TY-0007HJ-PQ
 for qemu-devel@nongnu.org; Thu, 02 Apr 2020 13:17:57 -0400
Received: by mail-pl1-x642.google.com with SMTP id ay1so1591771plb.0
 for <qemu-devel@nongnu.org>; Thu, 02 Apr 2020 10:17:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qNMuSy6myQERHMzlzFwavqf8HUhcKDEUQ/y2TeKt/W8=;
 b=Q48eN1qIgfBSGB008QFETon0+zBn6G9va49ZXitU7SxtMMMRvrgNFxbImGvgaeXuam
 6uvEBGM/PJaaxa9Tl5s4RixZJ7/DX4uNyJRHl/0SuxyP/NkUpPoyqdr4H+zVMEJAxoFF
 qJ7VzTdhqNeIok6CSOa71kXrkFLBqw0Ln/i5dX0xrmlBl4Woic9dsWZoLTwcFtz914CL
 WId8Jr+n7qM50K1VWHHDIfDwdO1M1fBdKTNAA7fsJyHncVbd2WjpJBmCsUrf1XKEU14m
 XJWvmE6QICPXfR7gC3Gz6FXezz6H8SvSZVxRJh5jpCUGT4yXL1Y8VgFFJvbx/IR6SDW4
 Mwfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qNMuSy6myQERHMzlzFwavqf8HUhcKDEUQ/y2TeKt/W8=;
 b=b07Judcd3ljnqdBF2hxBmAy/Q49Va7O+34rytRFShlIAnnN3ck6TuhSdplq847/78b
 kEi6An5rtoy+qIfFuaj7scuWNq4pLH+cnbK47GubxQ4MItAtzBUrcZ7DKbJlQMsiTx00
 iB3DJymy4LebzCybbsXp87e3HUILkslq+hBXtWYTPj11z0wBpbnZuysvg/206Y0pyE7v
 cenFN63NOsLlHcRY4WqshrixvMyXiV6+PYIZje4BMkR54sVQ9S9ChWROUe4aqJKDbLl8
 ZSgTO2yFpVvkR74/QzVXNOxwSQ0DrhwUdPC0+/ucWYzaqa/lodli3ewmtJlKyEP/WKtW
 QgxA==
X-Gm-Message-State: AGi0PuZffuM+XZ+RCDfkAOM8oA9x8oATMH3ZejX/jd8xcpXzK1Ea/r2Q
 KpCIplq98FUWB+OEdzv4q/M8aA==
X-Google-Smtp-Source: APiQypIsfrFFHbcxytlP/1obJ17DVib2VGdCFwq7Rl//gsK9WvUTmh2+cNLxdWp26tIk8M2ugY2P5Q==
X-Received: by 2002:a17:902:7d8f:: with SMTP id
 a15mr3771722plm.265.1585847875560; 
 Thu, 02 Apr 2020 10:17:55 -0700 (PDT)
Received: from [192.168.1.11] (174-21-149-226.tukw.qwest.net. [174.21.149.226])
 by smtp.gmail.com with ESMTPSA id h198sm4104607pfe.76.2020.04.02.10.17.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Apr 2020 10:17:54 -0700 (PDT)
Subject: Re: [PATCH] target/arm: don't expose "ieee_half" via gdbstub
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
References: <20200402143913.24005-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <e6b3a94f-b7db-942c-2611-c9881c2da5d6@linaro.org>
Date: Thu, 2 Apr 2020 10:17:52 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200402143913.24005-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::642
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
Cc: peter.maydell@linaro.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 4/2/20 7:39 AM, Alex Bennée wrote:
> While support for parsing ieee_half in the XML description was added
> to gdb in 2019 (a6d0f249) there is no easy way for the gdbstub to know
> if the gdb end will understand it. Disable it for now and allow older
> gdbs to successfully connect to the default -cpu max SVE enabled
> QEMUs.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/gdbstub.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


