Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CC85C3A589
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:17:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 578E3206C1
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 15:17:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="B6jKtKvk"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 578E3206C1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42932 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyHVg-0004sT-Am
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 11:17:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35938)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hyHUG-0004Hs-AJ
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:16:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hyHUA-0005uR-Et
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:16:23 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:37767)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hyHU9-0005ty-VD
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 11:16:18 -0400
Received: by mail-wm1-x344.google.com with SMTP id z23so1563708wmf.2
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 08:16:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:user-agent:in-reply-to:references:mime-version
 :content-transfer-encoding:subject:to:cc:from:message-id;
 bh=CKSoQeCMqfHPDVeCAgfZMxfTqtNaEakztdSQT/EZkzc=;
 b=B6jKtKvk9Ri373+kJuOKakY7Q5Na6Yi8/vfYE+eol0rP3ihTL2zRMOhbxTaRMU9xTZ
 ZU4qaWAaY8Iw0Qan/4eHUDPrUlyvIKSR6iP7eoo5E+azgarfvNYxuzbJCpPpiNa16fuJ
 AvmG/YfNvjlE0D3i+6ZGay1mN9EhuV7nWRjOWiLfw8WXJ/55VEqE33ofm16Q8rZSG4Yh
 ZOtrnNvsdFUiAMsAFfTvElFJf97Aq+DHFT3KBfJoJx/cTY1n92XgWZ8m5Oa0pbG0Pkms
 n8Ot0iHAfxNBqVC06m1J0fnmc0r3p58Q4GLHYfd5hf3EAMpbYTZPmqDdzUrCWk5f+UAj
 fY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:user-agent:in-reply-to:references
 :mime-version:content-transfer-encoding:subject:to:cc:from
 :message-id;
 bh=CKSoQeCMqfHPDVeCAgfZMxfTqtNaEakztdSQT/EZkzc=;
 b=B+Lztm4ypTBgns9Yu8MjOoFgMcXhhnDheU5Rn5pxpXugNsiWCZd933kXjaq3BkZ87e
 kX4FJn4xEU/Wgt8VH/AIVhvbY/t/DgYs3QnObrlbK1p9sR9l9zEpVz/gmGKHhNLdlVrz
 FApkPWe6TYuVf6ah4eXvDvOX6r5c/bNUkDkrGHrAiopHVAI8UViyOzfkMoIFLuy6dctY
 wjoFZbNMh+0D7sqEU4SVPSLXblLi/JIm4KiiqKeK/1z7cVZ6CXMq9D1vkHwX4PzOs3tr
 OIyvnwBLqqwez0yM+ZUlejAKnxkEcBfQGDDoqU76HeLLZ7ZErguDjUDGkQVskVcUzAFu
 ZqIw==
X-Gm-Message-State: APjAAAW78Pdv1CAh4xsIsdumxd5w6xrvPQsaQ0a6U2P5tI51JwBCz9Fs
 ipAmYbR7BjoGq1ZMh39BXVTr6g==
X-Google-Smtp-Source: APXvYqxgkEcZTEZLwwKw4eJfJj9h0nWDf8vSHNIwdtTxbXKGD7M6/MU6+Q6MKnQOsIGr6VZu2MiLvQ==
X-Received: by 2002:a7b:cf2d:: with SMTP id m13mr3271311wmg.120.1565882176690; 
 Thu, 15 Aug 2019 08:16:16 -0700 (PDT)
Received: from [10.254.112.49] ([94.119.64.8])
 by smtp.gmail.com with ESMTPSA id x24sm1478356wmh.5.2019.08.15.08.16.16
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 15 Aug 2019 08:16:16 -0700 (PDT)
Date: Thu, 15 Aug 2019 16:16:10 +0100
User-Agent: K-9 Mail for Android
In-Reply-To: <CAL1e-=jNu8w-9wgkz5Ug-uZKWreEY=6EqD_cYN_KY_qXfn2TPQ@mail.gmail.com>
References: <20190815020928.9679-1-jan.bobek@gmail.com>
 <20190815020928.9679-16-jan.bobek@gmail.com>
 <CAL1e-=jNu8w-9wgkz5Ug-uZKWreEY=6EqD_cYN_KY_qXfn2TPQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
To: Aleksandar Markovic <aleksandar.m.mail@gmail.com>,
 Jan Bobek <jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <FAFB0922-2E01-4945-A45F-2C98456C57A8@linaro.org>
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [RFC PATCH v3 15/46] target/i386: introduce
 function ck_cpuid
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
Cc: =?ISO-8859-1?Q?Alex_Benn=E9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On August 15, 2019 4:01:33 PM GMT+01:00, Aleksandar Markovic
>
>The function should be called check_cpuid(), imho=2E I know, Richard
>would
>like c_ci(), or simpler cc(), better=2E

Now you're just playing the fool=2E  Cut it out=2E


r~

