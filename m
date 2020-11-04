Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01CAFC388F9
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:42:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4110F206F1
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 17:42:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="LujySD4W"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4110F206F1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39900 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaMns-0005IO-38
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 12:42:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:36360)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaMmm-0004TJ-MV
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:41:28 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e]:45676)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaMmk-0001q2-R2
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 12:41:28 -0500
Received: by mail-ed1-x52e.google.com with SMTP id a10so6109975edt.12
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 09:41:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=o8Zq+olWEGYik/6RhTq/V/iTEwRP8qx2DZdhCtjBOXg=;
 b=LujySD4WqvYiJeJfiq64MwQp2E5uGnJUwrdnWukncVp3U8qa0kFOIp5CYn1vKb7H0f
 3rFBaKOPreZkkAl5SYuMd//DZCPZTjhbTJGYbbVH3gzzppROq0RTpLFpzeL/iqX0H4P/
 xtFie6PMBJPL5GYHbZpAsbPGUmu5v0Q45B0Wo4nkZ3aIic6tOuu01AR/wqcZ9Z2ZcSNH
 BnihMuE7zQs7EX9zRbMhziNSCaRcSIVLyUjJ7td5L+roUiJ+yHx+bp6pam9+w2/oggty
 RX9zi/UK2bNZxw9lcAvkFhtjISHfbFFIkk1vKG+ScOdzLf9rOd4C4bFS/Fa23oUostfd
 gRng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=o8Zq+olWEGYik/6RhTq/V/iTEwRP8qx2DZdhCtjBOXg=;
 b=UF6o0IsTgzZwl/5gBzXUZJYjKYSXJqEKmlS/jBHiEP/X/GfWyUMuWUk+OvKSr03aDh
 pYCUYYkMHEVTruEduVI6GbR1lTt2aPPOcXtVT/6KPUuPgPkaTMuTEDTFSjME6PTvbXvy
 RznuTy0F4Av9lKcab00smNiIJxHamCHBwfV/6nnkAXAR/CgyABOaHaPxri6sJQghsQ51
 mki236NpIo6madQ1/YolvQFXH2AgWN+FNommanuaTGdewV2hsdAnjb//q5jWK2YvROib
 LzcBE0H0gvdqzBN3XBE5nfJrJieondhNCLgTGwx8D4Qh8yHVkJm2FYuLC/YDUnj0kRhv
 zPEA==
X-Gm-Message-State: AOAM531DG2Zgpm+dT0Yst/x30kWKg7mx0WneMEu9m+JcWYN/5k8m0CkU
 1f7Y0fdoeKzviichnZQkfqi217DcIg3P+U7SViO8fQ==
X-Google-Smtp-Source: ABdhPJwadZ3rxSaECxvPGC3jYLgEdlI4T4XnLDH+FwbQ+OWkzNVlfnnQRkqd7Xw2qJckSeStHuw9JF9D4CZjDMU6tbo=
X-Received: by 2002:a50:fa92:: with SMTP id w18mr7709954edr.44.1604511684676; 
 Wed, 04 Nov 2020 09:41:24 -0800 (PST)
MIME-Version: 1.0
References: <20201104135400.3938-1-kraxel@redhat.com>
In-Reply-To: <20201104135400.3938-1-kraxel@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 4 Nov 2020 17:41:12 +0000
Message-ID: <CAFEAcA_ZXUwVCfHFZepkVwESgHZryaBNRPh4M3=Hvhfaa1jCOA@mail.gmail.com>
Subject: Re: [PULL 0/3] Ui 20201104 patches
To: Gerd Hoffmann <kraxel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 4 Nov 2020 at 13:55, Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> The following changes since commit 3d6e32347a3b57dac7f469a07c5f520e69bd070a:
>
>   Update version for v5.2.0-rc0 release (2020-11-03 21:11:57 +0000)
>
> are available in the Git repository at:
>
>   git://git.kraxel.org/qemu tags/ui-20201104-pull-request
>
> for you to fetch changes up to 0d9b90ce5c73505648909a89bcd5272081b9c348:
>
>   console: make QMP/HMP screendump run in coroutine (2020-11-04 08:02:25 +010=
> 0)
>
> ----------------------------------------------------------------
> ui: run screendump in coroutine
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

