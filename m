Return-Path: <SRS0=Ajie=DP=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEC73C4363A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:12:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 11E23206E5
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2020 13:12:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Tf22zBFr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 11E23206E5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52054 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kQViB-0003Vw-Tl
	for qemu-devel@archiver.kernel.org; Thu, 08 Oct 2020 09:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:46598)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQVY4-0007ws-Bu
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 09:01:33 -0400
Received: from mail-ed1-x543.google.com ([2a00:1450:4864:20::543]:36765)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kQVXz-0002Za-37
 for qemu-devel@nongnu.org; Thu, 08 Oct 2020 09:01:32 -0400
Received: by mail-ed1-x543.google.com with SMTP id l16so5748366eds.3
 for <qemu-devel@nongnu.org>; Thu, 08 Oct 2020 06:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gtCY0H0tDDkagqZGl/vsnIabsWlIPf7O8k8VgvISuf8=;
 b=Tf22zBFr87pkjIFAFKhNWRxi8mcbvUV7F+I70KvjtGCsytn4XKlPHl70kpo8ybFbtd
 oTRGbH66k8djj53fFVaj1ArS2jC5l3JQFCZqy6feMfMfDS94CSyaia4yxmdHd68o2vH5
 tzs578mPc2eaydlvAoP2A5lXcP69GYi1OpMyugmT80u0ev6zm+7OHYxAfzvWZ7Wb5gwj
 kpvYfOFmMouL88E9A8S+KPrYaW1Dnqb1vkkwi3YDpuruYgWjCi9sVFmyPNNfzqTXMuQp
 93A69BAADjCRdsN0VwVMaoqd0WqDZfR7d2BWozY1AIIHnASo7Q52dTo8PuxUh/qfFLy6
 VfNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gtCY0H0tDDkagqZGl/vsnIabsWlIPf7O8k8VgvISuf8=;
 b=kbC/NvWHMR4pkEvBd/BbvJvmaqxsx0R9hUFcZWwu5DNHScySMA3J+Toe53oPey91L2
 rEuRn/QGoQKvKOAER4D99fw2Ys0O59BxpjUXjP8aLdq0tR4f01KGYPNXMz0fPcw0lBDG
 Rg3CkMHNP6tii9yjvWcEPJ9QB8/1dplppOdToucuE+j9PAkpy1QBTkgcrJb5wtsAHXAu
 ZAggEA9g2w8N2acZ0TiXxdSQ1qw/V50ML4FUR3RBndMD9aWgCHehXyB5e8UDYiKZou8o
 7x+/g0652A0tEFkbbxS66DFMJ6IRaQVKLmFcMid6EsEt3WqBiV8FHXyWK/7/sJGsDxom
 ZRXw==
X-Gm-Message-State: AOAM533lCV15dXMGgKcuVWKo4lTd5RJxhSD3fajdoqJ7A/yZrNXktZVf
 qMmNsplLgrlhIVl/8Q3jPWpm1SP09HnzVTsRBv1LgA==
X-Google-Smtp-Source: ABdhPJxlb+ybGJgK1sO6DggPgMWtwbMbRiXQBpdKsYBWjXN6u5lx+HT3lv/A/hb4gY7muR2CU6JlUA4zEDgrGQvyq40=
X-Received: by 2002:a50:e68a:: with SMTP id z10mr9145545edm.100.1602162082163; 
 Thu, 08 Oct 2020 06:01:22 -0700 (PDT)
MIME-Version: 1.0
References: <20201001061718.101915-1-drjones@redhat.com>
In-Reply-To: <20201001061718.101915-1-drjones@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 8 Oct 2020 14:01:11 +0100
Message-ID: <CAFEAcA-KntvrdrxL33CdxAt2gPyxF=EuQ_iGsLK4NvSNyNrZvg@mail.gmail.com>
Subject: Re: [PATCH v4 0/6] hw/arm/virt: Introduce kvm-steal-time
To: Andrew Jones <drjones@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::543;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x543.google.com
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
Cc: Eric Auger <eric.auger@redhat.com>, qemu-arm <qemu-arm@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 1 Oct 2020 at 07:17, Andrew Jones <drjones@redhat.com> wrote:
>
> v4:
>   - Rebased to latest master
>   - Added an official linux header synch patch, replacing the
>     hack patch used in v3
>   - Added a patch to restore the arm-cpu-features test for AArch64
>     that got lost in the meson shuffle
>   - Added Eric's R-b's
>
> v3:
>   - Rebased: 5.2 machine type and kvm32 drop now included
>   - Switched to using new KVM cap that has been merged upstream
>   - Picked up some r-b's and some of Eric's comments from v2
>
> v2: https://www.mail-archive.com/qemu-devel@nongnu.org/msg727588.html



Applied to target-arm.next, thanks.

-- PMM

