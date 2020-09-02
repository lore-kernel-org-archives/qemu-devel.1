Return-Path: <SRS0=ff1W=CL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B5FC433E2
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 20:44:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C58420767
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Sep 2020 20:44:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="q8xX1wj8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C58420767
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59160 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kDZc8-0006Ae-Il
	for qemu-devel@archiver.kernel.org; Wed, 02 Sep 2020 16:44:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40050)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDZbM-0004ry-Qa
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 16:43:28 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:40077)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1kDZbL-0002iE-2N
 for qemu-devel@nongnu.org; Wed, 02 Sep 2020 16:43:28 -0400
Received: by mail-pg1-x541.google.com with SMTP id h12so282911pgm.7
 for <qemu-devel@nongnu.org>; Wed, 02 Sep 2020 13:43:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=A4Buu1CW2Wwkljix4C9rYHl8GB70Jee/OZwOZdSBEKQ=;
 b=q8xX1wj8FeF4IRh71nQljQemE+wH1J+z5cGmzuDIsztzjUSzT5FPOOKgzyJSvg+ru/
 jcTm5RwSy6rM7S41iEV7Z0yEk2/CakWipQ0+N2nd23Li0lhcOSNKljM05u6Ara88GC5b
 3f2WJEJHvrPVULOMdvK+96NE9e+nAyH17lEhk2k6NE8Wxa38ZEC9Vm1/4oRR8txFZ67i
 RuOG5/xcB4iWVmSg8zbezH4nhaD22RNwOPDnXBQ8p2w6VAHwVACqvTE/SvqUmaD9/EaX
 EgxvLT5N8ApZUiRUcPz4ZOlySfTFGhoWly8I4ge1geMcMFkEmMGQE6DNp+MM19qsd5UH
 OCOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=A4Buu1CW2Wwkljix4C9rYHl8GB70Jee/OZwOZdSBEKQ=;
 b=cOHLkeonPQgzTccGnZT07+B8HerWRzLlR+oxum88WlDpGSUeIdlHuUmdlVXOya5OKF
 BG5QzkLC+BYhb5Z+W1x8hhF1hRQyNoI3AGx9zJrKB6NRcvK0mPlGB0zXKQHkggNCLko/
 I+/DU7OIPUE6d6Kx2oox9hINOTUD31g0WS4uPlOMukT+rdfbvhmSRg8kIgMi0D9irWxl
 kwLCGNZb9i0weIfUelKwNG3rceGtc0lNlEgKHLkckqt4UcnHeIDwhXuml3MuSaMw3cPR
 ydxFwQyB885RBlLxeg3gKWkO5MOuoSaMBH60FNkDhLowbqqSC9x0yHv3Jn6EAxQwtEpH
 8mVw==
X-Gm-Message-State: AOAM533TyUDfCAVZ8dBHk5VfU+xozLH96/rJ6MqCCf4ge6QzA+brDfm3
 1z54kcXdXCEz+KTE7DWfI/H7OA==
X-Google-Smtp-Source: ABdhPJz5XrPMxYsi+lpDf4mp468IsOpCa0Nb44jtkO3ugDuiNvxrcS6M3r56SCKyTzhRemMIXiERtg==
X-Received: by 2002:aa7:824a:: with SMTP id e10mr259602pfn.62.1599079405859;
 Wed, 02 Sep 2020 13:43:25 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q11sm208722pgj.92.2020.09.02.13.43.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Sep 2020 13:43:25 -0700 (PDT)
Subject: Re: [PATCH v3 5/8] hw/hppa: Tell SeaBIOS port address of fw_cfg
To: Helge Deller <deller@gmx.de>, qemu-devel@nongnu.org
References: <20200902193456.29844-1-deller@gmx.de>
 <20200902193456.29844-6-deller@gmx.de>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <bab29b6f-210f-d01b-5301-840e0bf76a1b@linaro.org>
Date: Wed, 2 Sep 2020 13:43:23 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200902193456.29844-6-deller@gmx.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::541;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x541.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, NICE_REPLY_A=-0.324,
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
Cc: Richard Henderson <rth@twiddle.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 9/2/20 12:34 PM, Helge Deller wrote:
> Change QEMU_FW_CFG_IO_BASE to shorter variant FW_CFG_IO_BASE and hand
> over the actual port address in %r19 to SeaBIOS.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> ---
>  hw/hppa/hppa_hardware.h | 2 +-
>  hw/hppa/machine.c       | 7 ++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

