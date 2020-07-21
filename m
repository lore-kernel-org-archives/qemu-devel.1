Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 460BDC433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 18:26:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0AB8A206E9
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 18:26:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="P5gTuQ5z"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0AB8A206E9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:55806 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxwyE-0008Aj-GL
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 14:26:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:42622)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxwxR-0007hE-Ma
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 14:25:41 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:44806)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxwxO-000764-Rb
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 14:25:41 -0400
Received: by mail-oi1-x241.google.com with SMTP id k6so18030742oij.11
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 11:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=TVWpHGETx/n/kdNR2IcSbORdOjy01g8hvNtVyLwrxl8=;
 b=P5gTuQ5zeaYnI4i326B0MIYzqJ00brmhr0HNjvWSQYBpN69qCDuNLSaapZOwK0yrAv
 pgJKRIIr6vwI5ltlz+uXO29kY16CegRbpL4scF8UykV6xGze1/ADTR1ZJ/xR+frXuXuW
 z9V+KEbkDe5GMi0Nytb2JdW7QEdwBFaMYiyj7n/Y54zE0Igant0m3rzg8Je/rhSRHHd6
 hV8xRcTTUt3eXJ7bugUldcFXohzFZ61Wr5ozr3wbtUNpoNF1Lr3o7vwsjtPy1DKPT89p
 EQX6//FU/PygzIUsy6LtH8rqkOpp7FmxcQQMopda3ld8hn/8MROJHegDcA18NlToWGsl
 KqsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=TVWpHGETx/n/kdNR2IcSbORdOjy01g8hvNtVyLwrxl8=;
 b=ocOVbkC3e7tJMwBXyqLVWnL1TSNtNy5XEVo+hTkhULkcAYRe/RES3GRk9+jB1CbpFb
 TR+S+J1KDCEzOcKs9mFjofuJvAL5r4RrPIofj7rlSGw1EXYVXnd1AnXFueONVJiGrcEt
 SWt3pcM5d3VqvxaJtcFYfaBSgWYltJFM/3vm7bJpstraR6tW2QIbFQ85Zl2bJXqOEwcv
 nZsuswfLmjmLYIEvcD4/+8N+0Zf1Ve5WoN1aHlA8W6E1o8sLSJ4e7ecelfjvftGa3cCr
 BjX6A7psxQlnRUvdkh+Rl4FSTNdq31QMt9RyShuQBkbgiWKhhfXDSJo8cxABPa73UWow
 aFlg==
X-Gm-Message-State: AOAM530g9zB4mXRjF2OAxahGWAgm+8PEzaSoN/clAH7mJjwyT7P7RWV5
 x8x7OoCowzVHl2o424gpOMAJ/p+gXeDg79InTc3qLQ==
X-Google-Smtp-Source: ABdhPJxifUZhBz46cLz7i2k1oWmcQVPvPFdTE1iW8pIllqG5CBOh8+mYWzgNZDY57Eyu1g6vd7OVgdw9LHSdcghG4LU=
X-Received: by 2002:aca:54c9:: with SMTP id i192mr4158085oib.163.1595355937266; 
 Tue, 21 Jul 2020 11:25:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200721154147.1657100-1-armbru@redhat.com>
In-Reply-To: <20200721154147.1657100-1-armbru@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 19:25:25 +0100
Message-ID: <CAFEAcA9aak-zRKfXA4d4LBNQFRio3iJNhkZeY6c3Yk-2t7YW+g@mail.gmail.com>
Subject: Re: [PULL 0/3] QOM patches for 2020-07-21
To: Markus Armbruster <armbru@redhat.com>
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
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_BLOCKED=0.001 autolearn=ham autolearn_force=no
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
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 at 16:41, Markus Armbruster <armbru@redhat.com> wrote:
>
> The following changes since commit af3d69058e09bede9900f266a618ed11f76f49f3:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200720' into staging (2020-07-20 15:58:07 +0100)
>
> are available in the Git repository at:
>
>   git://repo.or.cz/qemu/armbru.git tags/pull-qom-2020-07-21
>
> for you to fetch changes up to 0dde9fd12fd39762ff68fca80d2f0a735d66e7bd:
>
>   qom: Make info qom-tree sort children more efficiently (2020-07-21 17:39:37 +0200)
>
> ----------------------------------------------------------------
> QOM patches for 2020-07-21
>
> ----------------------------------------------------------------
> Markus Armbruster (3):
>       qom: Change object_get_canonical_path_component() not to malloc
>       qom: Document object_get_canonical_path() returns malloced string
>       qom: Make info qom-tree sort children more efficiently


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

