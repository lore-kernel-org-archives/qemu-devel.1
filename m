Return-Path: <SRS0=N0XV=XP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3265C3A5A2
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 22:00:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6D79620820
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2019 22:00:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vDW+y7o+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6D79620820
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35674 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iBQwz-0004Dl-Ew
	for qemu-devel@archiver.kernel.org; Fri, 20 Sep 2019 18:00:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55691)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iBQwC-0003nm-GL
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 17:59:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iBQwB-0000nU-3x
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 17:59:36 -0400
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641]:37088)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iBQwA-0000nH-SN
 for qemu-devel@nongnu.org; Fri, 20 Sep 2019 17:59:35 -0400
Received: by mail-pl1-x641.google.com with SMTP id b10so3808872plr.4
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2019 14:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=Fl/f3/ggFALzae9KsX0yoWKHmaMvS7SHiXxmHzfRV2g=;
 b=vDW+y7o+zX5Fz1FCK2oMXaFJWCbR6923xJDqoc0+TnBTiHo8q+kwtXLAGBOs6aka7X
 Ds5NdII/ESvYD0IzzZqovlRZ2qMDpTZ9AlVNNagNtkxsdiXjS9DZ4DHCy4l/fkMDFDBd
 8CtUk76bXOHdPaK7lLyAqCZpmhemST7IUVqPA0GDK9LsO0ZTgSm9nUFr6aq6kLzR/t3P
 STkQN/ArmDNVt6B4ZR13t0HxvQL2ygw1iVHmam32wePD3XYh4aI2/5/VeClMJKqqNUQx
 UpUtsF33/fiMcj31arwUUkaYn2F8MBa9XJEt77vf7Q8XW5gveAUwQEjOtqF/eIKak3fA
 ajRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=Fl/f3/ggFALzae9KsX0yoWKHmaMvS7SHiXxmHzfRV2g=;
 b=VoCI0/8z232NanLzKqRDIpiIX08Oz75VvIYXYieYXbfdVEJyxW3R2eoOiMR2wGFHMw
 hBGh2ajN5E0c9wOfdI1kdLswF4R8GE4bSWLr6vqIeG3LuYlCHGI6rOR6DNSMzhuyykBY
 7MJT5eeZav18s++jC+ZefsJrP5Kf8SEMLAc1mWjfxNkKNiPrNfA83XIya92I7hMWy0PN
 4uwnHlbocm/4HC5y1Wi5dMEjryggaYATS+5YweKITMi29dMeY37J8zYLCRgJ/mWfluuK
 ztoNTHYS2MPiNzUuSgTsVLJY32mZNruu7uyUEmm/zITmnEranHI46wbhDvcKCP60dJ5a
 q+RQ==
X-Gm-Message-State: APjAAAUc05Em25S5HlWbfalAA21NVhWtFAa7USMS+pFv0qSclg0VDLx5
 RcyOB2wUMm61qGdP+qSBxVRAQ0esHWM=
X-Google-Smtp-Source: APXvYqxmu+f4kgRO2AzR0ZsxzOi2tprfMDyfQQzrHe4ENTupxy/6MD1qs45ITaFoOzD5f9I8lyY3gQ==
X-Received: by 2002:a17:902:202:: with SMTP id 2mr18424853plc.96.1569016772774; 
 Fri, 20 Sep 2019 14:59:32 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id c10sm3478780pfo.49.2019.09.20.14.59.31
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Fri, 20 Sep 2019 14:59:31 -0700 (PDT)
Subject: Re: [PATCH] hw/arm/boot.c: Set NSACR.{CP11,CP10} for NS kernel boots
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
References: <20190920174039.3916-1-peter.maydell@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <ef0f2fab-d482-cb88-4966-ca9a2eb7ab44@linaro.org>
Date: Fri, 20 Sep 2019 14:59:29 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20190920174039.3916-1-peter.maydell@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::641
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

On 9/20/19 10:40 AM, Peter Maydell wrote:
> If we're booting a Linux kernel directly into Non-Secure
> state on a CPU which has Secure state, then make sure we
> set the NSACR CP11 and CP10 bits, so that Non-Secure is allowed
> to access the FPU. Otherwise an AArch32 kernel will UNDEF as
> soon as it tries to use the FPU.
> 
> It used to not matter that we didn't do this until commit
> fc1120a7f5f2d4b6, where we implemented actually honouring
> these NSACR bits.
> 
> The problem only exists for CPUs where EL3 is AArch32; the
> equivalent AArch64 trap bits are in CPTR_EL3 and are "0 to
> not trap, 1 to trap", so the reset value of the register
> permits NS access, unlike NSACR.
> 
> Fixes: fc1120a7f5
> Fixes: https://bugs.launchpad.net/qemu/+bug/1844597
> Cc: qemu-stable@nongnu.org
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

