Return-Path: <SRS0=BZbV=DR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AF3B4C433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 15:19:06 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1D31422280
	for <qemu-devel@archiver.kernel.org>; Sat, 10 Oct 2020 15:19:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a6yY7bpe"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1D31422280
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=amsat.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44986 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kRGeG-000746-P6
	for qemu-devel@archiver.kernel.org; Sat, 10 Oct 2020 11:19:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34530)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRGcp-0006CF-Tk; Sat, 10 Oct 2020 11:17:35 -0400
Received: from mail-wm1-x343.google.com ([2a00:1450:4864:20::343]:40001)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philippe.mathieu.daude@gmail.com>)
 id 1kRGcf-0006pd-5f; Sat, 10 Oct 2020 11:17:29 -0400
Received: by mail-wm1-x343.google.com with SMTP id k18so12610109wmj.5;
 Sat, 10 Oct 2020 08:17:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=sender:subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=rZUK4OpgM9LDSuM+PftlglNnkrsDkN4iy8skrvx7zaQ=;
 b=a6yY7bpeVfflurfL3PA2HjXerIF+8xFrpPC2IekDNjdKP39IgixUjUQWkcC3R1V7fY
 pGQ54AfoO/tSa36JWtFMSidUKg2bTYWRsD3OOHDks2AjZlPF72LWkWqf7SWyAJB8kB+q
 xgMqzhbJQFO3tZ/FfhvXA7nVQNWrLEG1hMIoL6ZawOwFu598IaLAQI3XH5DXdnT1gcxY
 iPfJ6AEmHXdNpqc3vF17zNtkbpZFEqDy4robbE0X4M5fTLW7q1qxDADH+FNsEmkh2UNn
 K7+Mp1fTG7a+tFoh9tufu857NjqN+n4dWzjv2ERxp/eA1oIcdTUXPnYsB7fwhRPwgSPe
 IJ4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=rZUK4OpgM9LDSuM+PftlglNnkrsDkN4iy8skrvx7zaQ=;
 b=CEret54jJkUUlfuLOxrNqSP1qf0sdYFGZ6Zm0Htb0QPO+q+kUqjl6OJdTbdQC18LR/
 TvVJ/073BYgBWighT5zCREHe+pXG52HcS9YO00KveM9c5sSBwTLgz863kkh10dCIhWQm
 EGgp2IwAUnM09krJrK17a2F1cL9qqVgRfzprgMPiRHHBQI+cV3Cgnf3sxwlGOzHtTMNO
 HiQEOuvsUH2Sq6lOjnrIOdqvw8R1mdd0KikcP2Ql80KxU9UR74U4bDl7erH6dX2tJOQm
 o5Y/zSvYDCDXQFUniT1vqmGmZSqcgflf44b71cTmjpBUHznrox1YuxFIv/aMBLIElheP
 1ing==
X-Gm-Message-State: AOAM530KFjD782GRBbZ4hGhjBRZzy3yJKN/nBJSOUtlfJd1GebBukmqk
 EnAE8ndnv3V2uOVQhv/zysM=
X-Google-Smtp-Source: ABdhPJyz1X96dX7SISI9t4HyezEPNdDrBQHH+RkdnIeTdXQ8v35Q1jRcDmUPZNW0WAz40rGBknWafQ==
X-Received: by 2002:a7b:cb82:: with SMTP id m2mr3313045wmi.56.1602343037794;
 Sat, 10 Oct 2020 08:17:17 -0700 (PDT)
Received: from [192.168.1.36] (106.red-83-59-162.dynamicip.rima-tde.net.
 [83.59.162.106])
 by smtp.gmail.com with ESMTPSA id g139sm16781658wme.2.2020.10.10.08.17.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Oct 2020 08:17:16 -0700 (PDT)
Subject: Re: [PATCH v3 03/15] hw/core/clock: add the clock_new helper function
To: Luc Michel <luc@lmichel.fr>, qemu-devel@nongnu.org
References: <20201010135759.437903-1-luc@lmichel.fr>
 <20201010135759.437903-4-luc@lmichel.fr>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <f4bug@amsat.org>
Message-ID: <f49f1c17-9343-c5dc-51fd-da0edb208314@amsat.org>
Date: Sat, 10 Oct 2020 17:17:15 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.3.1
MIME-Version: 1.0
In-Reply-To: <20201010135759.437903-4-luc@lmichel.fr>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::343;
 envelope-from=philippe.mathieu.daude@gmail.com; helo=mail-wm1-x343.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FORGED_FROMDOMAIN=0.001,
 FREEMAIL_FROM=0.001, HEADER_FROM_DIFFERENT_DOMAINS=0.249, NICE_REPLY_A=-0.207,
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
Cc: Damien Hedde <damien.hedde@greensocs.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Havard Skinnemoen <hskinnemoen@google.com>,
 Andrew Baumann <Andrew.Baumann@microsoft.com>,
 Paul Zimmerman <pauldzim@gmail.com>,
 Niek Linnenbank <nieklinnenbank@gmail.com>, qemu-arm@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/10/20 3:57 PM, Luc Michel wrote:
> This function creates a clock and parents it to another object with a given
> name. It calls clock_setup_canonical_path before returning the new
> clock.
> 
> This function is useful to create clocks in devices when one doesn't
> want to expose it at the qdev level (as an input or an output).
> 
> Suggested-by: Philippe Mathieu-Daudé <f4bug@amsat.org>
> Signed-off-by: Luc Michel <luc@lmichel.fr>
> ---
>   include/hw/clock.h | 13 +++++++++++++
>   hw/core/clock.c    | 15 +++++++++++++++
>   2 files changed, 28 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <f4bug@amsat.org>


