Return-Path: <SRS0=vzij=WB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3AD1DC433FF
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 18:06:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 071C1206A2
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2019 18:06:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dpcn8Fpl"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 071C1206A2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:56378 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1huhNS-00036V-8w
	for qemu-devel@archiver.kernel.org; Mon, 05 Aug 2019 14:06:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51656)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1huhMW-0002bb-To
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 14:05:38 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1huhMV-0000jI-R0
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 14:05:36 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:34751)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1huhMV-0000iT-Mw
 for qemu-devel@nongnu.org; Mon, 05 Aug 2019 14:05:35 -0400
Received: by mail-ot1-x344.google.com with SMTP id n5so86243554otk.1
 for <qemu-devel@nongnu.org>; Mon, 05 Aug 2019 11:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=x3S9lnMWPO6rmwqwt0o+pilqUoT9vEjbQASB4qNatFM=;
 b=dpcn8FplpMXKVO/2g/zLeH2wcRv88lmV4vx8CKKYowVeamoywNrOQbgx575LKKOSxB
 hx7JnaFlUhPLUtnzBuWdlB1lLl5Y5iEz+jYOUS5lWkUX8m4rpfb9gxxSJcv9lBTmnv9f
 6l4v582A185ouUTEaWEuJFgNbCfLUOh750eSnbuPRoSuk7r+nLyyuPuHvQ4DpXxkmSeB
 Z83Rxt5SSvrrej9YbgcXc2ZCuH46bK+t4zgjL4MXRafv7u2SWfNdh56n+72TwEq5GYMD
 s595r5Szy2NEZ0xO2nJyMUhnqouis3qL+xtxdrSixCy1eF0Yrn8gfp1pHTv82USEsmdb
 18Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=x3S9lnMWPO6rmwqwt0o+pilqUoT9vEjbQASB4qNatFM=;
 b=Sr3yUeI/8KpCTQYgP54otEN5zzH0mMBvKHSURaTiWs+OIkAlhMOAbuFar5LNdD4Mr3
 WBdM6xhS2jpgEjid7RT1aDCU86fsRMwVnIhzbJrElMgcHe0Xm5HJGpKf6YtoWrpU1S2Y
 X7flrMwUlYnnIuoc+MIckb5Ar0KW7F6hbzd+QKUzS5G3xo8zOov4Q86JdknV5PT/6sn0
 tPCbAlwMziBxy2FGX5RwTNIhz3MfU4ue9Q6ko9ocJAWDtW+cS/B6SddXDFdHiH5HNKKe
 SlVVMPtKtytd7c+EOxMsbqMf44rigQ6JhBqS/3rwu50NiIAWWEpitEnVRig7uecrTGaI
 0Dvg==
X-Gm-Message-State: APjAAAWnkUA2km7o72lyM8dUl0EV3dbiVh0VYN11nOO23HVw7D65j9AW
 PWqj9XlFp7YSFnSvro7kGBUX9cJSxuQZ3AuOiF/Uz1w1
X-Google-Smtp-Source: APXvYqy5hfzJZU5bBPI6l0OShr0ZsiTMCKzr9l2eI6VNfsCI2VbKeuqGj9xD77X26kLYTSAjqNYxAoiTVyIeocPC/50=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr56501036oti.91.1565028333828; 
 Mon, 05 Aug 2019 11:05:33 -0700 (PDT)
MIME-Version: 1.0
References: <20190805163740.23616-1-mreitz@redhat.com>
In-Reply-To: <20190805163740.23616-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 5 Aug 2019 19:05:22 +0100
Message-ID: <CAFEAcA9UH0g2A5g=akRbcLS4RXKQcDfFySFum3-fgO=R=mE=Ng@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 0/7] Block patches for 4.1.0-rc4
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

On Mon, 5 Aug 2019 at 17:37, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 9bb68d34dda9be60335e73e65c8fb61bca035362:
>
>   Merge remote-tracking branch 'remotes/philmd-gitlab/tags/edk2-next-20190803' into staging (2019-08-05 11:05:36 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2019-08-05
>
> for you to fetch changes up to 07b0851c592efe188a87259adbda26a63c61dc92:
>
>   block/backup: disable copy_range for compressed backup (2019-08-05 18:05:05 +0200)
>
> ----------------------------------------------------------------
> Block patches for 4.1.0-rc4:
> - Fix the backup block job when using copy offloading
> - Fix the mirror block job when using the write-blocking copy mode
> - Fix incremental backups after the image has been grown with the
>   respective bitmap attached to it
>
> ----------------------------------------------------------------
> Max Reitz (5):
>   backup: Copy only dirty areas
>   iotests: Test backup job with two guest writes
>   iotests: Test incremental backup after truncation
>   mirror: Only mirror granularity-aligned chunks
>   iotests: Test unaligned blocking mirror write
>
> Vladimir Sementsov-Ogievskiy (2):
>   util/hbitmap: update orig_size on truncate
>   block/backup: disable copy_range for compressed backup
>
>  block/backup.c             | 15 ++++++++++++---
>  block/mirror.c             | 29 ++++++++++++++++++++++++++++
>  util/hbitmap.c             |  6 +++++-
>  tests/qemu-iotests/056     | 39 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/056.out |  4 ++--
>  tests/qemu-iotests/124     | 38 +++++++++++++++++++++++++++++++++----
>  tests/qemu-iotests/124.out |  4 ++--
>  tests/qemu-iotests/151     | 25 ++++++++++++++++++++++++
>  tests/qemu-iotests/151.out |  4 ++--
>  9 files changed, 150 insertions(+), 14 deletions(-)

This is quite a lot of changes for rc4 -- how confident are
you about them ? I suppose 3 out of 4 commits are updating
the test suite...

thanks
-- PMM

