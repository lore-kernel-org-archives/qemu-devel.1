Return-Path: <SRS0=l02z=YT=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D279CA9EB9
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 17:27:10 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CA3E120863
	for <qemu-devel@archiver.kernel.org>; Sat, 26 Oct 2019 17:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CA3E120863
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41068 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iOPqG-0004p7-WF
	for qemu-devel@archiver.kernel.org; Sat, 26 Oct 2019 13:27:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:37075)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1iOPpW-00039d-HG
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 13:26:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1iOPpV-0000J7-GQ
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 13:26:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:36642)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1iOPpV-0000IW-Au
 for qemu-devel@nongnu.org; Sat, 26 Oct 2019 13:26:21 -0400
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 9E0484E93D
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 17:26:19 +0000 (UTC)
Received: by mail-ot1-f69.google.com with SMTP id x20so3030796otk.12
 for <qemu-devel@nongnu.org>; Sat, 26 Oct 2019 10:26:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=ZYJL07FkAn8dEkXKWoG4AoP9HP6SP88PVT8o8uBP6Lw=;
 b=mXXyevMQOvA/iNI1gwY1mexvLfOKwa5VC4q9QUctLgPl5VPEJJU0FGPrt/Bwulh4+9
 NKhlimKhNs5zHLICr4GDQpGquW3yHZN+O5lHFVYZGbU4WB5rYHl3+Lwr58kI9kikKRiI
 HOIbRDhyuAJBv6pXQBQ6Wq4eQKXN60NfcWPMi+mh5MCrRbQM9RSG0mpHs0QJa9ROJQdX
 clLQXeVKLg1vudHl1rd5HwjsS45C/JdKR0Qobw5PujnoFx38IdpaueE4n1tvAUSXrgpW
 A44foOsYskCxCPR05HACigabIaC52aXsdthxeTAvi/OBCLC1P4tBOM18SP1xKNz19eth
 Ec0g==
X-Gm-Message-State: APjAAAXLg/8Ghzp4UymXL7HEv9VntnYiuYjLOL2600lWz4juJAT2WG1u
 tNlr1eE4+0dPp8vOIFWNTmtE8W6FEfQhoKVL/PGTIlKaAa2+feaHhDScFL76NrSsUmfva4WRSQK
 VnRYN88n0l5Dd1ze0OS334rw5cX6NLH0=
X-Received: by 2002:a05:6808:341:: with SMTP id
 j1mr7629221oie.106.1572110779039; 
 Sat, 26 Oct 2019 10:26:19 -0700 (PDT)
X-Google-Smtp-Source: APXvYqzKqMzoGvpBYiKbrWh6TNffZihq8OxuQ1qf+kol+ryDz/TxRYi0CHRiHmMVwKqsNyWb/c7aai5eHcJu2+ChjEU=
X-Received: by 2002:a05:6808:341:: with SMTP id
 j1mr7629203oie.106.1572110778717; 
 Sat, 26 Oct 2019 10:26:18 -0700 (PDT)
MIME-Version: 1.0
References: <20191025095849.25283-1-mreitz@redhat.com>
 <20191025095849.25283-3-mreitz@redhat.com>
In-Reply-To: <20191025095849.25283-3-mreitz@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Sat, 26 Oct 2019 20:26:02 +0300
Message-ID: <CAMRbyyuD1dmMg62tOkKRzOVpee8KNuWp-CGdZq3ZYJ2=MopN=w@mail.gmail.com>
Subject: Re: [RFC 2/3] block/file-posix: Detect XFS with CONFIG_FALLOCATE
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Alberto Garcia <berto@igalia.com>, qemu-block <qemu-block@nongnu.org>,
 QEMU Developers <qemu-devel@nongnu.org>,
 Anton Nefedov <anton.nefedov@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Krutika Dhananjay <kdhananj@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Fri, Oct 25, 2019 at 1:22 PM Max Reitz <mreitz@redhat.com> wrote:
>
> We will need this for the next patch.
>
> Signed-off-by: Max Reitz <mreitz@redhat.com>
> ---
>  block/file-posix.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 695fcf740d..5cd54c8bff 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -149,7 +149,7 @@ typedef struct BDRVRawState {
>      int perm_change_flags;
>      BDRVReopenState *reopen_state;
>
> -#ifdef CONFIG_XFS
> +#if defined(CONFIG_XFS) || defined(CONFIG_FALLOCATE)
>      bool is_xfs:1;
>  #endif
>      bool has_discard:1;
> @@ -667,7 +667,7 @@ static int raw_open_common(BlockDriverState *bs, QDict *options,
>      }
>  #endif
>
> -#ifdef CONFIG_XFS
> +#if defined(CONFIG_XFS) || defined(CONFIG_FALLOCATE)
>      if (platform_test_xfs_fd(s->fd)) {
>          s->is_xfs = true;

What about remote xfs filesystem, e.g. glusterfs over xfs mounted using fuse?
(how oVirt uses glusterfs)

The buggy behavior with concurrent fallocate/pwrite can affect this, and
platform_test_xfs_fd() will probably fail to detect xfs.

Nir

>      }
> --
> 2.21.0
>
>

