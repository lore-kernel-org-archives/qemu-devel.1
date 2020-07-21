Return-Path: <SRS0=zL9l=BA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CCF1C433DF
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 17:32:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 34DD82065D
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Jul 2020 17:32:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KOJwDNuM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 34DD82065D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44634 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jxw83-0005OT-Ef
	for qemu-devel@archiver.kernel.org; Tue, 21 Jul 2020 13:32:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:57860)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxw76-0004uV-BW
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 13:31:36 -0400
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:42338)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jxw74-00085F-9A
 for qemu-devel@nongnu.org; Tue, 21 Jul 2020 13:31:35 -0400
Received: by mail-ot1-x332.google.com with SMTP id g37so15639130otb.9
 for <qemu-devel@nongnu.org>; Tue, 21 Jul 2020 10:31:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=3tG5pS3wylim5+bEWdvfYQgTNe8D9880D7JlV1TSHXk=;
 b=KOJwDNuMynNaujXrijmrEcJceew1VtpVL9q6Ej66gACbCyD3mV1aWQ0NdTyN9thya5
 v94TmAq4TPahx7nGgGPZn3gsYL0zHDwtxdQUz8zKj+kqSjUIkS+OWPHGB9enhyasa+Eq
 bTa73E9VtKmmbHk3i5wYCDBcXAcsnxzRZyxO/YE2Pz9aHf6yQ0pr3bGAmPNDdGhh1U+A
 jVqEJ1oFRl161NT/pF8VfFK6NwCBGr/qmQE5q8MNFuTGGzijh1wyzQuWnAbdBAcZ8zNg
 xDuECqIcmGAeoDSWy/7nlM0yMGkLE62JpzvzkiwXIaMgtaaxyEC3UzeOHIfmqIjTiJiS
 8faA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=3tG5pS3wylim5+bEWdvfYQgTNe8D9880D7JlV1TSHXk=;
 b=DnkzwyTEF22PIOl3cRjKvk4YZI3o2YiKP/Twhg50iHEm4+VECShyhMysKonowEeAJG
 PsR09AyDiaO7QjHEkdrRqRAAedP3oNV2u8rlFOcATgqgD4feMfdxEUTo4Rut4r5WMAEV
 RrfWg8fxLPn362fhTHvjV/qGoQk52j7cn7TJvRvv1WOiJ6ceVm2AaFEbX+uhCEqh8+Ny
 AGmpaTfxv7Fc87Ypl8Ij2/rrP/lIGG9v16+HaXQlZ3iXOszqM0FUEBB9ToxrfTzHcwh1
 4i2yX3XxVxuzeJRByvVLp8sLTEO6+akv0gliR45nhzvi789PRpXBgAYYWKiLa7S4ZcTg
 Uxuw==
X-Gm-Message-State: AOAM530ZRVgLp+WjQhaZcchM4HnqcLCSQQA+L/6I8sVT18mxQwIxZE00
 R02wWUX+7B+XkVIXZ3O3lvjKZStmrEt4VeQI7X8C+g==
X-Google-Smtp-Source: ABdhPJxD/XuIR1J11w3H+5YBLSJeneRGGXd6Z/qtdq45hz9fXQCC3zvjEO9gQEp3wuePlpIbVpapmT09AKHZR/b6/0E=
X-Received: by 2002:a05:6830:10ce:: with SMTP id
 z14mr26064406oto.135.1595352692722; 
 Tue, 21 Jul 2020 10:31:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200721140245.14634-1-kraxel@redhat.com>
In-Reply-To: <20200721140245.14634-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 21 Jul 2020 18:31:21 +0100
Message-ID: <CAFEAcA_eNiZ8MPtcXsK0waLBZ6cta_f9=2vMWcTq7EkgpWuTzw@mail.gmail.com>
Subject: Re: [PULL 0/3] Fixes 20200721 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-ot1-x332.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 21 Jul 2020 at 15:05, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit af3d69058e09bede9900f266a618ed11f76f49f3:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-20200720' into staging (2020-07-20 15:58:07 +0100)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/fixes-20200721-pull-request
>
> for you to fetch changes up to d87350b065128e8156e7aca93e89a1ab9e5fa63d:
>
>   module: ignore NULL type (2020-07-21 10:56:51 +0200)
>
> ----------------------------------------------------------------
> fixes for xhci and modular builds.
>


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

