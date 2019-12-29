Return-Path: <SRS0=KIBN=2T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E8FDC2D0C8
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 02:58:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB606206F4
	for <qemu-devel@archiver.kernel.org>; Sun, 29 Dec 2019 02:58:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="NbA0oMwy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB606206F4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48730 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ilOmi-0001kE-RY
	for qemu-devel@archiver.kernel.org; Sat, 28 Dec 2019 21:58:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:57555)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ilOlr-0001Bj-7n
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 21:57:36 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ilOlq-0007OG-7l
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 21:57:35 -0500
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643]:40426)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ilOlq-0007Lu-0A
 for qemu-devel@nongnu.org; Sat, 28 Dec 2019 21:57:34 -0500
Received: by mail-pl1-x643.google.com with SMTP id s21so10597770plr.7
 for <qemu-devel@nongnu.org>; Sat, 28 Dec 2019 18:57:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=yLaqwPIFuNuKqoOfcXmFF2FZpBhCNI7L5ivEi70Tx7A=;
 b=NbA0oMwyNZ+xHiqx6KaWXfxDiL+pOlrQaZiXHwVeym3kJzJFrKbLErxhcRKN5lnWwQ
 pu36YjNLL/9jjXLwB0yRA7HPW2AK1G5TJxE20vcLRVBsCOLm7iqI5VbEctvNdZVwukrA
 tKUJrGKmNdGdlw1izmxlYjtYAP5w1viZr7XVSPz/KiQ+rG7ROmv+UIwpI1Lcq2/q9/61
 kkAuXipaTjXcsUzYpwQfiKRbBrorAK6eBEfb10a794gVrLnz5nHZgdz+SpTQor0+R1wR
 ePugyLpAxwR7J/ymPr8kZQimGyzyJOUiCz8ELa7zQkro0TtyKB3tTtiz7HGkrWxwifLT
 A+3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yLaqwPIFuNuKqoOfcXmFF2FZpBhCNI7L5ivEi70Tx7A=;
 b=nrMV+MWoLUHs+cIoBQVC/DCFcpwUJOodxwVkXFxHDJ4PAIkr275vuQ3r506Y5WEu7R
 azvHvDMMep6AMOVvUg9tsYg54qmqEHPRVOxluwCdJQ0OhnP84hIQIQEPmHfLqn5h7pDy
 463YHAX+l+HtGdCE7eU9XhVUEsThRvaMU2QlI+I4091hHnw7FnDXcwRDzH1w5BPigpD1
 trAiYhH+X61Ro+/EALWe6apO4CVsH7ZVNV9kSZZmz00v8PCK8fU2QhozkhY3iyKs92p7
 +R6SXcmO2s+oSSRZt+QLR+ZVq7+OcjSUmslnhCAYkKlcSbSygSyyixUFyRcPHH5wpPcf
 oUWw==
X-Gm-Message-State: APjAAAUVabcAsO5FBYrWlXXud4C7rJ8SHp3TPYraCtkujpz7lIjho2xj
 vrlvKjjxGUTpTUF/9lncdGqwWw==
X-Google-Smtp-Source: APXvYqwHLFGBtdQq3j/i+kaQWDuhG9WqLrDYK3G6uy+PcAqmC0j/2qwGQruwkABv4sH3+ivN+2VuJQ==
X-Received: by 2002:a17:902:760e:: with SMTP id
 k14mr62031009pll.238.1577588252927; 
 Sat, 28 Dec 2019 18:57:32 -0800 (PST)
Received: from [192.168.1.118] (194-223-58-9.tpgi.com.au. [194.223.58.9])
 by smtp.gmail.com with ESMTPSA id q15sm42618719pgi.55.2019.12.28.18.57.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 28 Dec 2019 18:57:32 -0800 (PST)
Subject: Re: [PATCH v2 4/5] tests/tcg: add a dumb-as-bricks semihosting
 console test
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191220132246.6759-1-alex.bennee@linaro.org>
 <20191220132246.6759-5-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <557f36ea-159f-ebb2-b7aa-e96b0844e1ae@linaro.org>
Date: Sun, 29 Dec 2019 13:57:26 +1100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20191220132246.6759-5-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::643
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
> We don't run this during check-tcg as we would need to check stuff is
> echoed back. However we can still build the binary so people can test
> it manually.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> 
> ---
> v8
>   - actually return the result!
> ---
>  tests/tcg/aarch64/system/semiconsole.c    | 38 +++++++++++++++++++++++
>  tests/tcg/aarch64/Makefile.softmmu-target |  9 +++++-
>  2 files changed, 46 insertions(+), 1 deletion(-)
>  create mode 100644 tests/tcg/aarch64/system/semiconsole.c

There probably is a way to easily test this with python, but I don't want to
write that script either, so.

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

:-)


r~

