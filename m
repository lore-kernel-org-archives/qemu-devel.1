Return-Path: <SRS0=xYMn=7P=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1CECC433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 00:41:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6C9CE20674
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Jun 2020 00:41:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QaKPWZIK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6C9CE20674
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54470 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jfuzY-0000Oi-L6
	for qemu-devel@archiver.kernel.org; Mon, 01 Jun 2020 20:41:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfuyj-0008Dj-PN
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 20:40:29 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:45955)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jfuyi-0001Ql-VW
 for qemu-devel@nongnu.org; Mon, 01 Jun 2020 20:40:29 -0400
Received: by mail-pg1-x541.google.com with SMTP id f21so4251885pgg.12
 for <qemu-devel@nongnu.org>; Mon, 01 Jun 2020 17:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Nzvkza+wwUwUXI0A7j5G5COIwo/zVmiMKp97kPpxA2E=;
 b=QaKPWZIK70ZAUq/SkyI2G5L0bse8Ppy/qht16sYJyVc+28zAO5mnTMp52Azk51kwjB
 gyJv1gcB9Bm4/alla+tL6xydbM3q7qM7h3+BHCoK8lmt79nR9SXUi/DtL4EPOt6PrBNO
 Nuj2NgxKHVbzwi4V1bMouEILJKlx52amOFWiO8C46U/0DVKMJF5TAnlWRsV+uqr/VFpW
 hRQFm96E5uRYx04DUfOlM6qUb0//uEa25SN5kTq9J7FnVYxqsRAK7f4nbd+5uPUnWK14
 HdT3ghPBZ+53EjPi5T2vHR3ci4I3FZjugXtqeaFAJS+80MFnSEVNezExKUfxhEFiUCTU
 dgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Nzvkza+wwUwUXI0A7j5G5COIwo/zVmiMKp97kPpxA2E=;
 b=CG/wFHhYrKPBwy3E2WM297nj8hfxqvyse6Yhye9EIoxa6aPKjrEZFN8CYHoKpdnb3e
 v25RvKsCLLvtL/pEf8LgVfDoM2yo9hQu/Lo0lnHW2/Bdk0XJuoFIMOPNxYYA3/ohNbCP
 vyoDb0SBA93Robs4EUq4lqdDKxku9VgAgvyceKAdETWNIKyf7nSjr8xc7wCw15xxLeh0
 dRcRgavV7FXf0EXR3jDiC5kNDEowqHZvm+w6lP3fy7QFMCufhqNXAOPaEH+Q5zmUqLB/
 yj6f3sx3Ge59Ydu5EHeU3VkdpZaqriL8qkvBWfsXCkZCohzYzGtG3MOFhORw8u32GxDN
 +HLw==
X-Gm-Message-State: AOAM532Zwh9cDTvpuUB18FeUsORof6Re+kikhg4eBRLJTEWEdD9PB/xW
 PvhvWDijh5qDN9StzpCeJvaEoSrfZys=
X-Google-Smtp-Source: ABdhPJxjuYhMorI1goZoK9RpI4ZKj+CKK+ZnQ6NNyWKbK6S4T+4nDT2mzaJAfSijmkAOAzSuSPz6Aw==
X-Received: by 2002:a05:6a00:843:: with SMTP id
 q3mr22078614pfk.107.1591058427630; 
 Mon, 01 Jun 2020 17:40:27 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id l23sm519373pgc.55.2020.06.01.17.40.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 01 Jun 2020 17:40:26 -0700 (PDT)
Subject: Re: [PATCH v1 3/3] tests/tcg: add simple commpage test case
To: =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
References: <20200527100546.29297-1-alex.bennee@linaro.org>
 <20200527100546.29297-4-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <286ec34b-06e0-92c5-4073-4951727ecb50@linaro.org>
Date: Mon, 1 Jun 2020 17:40:24 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200527100546.29297-4-alex.bennee@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
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
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 5/27/20 3:05 AM, Alex Bennée wrote:
> The COMMPAGE are a number of kernel provided user-space routines for
> 32 bit ARM systems. Add a basic series of smoke tests to ensure it is
> working as it should.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>  tests/tcg/arm/commpage.c      | 61 +++++++++++++++++++++++++++++++++++
>  tests/tcg/arm/Makefile.target |  2 ++
>  2 files changed, 63 insertions(+)
>  create mode 100644 tests/tcg/arm/commpage.c

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

