Return-Path: <SRS0=ES4k=XM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DC39C4CECD
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:06:09 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EEB9F20640
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2019 19:06:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="l5R+xVhM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EEB9F20640
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49874 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iAIng-000727-5I
	for qemu-devel@archiver.kernel.org; Tue, 17 Sep 2019 15:06:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:36139)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <alex.bennee@linaro.org>) id 1iAIjZ-0003Z8-CG
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:01:54 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <alex.bennee@linaro.org>) id 1iAIjY-0002LH-Am
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:01:53 -0400
Received: from mail-wm1-x344.google.com ([2a00:1450:4864:20::344]:51889)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <alex.bennee@linaro.org>)
 id 1iAIjX-0002KT-LH
 for qemu-devel@nongnu.org; Tue, 17 Sep 2019 15:01:51 -0400
Received: by mail-wm1-x344.google.com with SMTP id 7so4815417wme.1
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2019 12:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:in-reply-to:date
 :message-id:mime-version:content-transfer-encoding;
 bh=EVmYuxjFGl26Gukos0PdMYSNBzbtqt2j86FLhO3pfE0=;
 b=l5R+xVhMV53+VvWMyNxKsGKgqo7RbtBNEqR1Pgz0HvlguOswHwYNMPwNctAEttsWgi
 4VGdo3cJqIhNbRR7jdr9mH4erC47+mJ2zOfI53auwOkVysieudjyXTw87sVi9cmBODRK
 Dmeu8F6pGfyifEO0KgdlDG/aIXePRbxGR8fG/BEq/0PzUhWNSfsFdtEkcBmJrBrQrgGH
 5G891eChEzcCupOqlVAEfSriM8Ii8z3labnFaslBFsjln6RFZjlZXXoUiEUfNMpX+g9Y
 w/KOvuAQgNkdi8RMb0Mn2Jx3BCAdQPawtxhXezu1QqzBdTRsi9K6EUJT51tcwAcEbyI8
 PYyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject
 :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
 bh=EVmYuxjFGl26Gukos0PdMYSNBzbtqt2j86FLhO3pfE0=;
 b=fmzH6Ace4NKdc5jHB5wssJRRDDH9MNMUMRKzUghPdI5rAVH+UUTntWS3qv+Tusmd5j
 v7xj0sD2Ap210fxvA3yL6kjcR5xb1IzFAnNKnfVftz3RBXk++uyKlsYcdFw4fKgMwfyH
 WSCywNgC3euG9yLm73vEMNmB7bF3mhFGmI/FTSgpz6m91+gEGnPIApyVeNVwLXN6KcJK
 htYTF35bYQUbGNq2ZAN+i0+mSBMVFBP4zHtqEQKLH9ywjOuV4HShyn+skIJ5TlN6Jdcd
 qxvRV13nZfReVOrJXOFAHrasQ6sjtXQ0Ha0X7ny5lavcmsja3An50VPabnRv2fJo4JTg
 iuwQ==
X-Gm-Message-State: APjAAAUIIxLwtJefud1UupA6plIwKuZdnyNggZzUMOf1nAl7vGBUhrOp
 8OLBiXJrfDacTo9kkTK5pLVdFA==
X-Google-Smtp-Source: APXvYqyEhzIq1z1oB0JEmv6bupFy/mtE9abgRrNZZCnjdxCws5ZtTzYWx1Dl4kaRVmiSgcBBymy5Zg==
X-Received: by 2002:a7b:cf12:: with SMTP id l18mr5200930wmg.25.1568746910246; 
 Tue, 17 Sep 2019 12:01:50 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w12sm5096104wrg.47.2019.09.17.12.01.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 17 Sep 2019 12:01:49 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 057801FF87;
 Tue, 17 Sep 2019 20:01:49 +0100 (BST)
References: <156872146565.1757.3033215873677512474.stgit@pasha-Precision-3630-Tower>
User-agent: mu4e 1.3.4; emacs 27.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pavel Dovgalyuk <pavel.dovgaluk@gmail.com>
In-reply-to: <156872146565.1757.3033215873677512474.stgit@pasha-Precision-3630-Tower>
Date: Tue, 17 Sep 2019 20:01:48 +0100
Message-ID: <87blvi21cz.fsf@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2a00:1450:4864:20::344
Subject: Re: [Qemu-devel] [for-4.2 PATCH 0/6] Block-related record/replay
 fixes
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
Cc: kwolf@redhat.com, peter.maydell@linaro.org, pavel.dovgaluk@ispras.ru,
 pbonzini@redhat.com, crosthwaite.peter@gmail.com, ciro.santilli@gmail.com,
 jasowang@redhat.com, quintela@redhat.com, qemu-devel@nongnu.org,
 armbru@redhat.com, maria.klimushenkova@ispras.ru, mst@redhat.com,
 kraxel@redhat.com, boost.lists@gmail.com, thomas.dullien@googlemail.com,
 dovgaluk@ispras.ru, mreitz@redhat.com, artem.k.pisarenko@gmail.com,
 dgilbert@redhat.com, rth@twiddle.net
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>


Pavel Dovgalyuk <pavel.dovgaluk@gmail.com> writes:

> The set of patches include the block-related updates
> of the record/replay icount feature:
>  - application of 'snapshot' option on the file layer instead of
>    the top one: command line and documentation fix
>  - implementation of bdrv_snapshot_goto for blkreplay driver
>  - start/stop fix in replay mode with attached block devices
>  - record/replay of bh oneshot events, used in the block layer

Can we come up with a reasonable smoke test to verify record/replay is
functional? AIUI we don't need a full OS but we do need a block device
to store the replay data. Could we use one of the simple system tests
like "memory" and run that through a record and replay cycle?

If we can defend the basic functionally in "make check" then breakage is
less likely to slip through and you'll have less bisecting to do.

>
> ---
>
> Pavel Dovgaluk (6):
>       block: implement bdrv_snapshot_goto for blkreplay
>       replay: disable default snapshot for record/replay
>       replay: update docs for record/replay with block devices
>       replay: don't drain/flush bdrv queue while RR is working
>       replay: finish record/replay before closing the disks
>       replay: add BH oneshot event for block layer
>
>
>  block/blkreplay.c        |    8 ++++++++
>  block/block-backend.c    |    9 ++++++---
>  block/io.c               |   32 ++++++++++++++++++++++++++++++--
>  block/iscsi.c            |    5 +++--
>  block/nfs.c              |    6 ++++--
>  block/null.c             |    4 +++-
>  block/nvme.c             |    6 ++++--
>  block/rbd.c              |    5 +++--
>  block/vxhs.c             |    5 +++--
>  cpus.c                   |    2 --
>  docs/replay.txt          |   12 +++++++++---
>  include/sysemu/replay.h  |    4 ++++
>  replay/replay-events.c   |   16 ++++++++++++++++
>  replay/replay-internal.h |    1 +
>  replay/replay.c          |    2 ++
>  stubs/Makefile.objs      |    1 +
>  stubs/replay-user.c      |    9 +++++++++
>  vl.c                     |   11 +++++++++--
>  18 files changed, 115 insertions(+), 23 deletions(-)
>  create mode 100644 stubs/replay-user.c


--
Alex Benn=C3=A9e

