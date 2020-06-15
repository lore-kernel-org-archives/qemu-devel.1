Return-Path: <SRS0=tJVC=74=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BD12C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:20:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 65FDB2074D
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2020 13:20:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JBGDOzvw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 65FDB2074D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34390 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jkp20-0006mW-L6
	for qemu-devel@archiver.kernel.org; Mon, 15 Jun 2020 09:20:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33960)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkp17-0006DB-3q
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 09:19:13 -0400
Received: from mail-oi1-x241.google.com ([2607:f8b0:4864:20::241]:43969)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jkp15-0002gp-FP
 for qemu-devel@nongnu.org; Mon, 15 Jun 2020 09:19:12 -0400
Received: by mail-oi1-x241.google.com with SMTP id j189so15799560oih.10
 for <qemu-devel@nongnu.org>; Mon, 15 Jun 2020 06:19:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=iUa3F5rCLnPg5E82JxiMsvHOmT2nCJTCGiR/A4HOnn8=;
 b=JBGDOzvwZCdrBBlyriBT6rAPFpDOCQRzdr2Ajqd76LW6eSRuuCq5tc6fn9KlT9Shyo
 wpZKFd6rxIZ0pc4nmLiinIT8xSRyoq6iJcwr7oNwkuza5TgQm+rx0qEbOBWpvO/4+vdW
 YqOXnKZJy5vmurde/sPzDYOwhIZObCkCWowxwR8fpC5zUbrZ3SZrzozg5tWod+abUWM4
 OHaqZIW0/Ssa6WgVrLboMj85iLgtCrH4IvSiGKxO+WyKnwAyL2LNrq/8gipJqN83toWc
 JMiqimt/8YGIscpGz0VUjNeNPH2oM53HA/TThPhCxRDuSqbEefulaJRvzOAG1Y0wprpx
 jkrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=iUa3F5rCLnPg5E82JxiMsvHOmT2nCJTCGiR/A4HOnn8=;
 b=isZIahUVyObn7v1BZ47abIwwH8CFyTHEzODxk+E2w7mohmFfxFDIdWvyvWwj+KsQug
 RA2uDVSnz2bV55wKE3P2Hy5xVK8woip3UWnkDufNukZSJylcPxcoZXw4CYfw/coQW7UH
 NORlTmac3oY1M3omgBYf4Uj9bjfD40F8+T9c/fuaRN+xMTwBTuljq1peZQgxbsATLgoU
 F8iqX04I4i0m+oj+n58rIPh+eF0J/+dzFWmgRsEGPVQnaWzTeAuozOIdaAaKwNOhQYCu
 MISAEkkdPoYScCRcBDm+trVXdt8v4xaGcC2peOJOnN0kJgLwbGmg0BTaqTkNIJ+gdNRe
 4+nQ==
X-Gm-Message-State: AOAM531TlRW/lTxJPysH3mwwytX6X3aI2nteeqCJqkuOebPbViueHZNx
 iMw0l9Tqu0mnTWjIGP3EgjBdCB2GYtz4rPQe5tI3yA==
X-Google-Smtp-Source: ABdhPJwapg/fQqBV4Rtj55719RRDq2W3WW4QauftU7hlWmrVQOqDS1pAP8EaEi9dsvmxJIDwSxkISiySlxLb5s2HEms=
X-Received: by 2002:aca:1a07:: with SMTP id a7mr8761584oia.163.1592227150304; 
 Mon, 15 Jun 2020 06:19:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200603145258.195920-1-linux@roeck-us.net>
In-Reply-To: <20200603145258.195920-1-linux@roeck-us.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 15 Jun 2020 14:18:59 +0100
Message-ID: <CAFEAcA-JZhwvim9QHCn2a3OYCfpjvo8U-LjNX0g+6jB9YMVFyA@mail.gmail.com>
Subject: Re: [PATCH v2 0/2] sd: sdhci: Implement basic vendor specific
 register support
To: Guenter Roeck <linux@roeck-us.net>
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
Cc: Andrey Smirnov <andrew.smirnov@gmail.com>, qemu-arm <qemu-arm@nongnu.org>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@redhat.com>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Jean-Christophe Dubois <jcd@tribudubois.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 3 Jun 2020 at 15:53, Guenter Roeck <linux@roeck-us.net> wrote:
>
> The Linux kernel's IMX code now uses vendor specific commands.
> This results in endless warnings when booting the Linux kernel.
>
> sdhci-esdhc-imx 2194000.usdhc: esdhc_wait_for_card_clock_gate_off:
>         card clock still not gate off in 100us!.
>
> Implement support for the vendor specific command implemented in IMX
> SDHCI hardware to be able to avoid this warning.
>
> Patch 1/2 implements vendor specific command support in the SDHCI core
> code. At this time, only IMX vendor command support is implemented,
> but the implementation is written with expandability in mind.
>
> Patch 2/2 enables IMX SDHCI vendor extensions for all affected emulations.
>
> v2:
> - Added Reviewed-by: and Tested-by: tags to patch 1/2
> - Added missing error checks to patch 2/2
> - Added Tested-by: tag to patch 2/2



Applied to target-arm.next, thanks.

-- PMM

