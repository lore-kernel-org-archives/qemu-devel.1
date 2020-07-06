Return-Path: <SRS0=h+Ky=AR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16193C433E0
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 13:13:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D4DC120724
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2020 13:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="i+crjkCC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D4DC120724
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jsQwV-0007D4-6C
	for qemu-devel@archiver.kernel.org; Mon, 06 Jul 2020 09:13:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37770)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsQvv-0006hS-38
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:13:19 -0400
Received: from mail-oi1-x242.google.com ([2607:f8b0:4864:20::242]:44541)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jsQvt-0008WN-Fv
 for qemu-devel@nongnu.org; Mon, 06 Jul 2020 09:13:18 -0400
Received: by mail-oi1-x242.google.com with SMTP id k6so28051654oij.11
 for <qemu-devel@nongnu.org>; Mon, 06 Jul 2020 06:13:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=1fT/hLLdg2+88cLUyFSAOH1/RHevrdz3wUBOHtDQG24=;
 b=i+crjkCCZp/mK6e+6vPK4qh9VePJuVVMmDeftabgSXc3fLG/2enwse9ouVqsQzGdVQ
 71wAW/XlwdwdOx/KRCmPfLVYKu2Icw5rLMK3rPPoTJoCTM7o+CySuLG0PbYV3rCLqK0b
 1XpAs1PZdWE8aJjfXpg99UyNLILVn5ZXM25gkcEKF2BL70U5Ve+TstN19u2lDiqyrzhN
 QfDOy1q4cM9X0P8ZAq7X4nYjfjTHhkzNi8VmnjwmgBbZ2XJgWdNQbEZ56yQnBAu8Ejvk
 mKkvzbLiCGwJemffQTmuR7SYikQPS1LpzSUxEavYZ0sZ7CdJCX6o2C9iFVQIo3/NSjzV
 FwGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1fT/hLLdg2+88cLUyFSAOH1/RHevrdz3wUBOHtDQG24=;
 b=HsCtBob47zOzY88jVJXUep+Rl0xcjzqqiFqXPH/6y3m2QnM/aGvULzIKe/HsNoOBix
 NMbXN9D3AHI5Z3m638Lmna4K47VNNk/4RI8Dqhc5NZP+GahovWe93Hipap4W4jHzStH+
 7r5budszDtWnF33F0kPfkyIcla4ROvJiBlPpFjM2UG9hwrQeplbibby9eGCiUHHBbZ4I
 NkcAMvJUbnfTZdvZ4YKUuMDIUGCPRK06/vX+BqLy9LLaRDfIm6jXQpJLMszCQ4FQYGHR
 aoK9xpBapDlcA6zGzuiD1RSDp8p/qEhsjHlW3+/rEoWVto3gSLUYI6MDYeNTr0ASWaVm
 WrBA==
X-Gm-Message-State: AOAM531UZ0a+TshLPgzGItSlL8MVBypYDLx93a8grhIBrcNt1wEKPZQ0
 nm3RHgOe5Ymy3ygt64Nm0Uoamu5CVIRLi5fgNym4pQ==
X-Google-Smtp-Source: ABdhPJx1OgfnWBMISwWX90PwtJBRcv5KwX2TwMpsHc5RKsDS9JDQDDQXgZg+VkXd8wJQVNp+iWAxZW5tBLW4+L1hxYY=
X-Received: by 2002:aca:1706:: with SMTP id j6mr8745856oii.146.1594041196302; 
 Mon, 06 Jul 2020 06:13:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200702152659.8522-1-eric.auger@redhat.com>
 <20200702152659.8522-4-eric.auger@redhat.com>
In-Reply-To: <20200702152659.8522-4-eric.auger@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jul 2020 14:13:05 +0100
Message-ID: <CAFEAcA809S_vB2wL0Ckhem4F16iFdmO7Vtak8tpRFFEKHToN_g@mail.gmail.com>
Subject: Re: [PATCH v2 3/9] hw/arm/smmu: Introduce smmu_get_iotlb_key()
To: Eric Auger <eric.auger@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::242;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x242.google.com
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
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Robin Murphy <robin.murphy@arm.com>,
 zhangfei.gao@foxmail.com, QEMU Developers <qemu-devel@nongnu.org>,
 Peter Xu <peterx@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Will Deacon <will@kernel.org>, Rob Herring <robh@kernel.org>,
 Eric Auger <eric.auger.pro@gmail.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 2 Jul 2020 at 16:27, Eric Auger <eric.auger@redhat.com> wrote:
>
> Introduce the smmu_get_iotlb_key() helper and the
> SMMU_IOTLB_ASID() macro. Also move smmu_get_iotlb_key and
> smmu_iotlb_key_hash in the IOTLB related code section.
>
> Signed-off-by: Eric Auger <eric.auger@redhat.com>
>
> ---
>
> v1 -> v2:
> - creation
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

