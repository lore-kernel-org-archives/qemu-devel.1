Return-Path: <SRS0=2Sdx=UN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13324C31E4B
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:34:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8EFE2177E
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Jun 2019 15:34:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="wfRM2xpV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EFE2177E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52720 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hboDe-00005s-6Y
	for qemu-devel@archiver.kernel.org; Fri, 14 Jun 2019 11:34:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40105)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hbnYM-00023B-2I
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:51:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hbnYL-0008Hz-1z
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:51:41 -0400
Received: from mail-ot1-x329.google.com ([2607:f8b0:4864:20::329]:33160)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hbnYK-0008H5-P5
 for qemu-devel@nongnu.org; Fri, 14 Jun 2019 10:51:40 -0400
Received: by mail-ot1-x329.google.com with SMTP id p4so2925402oti.0
 for <qemu-devel@nongnu.org>; Fri, 14 Jun 2019 07:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=S6zqQalfkqCDaGwDOjJXKSBFfxxmr6eRLcatrxA4dUg=;
 b=wfRM2xpVoRwkbX3VJbPYy+uva9F5EkoJb49diVd0he4vOjcYtd2jKGWJAyMoBqX+gm
 wQ+pDZpHTeD6HsKTNa6xqzeyTI2z3fgAYrt1DMzTDGxgsaoU+KxFEmC1BUpd9ljidbta
 UlGevKoG0bqYe9oqszYUjkSyTHvF3rdJ/fjBknxwAtHZZKqM5HoaLTKfKCbJ3RSLYooB
 NfHzxNlUd0simdowkkIjSQYmRIX+iivkNKyQ5Pf+A71O04K4m+9Z5GkZzdxcyWNtatSV
 KUiznI4P0GuJ2laetOGA1uEdcu/AoTdcOOdLHAE6RqiRTfyA5ti0yy4N494KK+371Kxj
 a+Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=S6zqQalfkqCDaGwDOjJXKSBFfxxmr6eRLcatrxA4dUg=;
 b=qGtq5E0m+QyyTxbLa/pSHdfw6Rnt5BEigjoUi2UnygCaSPb6Z5/J9/R1ck+hNcOMvd
 vEFVNFPljQvzxuL+nT8+b25lll4yVSLFIc0JKn15LAE75wWeachQnh+tlf0wi7nn6xNO
 HDMlpnWFjq72DNdaLg1wv74cjN671esfWKeGzedZclh8Q5RT8ei7obLP401l4nysuQhY
 kmj73RjUjYEs1gLH1GayYd/ejzCy4v/yScQ3NYj3WAjLPsACsGNtzipLPXfaO8qEwmCY
 oMlu3o/rG0fesJL9ac2w/Q+7cMsW+RoKhkYik3iEFcJt2QZqeVZfL6lwIw+RIR0XAuVU
 dK/A==
X-Gm-Message-State: APjAAAWT/lmE2PeyrpG56PkK8DdT6f/rDWNGZlztt9nG1zzuQSvnzK1r
 tN12uyYfieWtV8FrFGlCwUtrtkQElK/gjtmwR34Vcw==
X-Google-Smtp-Source: APXvYqw4Wg5poRVVqCZH9PmUPUq6uFBDdys+GMcUU4Twyv5BbELgn+eAFSWFu9jDOJSYYkwZmXTJ3Bjw7HCQUaFwaGQ=
X-Received: by 2002:a9d:d17:: with SMTP id 23mr46914402oti.221.1560523899538; 
 Fri, 14 Jun 2019 07:51:39 -0700 (PDT)
MIME-Version: 1.0
References: <20190614134021.32486-1-mreitz@redhat.com>
In-Reply-To: <20190614134021.32486-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 14 Jun 2019 15:51:28 +0100
Message-ID: <CAFEAcA_xm5bWZum6O8+P6zCddsK7Y02MftRhn-p9HoF-BkQd9g@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::329
Subject: Re: [Qemu-devel] [PULL 00/20] Block patches
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

On Fri, 14 Jun 2019 at 14:40, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 5ec2eca83dc478ddf24077e02a8b34dd26cd3ff9:
>
>   Merge remote-tracking branch 'remotes/awilliam/tags/vfio-updates-20190613.0' into staging (2019-06-14 09:33:55 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2019-06-14
>
> for you to fetch changes up to 21c1ce592a144188dfe59b9e156a97da412a59a2:
>
>   iotests: Test qemu-img convert -C --salvage (2019-06-14 15:09:42 +0200)
>
> ----------------------------------------------------------------
> Block patches:
> - Allow blockdev-backup from nodes that are not in qemu's main AIO
>   context to newly added nodes
> - Add salvaging mode to qemu-img convert
> - Minor fixes to tests, documentation, and for less Valgrind annoyance
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

