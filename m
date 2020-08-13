Return-Path: <SRS0=egLd=BX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60B0BC433E1
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:07:58 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 277322078D
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2020 16:07:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g3SlKTsL"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 277322078D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54392 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k6Fll-0002Gs-FQ
	for qemu-devel@archiver.kernel.org; Thu, 13 Aug 2020 12:07:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49474)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6Fku-0001Pa-UF
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:07:04 -0400
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543]:34741)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1k6Fkt-0006jT-Ac
 for qemu-devel@nongnu.org; Thu, 13 Aug 2020 12:07:04 -0400
Received: by mail-pg1-x543.google.com with SMTP id t6so3053125pgq.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2020 09:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=zl4TcEPtT3e7lS4cAe5siNauaUkxeDu98hbJ675hxiM=;
 b=g3SlKTsLVf/mGD0+0Zse4yxj8+/FXyOQ/4ao/Qo35DUtU+Nhww4V8TjC+YB0wWaDV4
 3vpcueYf9JI40RuuNwI21YRtxb969MBeZQim8GBXEKur0WTB6Il17tetzyIvFHZjSLMl
 JhBtxUyO1cEITzwwIu/uwKUloR2Gb9AG6gWVRdZ+sQLXjkrMqggTNMSpKM2alz12VM8G
 s8zj9el/PkVedJDyRaPccchcFPrAUTiCIt/gH09QSQQYnsDMz0EKuoJGPRVMME8pzLee
 TKaUR14K8Dt0Bt9GqP7YU4vTv4rJeJ58ubhYDJsd3I8cKFUYdff92jjIH0YwaqHJ8FIT
 zntA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=zl4TcEPtT3e7lS4cAe5siNauaUkxeDu98hbJ675hxiM=;
 b=rNF7Dpy0uHcFKrm+e1vNExAGByJWQFP+Q4ns8Mq+qYrBDLxzNc3i5ZOtnkapFbtVB3
 GCcana611kCwPsENIMT1yMaOSuMyiRi8OZ6xGj1ln3T0eMD41Q9mnKMe+SwxvBwTBEfG
 A8RyDYA1yAsLC/ik9QQgsWXxTyLQR9I8ScwoRL1ApvaHskHo2HAV8Fb0++7DNhwnTdYr
 6wHOIAqVmQIF2tBCNTiHw62P7fw6v9Sc76i/OLsrlebLpYEyelv0bIzRes1R2dza8o8R
 LMt7PnsrJMjHCXlBb/K9YEAdplamupVJtFdmX532Zb82Vb1hOuRDwzNIrV/dinoI4par
 gIFQ==
X-Gm-Message-State: AOAM531mG/Z4wVwlLQtuOxjvk4u0HvCBV5ZxlWWU5VYZc0ByQHxrEuBS
 cdZzNHe8daDh4X1WExH3PO2q1Q==
X-Google-Smtp-Source: ABdhPJzUkYxjOYdTCnqRfyfb46yAbakI+8wpucyQOK5UN/fprl4yhC5amCmuakXTcJpNAKe4I9KDCA==
X-Received: by 2002:a62:64d5:: with SMTP id y204mr4867056pfb.83.1597334821561; 
 Thu, 13 Aug 2020 09:07:01 -0700 (PDT)
Received: from [192.168.1.11] ([71.212.141.89])
 by smtp.gmail.com with ESMTPSA id q66sm5722935pjq.17.2020.08.13.09.07.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 13 Aug 2020 09:07:00 -0700 (PDT)
Subject: Re: [PATCH 0/3] Implement blfoat16 in softfloat
To: LIU Zhiwei <zhiwei_liu@c-sky.com>, qemu-devel@nongnu.org
References: <20200813071421.2509-1-zhiwei_liu@c-sky.com>
From: Richard Henderson <richard.henderson@linaro.org>
Message-ID: <165f0d35-ef9b-c316-b5c6-43230a89479f@linaro.org>
Date: Thu, 13 Aug 2020 09:06:58 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813071421.2509-1-zhiwei_liu@c-sky.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::543;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x543.google.com
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
Cc: peter.maydell@linaro.org, alex.bennee@linaro.org, aurelien@aurel32.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 8/13/20 12:14 AM, LIU Zhiwei wrote:
> As bfloat16 is more and more popular in many archs, implement bfloat16
> interfaces in softfloat, so that archs can add their bfloat16 insns
> based on the blfoat16 interfaces here.
> 
> These interfaces have been tested by RISU on RISC-V bfloat16 with
> XuanTie C906.
> 
> LIU Zhiwei (3):
>   fpu/softfloat: Define operations for bfloat16
>   fpu/softfloat: Define convert operations for bfloat16
>   fpu/softfloat: Define misc operations for bfloat16
> 
>  fpu/softfloat-specialize.inc.c |  38 ++++
>  fpu/softfloat.c                | 391 +++++++++++++++++++++++++++++++++
>  include/fpu/softfloat-types.h  |   5 +
>  include/fpu/softfloat.h        | 133 +++++++++++
>  4 files changed, 567 insertions(+)
> 

Thanks.  Queued to softfloat-next.


r~

