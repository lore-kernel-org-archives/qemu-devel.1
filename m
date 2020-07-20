Return-Path: <SRS0=C20x=A7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEBF5C433E4
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:17:39 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9962E2068F
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2020 10:17:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jZGX5X6z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9962E2068F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxSra-0005r0-TH
	for qemu-devel@archiver.kernel.org; Mon, 20 Jul 2020 06:17:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:43074)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxSqv-0005IY-CK
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:16:57 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43311)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxSqs-0001Nh-FN
 for qemu-devel@nongnu.org; Mon, 20 Jul 2020 06:16:57 -0400
Received: by mail-oi1-x241.google.com with SMTP id x83so13978959oif.10
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2020 03:16:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=d22r45gYornC+aj8Wxf5zyEsQLelQikNBkLiinXRA4A=;
 b=jZGX5X6zVCm/MNvaV8ZqLchyE2fip47xrEMTFJQEhLLPUilK89DbMvARSfYunDwOUK
 2AmBbkKkusOdp8OKI7U7+tP6mZyJr0h3hta6SAsUD1AgYVdcwXIISoENh3S+saIKg6R/
 wwEgrD3bUwXjj2SHeWVw0VN2CI4dYTowy4x79wv9qd01qJ9DtMFHvSeSOMFr3EA4ELN0
 RAodUgyQqIQTiDT7d/Cx7ktTae137y+m7mQjOylwkXirDLH//sN49cYv+XR1Xvn2umP3
 TuiSri/q8yiZoPD07yzHBCmqvdEwyhOKNPCf+HhfY2Wz0biThfHDNY3tV4SEdbDPDOaS
 i60Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=d22r45gYornC+aj8Wxf5zyEsQLelQikNBkLiinXRA4A=;
 b=sF3UF1rOYGlMcFJBSOAwqBEX0bAsdrZHky8kCZPjgc+JYxmO+ed/bW9/y3vEqcAxfo
 ZW0Pw/CdkzIL2SLuYutEpQHtdSMnDcpd4JdaqhRWa/HZlDIk1USIP383v9K3T/wg+Cjp
 YgxTNIoS2MsWMmFA9a9FMnP+13LiPUAMsXbYxpwbPEqb28JqeCzibz+6R/L9s+RXrxeY
 b1QkraZ0uKfsIAhPTdhJU+0NNdj8RcogJQF4RB2a4XFOEGK9Ks0boZOpmDp1nNAnhBI3
 4h2XLAR3jrPx7phMVwM8OPtIULK36k3170VTXaHxlrytizqCDAhcIjKmrLJcxLSI+J1c
 GcgQ==
X-Gm-Message-State: AOAM531m69bqn8jTf0QxZHPVZ1cPo+C8eY9Fc5I+KV5zlmN1h2Znfhr7
 QrbKIynfxEYdxFvK8y5sDhED7DiI2NmWO1rQ3yorqQ==
X-Google-Smtp-Source: ABdhPJwdd+lZQ/rTukm0SghOVdyc4FZGEfU+7UhV9QC5P8m6Bo6KTZKu6u3/JGGT8KrN29R28YVuQUM36FPIEtYsNFE=
X-Received: by 2002:aca:1706:: with SMTP id j6mr16331853oii.146.1595240213005; 
 Mon, 20 Jul 2020 03:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20200711101033.47371-1-drjones@redhat.com>
In-Reply-To: <20200711101033.47371-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 20 Jul 2020 11:16:41 +0100
Message-ID: <CAFEAcA_F_zJESdsZbsQaD+SLN5HDuL1x9Z=YrxC9kXw1XGvrcg@mail.gmail.com>
Subject: Re: [PATCH 0/3] hw/arm/virt: Introduce kvm-steal-time
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::241;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x241.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
Cc: qemu-arm <qemu-arm@nongnu.org>, QEMU Developers <qemu-devel@nongnu.org>,
 Beata Michalska <beata.michalska@linaro.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 11 Jul 2020 at 11:10, Andrew Jones <drjones@redhat.com> wrote:
>
> KVM supports the ability to publish the amount of time that VCPUs
> were runnable, but not running due to other host threads running
> instead, to the guest. The guest scheduler may use that information
> when making decisions and the guest may expose it to its userspace
> (Linux publishes this information in /proc/stat). This feature is
> called "steal time" as it represents the amount of time stolen from
> a guest by scheduling out its VCPUs. To enable this feature KVM
> userspace must provide a memory region that will be used to publish
> the information to the guest. The memory region is typical migratable
> region. The GPA of the region is given to KVM through a VCPU device
> ioctl interface. This feature is only available for 64-bit hosts
> running 64-bit guests.
>
> This series provides the QEMU support of this feature. It will
> be enabled by default for 5.1 machine types and later, but may
> be disabled with a new CPU property "kvm-steal-time".

Just a note that this has missed 5.1, but I'll review it at
some point for 5.2.

thanks
-- PMM

