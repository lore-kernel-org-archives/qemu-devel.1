Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B369C432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:27:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1349420718
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 18:27:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wbFA0cfg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1349420718
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43084 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibqPo-0005Pd-9D
	for qemu-devel@archiver.kernel.org; Mon, 02 Dec 2019 13:27:20 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:60557)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibqP6-0004rV-S6
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:26:37 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibqP5-0002Ws-Ss
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:26:36 -0500
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:46477)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibqP5-0002Vg-LV
 for qemu-devel@nongnu.org; Mon, 02 Dec 2019 13:26:35 -0500
Received: by mail-pl1-x642.google.com with SMTP id k20so270303pll.13
 for <qemu-devel@nongnu.org>; Mon, 02 Dec 2019 10:26:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=aGJgiHH9sd1ke5gnSsQDTZuuqeW60GiMKpvcK0Se2Rk=;
 b=wbFA0cfg9jMunP65qtn8Bc1FH2baEVFtUo6E4C01kcsKJxC0elBMKufSbMAB2XkjXz
 wud0TC3SiSK7UBncKEc33NmvO7psra0r0YiGk0oUrPJ1Svvj3bIVrkbtO8Opobh4L2Tk
 nAwUr1ON/flvPyhJhvwSX7WsXh7qb2Q/gOR0sniMxHauhp7eHiYnnjTdGsuRW79Q3x7X
 ISSHGE3HO58U0/DVAc19HhGAThNdvu71ze1SRoOGNgz34ojWyTl9adv6+06RmKtQ7MKM
 grmHzglvqWpG+BYbbDLAFzgoXHgh4FXqaYpRo72O2KuC8WPtaXOGwYCA52G8+cg3inNJ
 tJ1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=aGJgiHH9sd1ke5gnSsQDTZuuqeW60GiMKpvcK0Se2Rk=;
 b=BKM5N8SQIBLFVgCbr3zGte9dKRCE9Up3ZIdI6mmWMyTLTgJV5IxhpBByEKTKC0QS59
 dF66ibHnNkiufaXoaV0hDkzbFdpZBaK0XzvhlJKpFcnfRKqVeovENg5dkAGw56QwoxOw
 V9U/oG/UJJ1+djppHSqQRje6Sf4bKU7Jpp5bva3dsN5ksakmN/z3o8VA6IyFyhy3Q8bm
 nAIw1KHfxUl+VtdRpK6UdYfW287mEucOhoEJl4oEY+iuTyVI8mHcSk9y0porRWPM6gKf
 5ehCWB1ZyJODdOYPl3TYpVyPlGKzr2H7RAwT1DWg/Ziw/mYJ76Tih0o1xOmKt7gA3dEk
 Xzrg==
X-Gm-Message-State: APjAAAX9+0OM3msntoGRYpCtw4MMdd1NB1Jnd/HxcmA4zUxwgLaIjFxm
 4wnMixsZ59FOSCN6Bt9Fe80zNQ==
X-Google-Smtp-Source: APXvYqw4rG2Z2KWwfgK5P1Z7QpqglitI/r7ECdLCnnd78swk7kYEyuyLpkH1LL9bL7967OKvVTsSxA==
X-Received: by 2002:a17:902:104:: with SMTP id 4mr636294plb.130.1575311194391; 
 Mon, 02 Dec 2019 10:26:34 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id y3sm145344pfe.183.2019.12.02.10.26.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Dec 2019 10:26:33 -0800 (PST)
Subject: Re: [PATCH v2 09/14] target/arm: prepare for multiple dynamic XMLs
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-10-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <7d088175-4b98-bd03-75db-f19b8a31bf8d@linaro.org>
Date: Mon, 2 Dec 2019 10:26:31 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191130084602.10818-10-alex.bennee@linaro.org>
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
Cc: damien.hedde@greensocs.com, Peter Maydell <peter.maydell@linaro.org>,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>, luis.machado@linaro.org,
 alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/30/19 8:45 AM, Alex Bennée wrote:
> We will want to generate similar dynamic XML for gdbstub support of
> SVE registers (the upstream doesn't use XML). To that end lightly
> rename a few things to make the distinction.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  target/arm/cpu.h     | 20 +++++++++++++-------
>  target/arm/gdbstub.c | 30 +++++++++++++++---------------
>  target/arm/helper.c  |  4 ++--
>  3 files changed, 30 insertions(+), 24 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


