Return-Path: <SRS0=3XOk=S2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AAC3C10F11
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 17:08:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C83C1218FE
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2019 17:08:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OH7TIdh4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C83C1218FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:44710 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hJLNK-0004Vk-Q6
	for qemu-devel@archiver.kernel.org; Wed, 24 Apr 2019 13:08:02 -0400
Received: from eggs.gnu.org ([209.51.188.92]:52522)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJLKo-0002Tm-Rc
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 13:05:27 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <richard.henderson@linaro.org>) id 1hJLKn-0007V1-Rs
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 13:05:26 -0400
Received: from mail-pg1-x530.google.com ([2607:f8b0:4864:20::530]:38160)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
	id 1hJLKn-0007U1-BH
	for qemu-devel@nongnu.org; Wed, 24 Apr 2019 13:05:25 -0400
Received: by mail-pg1-x530.google.com with SMTP id j26so9681730pgl.5
	for <qemu-devel@nongnu.org>; Wed, 24 Apr 2019 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
	h=subject:to:references:from:openpgp:message-id:date:user-agent
	:mime-version:in-reply-to:content-language:content-transfer-encoding;
	bh=3Orv7Nej65PeYzvB0AI25SZ17jU+Mw4ScyDJ/RG7uns=;
	b=OH7TIdh4lPB0any+4ChR4pNbQXebzLUMU4y0c1KLfudSiEG7HVyY7C5B62ltmxc+7h
	4aUHgVZCeTy0bZicRf2yU8WrS/+CunIz+usZC4Q3X5KZKUM+SNJfw5Ut2fgSYs0QgORM
	6LVhrbrvuC8R/OoPlLw4v5eO8hVz3XWq3Mz6J0whXjwcgBaZr0RFlm3TGIchKrS1dbOR
	tpTrKKvid8oPkbDywl/ZpK2Lh2/b0xxCZodznhPqmpT8kxy0dc6kWWYq5x0FcbA+Yh1+
	lKGOm0pvl7MCjiu+l9L8X0Ay27OMr+4p3SC6SNAA2VajN8ms+HdpeT+9Gv5rL5AbG9cg
	Ptbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:subject:to:references:from:openpgp:message-id
	:date:user-agent:mime-version:in-reply-to:content-language
	:content-transfer-encoding;
	bh=3Orv7Nej65PeYzvB0AI25SZ17jU+Mw4ScyDJ/RG7uns=;
	b=LMGBImaMYTeN+SqPNc5T1YZOgIhA2XI17DnwAXY9FR7F5SDhpuF2rxxpJ1uhyg4cHZ
	3jYD1neLr5fEk/KusnZ//ebE594O7aWggLUHCpkgDvlKtCGJ46E370FxcWMx6g7ym4ka
	yt/Y44YvIfVPspQNoNS5xf5Ogmz4Hb7PjPd5isUqqdyMeDwJCOkOD0ykxw1MO8PQJX1h
	Pv2r30SnGFuBlqX8htPvwJks8h49BNYOzC/gvHY8kGGaSAOeXBx9OsN9vpAzk3g97f3e
	wqi9JOVWTP4hVKPmW0SCttv/GdEQL69bU67HjDmdGECvCROW/KkT0E6bdOeNshUdrTID
	/4TA==
X-Gm-Message-State: APjAAAVqi5snL+jFj0El9K7XeJB2pwzavVsok+lTokAJNBJjjc1TNEfn
	bu/MkxOrGfszilJqyP8uypZ/FEhE3FA=
X-Google-Smtp-Source: APXvYqwuVwYv3EnqnHpD+OhC3YlHKYtG7vKZPaCqt8r8+cCIcAl9dX5IUvTO2u8FW2dJv1jKjnUonQ==
X-Received: by 2002:a62:1d0d:: with SMTP id d13mr34557294pfd.96.1556125522932; 
	Wed, 24 Apr 2019 10:05:22 -0700 (PDT)
Received: from [192.168.1.11] (97-113-179-147.tukw.qwest.net. [97.113.179.147])
	by smtp.gmail.com with ESMTPSA id
	p20sm16821909pgj.86.2019.04.24.10.05.21
	(version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
	Wed, 24 Apr 2019 10:05:21 -0700 (PDT)
To: arilou@gmail.com, qemu-devel@nongnu.org
References: <20190424142714.28460-1-arilou@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <5cab37c9-8bdf-2e7d-c6a8-93f6f176720b@linaro.org>
Date: Wed, 24 Apr 2019 10:05:19 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
	Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20190424142714.28460-1-arilou@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
	recognized.
X-Received-From: 2607:f8b0:4864:20::530
Subject: Re: [Qemu-devel] [PATCH v3 01/20] gdbstub: Add infrastructure to
 parse cmd packets
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190424170519.7fr8HwEDO8XXtMwvcbTmMs3C3CILaabkt38J8x4CD60@z>

On 4/24/19 7:26 AM, arilou@gmail.com wrote:
> +static const char *cmd_next_param(const char *param, const char delimiter)
> +{
> +    const char *delim;
> +    static char all_delimiters[] = ",;:=";

static const char

> +    static char no_delimiter[] = "\0";
> +    char curr_delimiters[2] = {0};
> +    const char *delimiters;
> +
> +    if (delimiter == '?') {
> +        delimiters = all_delimiters;
> +    } else if (delimiter == '0') {
> +        delimiters = no_delimiter;

    return strchr(param, '\0')

> +    while (*param) {
> +        delim = delimiters;
> +        while (*delim) {
> +            if (*param == *delim) {
> +                return param + 1;
> +            }
> +            delim++;
> +        }
> +        param++;
> +    }

Maybe

    param += strcspn(param, delim);
    if (*param) {
        param++;
    }
    return param;


r~

