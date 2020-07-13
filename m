Return-Path: <SRS0=6r5r=AY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AD05C433E0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:35:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 241A0206F0
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2020 08:35:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="CTY+VXgF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 241A0206F0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57924 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jutvb-0006Ym-FH
	for qemu-devel@archiver.kernel.org; Mon, 13 Jul 2020 04:35:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:45110)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jutum-0005f5-OP
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:34:20 -0400
Received: from mail-oi1-x244.google.com ([2607:f8b0:4864:20::244]:41613)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1jutuj-0007ie-Vk
 for qemu-devel@nongnu.org; Mon, 13 Jul 2020 04:34:20 -0400
Received: by mail-oi1-x244.google.com with SMTP id y22so10310751oie.8
 for <qemu-devel@nongnu.org>; Mon, 13 Jul 2020 01:34:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=viAZnrTBZeQWPn+TbviRi84L+AvSdDdkqR1AOfFBRr8=;
 b=CTY+VXgFU2RoCr1TDsk9mxOtIpDunUEhjOOJVd0Am0CUR0MIdtCKl8eTkoJP2OZzkW
 m6f13M8Q8jfsgEtWflwVuKzruSkuovYHkbVHWwqB1tQrv00qCNOh0sAHDZp7dflGyRUl
 qqSbTr7TmljN7utl+yr8cGUE39eUPfAdZnp86MsFqQZcLidbxLFxoYfd9td9HVi/Gzmt
 IYyNBYK2H+B8i5uF+VSWjAKf6haRquQHk70XdQhhhnJEeNSwyxjEQG16pnbBIS2w8Xqc
 RDO31oXQ62Py+BqatuUPhGmWTeT20Z49KMybMO9GLvK5zAXYqqgD27j2XDxEKJ+9Z0S9
 RifA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=viAZnrTBZeQWPn+TbviRi84L+AvSdDdkqR1AOfFBRr8=;
 b=HFikIKdfRgxH21zsZRvTDCW224Q96CKaSCLNK9j3K4UK6/By9NX1/o9kGv8nbkkxQN
 7TIn5CRtiH+hOF5LQ8o1PPQUA2S3tJKA9Kybw8Ns9lvxsYY+k5hJTXagvSRbgWcylFv/
 SWqD/rnPm3UObAkhjG4fun/PmMJioJUaWABUY1XbffDyTN8c5pyS28IaJQjsLymNjmyS
 XhH0NaCzZXTvO5j7xtVdNmUAGDpLvg/zvy7b0PGBcpQSpqTSMKSg+MSiai3DutIl5pjC
 lEyKTiBUw36uzZXeuEpebs0ku04DoF/m0H4fTHHf/p5ydFv02VhYsniNEXh/11y0v8GA
 6g9A==
X-Gm-Message-State: AOAM530dVBBG+5Wil+Ys9/qRZQSjHm0wfeOzNm6kbts6H1evAHavDUZ9
 FjOT2uo212tuRhzvAd6pnlSpNAPrpi15I/KJHbeUxg==
X-Google-Smtp-Source: ABdhPJxrhR+0RwM4pUgi8B+4TqaWBB3T09BxfnHF4XYwDinssOziNfzPBkVUb8RrK9BjNERBNCr7PZqdBb0tTPDD50s=
X-Received: by 2002:aca:1706:: with SMTP id j6mr12500319oii.146.1594629256516; 
 Mon, 13 Jul 2020 01:34:16 -0700 (PDT)
MIME-Version: 1.0
References: <20200711170732.26213-1-alex.bennee@linaro.org>
In-Reply-To: <20200711170732.26213-1-alex.bennee@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Jul 2020 09:34:05 +0100
Message-ID: <CAFEAcA_m5dyUWt1ZF_YbrF_8SeCg_OtNY9rZR0dxSeKCg-FYjA@mail.gmail.com>
Subject: Re: [PULL v2 00/50] testing updates (vm, gitlab, misc build fixes)
To: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::244;
 envelope-from=peter.maydell@linaro.org; helo=mail-oi1-x244.google.com
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
Cc: QEMU Developers <qemu-devel@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Sat, 11 Jul 2020 at 18:07, Alex Benn=C3=A9e <alex.bennee@linaro.org> wro=
te:
>
> Fixed a few, dropped a few, added a few
>
> ---
>
> The following changes since commit 827937158b72ce2265841ff528bba3c44a1bfb=
c8:
>
>   Merge remote-tracking branch 'remotes/aperard/tags/pull-xen-20200710' i=
nto staging (2020-07-11 13:56:03 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/stsquad/qemu.git tags/pull-testing-and-misc-110720-2
>
> for you to fetch changes up to 4a40f561d5ebb5050a8c6dcbdcee85621056590a:
>
>   iotests: Set LC_ALL=3DC for sort (2020-07-11 15:53:29 +0100)
>
> ----------------------------------------------------------------
> Testing and misc build updates:
>
>   - tests/vm support for aarch64 VMs
>   - tests/tcg better cross-compiler detection
>   - update docker tooling to support registries
>   - update docker support for xtensa
>   - gitlab build docker images and store in registry
>   - gitlab use docker images for builds
>   - a number of skipIf updates to support move
>   - linux-user MAP_FIXED_NOREPLACE fix
>   - qht-bench compiler tweaks
>   - configure fix for secret keyring
>   - tsan fiber annotation clean-up
>   - doc updates for mttcg/icount/gdbstub
>   - fix cirrus to use brew bash for iotests
>   - revert virtio-gpu breakage
>   - fix LC_ALL to avoid sorting changes in iotests


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

