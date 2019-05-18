Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A58EC04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:47:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 07B3A20645
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:47:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ErnGEMWN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 07B3A20645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35531 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS1Y3-0005BO-8s
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 11:46:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35806)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1Ve-0003UL-Bu
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:44:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1P5-0002ce-Jq
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:37:44 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:41911)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS1P5-0002bf-Dm
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:37:43 -0400
Received: by mail-pl1-x62d.google.com with SMTP id f12so4703525plt.8
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 08:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=psa72ECFMwSKc2vx7JLPLvxmtVux/sCUyVXk1dP8osE=;
	b=ErnGEMWNVCPF2HczSkmFs+mPXlj+JLB/8I+F7LjDelbvEnRvu32eNbma7KjFk1p3yf
	vftcuP4bl+pbTvJm1lyN2xEx3tHJJHPOuyyT9VxCVPvpjNmOqCfaZpuY8L5iVPBl4GNp
	yC7aOorQQrvsB41QdeotuapoJBdC97F+8y/+bkV/g1OtfTOSzcX4sXUbH+Z4+CbE5v/2
	815C+J4mWeFGrQkc9oTRlU1ECJZREb4AWrK0PYmalcy+vNtq8Zj+KQF9vBiyjylC+AEc
	1NBaCNr7a/WrJGQhA63LEDymCykTRzwu2zJ3yEzUmeKJxiLVNO4Ye/kb4gjCFCAm11pS
	he2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=psa72ECFMwSKc2vx7JLPLvxmtVux/sCUyVXk1dP8osE=;
	b=qULJSfjD4q1vUR/NntEbyMwOIYI7sxgWMAdIgY8I+SIBBmBYOCgBHe9QTUF9TBgCeU
	HYnpqR+QY/ZZxLO5DMd/REJ6heaTLdWX7eHcrTNSDQONtIV2cjE/7F8i1KME2q6ZRI7K
	h4B9+SczomyXUdTraKnpKlTzvUnZlbQj4ghhnDAxyy1NcSLhMXQ2XkPkRajooEcvqU6/
	HnFBwe6BChBjho0W5IFZWsxrMSEyWy4uwAPlo05L83Pk6X32qdpkl5nQ5RQ6z/fqYL/f
	uSLkVMb6WqdO8j/1V8K+1WXSBsnElaQt46mcqATzB5YZEqwYDuMIXk3FWdaTK+aW8bzv
	O2Vg==
X-Gm-Message-State: APjAAAWSEftJq/HI+4SKo7xN3Aft07y4rvOwUMotVgHfPJHtuNT2pUuO
	nGw72PhB1Qg83jWGZYVk4GdPWw==
X-Google-Smtp-Source: APXvYqw1UPDXswA5xuL8q/Au3gmQS5l9kyry/ss5SY4HSPz9AVJ1aPUuq+J+51sVzTRwTQrJ+iSWgw==
X-Received: by 2002:a17:902:e091:: with SMTP id
	cb17mr63582958plb.222.1558193862343; 
	Sat, 18 May 2019 08:37:42 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	q20sm13428060pgq.66.2019.05.18.08.37.40
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 08:37:41 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-9-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <3433a282-de41-cb8b-fd2e-834f274fcfe4@linaro.org>
Date: Sat, 18 May 2019 08:37:39 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517224450.15566-9-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62d
Subject: Re: [Qemu-devel] [RISU v2 08/11] configure: add i386/x86_64
 architectures
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/17/19 3:44 PM, Jan Bobek wrote:
> Now that i386 and x86_64 architectures are supported by RISU, we want
> to detect them and build RISU for them automatically.
> 
> Suggested-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  configure | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)


Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

