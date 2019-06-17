Return-Path: <SRS0=A34B=UQ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D43EAC31E5B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ED882080C
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Jun 2019 22:37:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IrMqfCi/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ED882080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52326 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hd0Fo-00034k-PR
	for qemu-devel@archiver.kernel.org; Mon, 17 Jun 2019 18:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:35490)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0E8-0001WW-Tb
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:35:50 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hd0E6-0001Ip-UE
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:35:48 -0400
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:41813)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hd0E5-0001Fn-0B
 for qemu-devel@nongnu.org; Mon, 17 Jun 2019 18:35:45 -0400
Received: by mail-pl1-x643.google.com with SMTP id m7so1185090pls.8
 for <qemu-devel@nongnu.org>; Mon, 17 Jun 2019 15:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=vFCAUZD9c0hpV/IeC9fTH7uuGE25oR1bqsnC8xcFQ24=;
 b=IrMqfCi/JrmsT1M1XBFOOzHg23qM8i3tMh3R+w2l3bKzwz5Mkj/tv5gPvo01uOv5cO
 R/lOLguPS2sxk37/T+oe7+uhOSKpvcfoD2yMUqbFJqrRmiLPKEo8PdkUt9+qLJvPlbCH
 42DdDarGRZAUW91Ot9wE8wjWjtGmmnREdMq8BsvAtKHfUypgWIDhx1aMBNxQZ7UFEmV9
 XyxWBEOfW1apJnHmGvPY4ju2+qV5Zk3DBk9GDY4U3ecxbd52GuhL93/HUUunkYgzxh4L
 QatrAa+MmkqnHSKnplWSpV1Rhuwj5YGcpc40G0XB6cN1mu2MRjhhIZlk+Dbwv2AuHd34
 7E/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=vFCAUZD9c0hpV/IeC9fTH7uuGE25oR1bqsnC8xcFQ24=;
 b=McgKFiyDmCXN1IXP8ZLXWzMhJ1qTGK/wd5XmzCSqqeDAP02HUAX4n3vt0Khpv2almB
 a5kmqupMo1NjfSzjQA5solXb56dzvgjUhRmyoV4RathKm0nwO4ErRe28WM1xyJB23zys
 HjWHxecpouMv3z3SRy1ITaEGic7SpGdJwdxh6Ii+BzI4dIsTVpcAgb8TJ404tL10DBkD
 LB7BhgEzkxkypGTC/XfXotXzKhWwehPk/bDLA2b+iDhhPBa9wCI2Ka7yAd51XvYXNvTn
 4TGuaEASeT8/qSuGEJK8pJRl2OY53Y4gbF5huJ/NQss9Jb9g2tpf9dW3KYqI4z5UMJjD
 gg3A==
X-Gm-Message-State: APjAAAU+JrIa/UO/4uXfGZ+FDBxYfcG7dVvAMJQbtqxy5lAJMyjmCGGO
 mWwsIImJZL8GuR9ptpJU1LU6mA==
X-Google-Smtp-Source: APXvYqzeEjOQG0vkKJXB9D0tC/swtKPW0DhQjgAcYQoCYfXIoIUZ84oo1zmK7sPTFzG+4vdGJIGg6g==
X-Received: by 2002:a17:902:8a8f:: with SMTP id
 p15mr107943847plo.157.1560810942924; 
 Mon, 17 Jun 2019 15:35:42 -0700 (PDT)
Received: from [192.168.1.11] (97-113-2-33.tukw.qwest.net. [97.113.2.33])
 by smtp.gmail.com with ESMTPSA id r77sm12012178pgr.93.2019.06.17.15.35.42
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 17 Jun 2019 15:35:42 -0700 (PDT)
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20190614171200.21078-1-alex.bennee@linaro.org>
 <20190614171200.21078-31-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <39779cfc-e013-4a7c-e625-e09edf771138@linaro.org>
Date: Mon, 17 Jun 2019 15:34:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <20190614171200.21078-31-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
Subject: Re: [Qemu-devel] [PATCH v3 30/50] target/hppa: fetch code with
 translator_ld
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
Cc: "Emilio G. Cota" <cota@braap.org>, Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 6/14/19 10:11 AM, Alex Bennée wrote:
> From: "Emilio G. Cota" <cota@braap.org>
> 
> Signed-off-by: Emilio G. Cota <cota@braap.org>
> ---
>  target/hppa/translate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


