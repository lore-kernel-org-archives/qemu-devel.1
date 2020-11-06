Return-Path: <SRS0=tv2o=EM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C2C2C55179
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 10:36:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 906F5206ED
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Nov 2020 10:36:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PGS4GCV2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 906F5206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50720 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaz68-0004Zj-1V
	for qemu-devel@archiver.kernel.org; Fri, 06 Nov 2020 05:36:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:50864)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaz4e-0003p2-9b
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 05:34:28 -0500
Received: from mail-ej1-x629.google.com ([2a00:1450:4864:20::629]:33446)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kaz4c-0002zz-FB
 for qemu-devel@nongnu.org; Fri, 06 Nov 2020 05:34:27 -0500
Received: by mail-ej1-x629.google.com with SMTP id 7so1241432ejm.0
 for <qemu-devel@nongnu.org>; Fri, 06 Nov 2020 02:34:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=BV7jLz7kbMc4ByjP0kIb1qW+PSrnjStNDvt5h+atTZs=;
 b=PGS4GCV2W6rEZjaDZDkqbr509MM0TjNiH76uE+jIyfpJxB9xVshjM8BV6vZVfXzOvb
 2HkgysO8tB/Wz9jncnP/oThkmc4HQr2Y5nsVJhCqJS5vyrxyEY7IUYY9RKb9ciTQtkzU
 TGFnYJjMDUWF4lg05PPDMg963Ss2FwftlkDCtvpNMQBPTIlmrZGg6ry+pilgxOgpR+7y
 4jkPxuouYMp70pd+NL/BD3Ze4y0ZuKdoDkVFNFEsKJMEADqcMFvxa7hcO+z0YU4kQ1wY
 Jr816WF8CWhvir8hT+G3XjL7xcu+OPRqXMMkRCo+Ugl/kuZbhSowtJgaXzHH6XSwgnoc
 cEWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=BV7jLz7kbMc4ByjP0kIb1qW+PSrnjStNDvt5h+atTZs=;
 b=Ac3Er/JVErD28neoI1C4pv9WmPCHJxVnq4je9FDrxr8oeg2aj6f9ZszKHa/kHiJQR9
 BQt4n4Noc8BZkMr8aGW4umRRkrxwO3+g61Wj2XK+aSjLMeSpFVjAi0pZS3dHtbbtlUM6
 aiHivk5MFJAsxDl16W6OPoR/0FaxMd+W2dY7/ZVLzYHDj9+X2oLxZ3i5oXuOwmRjVzqS
 z95vhOT1DrrlQ2FkplDxwisUxrrqSfNzJnhL1RfdcBV5JNKckij3xmPe71rs3RsypMO/
 G1OXy4qWZ3p8hbMd3zG4X4WVQjIfsKRV7tBW25baT/fJKa1wvYr1TBRir0RDGgdoz8Ma
 bPsQ==
X-Gm-Message-State: AOAM532awKkTThoSg+VeRnl83wRJA6hpytze4TGRAt3mNUjq1UMzUuhs
 u1mbxYeSjftVpL2dlejCWcBp3URF/oFTqvVHIq+3dg==
X-Google-Smtp-Source: ABdhPJw2A2LTWUuDU6UAFHu1hLV/O3aDi1n915pqPLD5ZW9scIviaK8BeLiRFQ6hnvrQSlQ6repKK+3VaXSnbForio0=
X-Received: by 2002:a17:906:6896:: with SMTP id
 n22mr1456325ejr.56.1604658863944; 
 Fri, 06 Nov 2020 02:34:23 -0800 (PST)
MIME-Version: 1.0
References: <cover.1604653990.git.qemu_oss@crudebyte.com>
In-Reply-To: <cover.1604653990.git.qemu_oss@crudebyte.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 6 Nov 2020 10:34:12 +0000
Message-ID: <CAFEAcA_aaWxPfupDTrkoPSZoHEyaGhP374rx=8Ei+DJYdZvs=g@mail.gmail.com>
Subject: Re: [PULL 0/4] 9p queue for 5.2 (2020-11-06)
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::629;
 envelope-from=peter.maydell@linaro.org; helo=mail-ej1-x629.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>, Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, 6 Nov 2020 at 09:36, Christian Schoenebeck
<qemu_oss@crudebyte.com> wrote:
>
> The following changes since commit e2766868d45d8c8f8991cfd133e6a0c14abfe577:
>
>   Merge remote-tracking branch 'remotes/kraxel/tags/fixes-20201104-pull-request' into staging (2020-11-04 22:13:02 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/cschoenebeck/qemu.git tags/pull-9p-20201106
>
> for you to fetch changes up to e6b99460b14469e0b83febc8d5a501947d1d5c7c:
>
>   hw/9pfs: Fix Kconfig dependency problem between 9pfs and Xen (2020-11-05 15:21:11 +0100)
>
> ----------------------------------------------------------------
> 9pfs: some fixes
>
> * Fix meson build config for Xen.
>
> * Code style fixes.


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

