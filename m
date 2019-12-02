Return-Path: <SRS0=6iUH=ZY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E43CC432C0
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 02:20:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 28C9D206E4
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2019 02:20:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="y9s5hoN2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 28C9D206E4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57946 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ibbJw-0002FD-CV
	for qemu-devel@archiver.kernel.org; Sun, 01 Dec 2019 21:20:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:58199)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ibbJ6-0001n4-5h
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:19:25 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ibbJ5-00034w-2U
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:19:24 -0500
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:42268)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ibbJ4-00034N-So
 for qemu-devel@nongnu.org; Sun, 01 Dec 2019 21:19:23 -0500
Received: by mail-pg1-x544.google.com with SMTP id i5so9291332pgj.9
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2019 18:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=iyC9OtCOaANbEBY9+bjev651YENbWTUe2IqwLwfN39o=;
 b=y9s5hoN2JRi+GoozoMrZGV7rgA/O1IOWPOnKR7AahmNugQ/GD11Dpo3qqTYHWgYG7z
 8KrGDrRN08Q8YNKIQOmjftYCco3KIDr3qK8NR1v0QqSsF9hFA1iYKgqGIkYLMcVPn/85
 tSQYRlhFxVGdv1CFCgnu1g8s8bWoI8X2yOACB5rXwYh9ivwJlhfMDA7ZkM3QtoWkBwmr
 +RdylDvYGG2qGUjWVpw/9JctU1JsaB8QskwpBp0h7fArM3m8HoX+yF57g84xvJsJewsc
 ZvU8I3C0cXGpiT2YCPSpJAENUyIspNEzkWzjGBfdOb8Mz9elUEopMxIdRAUSVBfC2qiX
 PoNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=iyC9OtCOaANbEBY9+bjev651YENbWTUe2IqwLwfN39o=;
 b=GAE2VVgRaujV0Fafxlpm6xxuTzocSwKgxQjlVIfRkfh74mpgjJaOoFMxbq8NZgJN3C
 g/pNU9o5W/guTLPMpgB9d79kX8Dn7lO2xb0SvBAUoWq1+mpZ6YqU22cFZYchM1tf8MAC
 mYBk3wbwy0RenLH05Lqg7olxfnbLcgMl4qwCKGUN1FcpD9Tw3NzwRzMpbBdVxc3YuQmD
 IAgoC8GeoiTv0SVGa1CCZ8sVfLPfWaUAnvz8LLTERZjahiXh1VJ6T0Fky7VgC5cNVWry
 O3KKLoWTpvrrzllLQ6S83RspcVnaQ+jUZqFtbb1wuKIN2ncw/hBY24uaFc472cS3RSFN
 qh/g==
X-Gm-Message-State: APjAAAU5oLCHoj3j5f2uAwQY44+BZsdNlUjd5XyBMZeHsXDpl3xKJ5Wh
 l5JnPDWHCWCiT1K72m6IhRZZXA==
X-Google-Smtp-Source: APXvYqz15g1US+o4JeAJX3n84Wn0gRDrknPb4xBW9GhAAk0j3Aa7w7ZBsNcA8XswdfaBiuXvhLTt4A==
X-Received: by 2002:a62:1742:: with SMTP id 63mr14862952pfx.231.1575253161614; 
 Sun, 01 Dec 2019 18:19:21 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id a26sm31338685pff.155.2019.12.01.18.19.20
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 01 Dec 2019 18:19:20 -0800 (PST)
Subject: Re: [PATCH v2 05/14] gdbstub: add helper for 128 bit registers
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191130084602.10818-1-alex.bennee@linaro.org>
 <20191130084602.10818-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a6e17296-a883-6097-314d-906b4edcb706@linaro.org>
Date: Sun, 1 Dec 2019 18:19:19 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191130084602.10818-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::544
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
Cc: damien.hedde@greensocs.com, luis.machado@linaro.org, alan.hayward@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/30/19 8:45 AM, Alex Bennée wrote:
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> v2
>   - take care of endianess of the whole 128 bit word
> ---
>  include/exec/gdbstub.h | 13 +++++++++++++
>  1 file changed, 13 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

