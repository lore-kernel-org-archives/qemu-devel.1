Return-Path: <SRS0=wQM/=BV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85873C433E0
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:39:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4439120756
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2020 09:39:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oMt1cxQm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4439120756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52122 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k5Ql4-0003f6-E0
	for qemu-devel@archiver.kernel.org; Tue, 11 Aug 2020 05:39:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57386)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5QkW-0003FG-Hr
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 05:39:16 -0400
Received: from mail-oi1-x22a.google.com ([2607:f8b0:4864:20::22a]:44201)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k5QkU-0001iR-UJ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2020 05:39:16 -0400
Received: by mail-oi1-x22a.google.com with SMTP id h3so11610802oie.11
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2020 02:39:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=e6OfBH85dXb871lqmuteUSXCHB4+mmEErwt1EbH5hss=;
 b=oMt1cxQmpMC+ufg+kB2sPwHmIQ0XEe5kdQEaTyKP5042+waE9gkMi5AOuO+7qS19jB
 2CtAM3Y4GjK1j/TiP/ng8QpRwBUoYFaIWZB8h5KCQ7mjDj3wOfYnyVqEwBv7vf7MDTGp
 qPKYY6DhR1N0LxJ7BnLWmIHRNU1mF5Fd7zAzqpW9fEdnqWuZYZjq7CplteLX4DVf5m5q
 8bHaJRpb8GeTz2iN65wigsahrzuBL9/fv3vaH7ZcFJcgzdfiu3r3D72yQ7NL0mfBAj0y
 IzZIfu2f1gM9hN3OSTf15OwlfEkahVIFzCG5BdUpJYMO0cjYzyoDRu5mxNWeP5bToqQr
 zd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=e6OfBH85dXb871lqmuteUSXCHB4+mmEErwt1EbH5hss=;
 b=PKAFXlfYmjQUb9CyCmTrYyEXLr4cSYhSIBM9TFeNp9wx1BbGYK5bY1A3ADAZ7CKNmY
 cxj75yS0Rd+QdC32PXLh711nAoRxxIodH9ACnO4PT3c7vpt568ksinFteES2qiTrN80k
 US18N7Jy08CC4+UC/Qw1dIH6Qr7zYcuJ/3yYRlbKPjeVfGigaUDjeK0h2QygVw4NPpmi
 7+uxzyyqRb+Ef4ng+iIMROobaz41gTxIDJ1+eyun7bzremnBULrl31h+T16ZsUSKHISX
 cU841bhYdBcahEMz5dr10rtlFxYWX2OqZOTwWGcvsNPTjCZ1AP4NwsPmhY3r9TpOSiYY
 BsHQ==
X-Gm-Message-State: AOAM530zg1QWOEYfpnpY3ENKkmkkz3Ja2Kcx0rsXA13YMSEeCnhHxlXA
 J8izu4ZUjt1doi6KDUageGlv+FpYK59lIeoKLpWYVw==
X-Google-Smtp-Source: ABdhPJzU74VJuxdwoMoshmS2U/AUqQyZapfWLrcqsa8KInKie+1XRjKaJsO9NsDhI687LazdeYhKfMFbDKuodKYF6KM=
X-Received: by 2002:aca:5703:: with SMTP id l3mr2576525oib.48.1597138753513;
 Tue, 11 Aug 2020 02:39:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200811093505.972894-1-mreitz@redhat.com>
In-Reply-To: <20200811093505.972894-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 11 Aug 2020 10:39:02 +0100
Message-ID: <CAFEAcA_v=pTcao6-42bQP7yhVq1Zinjk-bbE71Bksu0=LaON0A@mail.gmail.com>
Subject: Re: [PULL 0/2] Block patches for 5.1.0-rc4
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x22a.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 11 Aug 2020 at 10:35, Max Reitz <mreitz@redhat.com> wrote:
>
> Hi,
>
> There is a bug in the backup job that breaks backups from images whose
> size is not aligned to the job's cluster size (i.e., qemu crashes
> because of a failed assertion).  If this bug makes it into the release,
> it would be a regression from 5.0.
>
> On one hand, this is probably a rare configuration that should not
> happen in practice.  On the other, it is a regression, and the fix
> (patch 1) is simple.  So I think it would be good to have this in 5.1.

I'm really reluctant to have to roll an rc4...

thanks
-- PMM

