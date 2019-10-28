Return-Path: <SRS0=Szrt=YV=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC0ACA9EC0
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 21:15:57 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AEC0A21479
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2019 21:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UBL1r0HG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AEC0A21479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43888 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iPCMm-0005Go-Rt
	for qemu-devel@archiver.kernel.org; Mon, 28 Oct 2019 17:15:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:41197)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iPCKD-0003hQ-1E
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 17:13:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iPCKB-0003pf-KX
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 17:13:16 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:43258)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iPCKB-0003ow-EL
 for qemu-devel@nongnu.org; Mon, 28 Oct 2019 17:13:15 -0400
Received: by mail-ot1-x344.google.com with SMTP id b19so5567167otq.10
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2019 14:13:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=GyjR0Mt25HWJJcFrencpKRwn/ou68jOyiWVAcYKGGzM=;
 b=UBL1r0HGojNWT78HwcSPUrRGt4f+8YtbQCAr1azXjwEkSUhhL9RJIarjWTBxV/a8Uk
 Ga55PFxz4MmC0mCKWAZBFTMJWT8Q9AyD2JmzY4Cc8rbmZyrpzY0gAVS0v7dlpDpiYseD
 kdMn7CdhjlStJxlwUqB0QO2uJCdsQ+51MUwhGg7n5L2mp4JlzS6oepZgf9mxdByhT8zs
 mKA0M0oO8Bw5fCUGEtMV1EJMNR7C4vETBBBJuG/kGVZ0jCjQ1TWtdOclcHbBEsgXSAv5
 NsdcYJYdrLuVwNi9XZxe5vh8cEay2u+rnUIIduxiO+ZsrCc0eBpPi/9FXvjSUIOh+ctT
 AsJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=GyjR0Mt25HWJJcFrencpKRwn/ou68jOyiWVAcYKGGzM=;
 b=OlBfT1CH56hd8GAo/Zpdqpm7BZfEYRkPvcLoDwslo8XV7AlGyW/bcUFRE2lthyKUsX
 CYD8L5M0hBQnaHQ8QV2/YxooyayWK70H5m4NHmbu9vnnmjcXm4c7kCeRJoPpSG4B1Fm5
 Atd8Dbm1LBwg5UpdpzXSKicN0QpcP/StNdrJB5XAKY/qXn+AuuOYzvD6tqLNElvuIlCk
 4MxKu+Hv6BBODVK2n+XivCwkI+evCecnmdnWMWGnDhj3JDR8cTjqsoLaFv7aaWnwLIFR
 AHHdqJrzAwoE0TCa4HGTjpif2TTZiGprkluunWGoPPnSiRde2l4G4eN3gyquVs+//o6u
 OnKA==
X-Gm-Message-State: APjAAAU64AmF6ztm6hhA4daENQEV23qHAnfENUVwaPweq9QjsmP1q+/w
 iN9fSh2QlcpoVX1NIt5RloavEiFNbJF/CNnNjwGa7w==
X-Google-Smtp-Source: APXvYqxPtT+XzSfu69AKHxBO/nld1OwE2IKECQFqzNnh+9S0DTMjMehKcmhy8ZZDAp48vOsnC7JFnk4/TqmGDdMpp4Y=
X-Received: by 2002:a05:6830:ca:: with SMTP id
 x10mr14419213oto.221.1572297194337; 
 Mon, 28 Oct 2019 14:13:14 -0700 (PDT)
MIME-Version: 1.0
References: <20191028121501.15279-1-mreitz@redhat.com>
In-Reply-To: <20191028121501.15279-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Oct 2019 21:13:16 +0000
Message-ID: <CAFEAcA9A41vp_WDOWxw_+tWTsLppW8Z0Gg0yWCWOK3KSmGtyog@mail.gmail.com>
Subject: Re: [PULL 00/69] Block patches for softfreeze
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
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
Cc: Kevin Wolf <kwolf@redhat.com>, QEMU Developers <qemu-devel@nongnu.org>,
 Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 28 Oct 2019 at 12:15, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 187f35512106501fe9a11057f4d8705431e0026d:
>
>   Merge remote-tracking branch 'remotes/stsquad/tags/pull-testing-next-251019-3' into staging (2019-10-26 10:13:48 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2019-10-28
>
> for you to fetch changes up to ba9c45139e2938b8d20ce407db83a31bc9e5066c:
>
>   qemu-iotests: restrict 264 to qcow2 only (2019-10-28 13:09:43 +0100)
>
> ----------------------------------------------------------------
> Block patches for softfreeze:
> - iotest patches
> - Improve performance of the mirror block job in write-blocking mode
> - Limit memory usage for the backup block job
> - Add discard and write-zeroes support to the NVMe host block driver
> - Fix a bug in the mirror job
> - Prevent the qcow2 driver from creating technically non-compliant qcow2
>   v3 images (where there is not enough extra data for snapshot table
>   entries)
> - Allow callers of bdrv_truncate() (etc.) to determine whether the file
>   must be resized to the exact given size or whether it is OK for block
>   devices not to shrink

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.2
for any user-visible changes.

-- PMM

