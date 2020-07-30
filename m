Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50A44C433E0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:34:20 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 176552074B
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 11:34:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="GwdUmkF8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 176552074B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:37482 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k16pH-0005Rf-Ei
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 07:34:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36766)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k16oh-0004yD-Ih
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 07:33:43 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:45532)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k16of-0006Ar-Qo
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 07:33:43 -0400
Received: by mail-oi1-x241.google.com with SMTP id o21so2730075oie.12
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 04:33:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=a/KbVx1s3ycJ66pUa39DQPUXRctiQhwXA1nHi7J6pvM=;
 b=GwdUmkF8k3UVTryLn57Pqrk1LruMghh8A0C5boBOuSo5L1//iCm7UcWALltoY9Tuax
 uLosOo+LZfiHGOzgEjfVc99fKEhlkVyF+reFvtDYzhnJMuXCQym4AbrVSN6KFUopxz7h
 xGENKuIniDoGy1oVDGTBA6P7kMSt3KKFKWBBvFBlaEFE5L8Q5c+V0eDjVfs9T75di4Qk
 4B1VNSNOgzR/d79dLvS/MC3oqJcTbakOYZAAtDL4ho60ujpllxqmca5MOwhWA9WTQLjA
 /KiHGjFxh3kX+Tb1VbYuFTpaO42GdmpvpusPtqpG3CZIq/JIq99PEiRZj7PfcorkU3/a
 DZOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=a/KbVx1s3ycJ66pUa39DQPUXRctiQhwXA1nHi7J6pvM=;
 b=Hzr6du406chxzVZ5zWHtzgJJOaJedNon+19tJPnQ4nHqdxFjhr196gbuIEzmk6Zt1z
 bmT5CoHSEJqy2P94aXuyKqoKBB9zCza37EpO4INJQYTNMUL5kpNreJnKJrbMt1Q4S+58
 ZcY+NgcNHBTT0JZ0BDHXA+cPA5o5Wo1f7wzSJl3RoIXrp9cO7QKct6h+vHIE2bgUwQl+
 a84pBN3fYEnSVcPX3gtHV1pZGqv65CijZetDib9yVWP5ODmTHgPGET8GOBhX8QjUixxv
 p38BSMalfoimxFjr4kJQ+PcdZyke2ThlFAaSDQ9ur24hTa2WOSUX28vnAb7hfKLiL9YK
 NVSw==
X-Gm-Message-State: AOAM531e/1cI+qTgXemhgfX15P+s5cw+WmKJGb9aWS5Lq9KdT1hfAbHG
 k07vevz17orcCkBfWJT1Iy+oxW/4FrkkkcbXG5MYEQ==
X-Google-Smtp-Source: ABdhPJzfXsrwqYDyVw92r1b++cah1Kipdre8OLLOdl7BCpr5/beKT/MUT+f9fbTWsLS8OdjpwwehOcULSMb4KKALEN4=
X-Received: by 2002:aca:50c4:: with SMTP id
 e187mr10721818oib.146.1596108820417; 
 Thu, 30 Jul 2020 04:33:40 -0700 (PDT)
MIME-Version: 1.0
References: <1596074182-4920-1-git-send-email-likaige@loongson.cn>
 <1596074182-4920-2-git-send-email-likaige@loongson.cn>
 <CAFEAcA_ZgrkcpwYZD-stZGDDjhTgMOSLx--9KHPnxfbKz58s7g@mail.gmail.com>
 <25c0ba1a-088d-c932-1f17-030211af5d4f@loongson.cn>
 <CAFEAcA_uy0dpxQ07S=THCBaMx2R0-xaM_BUn8OxLkOwR9LJdWQ@mail.gmail.com>
 <b52213cb-1caf-75b9-7783-ca531af44e43@loongson.cn>
In-Reply-To: <b52213cb-1caf-75b9-7783-ca531af44e43@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2020 12:33:29 +0100
Message-ID: <CAFEAcA_6kfWz0KbPYOj4BwHJKDF=k3tvbSozs4_5wk=SVr+0cA@mail.gmail.com>
Subject: Re: [PATCH 2/2] target/arm: Fix compile error.
To: Kaige Li <likaige@loongson.cn>
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
Cc: qemu-arm <qemu-arm@nongnu.org>, David Hildenbrand <david@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, "Michael S. Tsirkin" <mst@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jul 2020 at 12:28, Kaige Li <likaige@loongson.cn> wrote:
>
> On 07/30/2020 07:21 PM, Peter Maydell wrote:
> > Clang, gcc, OSX clang, something else, and which version number?
> Sorry for that. Gcc version is 4.9.4.

Ah, that makes sense. That's a pretty old version of gcc (it's
almost the oldest we still support), and it had more false-positives
for maybe-used-uninitialized warnings than more recent gcc versions.
Adding in the = NULL initializer should help it.

thanks
-- PMM

