Return-Path: <SRS0=CnYV=4F=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB101C34022
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:58:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99A0A207FD
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2020 18:58:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qcXSkEAu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99A0A207FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:51010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j3lap-0006sN-T3
	for qemu-devel@archiver.kernel.org; Mon, 17 Feb 2020 13:58:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50321)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1j3la9-0006IA-9q
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:57:26 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1j3la8-00087G-Fd
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:57:25 -0500
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:33882)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1j3la8-00086y-Ac
 for qemu-devel@nongnu.org; Mon, 17 Feb 2020 13:57:24 -0500
Received: by mail-pg1-x541.google.com with SMTP id j4so9687185pgi.1
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2020 10:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=OrQ87Mo1G4nIGFgelk22OWo/vzSSWntxzmTb97TOftk=;
 b=qcXSkEAuMgOnalxd1ydzo/VcchSpDCMPJNv74tH+7/SvLcVRgESObM0tfnn+hVJ7Tm
 CfdAJ/9KF8PECW003VXhrKu/dUckdKYQQiivYRTpfJCOYl7nCphQnSljVo4bcFw0Ig66
 LD7aGYpxmDW3RMSE1DmA4Yu7+4yO/IDvT/lPOojRRoHMkOvieyfbm4qJjvXv55hFjXZy
 Rqfe4hCTxqZIDjvPK8MCbh21C34trDxxciFy4gxsc8U6JEJ0QbzowrmvF/skxS/QnasA
 oiW0whU1g2+givil8c7N7dZRpnVpd/Tc2NFqzPZQPTUifhDazyTk/PVQzcc3tXdB6Rrb
 H77g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=OrQ87Mo1G4nIGFgelk22OWo/vzSSWntxzmTb97TOftk=;
 b=bPSLD0K+GgoM+SBpB26cPu0vAKT45kv2ksnw29SXZO0wcuH/SSgpsY2rW8qCOE1Acc
 ncNE1rOm0wZX3qmGsk3Qc008nRPm6OujEAf0Appc73iy3HJXdahdBtkLqv7j5iSSQWix
 t7gsVwbsXb+qrsbEob41HXDhyqWQ/yjI11cdCNu1KoC3fsyRDSIPCW7U6Zbqr1ohCmXd
 nz3j7Hv0aTuMcD77vukol+zy+NPU1s7DKqJiICdcI7MP5vUbkqfH26mpBtqlIgBbtyLO
 1v26uLSAGA7PW2VD/4hg6zYCq+z4Kn2fQsRTCTaTJO8esI1yPhF9gGmGWbfRFeZ0gl9j
 Rz8w==
X-Gm-Message-State: APjAAAWDswwXPwgid+6NhMxpMIDYqhc+h8pObpa7TFI6iG5gGh4f5GjZ
 WhItHQOT+O6kN6vW8J1qDizSmQ==
X-Google-Smtp-Source: APXvYqw+2GJjM27K1a6TmL3IYkZ2l6p4qXJvRJh1G2EjoWY6+pgnNuWLdcNbsw4RgZCpGTs2uGTBiQ==
X-Received: by 2002:a62:1b4f:: with SMTP id b76mr18446594pfb.163.1581965843436; 
 Mon, 17 Feb 2020 10:57:23 -0800 (PST)
Received: from [192.168.1.11] (97-126-123-70.tukw.qwest.net. [97.126.123.70])
 by smtp.gmail.com with ESMTPSA id
 t11sm189501pjo.21.2020.02.17.10.57.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2020 10:57:22 -0800 (PST)
Subject: Re: [PATCH v5 16/79] arm/imx25_pdk: use memdev for RAM
To: Igor Mammedov <imammedo@redhat.com>, qemu-devel@nongnu.org
References: <20200217173452.15243-1-imammedo@redhat.com>
 <20200217173452.15243-17-imammedo@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <91a3e5a5-7057-cd75-cd26-6ad7d99f753b@linaro.org>
Date: Mon, 17 Feb 2020 10:57:20 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200217173452.15243-17-imammedo@redhat.com>
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, jcd@tribudubois.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2/17/20 9:33 AM, Igor Mammedov wrote:
> memory_region_allocate_system_memory() API is going away, so
> replace it with memdev allocated MemoryRegion. The later is
> initialized by generic code, so board only needs to opt in
> to memdev scheme by providing
>   MachineClass::default_ram_id
> and using MachineState::ram instead of manually initializing
> RAM memory region.
> 
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


