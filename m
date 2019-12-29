Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A689C2D0C8
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 02:56:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 29E97206F4
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 02:56:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xhdSf+ie"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 29E97206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48702 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilOkN-0000gl-8G
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 21:56:03 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52993)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilOjh-0000Ad-I0
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 21:55:22 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilOjf-0000yV-Ro
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 21:55:21 -0500
Received: from mail-pl1-x62e.google.com ([2607:f8b0:4864:20::62e]:38224)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilOjf-0000v6-KP
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 21:55:19 -0500
Received: by mail-pl1-x62e.google.com with SMTP id f20so13341682plj.5
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 18:55:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=AQ5wuWBkttqWMjzeFk3QomgPdhj10I/gl23e6kMq94s=;
 b=xhdSf+iecpNeeGVwG0otkJI9H72zCUX16A5CwbcMsMmwt00kPYe8nQ1UPyGSP/XiMX
 3x87StfF9KsNkdbB+Rbovzm87n1iRHQpfT1P13AfqDaL9NavmGuyrOc0FwwwI9o+Jdht
 iNEmERIOgPD13LEU0Asc1/o7VomWkzyAZzSy2RTVrZNWxTW+cjfWiTE+E7CpQVipzaDU
 XtlLfCC5DXYAp4K/iSyPA/XAPjMb/Sz1ZzcuGOFbbN5Tqbx3wT3fg2gVHyVDkKLueaQv
 IFgiQGnr98ZGlKOWOfXwqz8J8wE/pXTesxMQCjYZiXYyMCBf2rgCB/XbTUr6HDPSvwiS
 YR1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=AQ5wuWBkttqWMjzeFk3QomgPdhj10I/gl23e6kMq94s=;
 b=pmMYL2LHcqaLVtO3g9jmWwpMAnPB5v+7q4Jya4W5QxByHWO3SsAXNJjbrFPrIA4Rhl
 yCMBh7PxAs7WsPzdFCjs3/FhAJe8/pjhF0aEsRyBHw31me/pd9rwFW8fcR+mpmcCdGJf
 hqK5k4EFGGP7Tea1LkjRBmgcxhdCez1fdeSCmfRpR4hDyHmXlTWvI7eMtWze9tscYOdv
 od88/AOzTQRZ98SpHG1KEtr6crsfFcG8sGQ6HDwo+2e12G3UffMh/DzFcCnYxHBXUzsL
 uepYGOWxVJpyRd/9QKTQ4R5DSWQR3PAJG6oZb2LeiH1Yz30lLVhnRboWkvSX+y/VZvDA
 wYEg==
X-Gm-Message-State: APjAAAVYrw0bOgKOGU/+GdeTU+cikt34xuRNn5x33QPeHVN2tsplBsl7
 tr+NKEhoSs0pkAhlyM/EXSgfVQ==
X-Google-Smtp-Source: APXvYqxdRsTr+OzhYPD7oVlv3tn76et79APt93h8boIWh41u+Sg3UNPIQ6vqzsHuPJTijZ08SeyhBQ==
X-Received: by 2002:a17:902:9302:: with SMTP id
 bc2mr44060166plb.328.1577588118263; 
 Sat, 28 Dec 2019 18:55:18 -0800 (PST)
Received: from [192.168.1.118] (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id t187sm45508694pfd.21.2019.12.28.18.55.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2019 18:55:17 -0800 (PST)
Subject: Re: [PATCH v2 5/5] tests/tcg: add user version of dumb-as-bricks
 semiconsole test
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191220132246.6759-1-alex.bennee@linaro.org>
 <20191220132246.6759-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <09322c6e-74d9-08d0-1138-f2d5581a7244@linaro.org>
Date: Sun, 29 Dec 2019 13:55:12 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220132246.6759-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::62e
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
Cc: Peter Maydell <peter.maydell@linaro.org>, keithp@keithp.com,
 "open list:ARM TCG CPUs" <qemu-arm@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/21/19 12:22 AM, Alex Bennée wrote:
> +#if defined(__arm__)
> +    register uintptr_t t asm("r0") = type;
> +    register uintptr_t a0 asm("r1") = arg0;
> +    asm("svc 0xab"
> +        : "=r" (t)
> +        : "r" (t), "r" (a0));

This is the #ifdef __thumb__ svc code.  Are you enforcing that with
command-line arguments?

Might as well fix this, then test both arm and thumb.


r~

