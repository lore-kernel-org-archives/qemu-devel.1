Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78431C433DF
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:10:01 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4323220738
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 19:10:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="shGHkeue"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4323220738
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57162 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k9CQK-0006YG-IY
	for qemu-devel@archiver.kernel.org; Fri, 21 Aug 2020 15:10:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55318)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9CPa-0005uZ-Jg
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:09:14 -0400
Received: from mail-ej1-x636.google.com ([2a00:1450:4864:20::636]:35649)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k9CPY-0005bI-GG
 for qemu-devel@nongnu.org; Fri, 21 Aug 2020 15:09:14 -0400
Received: by mail-ej1-x636.google.com with SMTP id a26so3598626ejc.2
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 12:09:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=aoX/cNIIsnByReMMiUOzNvMTf8+idCWJ6JVBXIaYLSY=;
 b=shGHkeueOBONZyXMH4T673lkD7y5qv6zkOYZsriUanXoHjxSfG/QtU7BBCuJwnjOUA
 PUcUm6b8+V3M8vyn0Xbzh95vzfO6W1n4EbY1IiMZ7jvcqz6RCYzDRwCUGdf1114rdcWQ
 2kmUClmpKq0mQESXkl87JibLbeDqq1+ZCqzDQaH8Fr6HlnupuzJZjJTFQWSziJToTlKk
 l+iadu6bSN/OuNDmFHZ7LsmJMYlyPUwb85FutmHkCVIpEC6kt1CRcfpE3WuZly7DApFB
 A3LgBqgbiQ33Oma5Rm9xgcQfV6YfriPk0n4ThMK3vRtwNGmYe/XsrW21dwT2I4JpErHX
 aHpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=aoX/cNIIsnByReMMiUOzNvMTf8+idCWJ6JVBXIaYLSY=;
 b=KMtuISr9f5jFmDxm4OZuU/CfZ24NCD8N0B8vJZGs2LsVssoMhhqQycMIBkd7GeqrpQ
 LhY3MQ8SLAtZZYhGFWdmNC4xRkj4ojx93RAPICz7T33EIyF6MWSJUvt3GjeVoR22fmav
 tITLx2KCizidwrXaOeVyeslGImQy/ki0a58xIG7PnvDul8ONl3uJEIWs3ga6t36Btb09
 iDLAvezmGFab38MoWIg3g+CZTzSQL+FOIODiJvRVDEaMGs3xNc20IcQiMHmr3ORHTx6f
 td2u85j+vcHXuyKZpQobJaczsXJ3Yt2sIxyXzKHnGALaR4MuzxuV8eaW6YVarWJrAEYh
 sGuA==
X-Gm-Message-State: AOAM531pHq5504WLinUPHGBSHbPMfOYlUzcrWFInpUrdVtNOYIApfnQ6
 wBQcp8lhgWliIHrQhSAM1H6j1fyBjvq4k/3eZ5LjWA==
X-Google-Smtp-Source: ABdhPJxUnN2LwyTTjQWuQ7jch888r5E7CJ7Tc3lCR/F8oXJ2iRwrd47Gjhua6Czi+vzARWxSNYOtDKpELDeLujzbMhM=
X-Received: by 2002:a17:906:7fc9:: with SMTP id
 r9mr4134799ejs.407.1598036950309; 
 Fri, 21 Aug 2020 12:09:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200817151634.35563-1-stefanha@redhat.com>
In-Reply-To: <20200817151634.35563-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 21 Aug 2020 20:08:58 +0100
Message-ID: <CAFEAcA84g028hVQV6NHzh-44Z00bFjwpYy1SQ03MO8LSfTUnRw@mail.gmail.com>
Subject: Re: [PULL 0/3] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::636;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x636.google.com
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 17 Aug 2020 at 16:16, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit d0ed6a69d399ae193959225cdeaa9382746c91cc:
>
>   Update version for v5.1.0 release (2020-08-11 17:07:03 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 44277bf914471962c9e88e09c859aae65ae109c4:
>
>   aio-posix: keep aio_notify_me disabled during polling (2020-08-13 13:34:14 =
> +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

