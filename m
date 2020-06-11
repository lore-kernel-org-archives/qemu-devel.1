Return-Path: <SRS0=U615=7Y=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26163C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:34:40 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E50A5206C3
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jun 2020 16:34:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="k158iE1C"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E50A5206C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53460 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jjQA3-0004Dl-2T
	for qemu-devel@archiver.kernel.org; Thu, 11 Jun 2020 12:34:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56762)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjQ1p-0000As-6s
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:26:09 -0400
Received: from mail-pl1-x642.google.com ([2607:f8b0:4864:20::642]:42692)
 by eggs.gnu.org with esmtps (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jjQ1m-0006KD-9z
 for qemu-devel@nongnu.org; Thu, 11 Jun 2020 12:26:08 -0400
Received: by mail-pl1-x642.google.com with SMTP id x11so2505390plv.9
 for <qemu-devel@nongnu.org>; Thu, 11 Jun 2020 09:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:message-id:date:user-agent:mime-version
 :in-reply-to:content-language:content-transfer-encoding;
 bh=py+5FHz0gv2HmRSnBja2NeB+YV/T5Ene0y2g6hXvAW0=;
 b=k158iE1CDU86EHUdy7o2GAlstD+7VMCu6gmgTrJxtbHjzFA1tImZPNGW7uK9J0D98b
 Bu4qC6+Kt+VI0vM2SreTTqR64hQe0kvuwj1A5SnRx0Y4lcyhXwsyNe43Ujxpbr+aIfHN
 EO+lpF+Y9ME8gVmmzejgU5j3laJZWpBKhmW8NMZThxHoHylWWGx0sBa8Kg5ygiVgI59i
 zKXvTBzvE/OyWXP6Rk722Qq75zGFqumZ4Q4K1duKM2vf55wykSa5muVNghl+POgaxyGh
 g6MimcyZQRSGkAvwWClbYZW+1xqo/qZJPMifeMdytwDMJmahFmXq8BDVGqWcRrwpYZcK
 Hfgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=py+5FHz0gv2HmRSnBja2NeB+YV/T5Ene0y2g6hXvAW0=;
 b=iEOZvfyCQEo41w7FROU1LT3gxD0d3x9pfw3UWO1MXQMg9ikAoOmDnxQyom1MaUBhdz
 X8WXmnZKv8wDe/HRXN/ifjsC/S+Z3L347riv3Su3XW+EAprAyWG2dizfd9EZ9RZfYtz8
 juYIj8nqa4SE1sy/uMv4BOMITs3XX7wfFdhGKUbk2zlBzZcahoN9/WYEuf0HqmcIb3TG
 UWLtgm9jw7a7y+C7otGojphoGUJcqaHgtMJxNbkhI7n0/kZQ+eg/C6Ya40cBVywwY3Ze
 tnnPLN4r1HH+AiKtoGDJW9TJlG0IfGv02koPPDOHzVKoR1XTfNVKNXenNEifxCmxxfZA
 RRYw==
X-Gm-Message-State: AOAM530fgcaVAyaJ+41EaDHe5oG/gaamH0gUucFANERNefl25uJR6yZ2
 S8MMil/1J9nB6E3JxGzqiZ1oZWBTgUU=
X-Google-Smtp-Source: ABdhPJyqUpOw+6im7GToEh0Q1cY9IuTaRx4ON48ejs4hfA+qD7W5hbTT2RTN10nz2xttWfECdyj5iw==
X-Received: by 2002:a17:902:c697:: with SMTP id
 r23mr7806126plx.312.1591892756997; 
 Thu, 11 Jun 2020 09:25:56 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id f3sm3269390pjw.57.2020.06.11.09.25.56
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 11 Jun 2020 09:25:56 -0700 (PDT)
Subject: Re: [PATCH 07/10] target/arm: Convert Neon 2-reg-scalar long
 multiplies to decodetree
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20200611144529.8873-1-peter.maydell@linaro.org>
 <20200611144529.8873-8-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <de8e8d1c-a9aa-187b-0ef2-eef909ad5a9a@linaro.org>
Date: Thu, 11 Jun 2020 09:25:54 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200611144529.8873-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::642;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x642.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=_AUTOLEARN
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

On 6/11/20 7:45 AM, Peter Maydell wrote:
> Convert the Neon 2-reg-scalar long multiplies to decodetree.
> These are the last instructions in the group.
> 
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  target/arm/neon-dp.decode       |  18 ++++
>  target/arm/translate-neon.inc.c | 163 ++++++++++++++++++++++++++++
>  target/arm/translate.c          | 182 ++------------------------------
>  3 files changed, 187 insertions(+), 176 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~


