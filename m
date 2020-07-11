Return-Path: <SRS0=vx8y=AW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E70DC433DF
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 14:12:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B35F2076A
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Jul 2020 14:12:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qM2wRNus"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B35F2076A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:48158 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1juGET-0006T6-8Q
	for qemu-devel@archiver.kernel.org; Sat, 11 Jul 2020 10:12:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58510)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juGDw-00061N-6y
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 10:11:28 -0400
Received: from mail-oo1-xc36.google.com ([2607:f8b0:4864:20::c36]:39036)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1juGDu-000247-GQ
 for qemu-devel@nongnu.org; Sat, 11 Jul 2020 10:11:27 -0400
Received: by mail-oo1-xc36.google.com with SMTP id c4so1534228oou.6
 for <qemu-devel@nongnu.org>; Sat, 11 Jul 2020 07:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=yzLl2PgbI1FNgby9NDzTcsup/gjp2Uex/YQuS8VmxYU=;
 b=qM2wRNus0twBuJctyCrhetAiA4H4O4PAUSsppX2YFQjOSiMUK3kMPVEhKqZQZF4g55
 DLBzmmcC8kLbOMDUTqN++GqlT6pM/Mb/7XridGwQkzYUGvCLjjCH0gy4HxgtLxe79P8c
 B18fyTtOpy+52VVatjOgMHPBmoC+4DTRyIU1gfxYUGlzABbyQgizczkL8X1hiKHYqdYF
 +YmgiVVjQBBs507FU9zEFxKTUDSFt6mVOFDt2jmNNia2RW2pcAK2Fj5Hp8CA9vsacnM1
 knv5h8ZfRwOFFyzCR3M0YnHn47bLPxC6H0YJA22vxBzeiaDsjj9wMk8xE0kzfGut8R1t
 g2hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=yzLl2PgbI1FNgby9NDzTcsup/gjp2Uex/YQuS8VmxYU=;
 b=t8JrzZsoQM+weCp3XOSx82/M/W16+mG02kfW+LRGsNZ4PlN8wEEutnEQ36OjaIkSl3
 WSmyTBT11PnCumV0RXoxt4BPZKWa1Fh+Mf7sl5bPyxnH9tmwU6aZJVtvf/3clVNhZWDb
 8jHD0iti8Z7zEfrrUGpMwwM0ePL+0Nrn5q40pcM+8tIeH3AF9bQXrfHyEv9gk384jodl
 8NSlbIwGCe5DD6L2DmfmPECvYLzXJjp/W9C/0Sxuw3NYyAJRYi+px/Xx1iGcjXnWoWdY
 3zb1KvB332c25ZnkqfNqDwaQSn24xtB0FucF8il8sFNppqw/4Y++vcOAa5/iLLryGkzP
 0Zlw==
X-Gm-Message-State: AOAM530/CRWB2b9UGRR+SUnxNNAE8CEVtEStjCrmdbv3miB3Y59Ye7sc
 SYV4OvLyRRwRT0fGE+Dv7dBaCSYdYu7jg895EbFjqg==
X-Google-Smtp-Source: ABdhPJzcy6k5v3Yt8/825njvJvXCdsdLtrZUgpv74mVPfIjDgfyzHYzYagTuYX8ycfvp2QWcSD74nWhxOdboT6Ly/mo=
X-Received: by 2002:a4a:9653:: with SMTP id r19mr41397241ooi.85.1594476684538; 
 Sat, 11 Jul 2020 07:11:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200710131145.589476-1-anthony.perard@citrix.com>
In-Reply-To: <20200710131145.589476-1-anthony.perard@citrix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Sat, 11 Jul 2020 15:11:13 +0100
Message-ID: <CAFEAcA__qp9jrvdw7Zt6_y_Z9NjEtn+5arsds9cWpoWF=doYSA@mail.gmail.com>
Subject: Re: [PULL 0/2] xen queue 2020-07-10
To: Anthony PERARD <anthony.perard@citrix.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c36;
 envelope-from=peter.maydell@linaro.org; helo=mail-oo1-xc36.google.com
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

On Fri, 10 Jul 2020 at 14:11, Anthony PERARD <anthony.perard@citrix.com> wrote:
>
> The following changes since commit b6d7e9b66f59ca6ebc6e9b830cd5e7bf849d31cf:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/tracing-pull-request' into staging (2020-07-10 09:01:28 +0100)
>
> are available in the Git repository at:
>
>   https://xenbits.xen.org/git-http/people/aperard/qemu-dm.git tags/pull-xen-20200710
>
> for you to fetch changes up to dd29b5c30cd2a13f8c12376a8de84cb090c338bf:
>
>   xen: cleanup unrealized flash devices (2020-07-10 13:49:16 +0100)
>
> ----------------------------------------------------------------
> xen patches
>
> Fixes following harden checks in qdev.
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.1
for any user-visible changes.

-- PMM

