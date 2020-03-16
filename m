Return-Path: <SRS0=yzMV=5B=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8CE1C0044D
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:50:48 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 70EDF20679
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2020 19:50:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DYbnMOE1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 70EDF20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48082 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jDvl9-0001Qz-LZ
	for qemu-devel@archiver.kernel.org; Mon, 16 Mar 2020 15:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:32768)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1jDvkT-0000qe-Dc
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:50:06 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1jDvkS-0003sB-Ev
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:50:05 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:34070)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1jDvkS-0003pQ-76
 for qemu-devel@nongnu.org; Mon, 16 Mar 2020 15:50:04 -0400
Received: by mail-pg1-x541.google.com with SMTP id t3so10327112pgn.1
 for <qemu-devel@nongnu.org>; Mon, 16 Mar 2020 12:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=JIIXamngHKCNeGNFCvKp7fJI5aol/285BJCeJ13G1Aw=;
 b=DYbnMOE1p6fNHBWyNshe1JqLgxkUEJKp7IhCGmrY8cQDYCWT97FIzU4UlcQoTOEmNc
 g+gaRYp8IijbJOjjbBqgwoTfujYM9FpLbAmI3COsf696qM2MxpfS8VYjReiUHhSsA29u
 v3qm/j5bnDmx3amXZBrIAGvx1FczjljWwZivI9824aK4zXP2kucEEUzIdHrNjK42dj3w
 Vk9JhkgmJWv4i+/b2eVBzlzykm68EUFFpqn0dyvH0cxzsPIvQaYJX5lfO5ClPUxFJAGE
 d+YMrfFyFmX3wmnJPLu0yhGNIYVIU759uwfv4pvbaTmlwdTeKQPxE9xwovTsSJk1kZEH
 RucA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=JIIXamngHKCNeGNFCvKp7fJI5aol/285BJCeJ13G1Aw=;
 b=mzkef6MAQ4O0N7kqQ/we3hO0OXkr5RlWHzCTqpjV4+o64XxNbk8cJIUIwiB4rSH6Fy
 n2MdajmQ/f8HV8XPFx6Mvi2mzTGCipFlJ+zkx7utzC2W5F0if3EA6MlneA3svjdfbUbp
 eNM1l/Oi03FbQaAaNt9UL6Gd6hETS0BCqwyy4JbB+yPIcBtDYshQHftXnfCQIwNnkMc1
 5D5FqAq88MsUoHKYDNdtFWuI2+IC3Nw36fXf2TqtJCBtEqMGQ5+++8iehIEMTkvqLkCb
 rRRUjE5o9zW+bEBVVxjluNKjkhYjILP1DMXtO2E98C3QTvzuOca1Y7OKz4+LFKcChcKh
 fxYA==
X-Gm-Message-State: ANhLgQ2r6S16KLyHeKe3TgZzLd02le0yl+u7kazu7YSLNACBt3/SKbs7
 YVrWit7CkTaM2hwrq+b2ketvAg==
X-Google-Smtp-Source: ADFU+vt0yq9wHnOPkKK1VlQnOJyORm9Djm7DBt1D1EXniKGL7V6557Qng/hrzuvzNfQpAtJaK3s2IA==
X-Received: by 2002:a63:58e:: with SMTP id 136mr1382048pgf.306.1584388203071; 
 Mon, 16 Mar 2020 12:50:03 -0700 (PDT)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 md20sm564159pjb.15.2020.03.16.12.50.01
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 16 Mar 2020 12:50:02 -0700 (PDT)
Subject: Re: [PATCH v3 10/19] target/arm: Restrict ARMv4 cpus to TCG accel
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 qemu-devel@nongnu.org
References: <20200316160634.3386-1-philmd@redhat.com>
 <20200316160634.3386-11-philmd@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <b5c047f3-ab3e-825d-35c8-b24c8efc616e@linaro.org>
Date: Mon, 16 Mar 2020 12:50:00 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200316160634.3386-11-philmd@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::541
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
Cc: Fam Zheng <fam@euphon.net>, Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>, kvm@vger.kernel.org, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Alex_Benn=c3=a9e?= <alex.bennee@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 3/16/20 9:06 AM, Philippe Mathieu-Daudé wrote:
> +static const ARMCPUInfo arm_v4_cpus[] = {
> +    { .name = "ti925t",      .initfn = ti925t_initfn },
> +    { .name = "sa1100",      .initfn = sa1100_initfn },
> +    { .name = "sa1110",      .initfn = sa1110_initfn },
> +    { .name = NULL }
> +};
> +
> +static void arm_v4_cpu_register_types(void)
> +{
> +    const ARMCPUInfo *info = arm_v4_cpus;
> +
> +    while (info->name) {
> +        arm_cpu_register(info);
> +        info++;
> +    }
> +}

I much prefer ARRAY_SIZE() to sentinels.
I know the existing code make much use of them,
but we don't need to replicate that here.


r~

