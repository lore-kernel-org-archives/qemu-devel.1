Return-Path: <SRS0=+uBF=DN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18328C4363D
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:20:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4DB0420663
	for <qemu-devel@archiver.kernel.org>; Tue,  6 Oct 2020 12:20:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PnSujMkB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DB0420663
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35486 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kPlwo-0003wR-By
	for qemu-devel@archiver.kernel.org; Tue, 06 Oct 2020 08:20:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50930)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kPlvh-0003N6-GZ
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:18:53 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d]:44629)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1kPlvf-0005N0-GX
 for qemu-devel@nongnu.org; Tue, 06 Oct 2020 08:18:53 -0400
Received: by mail-ed1-x52d.google.com with SMTP id b12so13264158edz.11
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2020 05:18:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=MFNLC3VZwAQXDrBp8oH5jMb7fBOxd027KWYblgA2yw4=;
 b=PnSujMkB6spRnI7IUkY2HT0eWkHujXnqkRR7CbsqaRm/7XE0tYllZs22yGVNciURq1
 JTUwCAG7eY/xoR8Yia/8ka7pm8dZx4hhUev3UIV+Z4SXSKHladPmYhpYXrDtiO39A5xq
 SJwUajfoJu6VTJzCHYBIDXs3Qe0D/3YVGWL9GwkygvFfz5ilnkQmiFBLwZKBgHKk8u2h
 gEbDCVG0UeLg79CYnO2d+3g09mXhj/uaYfbQQId0jaZIel4sBxn4X7OaKNzVh/nG/nte
 jetLkftiINaTwl6BLC8ZfHbwyvMY1uZxVPzk/VyHIc5wZiZDYdDhAq7xqV31+60pBbdW
 lVDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=MFNLC3VZwAQXDrBp8oH5jMb7fBOxd027KWYblgA2yw4=;
 b=uEfGl5qjO+18JtCt4A3/xO1TCd3eITrlMUArdB4MgzOTpKat9IPTyiehlCvqc054/I
 F3NALzEjV5EylIVYq7/y4WewZf8jU6gXMdEr1XrRG5T92HD5mlBevffPe7gKm4MltgG9
 ZdrnyJyEabz3YImIv7a5WikADd+0fnEI/m/AGAHs4GcINotcdx6ngiTb43be3tMG2NSc
 geavXZmDGvvJXQf9CLyLZCiobggZ02uTjgaMHX+yUfKfddx3HPr4XQDSQx9JDQ681Q2N
 ss4vpzuaz4CW8m3ho19Boc38jPYrAB3CbcEucB+bR23ObyPBobH+vkc87QcBZz7mjVnn
 OFuQ==
X-Gm-Message-State: AOAM533sOIgswmnbBg5b67BvHql6LkP7RVuREuxg8NhLzTTegzuv0Evz
 k+YXIxWGSDdPuEv64RhJ7vy0InuGamelNKt7byBNnQ==
X-Google-Smtp-Source: ABdhPJyZZ+7NOEYZQpPcFJxqqiqlG4qnmJXnw2aWv2FMJ6eKHpY7S+biv9YjPTBoR+1BG5ZduZaQZRJARMHz2lnx6sM=
X-Received: by 2002:aa7:c302:: with SMTP id l2mr5202414edq.204.1601986729556; 
 Tue, 06 Oct 2020 05:18:49 -0700 (PDT)
MIME-Version: 1.0
References: <20201005154323.31347-1-stefanha@redhat.com>
In-Reply-To: <20201005154323.31347-1-stefanha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 6 Oct 2020 13:18:38 +0100
Message-ID: <CAFEAcA8-p56=5P54hVRfHFbuxTbiDP+AGWbFMHJu-H-rk-brCg@mail.gmail.com>
Subject: Re: [PULL v2 00/17] Block patches
To: Stefan Hajnoczi <stefanha@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
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
Cc: Kevin Wolf <kwolf@redhat.com>, Fam Zheng <fam@euphon.net>,
 Eduardo Habkost <ehabkost@redhat.com>, Qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Cleber Rosa <crosa@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, 5 Oct 2020 at 16:43, Stefan Hajnoczi <stefanha@redhat.com> wrote:
>
> The following changes since commit 469e72ab7dbbd7ff4ee601e5ea7c29545d46593b:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2020-10-02 16:19:42 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/stefanha/qemu.git tags/block-pull-request
>
> for you to fetch changes up to 9ab5741164b1727d22f69fe7001382baf0d56977:
>
>   util/vfio-helpers: Rework the IOVA allocator to avoid IOVA reserved regions (2020-10-05 10:59:42 +0100)
>
> ----------------------------------------------------------------
> Pull request
>
> v2:
>  * Removed clang-format call from scripts/block-coroutine-wrapper.py. This
>    avoids the issue with clang version incompatibility. It could be added back
>    in the future but the code is readable without reformatting and it also
>    makes the build less dependent on the environment.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.2
for any user-visible changes.

-- PMM

