Return-Path: <SRS0=sZ46=CY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60F61C433E2
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:38:41 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD00720678
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Sep 2020 17:38:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nA5u4ONZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD00720678
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52910 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kIEud-0000Dc-TX
	for qemu-devel@archiver.kernel.org; Tue, 15 Sep 2020 13:38:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45122)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIEaI-0003aH-6B
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:17:38 -0400
Received: from mail-pg1-x544.google.com ([2607:f8b0:4864:20::544]:46539)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kIEaB-0003Om-It
 for qemu-devel@nongnu.org; Tue, 15 Sep 2020 13:17:33 -0400
Received: by mail-pg1-x544.google.com with SMTP id 34so2291848pgo.13
 for <qemu-devel@nongnu.org>; Tue, 15 Sep 2020 10:17:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=euBs6b9S/mzcDox8EZ4szpaxfhb7xnkYj3Q7/mNSLhk=;
 b=nA5u4ONZ9rMHwdsp9U4ayrnpi3bw6ZrArmtvIVyvBj/9c4rqu760PTnZtHZWgIxyqp
 YT+7cnLd95QkOHNkTr4suEbX59RuYV5a9wV30Td6RStgSmxGcQOiqRPmKQQu8bc/93JG
 TdVtxchcNqCHXQKlNRKAktypVgPlWag2CLLg7NSlw7MLoOKztPcfUY+8Y0Y/Gy1T4hra
 wr2Fcikc6GX6Z9ALrKpeyIOIYNvL0C3cJYxIFDoEqyFQO4vYn/10Mm4+69hb2EzRNCPR
 iqNW+QOOzJCbyoZsAJv+/NLS7I7iEkTfdaoXFKWw5lkzYonYu7pDweV4PnZo2ekKhYdB
 KtFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=euBs6b9S/mzcDox8EZ4szpaxfhb7xnkYj3Q7/mNSLhk=;
 b=r+V5L6F4Vr0lj2A02Lps/IL1K8e/tww9KbMbWgxmekMDuOt2tnxggXJAe0XqPEyhi2
 SVtddeMO2rAfBVW/e0wXLqnDSOBzBvQeHoLhFN+RbirYBxxqrhzS8Ao81nAA95SbmHii
 FESpIYSsQ64jvfmCYTqiS+mRBGRkmgtx42Opmv31JGNoBtObIINh4J35e1JETibGyIBM
 n8w6sdT20AN5oIDV9FFHnZD+1WEd9kytMGRMOpDKb4Ux4TgoI/AnrrhMrdT4dJ3YyPhO
 eXZgJvhEzEeQYZ97nDmTpjZ2kGgp/q7gig4hJC2g5tH4wmxEiXzfcuLaWmXsTknX++C3
 6urA==
X-Gm-Message-State: AOAM533+pgf5qbKpJk+2rs7slG9ti2kWUjbMDHn8j7wkVAvFCYdedefh
 T0EKN9WueDUT75gB3z52rgrrNh/nDOboJw==
X-Google-Smtp-Source: ABdhPJw4jr4xzKbgm9njrpFEtMZ52Ec1AHsH9wspwZSwmOlM+YtNim/Tkm7tMwv7ijzWlz5dzO2NcQ==
X-Received: by 2002:aa7:8437:0:b029:13e:d13d:a103 with SMTP id
 q23-20020aa784370000b029013ed13da103mr19167881pfn.31.1600190247223; 
 Tue, 15 Sep 2020 10:17:27 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id l5sm11923150pga.43.2020.09.15.10.17.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Sep 2020 10:17:26 -0700 (PDT)
Subject: Re: [PATCH v2 5/8] configure: clean-up the target-list-exclude logic
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200915134317.11110-1-alex.bennee@linaro.org>
 <20200915134317.11110-6-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d7619eb2-d879-2e8e-ad80-21807de3eecc@linaro.org>
Date: Tue, 15 Sep 2020 10:17:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200915134317.11110-6-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::544;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x544.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/15/20 6:43 AM, Alex Bennée wrote:
> Rather than sed and loop just do a grep.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  configure | 10 +---------
>  1 file changed, 1 insertion(+), 9 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


