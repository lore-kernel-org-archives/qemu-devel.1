Return-Path: <SRS0=ZZp+=TS=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0087C04AAF
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:49:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B3A120645
	for <qemu-devel@archiver.kernel.org>; Sat, 18 May 2019 15:49:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rjOjkIep"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B3A120645
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:35547 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hS1a3-0006jQ-TN
	for qemu-devel@archiver.kernel.org; Sat, 18 May 2019 11:49:03 -0400
Received: from eggs.gnu.org ([209.51.188.92]:35775)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1Vf-0003U3-Oi
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:44:32 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hS1Mh-0000lG-JC
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:35:16 -0400
Received: from mail-pl1-x62d.google.com ([2607:f8b0:4864:20::62d]:44560)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hS1Mh-0000kw-D7
	for qemu-devel@nongnu.org; Sat, 18 May 2019 11:35:15 -0400
Received: by mail-pl1-x62d.google.com with SMTP id c5so4686397pll.11
	for <qemu-devel@nongnu.org>; Sat, 18 May 2019 08:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=mVLSR1h4xgK2HaqbCmzauRfBHDMBq4sh7mP0qu9Crig=;
	b=rjOjkIep8/gC5k0oTxt1v+x+6Z+H/4n2oSs59Ps3tSWGqS+3NnXT5zm/XgSoPmonax
	A8WVUp0SNUiTqBm0G73ODhYrdVrpAv+BgLyw6hQdUoj3HGVbGF2HrMfPzeIujX0U1nUB
	YG3fh91LgXJVecvOk7lVbelBxV36sNvrvTzM6zLOyPO9V/WERWmdabSXn+RvlzkqqMUe
	DDbrjPaSDM2M2AzSpVFRnY25YJZqIn9yT3kfwFgW7ca0hMQs3EPyZMndaNJzZveG80xS
	FitUxfBzJCO8RQ6D9wsCC8V6w3cbIlPv4u8rb7Njk4NyyLU0Ijmumaj1/+I4gqwVYXG+
	QFVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=mVLSR1h4xgK2HaqbCmzauRfBHDMBq4sh7mP0qu9Crig=;
	b=SlEOf13IUfTsbaSs435gmdq2FWEQI+Jc/4RwfEkqN8V+MeQW0EF7ekZ4IivRT1QlVC
	OJqbBC1hyMNIE9tkGA03ZNEdI447oXXoRcGp1bf5hGuhDjDLyMD9Q3PUwSrPtJS/L/lx
	O4ySilqX9sUfxReoovHyNf4bp/4pkAMm2CPdbSg4HGX9R7cHNwywPWgiSNU+sJRW13u6
	iKCO56gjmBjnc7Am2725PTYpC9eswq+UzhL/IEF/smKDB5Rb7lWqQ1gplni+wTVNVYHF
	l51cpdj6pdhGJ7xI9xWCP1T4lYtpuOFTMz/iHZq9Fwj3nI3POthPp+IQMWnm65sTiQU9
	aqZA==
X-Gm-Message-State: APjAAAWBZ7wycvbsUJJl8Oix8RLhv1ck1rsmHFdOxCEReGdFWk2IpSS4
	x3oNameDbYAaQDEd3BYgm5BzeQ==
X-Google-Smtp-Source: APXvYqxkkxIlAOtxvc2puMTRwd6p7Z0pU6KTP3fhqn4KF9oFIJDhypZM62kl0U6Wd9Xbh6TgNW1o7Q==
X-Received: by 2002:a17:902:d892:: with SMTP id
	b18mr19921748plz.216.1558193714360; 
	Sat, 18 May 2019 08:35:14 -0700 (PDT)
Received: from [192.168.1.11] (97-113-13-231.tukw.qwest.net. [97.113.13.231])
	by smtp.gmail.com with ESMTPSA id
	o6sm29538589pfa.88.2019.05.18.08.35.13
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Sat, 18 May 2019 08:35:13 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190517224450.15566-1-jan.bobek@gmail.com>
	<20190517224450.15566-7-jan.bobek@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <60aad027-cbb2-93cd-5e35-56608a21eed0@linaro.org>
Date: Sat, 18 May 2019 08:35:11 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190517224450.15566-7-jan.bobek@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::62d
Subject: Re: [Qemu-devel] [RISU v2 06/11] risu_i386: remove old unused code
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
> The code being removed is a remnant of the past implementation; it has
> since been replaced by its more powerful, architecture-independent
> counterpart in reginfo.c.
> 
> Reviewed-by: Alex Bennée <alex.bennee@linaro.org>
> Signed-off-by: Jan Bobek <jan.bobek@gmail.com>
> ---
>  risu_i386.c | 58 -----------------------------------------------------
>  1 file changed, 58 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


