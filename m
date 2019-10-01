Return-Path: <SRS0=WBSu=X2=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60CA6ECE58A
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:59:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30F5E2168B
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Oct 2019 17:59:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xSUCO0Sm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30F5E2168B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:46138 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iFMQR-0001fA-8k
	for qemu-devel@archiver.kernel.org; Tue, 01 Oct 2019 13:59:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37462)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <richard.henderson@linaro.org>) id 1iFMPY-00016k-GU
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:58:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <richard.henderson@linaro.org>) id 1iFMPX-0005xg-JW
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:58:08 -0400
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541]:44864)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <richard.henderson@linaro.org>)
 id 1iFMPX-0005wG-CT
 for qemu-devel@nongnu.org; Tue, 01 Oct 2019 13:58:07 -0400
Received: by mail-pg1-x541.google.com with SMTP id i14so10160003pgt.11
 for <qemu-devel@nongnu.org>; Tue, 01 Oct 2019 10:58:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=GpG3ksufPUabInnVHaFmlcM2bJfnLvdb2nUimFeA08Q=;
 b=xSUCO0SmLutHE9MyHtPLHBggp79hImRbJhKlEMdnBZziHfO8misTP5aecFBZi3xcDN
 Rwqncr0enYd9iqO9mFFJp5daLAtE8LAc3cTXnwMiNlk/pJo6DuiMurhB3OAppLS9dE60
 iVtXhQIcsmy3NdFXKwZs8x7kvyrZ+6UOdfAsG/o9LtCQJC1HFyArUm1ebpY65BSbp3ll
 hPHPq1dQwTar4OljFCF3s/figfSn23984qHXxUVF4dDBG8FvW0EYVhOkImISd3ahcOpg
 Xxm5z+MoOdQ3WupgbwLiIIzxCXnENvxEGYhTXMB6Afi7cEu+4wWuVFkwP/XQwQSt940p
 pNLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
 :date:user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=GpG3ksufPUabInnVHaFmlcM2bJfnLvdb2nUimFeA08Q=;
 b=RGfCxquvA2i89fs5r93hi51/m9H65gX7TWCZIPGQb3TFfwOZJgYwW8ns9HFNjrEbkq
 dwhfBO/8mPfVywE06S1ib0zSfzZWoXI2RCVNagKlPVeNsdrRDj+7Qle9Trs/u7oOovzQ
 SXq16/KiFxSIQ14nmeoxGcMZqQUcKtoTVUYWCqhBAFLBP853MZShXhOZDCTVSqoxJzCP
 1+3snmu4Zk7OiMP7US5EXyPzpB85M5oAZDBJM46dbyVPVjxeC1ciWU1AgKgIgUJ0N+9j
 grpTVgJmwYPjlDGcUPXMXX5lYpvxNbJfnKU+VQhA/880ik60dv4hVI1gw5XkIR1S4R3d
 TEmw==
X-Gm-Message-State: APjAAAWwZJiwBcZy3Q8a9l5ljanCim2vh/Z6cCs/Ub46o6TZ/NBlc//w
 twc+2sghB0FOEKg1Jg2onwDqzw==
X-Google-Smtp-Source: APXvYqzCf1nNyyRE7Snq0KrLW8VzB9cE8x9ERYguQ8gDSSS3ZgQ93bQKAjDattLuGfxFEfmoVZJFJg==
X-Received: by 2002:aa7:9104:: with SMTP id 4mr29339661pfh.176.1569952686018; 
 Tue, 01 Oct 2019 10:58:06 -0700 (PDT)
Received: from [192.168.1.11] (97-113-7-119.tukw.qwest.net. [97.113.7.119])
 by smtp.gmail.com with ESMTPSA id o60sm4022122pje.21.2019.10.01.10.58.04
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 01 Oct 2019 10:58:05 -0700 (PDT)
Subject: Re: [PATCH v5 8/9] target/arm/cpu64: max cpu: Support sve properties
 with KVM
To: Andrew Jones <drjones@redhat.com>, qemu-devel@nongnu.org,
 qemu-arm@nongnu.org
References: <20191001125845.8793-1-drjones@redhat.com>
 <20191001125845.8793-9-drjones@redhat.com>
From: Richard Henderson <richard.henderson@linaro.org>
Openpgp: preference=signencrypt
Message-ID: <231b4353-9c4f-71e3-3337-bf858edabdfc@linaro.org>
Date: Tue, 1 Oct 2019 10:58:03 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20191001125845.8793-9-drjones@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
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
Cc: peter.maydell@linaro.org, armbru@redhat.com, eric.auger@redhat.com,
 imammedo@redhat.com, alex.bennee@linaro.org, Dave.Martin@arm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 10/1/19 5:58 AM, Andrew Jones wrote:
> Extend the SVE vq map initialization and validation with KVM's
> supported vector lengths when KVM is enabled. In order to determine
> and select supported lengths we add two new KVM functions for getting
> and setting the KVM_REG_ARM64_SVE_VLS pseudo-register.
> 
> This patch has been co-authored with Richard Henderson, who reworked
> the target/arm/cpu64.c changes in order to push all the validation and
> auto-enabling/disabling steps into the finalizer, resulting in a nice
> LOC reduction.
> 
> Signed-off-by: Andrew Jones <drjones@redhat.com>
> Reviewed-by: Eric Auger <eric.auger@redhat.com>
> ---

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~


