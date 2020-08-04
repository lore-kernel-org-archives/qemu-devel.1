Return-Path: <SRS0=UEgn=BO=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52C68C433DF
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 12:04:08 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 240D42086A
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Aug 2020 12:04:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="EJD76uf1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 240D42086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42172 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k2vfr-00088k-CB
	for qemu-devel@archiver.kernel.org; Tue, 04 Aug 2020 08:04:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59564)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2vea-0007GP-Oc
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 08:02:48 -0400
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232]:46291)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1k2veX-0003eF-I9
 for qemu-devel@nongnu.org; Tue, 04 Aug 2020 08:02:48 -0400
Received: by mail-oi1-x232.google.com with SMTP id v13so19465449oiv.13
 for <qemu-devel@nongnu.org>; Tue, 04 Aug 2020 05:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=yoKmKiR2TJ74eR2Wzmi7g0ckceS6f1XmFqfjMXSAC0E=;
 b=EJD76uf1qlnEbnbsSXcCjiR1dwF63Eymy4O3vdUuxerJGrjkx8QmybzJ3s7f0BtRaA
 AJQMd2jWYVcLD7Q9+ET5jGb/RzyjdlWE1qbNFSWwkdvB7sa1fGpxIqPF5WLWDJz+EHVI
 BgHBMoZtVg5G6iWt+KPjMJgLgdGWV7NjEcR1yc2O9fDeIGk0bC/1lo81odjohmF32WZ2
 gtQduwbXt96PWkauMBsGmvODCtFhxx4obfWoW0QUJjPsb6a9T0CzHWk/r8BGF1hw2YOs
 XudmYvMvo8I2nDzAch+QRxWvA+PuGI8kC5GuSFnlSFuYQqd0Bf39m47a9Q34hdgWvgZU
 mu2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=yoKmKiR2TJ74eR2Wzmi7g0ckceS6f1XmFqfjMXSAC0E=;
 b=itdBvqADHoS/kfpAt7pFCRIg6KKBj4QiB4vPHUMNcUDpUpEAf56F/E892Xr5qxjyJA
 4f2Wj/0OCjBZIkV6UaSN8DxNxn/oGg5a91dPoBVPUp2lMuRalLXYTBWJIItCx539CWro
 EgArJRX6wZ6ygKPbuRTw6oac8Gf7SuseNBs2sxPQvYHWbHDc7WX8QFnQC1OuIK3wIstz
 MKdcyalxodET0j/y+4aszjJFA+pdSpO9QD8CTay6pUnqfZ3FDA3X/UOgcdhngLlpwA29
 EFWFyDHwCVrgLg7MOTxA7BcqLknKU7IrRyDJ2QSQj9kFMC84HfA7y4XblpM0fSsCLfk5
 EJ1Q==
X-Gm-Message-State: AOAM530eSxGhBKCKMCyOO0pD3XL/9NdPK8U+Bw/DXpdcdyjNGHDyjjV6
 cqs9JDGOnT6T9PIA4pW2ETTSzezNGGU+jU58bddmQQ==
X-Google-Smtp-Source: ABdhPJwh89DKXqLZiAeMyV9LAFWrB/U0YIK3LfYvYk9eY4qJFGJuRx/INllEMvIAujSto2az2g/8kBZ0ao02G4dSGnE=
X-Received: by 2002:aca:50c4:: with SMTP id e187mr2897725oib.146.1596542563240; 
 Tue, 04 Aug 2020 05:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200804092624.1126013-1-anthony.perard@citrix.com>
In-Reply-To: <20200804092624.1126013-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 4 Aug 2020 13:02:32 +0100
Message-ID: <CAFEAcA8c9w7iKy5UA=jS47mQrK7SZTkta8OktBNvH3crTs=rYw@mail.gmail.com>
Subject: Re: [PULL 0/1] xen queue 2020-08-04
To: Anthony PERARD <anthony.perard@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::232;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x232.google.com
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
Cc: "open list:X86" <xen-devel@lists.xenproject.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 4 Aug 2020 at 10:26, Anthony PERARD <anthony.perard@citrix.com> wro=
te:
>
> The following changes since commit 5c1c3e4f02e458cf280c677c817ae4fd1ed9bf=
10:
>
>   Merge remote-tracking branch 'remotes/pmaydell/tags/pull-target-arm-202=
00803' into staging (2020-08-03 20:34:26 +0100)
>
> are available in the Git repository at:
>
>   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-x=
en-20200804
>
> for you to fetch changes up to 8e0ef068942e4152f0d23e76ca1f5e35dc4456f7:
>
>   accel/xen: Fix xen_enabled() behavior on target-agnostic objects (2020-=
08-04 10:21:35 +0100)
>
> ----------------------------------------------------------------
> xen patch
>
> Bug fix.
>
> ----------------------------------------------------------------
> Philippe Mathieu-Daud=C3=A9 (1):
>       accel/xen: Fix xen_enabled() behavior on target-agnostic objects


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

