Return-Path: <SRS0=WSdW=BJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA5A4C433DF
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:26:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 842CC207F5
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2020 20:26:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Z6qRDFUQ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 842CC207F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49134 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k1F7w-0003yE-Q7
	for qemu-devel@archiver.kernel.org; Thu, 30 Jul 2020 16:26:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41476)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1F7L-0003Q4-KM
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:25:31 -0400
Received: from mail-oi1-x230.google.com ([2607:f8b0:4864:20::230]:42356)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k1F7J-0003ZD-QE
 for qemu-devel@nongnu.org; Thu, 30 Jul 2020 16:25:31 -0400
Received: by mail-oi1-x230.google.com with SMTP id j7so8459733oij.9
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2020 13:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=YHlc384mFb3XF8dMrD2AfcjHoCI2l9HlgVEZF+ZxYWQ=;
 b=Z6qRDFUQxgewW+RYxmMdMs28IKISq5uF7DcxADVmgykgSKYr5B5lfyqR9MizSVCnYD
 UBB6yeT6TeHoTyOsKn7z16Upc5i6hGE5chdMU4GOQQUOZ8+ORtqVREOwgNF2yzX/NlhM
 vgeEb5sacj7d071zA2he+7ZXkPZa3vlYOIguLFhLMvPGOmEcupDF52UWlld74SrKqrcE
 jeJOo2jiUGlylNvyfEQB9EnGhYSgvUrYr6UM5oQ8gUKehCKrCNGDlKXGkNpPrdR32mo3
 ro5JSxjOS/PXl5A/L6P85qgeevtfukhclTvnsCF0nSsScvCqEKb5wwjCmp5Kd1mLN1xd
 Od9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=YHlc384mFb3XF8dMrD2AfcjHoCI2l9HlgVEZF+ZxYWQ=;
 b=JWJYrWlGBtPDCQCqUCzfMSEfx30AhVVtQf1p87LCzgkl3Kz+pTfr8ZuhY7y19R66wH
 Ulq8PMQjCDJPLokhNCtSiOnQ5V8lg9Gjd1mHf1jUUfm+3OuEW7lUvyD3BtoVgfH+shBi
 U4INi7ndE5K/Z4aujggq79lxn8ah4dLC8ecVZyaHezyXvjm6wa6+mZn/O0D5yY+8413w
 g+B9IhS9nsmqHnTAYXq6WnRpIiOk65+M7BBoumxXJGN8oTcD2oJtsO1pilroGemzoqz5
 fMu+BJZE7ulSrmIWpT9ui4eq19LyiIIn1sqGpvl18bB8PdR3KDRl9+YWe4Jyxrz2K9+w
 fPMQ==
X-Gm-Message-State: AOAM532rBb50Oa/FCsev9nEJoZ118H3cX8JsuI5uSxZ4/TyeTLlUiIVu
 jIsVvw1Po17l3516aHA56twUxYdLdf/LPrnc2/7HwQ==
X-Google-Smtp-Source: ABdhPJyyBoOViTrU3mI5RlA5d1NFl1m6UgAan73op13gd/mH+zcRo8JE1sDx99V4eusVuDIcvqwDeMABpA+Y+BXbshA=
X-Received: by 2002:aca:4a96:: with SMTP id x144mr546547oia.163.1596140728742; 
 Thu, 30 Jul 2020 13:25:28 -0700 (PDT)
MIME-Version: 1.0
References: <20200730181414.160066-1-stefanha@redhat.com>
In-Reply-To: <20200730181414.160066-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 30 Jul 2020 21:25:17 +0100
Message-ID: <CAFEAcA_GMRXdN-arOz_7zVc9WwPySvoUMDrcjaMsZmuqt3qfbQ@mail.gmail.com>
Subject: Re: [PULL for-5.1 0/2] Tracing patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::230;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x230.google.com
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
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Eduardo Habkost <ehabkost@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Thu, 30 Jul 2020 at 19:14, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 5772f2b1fc5d00e7e04e01fa28e9081d6550440a:
>
>   Update version for v5.1.0-rc2 release (2020-07-28 21:51:03 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/tracing-pull-request
>
> for you to fetch changes up to 000822441e34916991f7c03217dc24f38be49e50:
>
>   tracetool: carefully define SDT_USE_VARIADIC (2020-07-30 16:02:38 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> A build fix and a 'simple' trace backend regression fix.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

