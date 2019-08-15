Return-Path: <SRS0=gzPR=WL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F02FDC433FF
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 09:10:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B512F2133F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2019 09:10:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GnxUhN2X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B512F2133F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39814 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyBmJ-0000g1-VJ
	for qemu-devel@archiver.kernel.org; Thu, 15 Aug 2019 05:10:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43225)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1hyBlg-0000Aw-7g
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:10:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1hyBlf-0005o8-AL
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:10:00 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:53350)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1hyBlf-0005ni-37
 for qemu-devel@nongnu.org; Thu, 15 Aug 2019 05:09:59 -0400
Received: by mail-wm1-x343.google.com with SMTP id 10so699189wmp.3
 for <qemu-devel@nongnu.org>; Thu, 15 Aug 2019 02:09:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=1oomXRITwGgesqF3NS3HPb6mmGXTSX7u4A6AoAH+bxs=;
 b=GnxUhN2XmoGgXSufuO6sfPCQ0j+Q+3/tSeV/Dt25g+1Z6PXmrLZVovaSBEr+zSqgon
 NeSt03kWJakTsPQg+CxUtsVWFu6NpPJFM0C0jXJ4DUW6O/xMKavObCSUHNpjbC/dAQjk
 L9aZ/Se3xkgUdTFWwyNwy3J8/Yy56JJiK1QLBt090qsDJUJdA8NmWL86Tth1rvGKeAv+
 owck8KjGvCGi1vsTyw/eglk4sjPI+wCsvAp9Exzp64WmNJQvyL9P9uPI51Hq4kTV640x
 oXqsAe3AiktUDyfoesghu7+2LJ5zFgpB2gvJKd+KrxkB96+M1YzqYdYyiAjDagi8+rwu
 CBWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=1oomXRITwGgesqF3NS3HPb6mmGXTSX7u4A6AoAH+bxs=;
 b=mdpsFkBJfO+iM78B+KZYNDgeh4ADjhM2NfQgD7S/Tq2rHifFckLqVkpl4ie+7gQYjU
 JWQVNG080U7PLLo9FYhWjtkzAl845wbPNrvaSxznxEoR9J/JM5d6YvnzfN8GpeQFG2GP
 bBs1oboUrEvrLs5CvJ9rzgERxPdr9Nzx/QBLi/OEbc31bZHAFYQfuRNs9GxQpSfeQoQa
 8KLBE1zagNZVqGV8wijWJs7Pk9SK/alO0wCOKb+Kwgc2PA1O/Fuw8XNFHenu04r+SjZ5
 d4LVvaJTthW0ROP7CfP+pog/RnnrL2Aew8N0kEOYyW/qjhnzjj6PmVDhhsU855ih3A0V
 1wUw==
X-Gm-Message-State: APjAAAV8aFzS9uHCA+0RwA22YsI4ddYPpkui/ahj7Y5njV11O38vL4GA
 R0goNepnX1cVnpSEG2fBTM+K7w==
X-Google-Smtp-Source: APXvYqyIwlIFgQ1LoI2uSUjBWkKFzXF5S6MAUKUF5s6TEFOlIHInNbZnmJHGN3Z+vW3fNerTflkDKA==
X-Received: by 2002:a7b:c3d0:: with SMTP id t16mr1818539wmj.25.1565860197330; 
 Thu, 15 Aug 2019 02:09:57 -0700 (PDT)
Received: from ?IPv6:2a02:c7f:a69:1700:8897:9507:94c2:b98d?
 ([2a02:c7f:a69:1700:8897:9507:94c2:b98d])
 by smtp.gmail.com with ESMTPSA id r16sm4115196wrc.81.2019.08.15.02.09.56
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 15 Aug 2019 02:09:56 -0700 (PDT)
To: Jan Bobek <jan.bobek@gmail.com>, qemu-devel@nongnu.org
References: <20190810041255.6820-1-jan.bobek@gmail.com>
 <20190810041255.6820-17-jan.bobek@gmail.com>
 <b0bfa230-f508-ace2-6daf-75f2156251d6@linaro.org>
 <cee901d6-9423-8c0e-3b61-f3b09019ac5d@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <d9cefe05-3119-c0c3-816b-b2df7378d0be@linaro.org>
Date: Thu, 15 Aug 2019 10:09:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <cee901d6-9423-8c0e-3b61-f3b09019ac5d@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::343
Subject: Re: [Qemu-devel] [RFC PATCH v2 16/39] target/i386: introduce
 instruction operand infrastructure
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
Cc: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/15/19 1:00 AM, Jan Bobek wrote:
> On 8/13/19 2:07 AM, Richard Henderson wrote:
>> On 8/10/19 5:12 AM, Jan Bobek wrote:
>>> +#define INSNOP_INIT(opT, init_stmt)                                \
>>> +    static int insnop_init(opT)(CPUX86State *env, DisasContext *s, \
>>> +                                int modrm, insnop_t(opT) *op)      \
>>> +    {                                                              \
>>> +        init_stmt;                                                 \
>>> +    }
>> ...
>>> +#define INSNOP_INIT_FAIL        return 1
>>> +#define INSNOP_INIT_OK(x)       return ((*(op) = (x)), 0)
>>
>> Return bool and true on success.
> 
> So, the reason why I did this "inverted" logic (0 = success, 1 =
> failure) is because I was anticipating I might need to differentiate
> between two or more different failures, in which case returning
> different non-zero values for different error cases makes perfect
> sense. I have not made use of it yet, but I'd rather hold on to this
> idiom at least for now, until I am 100 % sure it really is
> unnecessary.

In that case "int" still isn't the best return type -- an enumeration would be.


r~


