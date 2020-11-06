Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 135B9C2D0A3
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:10:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5A5262072E
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 17:10:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="w4h/Ptww"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5A5262072E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:60874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kb5Fo-0007v2-DN
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 12:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:34072)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kb5El-0007Lo-Da
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:09:19 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:38912)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kb5Ej-0002xK-Nx
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 12:09:19 -0500
Received: by mail-pg1-x541.google.com with SMTP id i7so1404030pgh.6
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 09:09:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=R5Mya+ZYT8iXtyZrB8C8KT4dNbiypl/gR9Qdx7+noXQ=;
 b=w4h/PtwwuZ6Lq9ntn8m5fuW4l+fDk7hmk8bNwNlwgmBqeYt6nyi8/G91nBGt1sH6NH
 lyDA+2NX/jMvAWZX/0h2RHkGH4kyB4hAQYO/wq43Sz035ZUh1jkcxQW3mOPOUtnDAl+F
 tkbiv3mHsbF6RHYDQhmSEo8RBKlDz7MkFZzOgLfl8BnvPMVAKy+Hk4rS+1K4OSjWVnx5
 8IPzPoujqLYhXJthVB0V9HCSX/hcGO6Us1VOXXA9aqXxsOiDfm03RwRQNPmYFq4tFLAl
 9/9HIdw/+UpnAOB6T4qAPklvMT9VmYevq2kwPwUhbYxN8l9i5+Wq7JP7ZoCZPlGJ6SON
 l5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=R5Mya+ZYT8iXtyZrB8C8KT4dNbiypl/gR9Qdx7+noXQ=;
 b=ThzgC5h95S8d3hpUzVhuDeSArhTcgL44SweAEqOaiS6xzlUgJj3PotGw9YUQOAG8ed
 RDSiN23EyBBtJ7idFzmrpWjRQ7VF6CnnRLckImsP3yTNRbwcoPV/SCJbkEl23GYxNacH
 BaLfmhGfVFk8YWDm3ZW7BrV1Qto2wPuIJiuuyhXldIcV/fD441Vl0VsqBMneepuE5u1W
 NAdgj/map6JZIQqH/bO9ltyvWdiArA0J/JhCfZUe9gM1nxU92H/t7DqTXr6Md0sR9UtY
 KzC1yeKUfanwtzr/ebN9yG1W3oZkwG/IVUYbX2fVlZ7RE7eyaPtisTjrXV7S0FxBjbyk
 ojfQ==
X-Gm-Message-State: AOAM531sTjTjFqUZ3cDK9UFdFDWqs/OQcruAFSGjljXOjX/DrDHDCZyw
 s7OfeFvpB0CtRsDV0F6OXLkxoQ==
X-Google-Smtp-Source: ABdhPJyV8y+rdngGtrwhdMb8+27o0w/E94QZU/sgEXwccLRE9Ce+mTarSfboI8Y+2MqbMJlpC/LB2Q==
X-Received: by 2002:a17:90a:3f10:: with SMTP id
 l16mr558851pjc.110.1604682555972; 
 Fri, 06 Nov 2020 09:09:15 -0800 (PST)
Received: from [172.16.1.221] (76-14-210-194.or.wavecable.com. [76.14.210.194])
 by smtp.gmail.com with ESMTPSA id m68sm2344576pga.46.2020.11.06.09.09.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Nov 2020 09:09:13 -0800 (PST)
Subject: Re: [PATCH v2 1/4] linux-user/sparc: Correct
 sparc64_get/set_context() FPU handling
To: Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org
References: <20201106152738.26026-1-peter.maydell@linaro.org>
 <20201106152738.26026-2-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <29cf2911-b92a-ada5-fb03-18cd022fee14@linaro.org>
Date: Fri, 6 Nov 2020 09:09:11 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201106152738.26026-2-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: Giuseppe Musacchio <thatlemon@gmail.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Laurent Vivier <laurent@vivier.eu>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 11/6/20 7:27 AM, Peter Maydell wrote:
> +        if (fprs & FPRS_DU) {
> +            for (i = 16; i < 31; i++) {

32.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

