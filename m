Return-Path: <SRS0=2YLf=2C=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6F9AC2D0C5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 00:33:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 74852214AF
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Dec 2019 00:33:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Gdyt88Z/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 74852214AF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52194 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ifCQL-0004VS-JQ
	for qemu-devel@archiver.kernel.org; Wed, 11 Dec 2019 19:33:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:33678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1ifCOJ-0002up-BU
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 19:31:40 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1ifCOI-0008Ka-5b
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 19:31:39 -0500
Received: from mail-pl1-x644.google.com ([2607:f8b0:4864:20::644]:41980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1ifCOH-0008Ib-Tw
 for qemu-devel@nongnu.org; Wed, 11 Dec 2019 19:31:38 -0500
Received: by mail-pl1-x644.google.com with SMTP id bd4so254871plb.8
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2019 16:31:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=7ahxi1d2bbzjUWQmcsGmCMgx9eDpy5No8A6ZKNnwCcs=;
 b=Gdyt88Z/Mcr4CQV9POK32maEJHE8LiMsUBTO0adeApEgFJsLWCioRG41OT4Po0ABqQ
 d1NdjQ8j1wfYVW7tAJH1EY/5iGZrUeSyrw0NYOsMgcRXUZ0ne/mc55QudU1vtvWnQREU
 9iXbpdQHPhJJnDMJ4+ZWSUYdGLog8Uys8bWjtW74WM1XBuEfRDmVmFjbVP9udnaD7D+X
 eontXFbljWwUeVmZKbTUlZQJWkumkl0sI6281zOk22fJMFlAlg7SKK1YUb7cz7CzCgpw
 kx3nn62bwkSX/n9pV2ZkCgCybhEz0o4Vi/7xoTWJNSvcbgs35OrZtOtexXVdRI8lVNfL
 Ztfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7ahxi1d2bbzjUWQmcsGmCMgx9eDpy5No8A6ZKNnwCcs=;
 b=cFmzXThhZ+H/Ee5Jrm7xc2ZRO3ZwOl6nw187aWxVvORYJFXgEUqKE4MUvfGf+KMwIe
 nzObveSxZjXksgo0hJ6/WXY7ieezxIhYmPtsFFS+EKaMwFP09YJaNPUmUCFRbYA5qk8f
 R+uy78ss21Pf/3/SMCvJlWyctLoa2Fw0BeYMSXNZqoHltYst4oxFjmuKoGCEfT6gIuKm
 2VxNrs9gam3LtqjmjZNkFrf1FyNyJqZg789g2RON/boYjS5tTd7C0uFWEPBUT4VyyRoq
 RZ5Xr1VCI9UbVDd93abT1e9+LO65AR7+tzOO+5Vh0C5NVBWTRu03p+M3QZl5bzlr36A0
 J1LQ==
X-Gm-Message-State: APjAAAUrxN7FnxgFDCyRl+BiFQMYYb9UAui1+Rek2KjnNZJNsi1rU4Fg
 bzKo1JJowttiuFgROfVvMV+OQg==
X-Google-Smtp-Source: APXvYqyy6xGMmLJlnhIAxl5T79tL8JwPW3uYtM1zUhYaP9EZFnnJ8zJ9Di2L8uuVAbcHXFjNUHw1fQ==
X-Received: by 2002:a17:902:7c0c:: with SMTP id
 x12mr6449973pll.239.1576110696628; 
 Wed, 11 Dec 2019 16:31:36 -0800 (PST)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id h7sm4749443pfq.36.2019.12.11.16.31.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Dec 2019 16:31:35 -0800 (PST)
Subject: Re: [PATCH] target/arm: ensure we use current exception state after
 SCR update
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20191209143723.6368-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <c0c7e5e4-9d62-6a07-b972-d8cbf2c18c25@linaro.org>
Date: Wed, 11 Dec 2019 16:31:33 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.1
MIME-Version: 1.0
In-Reply-To: <20191209143723.6368-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::644
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
 =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 12/9/19 6:37 AM, Alex Bennée wrote:
> +/* Re-read the current EL, don't use cached values */
>  #define ARM_CP_CURRENTEL         (ARM_CP_SPECIAL | 0x0400)
>  #define ARM_CP_DC_ZVA            (ARM_CP_SPECIAL | 0x0500)
>  #define ARM_LAST_SPECIAL         ARM_CP_DC_ZVA
...
> @@ -5179,7 +5179,7 @@ static const ARMCPRegInfo el3_cp_reginfo[] = {
>        .opc0 = 3, .opc1 = 6, .crn = 1, .crm = 1, .opc2 = 0,
>        .access = PL3_RW, .fieldoffset = offsetof(CPUARMState, cp15.scr_el3),
>        .resetvalue = 0, .writefn = scr_write },
> -    { .name = "SCR",  .type = ARM_CP_ALIAS,
> +    { .name = "SCR",  .type = ARM_CP_ALIAS | ARM_CP_CURRENTEL,

I don't think you should reuse this value.  It is not a simple bit.

While ARM_CP_* all appear to implement a 16-bit quantity, the type field is
already an int, and so can easily hold more.  I think you should use a new bit
for this.


r~

