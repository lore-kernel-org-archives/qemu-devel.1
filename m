Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43527C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:38:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0F2662067D
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 19:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="uMzM7m7r"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0F2662067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53886 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jv4HY-0006Z2-97
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 15:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48182)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv4GR-0005Aj-NY
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:37:23 -0400
Received: from mail-pj1-x1041.google.com ([2607:f8b0:4864:20::1041]:34407)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1jv4GP-0000rJ-K4
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 15:37:23 -0400
Received: by mail-pj1-x1041.google.com with SMTP id cv18so277996pjb.1
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 12:37:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=8dSFPC2TqmapCBW8WPoAAHp112NndR+7CwAV2qvOd6w=;
 b=uMzM7m7rXvoRXf0KHwK0pWkynApGtmeY0b9iCmK1r+g1wKUT2ZsbIKvF14PcG2CQZ3
 E9IJSUdKDzNEV9zNSZbAZHUeOwB4rhyZ4+n1TAbDqy6Z96Olm6VwxfrF5sFETj1PGEo7
 qZb0CmPnt+TOr55/T/9SsgPG97doEoQ/z73bub8dkEfhb6vKRDZUXo/ZqG3aKfZnBGNJ
 ydvX3/09rbYXH4hCqDrbrcelvRohc+vU1D5tSooG10+SVtmWCoSzYqGN6hQLOFStEPk/
 1VbSSRJ2GSqp63cdmt6jUQY+0s+cLbP/hqDSWbg5mRlLNgmJcUfwjkbW5zlpziQqHzcT
 Fq4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=8dSFPC2TqmapCBW8WPoAAHp112NndR+7CwAV2qvOd6w=;
 b=Dd8jEKy8XPZ21Dx9duUibfh2YYFJecSrU1J31QU2T0IsyjpZTCvouOMIevT2NGNbwW
 9lx2H+e3sk533eOSt/Jm+2Wwl49TvIZCtqBUdckJDEXt++rM/H5+WsijpJ3W8z+nciXL
 ETziJqV70HQcpad+j8y3lECXHoD1tPo0xFeaJSfeSNXGpL73xD94ayUXXKELdYM//bfs
 RBNgVKjEJm/hrajedK784Z6m3oIZhFxevJVxn92/wuVKz8EF2h26FTOFEsNMb6n09fLo
 iHSI0bWHajT+fTNHM2zm8pyAeENyUM6j/sEFTHT4UWJcC1TZtoEr3UmIjxWL9FXXWqnW
 BVMg==
X-Gm-Message-State: AOAM533Z9ZCiEHupiRitT92fvkZiCftum9Irx1/pOiAvyf5M1dgdyPg8
 /8oKk/LHDqYtN1DaaaEcvQJcFg==
X-Google-Smtp-Source: ABdhPJyKIbXka88XbQ4eYvXZUgNu85s9NlS0KzCbrAF1xVvJ8jnVhJ8skvSeUtxsGsN1gATI1lPEEg==
X-Received: by 2002:a17:90b:234f:: with SMTP id
 ms15mr890276pjb.7.1594669040190; 
 Mon, 13 Jul 2020 12:37:20 -0700 (PDT)
Received: from [192.168.1.11] (174-21-143-238.tukw.qwest.net. [174.21.143.238])
 by smtp.gmail.com with ESMTPSA id t188sm15641037pfc.198.2020.07.13.12.37.19
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Jul 2020 12:37:19 -0700 (PDT)
Subject: Re: [RFC PATCH 8/8] fpu/softfloat: define misc operation for bfloat16
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org
References: <20200712234521.3972-1-zhiwei_liu@c-sky.com>
 <20200712234521.3972-9-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <d4937836-a4b5-4258-bafb-7545658ea872@linaro.org>
Date: Mon, 13 Jul 2020 12:37:17 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200712234521.3972-9-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1041;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1041.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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
Cc: wenmeng_zhang@c-sky.com, alex.bennee@linaro.org, wxy194768@alibaba-inc.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 7/12/20 4:45 PM, LIU Zhiwei wrote:
> Signed-off-by: LIU Zhiwei <zhiwei_liu@c-sky.com>
> ---
>  fpu/softfloat-specialize.inc.c | 38 +++++++++++++++++++++++++++++++
>  include/fpu/softfloat.h        | 41 ++++++++++++++++++++++++++++++++++
>  2 files changed, 79 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

s/brain floating-point/bfloat16/.


r~

