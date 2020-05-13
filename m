Return-Path: <SRS0=Qw6D=63=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C35DDC433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:29:25 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17EE420575
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2020 20:29:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="arF6XLXr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17EE420575
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44322 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jYy0K-0004Sy-NX
	for qemu-devel@archiver.kernel.org; Wed, 13 May 2020 16:29:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53408)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYxyr-0001tp-1h
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:27:53 -0400
Received: from mail-pj1-x1044.google.com ([2607:f8b0:4864:20::1044]:40616)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jYxyp-0005Jq-WE
 for qemu-devel@nongnu.org; Wed, 13 May 2020 16:27:52 -0400
Received: by mail-pj1-x1044.google.com with SMTP id fu13so11477002pjb.5
 for <qemu-devel@nongnu.org>; Wed, 13 May 2020 13:27:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=94tCrSIi/KmR8/Up4L70I/FWg637eCFQKVyCm4NEFFM=;
 b=arF6XLXrHIzVd7KNRv+tTliH1adCCkPSe+KTwDDaNR50pGqJNCKrtp9KqMdVm5yUi0
 KqHkTm8TkvvAbFMcce4RDS9zsgJvhhEL2S8m09OItsiacWNF7NCXnWImdMRwndI09fXy
 22H/2eCABp7hesn570XV6ZABzHGBaE0YxfLMSItkHvmcmJKlcPylOKj4GtLZ94DrX2Qv
 9Z/rr1VPbf2wo5eXGQz45jtwCOiFDXVHuqpDFlO1p0R5I0YJQNVK/F+gowgsUi2RMuUu
 IRXZB9yyGuDkqvvopdSBZr7kJ7D8t0NMIXujW7XOHUzqooxg9Nh3VwycboiGl5rBT8PK
 pquw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=94tCrSIi/KmR8/Up4L70I/FWg637eCFQKVyCm4NEFFM=;
 b=YcMxkHa7kV7v+CdH0ZkEiZiyBAmWudgEMqsh3TLhvFrZ3KCTTWUXvVuT1gyqyVXEDS
 9cyMijHzZT8f44v5ZbSK1+S9KPNKqanDfcXv6kf/MlMSZ3kWeNv8h2lJp/TwGRY3Pjs6
 iok99uSMoEFWnQ7Uau6+XitRkZPdTWqsgAuYm9AmP0R6zdRIBTEzv3y+id7HK8iLfC+H
 Gl1gWx+NcJbe1dP30bllf1eoYvaCYMQcwSPbH8Gdo33wV33IPrl6x6IBwHqXpe49kLh3
 InoGefOMhvuFqvhTdHXhaNqn5zvTw1hTWshB7Jp7ylwKhjQZLEZyfhcOfUJPxBpkJiEy
 iIQQ==
X-Gm-Message-State: AOAM5322GX8bGsRMn0dWEcrXjh21xkXQIuqBIgN+FMNukirXQ4WdA/pO
 ulBjLYeHssyI6LwwgofXPJ9rXUgu5sY=
X-Google-Smtp-Source: ABdhPJzXes6Joeo1+Ecb6gTpGLKih9D5G97otphIixc5fwFCn5VU52UT6mU4l7FW23EsSfoHpK1tzQ==
X-Received: by 2002:a17:902:d907:: with SMTP id
 c7mr909978plz.200.1589401670302; 
 Wed, 13 May 2020 13:27:50 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id q62sm16968898pjh.57.2020.05.13.13.27.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 13 May 2020 13:27:49 -0700 (PDT)
Subject: Re: [PATCH v2 03/17] target/arm: Convert Neon 64-bit element
 3-reg-same insns
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200512163904.10918-1-peter.maydell@linaro.org>
 <20200512163904.10918-4-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <a1bb49cd-3a45-8d76-ebc3-de0f81cf212f@linaro.org>
Date: Wed, 13 May 2020 13:27:47 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200512163904.10918-4-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1044;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1044.google.com
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/12/20 9:38 AM, Peter Maydell wrote:
> Convert the 64-bit element insns in the 3-reg-same group
> to decodetree. This covers VQSHL, VRSHL and VQRSHL where
> size==0b11.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       | 21 ++++++++++++++++++
>  target/arm/translate-neon.inc.c | 24 +++++++++++++++++++++
>  target/arm/translate.c          | 38 ++-------------------------------
>  3 files changed, 47 insertions(+), 36 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

