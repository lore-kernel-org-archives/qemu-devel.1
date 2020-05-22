Return-Path: <SRS0=muh1=7E=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1B7DC433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:16:34 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57EDD2078B
	for <qemu-devel@archiver.kernel.org>; Fri, 22 May 2020 03:16:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AleG+5Oz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57EDD2078B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52636 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jbyAj-0004tC-Gf
	for qemu-devel@archiver.kernel.org; Thu, 21 May 2020 23:16:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51292)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbyA9-0004Ti-Ss
 for qemu-devel@nongnu.org; Thu, 21 May 2020 23:15:58 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:53558)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jbyA8-0005mq-AH
 for qemu-devel@nongnu.org; Thu, 21 May 2020 23:15:57 -0400
Received: by mail-pj1-x1041.google.com with SMTP id ci21so4339452pjb.3
 for <qemu-devel@nongnu.org>; Thu, 21 May 2020 20:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=E3SYkER8Sn9ftb2w9pWLSYpCwA+PpwNblKshnXJNCwE=;
 b=AleG+5Ozjv4MXPO0cxuzo+dIjsvhZxNhC8zZh27stg/zx79bV4rH9RvzqlEORmrGB1
 Y76AXTlSuBLSGzAaoiZA29GT1NB7eCr7QBA+SlEtSugVETYOwvJHPnTKroLeQ0O63F8s
 cDOB0ysSD20bsz2FjJnyZqU1oqi+uxc2X/UZ/5L/9ISPNJJCjTaIOxShX8eFwhfTnUho
 Aonu/f5YG/18H26O1LxUdXtEQ9tOOk0ali+9xLvJ2EW2VAs8z31rfEqvMplpRPQeSz4Z
 clNoQC0vpIYI0TBDhiS+qyDXo53LN0yvVIOiMexm1zrZtE1hDf8J2zL/UCyyS3YioZOo
 M3vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=E3SYkER8Sn9ftb2w9pWLSYpCwA+PpwNblKshnXJNCwE=;
 b=Fe/6R7yasDLImdOpJYE3+Ceqms8laa7t+j+W3+JdGmLDSMfPZsc7vy6qbHNB6HuK6i
 t7zQYyE5IPBkVqhVwKE9tulBtifsKWQyh0NPdqyLNhm7+C2hVoo/ZG26jO3B+q0/R/UH
 NTJ/FupNyaRlqBKNPSbIf5licpZxadwisKzelEnozOIeIm7nN2bafNDo8PH9WDgqGpSa
 ecQFXq04h3wzAnbQxTGcEwL/lzw9FzhOJ5ZPW6KSx4PRPZ7pVu7UnV8/IdBTS2EGRVTS
 QZZDDFVuc0XEYBlmUphY9hT6HRISNYmPRrXGQBi90cfamIjDwMsNSy0ZHyimllFAti50
 R86w==
X-Gm-Message-State: AOAM530S1KZ0H2LZSUZdLmFi1F1YlTA3KsfT5yctWg6qS1cYbfU11mAk
 pd0vdeoqjSwiVbT91bpe6IVjMw==
X-Google-Smtp-Source: ABdhPJxSK+lmZ3mxgKTN1EJzLXEb5HjTXqJggv6A6HE0R7aTm5p44s/5EfetyoMaPkJ4l1nycaQJNw==
X-Received: by 2002:a17:90a:5895:: with SMTP id
 j21mr1987679pji.92.1590117354517; 
 Thu, 21 May 2020 20:15:54 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id h7sm4930365pgn.60.2020.05.21.20.15.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 21 May 2020 20:15:53 -0700 (PDT)
Subject: Re: [PATCH v2] linux-user: limit check to HOST_LONG_BITS == 32
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200521135748.9859-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <3069bc1b-115d-f361-8271-c775bf6957ea@linaro.org>
Date: Thu, 21 May 2020 20:15:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200521135748.9859-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: Thomas Huth <thuth@redhat.com>, Riku Voipio <riku.voipio@iki.fi>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/21/20 6:57 AM, Alex Bennée wrote:
> Newer clangs rightly spot that you can never exceed the full address
> space of 64 bit hosts with:
> 
>   linux-user/elfload.c:2076:41: error: result of comparison 'unsigned
>   long' > 18446744073709551615 is always false
>   [-Werror,-Wtautological-type-limit-compare]
>   4685         if ((guest_hiaddr - guest_base) > ~(uintptr_t)0) {
>   4686             ~~~~~~~~~~~~~~~~~~~~~~~~~~~ ^ ~~~~~~~~~~~~~
>   4687 1 error generated.
> 
> So lets limit the check to 32 bit hosts only.
> 
> Fixes: ee94743034bf
> Reported-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---

I say again that I'd prefer that we disable this warning.


r~

