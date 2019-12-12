Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42D45C43603
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 00:37:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0DED5214D8
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 00:37:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Rom8Njni"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0DED5214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52242 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifCTn-0006Za-6y
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 19:37:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:52020)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifCSz-00062I-Bm
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 19:36:30 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifCSy-0008Bc-Eh
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 19:36:29 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40185)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifCSy-00089i-8O
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 19:36:28 -0500
Received: by mail-pg1-x541.google.com with SMTP id k25so198983pgt.7
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 16:36:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=EBXWGM+EyE3h+YSrNPASzXIjTgAbTF+CJziNTgPQOdo=;
 b=Rom8Njnibqlg71eElLdJ/4Tum17IzXEg9p0+k72itPKxD9n3qpUiPVNbHgdrwfG4kv
 9jBr/dEJ9ayyrpTaeTO0YqF3ZX8sC/9Q2jjy3onxueYM5j23eTCOjfT5gKDoMzVPeUU6
 xInVMsynMypPVSEYqZmS8J5vzHExhBnTScCnoWxE2h6Z9S5AEOAlfBzgh+YUOprfk9DY
 W3+cR6PVQNJTSPYL+MfOczw4YxWquCHxIMDXyRVQ/NekD/Jq+cM3mhGnm6UGDkJMnvmc
 VPP9X/j2IZlWiaGMAxYgfJFZ5frXTnDdqqS/HICUmNUBD4f2RUyNJy93HLnP6przGlLR
 Jtlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=EBXWGM+EyE3h+YSrNPASzXIjTgAbTF+CJziNTgPQOdo=;
 b=KwKjgOhdptfL+kmFqxgk3z4abuHotZOsTjSseaIhOZrgyiVVWH5Qe0ZuKms9SwCEBf
 N2UpkoAhSd7JOuify0qrWjn5LGdXud8l26P8sq3Avnw385W64IihqkgiCNRi7CJAW8is
 w25EOiRohrqF9s7DwQKwCUIMWW8LtWnKYY1psEnHM6O52KieQg4rUqsRqseFDTFi4iuj
 rF9e8nJoIvs8NbqplfiMA5z2GofKUAyY3akb6Gs2c0yh02MZgu077+oMqmGRkaNRyQK5
 /3JNoSv0oL7bHJqYAf9ITZlQwI4Z/+apap9x9dkmWrKsPjy6+3tKr0m3vYZ5P0IqdT73
 WUlA==
X-Gm-Message-State: APjAAAUi7V7j4LVGui/fEsx5Xa+nZb5I88GUcu8OUJpQx3HYIS6WmpeG
 cDU5oNrve88HUm9kc4T5lJp3NQ==
X-Google-Smtp-Source: APXvYqwPrYv5D14beVLe9QF1KTYggoi6brCUqnoLQX7mZLrMqhFCB1W9EUwdv4iCCoHOj5Zi6fRsiA==
X-Received: by 2002:a62:aa13:: with SMTP id e19mr6853409pff.36.1576110986855; 
 Wed, 11 Dec 2019 16:36:26 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id q6sm4683307pfq.27.2019.12.11.16.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 16:36:26 -0800 (PST)
Subject: Re: [PATCH] target/arm: Display helpful message when hflags mismatch
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
References: <20191209134552.27733-1-philmd@redhat.com>
 <87d0cx32vv.fsf@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <1d51109a-ae9f-7bfe-66d4-0e1e1266df64@linaro.org>
Date: Wed, 11 Dec 2019 16:36:24 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <87d0cx32vv.fsf@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 8:00 AM, Alex Bennée wrote:
>> -#ifdef CONFIG_DEBUG_TCG
>> -    assert(flags == rebuild_hflags_internal(env));
>> -#endif
>> +    assert_hflags_rebuild_correctly(env);
> 
> I'm trying to recall why we don't just use:
> 
>   g_assert_cmphex(flags, =, rebuild_hflags_internal(env))
> 
> I think it came up in one of the reviews.

checkpatch.pl.

Because, I believe, there is an environment variable that causes this to *not*
abort on mismatch.


r~

