Return-Path: <SRS0=1jZz=6T=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 252D9C47254
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:33:53 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DEBDC206B9
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2020 09:33:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wn/zbo66"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DEBDC206B9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33372 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jVtxX-0001JY-Vr
	for qemu-devel@archiver.kernel.org; Tue, 05 May 2020 05:33:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49498)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVtwx-0000sx-43
 for qemu-devel@nongnu.org; Tue, 05 May 2020 05:33:15 -0400
Received: from mail-wr1-x443.google.com ([2a00:1450:4864:20::443]:40916)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1jVtww-0000pD-5A
 for qemu-devel@nongnu.org; Tue, 05 May 2020 05:33:14 -0400
Received: by mail-wr1-x443.google.com with SMTP id e16so1876357wra.7
 for <qemu-devel@nongnu.org>; Tue, 05 May 2020 02:33:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=w+h6QnHpLDVtJmYN/evVm0++vurR8iK5LUCKzfaw0eE=;
 b=Wn/zbo66l0IEb8FHGLiIPxVPNIDQnOYExLaZqgzwI/kiXoZN+vXb6rM1nIvHdsCA+e
 SPf909L772u5KJDBdVakwiZb7ezald/TOk4wknaeOPizawTeXRHg6Clb2i5C5u1GM2GD
 /XFl/KAwhp6KNKMGu0XQB+IELAvStB5Xn04DBsgLtsM/fMOUKK6VPFWH/N+mSQ0sZz3d
 jvRhH/1mYE40WWNXXn/Tkxa+KjKKvCK6XNur16I1ogYaRUNnG8LrElUybGDlV71GCica
 6YVSg9I8EoKhg2hTAMUSB+3uDY7go1GYlmOtjq7MqpLwGL3yXST/kAfeGtTQ/JyiSQhP
 zzBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=w+h6QnHpLDVtJmYN/evVm0++vurR8iK5LUCKzfaw0eE=;
 b=t2O21POZm+orB6Ar9cGU0lXV/zBqUF67boORkISZXm+S473+et4unAIw9Lie1OQIzK
 Ec5V/NbseO3mx59jIQL/A8aYkNwp4atL5lTQ8a75hDlfc5XqPA5Hm4JCtiClaHZyDmxY
 ioXGahK7qpB4sW6toksDektt7Q4yIsIoUaMqgM8LcpXI9CnzIKi2tCV4Q1Bu+mqz0bt0
 up9HEIc5ST4s4EmKG5tJpYu1dQgZnSlhep8w6kF5ubFgZoyFFExpIKeJ4dEHSAXft2dx
 ViEFjygkz4nJ9EDjvFGHAWLFErfCr2w+79+coeZdwT0EeO17jKvhuVSEgXr/BNKKSjZk
 jowQ==
X-Gm-Message-State: AGi0PuYNkheEFCYdhp5a06f78ki0yumtVwFcwJkKOgvk7vuvctrnG6Ew
 pb73KGAuyrh1mY1/nwRWnEdHeYPL
X-Google-Smtp-Source: APiQypIwAEKUV87d8fIQiWdtCseoPhF8B26YVeCbRReYtf/y6wixzTR4L8itm1thV/EGOYjpsrmyEw==
X-Received: by 2002:adf:e941:: with SMTP id m1mr2514186wrn.385.1588671192425; 
 Tue, 05 May 2020 02:33:12 -0700 (PDT)
Received: from [192.168.1.38] (26.red-88-21-207.staticip.rima-tde.net.
 [88.21.207.26])
 by smtp.gmail.com with ESMTPSA id e2sm2162497wrv.89.2020.05.05.02.33.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 05 May 2020 02:33:11 -0700 (PDT)
Subject: Re: [PATCH] tests/Makefile: Fix description of "make check"
To: Huacai Chen <zltjiangshi@gmail.com>, =?UTF-8?Q?Alex_Benn=c3=a9e?=
 <alex.bennee@linaro.org>, Fam Zheng <fam@euphon.net>,
 Markus Armbruster <armbru@redhat.com>
References: <1588663771-5534-1-git-send-email-chenhc@lemote.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <2cff4b96-bb14-8a24-1bcd-71308b6dc070@amsat.org>
Date: Tue, 5 May 2020 11:33:10 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1588663771-5534-1-git-send-email-chenhc@lemote.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::443;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wr1-x443.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=_AUTOLEARN
X-Spam_action: no action
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
Cc: Huacai Chen <chenhuacai@gmail.com>, Huacai Chen <chenhc@lemote.com>,
 qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/5/20 9:29 AM, Huacai Chen wrote:
> The description of "make check" is out-of-date, so fix it by adding
> block and softfloat.
> 
> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>   tests/Makefile.include | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/tests/Makefile.include b/tests/Makefile.include
> index 03a74b6..5d32239 100644
> --- a/tests/Makefile.include
> +++ b/tests/Makefile.include
> @@ -4,7 +4,7 @@
>   check-help:
>   	@echo "Regression testing targets:"
>   	@echo
> -	@echo " $(MAKE) check                Run unit, qapi-schema, qtest and decodetree"
> +	@echo " $(MAKE) check                Run block, qapi-schema, unit, softfloat, qtest and decodetree"

Maybe end with " tests"?

>   	@echo
>   	@echo " $(MAKE) check-qtest-TARGET   Run qtest tests for given target"
>   	@echo " $(MAKE) check-qtest          Run qtest tests"
> 

