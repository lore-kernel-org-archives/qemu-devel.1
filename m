Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51525C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:44:03 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9EE0247C9
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 15:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LrHvKXcM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9EE0247C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41554 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXncH-0003cO-In
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 11:44:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50588)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kXnZ9-0007wP-Qn; Wed, 28 Oct 2020 11:40:47 -0400
Received: from mail-oo1-xc41.google.com ([2607:f8b0:4864:20::c41]:33110)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <raphael.s.norwitz@gmail.com>)
 id 1kXnZ7-000198-WA; Wed, 28 Oct 2020 11:40:47 -0400
Received: by mail-oo1-xc41.google.com with SMTP id u5so1270726oot.0;
 Wed, 28 Oct 2020 08:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=xLxievp7hffuJOG/AbosdmuZHIAKJRbI1YEXMb4NUmA=;
 b=LrHvKXcMIqIxsZEhCj7jWSHIPkca9uNazW4Hnk7CGNI7tcznjA1k7pu95WTgNmax6r
 Y00tOKrxi8J24VJybhoPoyG7V7bnQCSMy++a0CpGXHwr3XrkxjwQsahnHAyEFP3lCfjb
 JTYFotXEhP4RLZt2tBfC758F2DqbKt20X60U96zXliEud429aXExuX2+xC4G2nIkgh+5
 ZFAOP8HBzcny8i9iyPaNbsR6jH80t32a6/cbTujmUKPttD4PVDBfrXoEpOB8wYhUX3Tr
 eQvHgCYuYd6SnoxwO1cpcJo8FDymlh645W5YgWoNPUBoM1LYO19r1xdRyYm7WiuRkoHI
 JjpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=xLxievp7hffuJOG/AbosdmuZHIAKJRbI1YEXMb4NUmA=;
 b=a4RxMd5m2nAeeDSy0kqHz9Id9YOdVm7bL75nt5MLJ3wPIt5F1gX8kIO2njRBmxXGxl
 0aKlScZXOcwpulw01GzM7CBp14+PvLvwIL4+gUJvZedkl/8pACqMin8xPJAMe/z33gPi
 IMK2mLKWlE61M+gikXRNlo5wImn241xa6JMwUzuu8oZT7RAKItsK9GzfSRU+xrpoJQu5
 tYjqgkspVTF3VksGdrhb+QFprN9inUkUJKbaEZY44GpWIbryEdtdH2NW2dLzS7iRCMiE
 kDvEtIdp717+Y+pb4U9AsnIqo6KkSraLKrt3JT6ZhU/OP6WRdNwGKzn+95z6hDin4o4b
 FvbQ==
X-Gm-Message-State: AOAM531l0wfSS3oKMLpQGC1aynVGYFaKKjQoiXA4dqAFCP7iBF3Cx3h9
 a35Lz62nyw2xxw40qRBFH8kV5+u/TzboYZRAvYY=
X-Google-Smtp-Source: ABdhPJxEO/jRz9J6fA/4orU+fhlX25q3D6ejVdGqeEpin7H81CWLZbmJLkSdY3y2sCYen7ohr6WL/OVDXGhj/fztWd4=
X-Received: by 2002:a4a:b601:: with SMTP id z1mr6205975oon.83.1603899643907;
 Wed, 28 Oct 2020 08:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <5F997B84.9040900@huawei.com>
In-Reply-To: <5F997B84.9040900@huawei.com>
From: Raphael Norwitz <raphael.s.norwitz@gmail.com>
Date: Wed, 28 Oct 2020 11:40:33 -0400
Message-ID: <CAFubqFv0m9BeAvmCCkv9iEMvUXfHP2z+HJ8ffkOG4KONig2LHQ@mail.gmail.com>
Subject: Re: [PATCH] vhost-user-blk: Fix two resource leaks
To: AlexChen <alex.chen@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::c41;
 envelope-from=raphael.s.norwitz@gmail.com; helo=mail-oo1-xc41.google.com
X-detected-operating-system: by eggs.gnu.org: No matching host in p0f cache.
 That's all we know.
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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
Cc: qemu-trivial@nongnu.org, QEMU <qemu-devel@nongnu.org>,
 Raphael Norwitz <raphael.norwitz@nutanix.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

The change looks good but I'm not sure I'd call it resource leak in
either case since the failure case kills vhost-user-blk/scsi. In the
commit message maybe rather say "vhost-user-blk/scsi: fix broken error
handling for socket call"?

On Wed, Oct 28, 2020 at 10:10 AM AlexChen <alex.chen@huawei.com> wrote:
>
> When socket() fails, it returns -1, 0 is the normal return value and should not return
>
> Reported-by: Euler Robot <euler.robot@huawei.com>
> Signed-off-by: AlexChen <alex.chen@huawei.com>
> ---
>  contrib/vhost-user-blk/vhost-user-blk.c   | 2 +-
>  contrib/vhost-user-scsi/vhost-user-scsi.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/contrib/vhost-user-blk/vhost-user-blk.c b/contrib/vhost-user-blk/vhost-user-blk.c
> index 25eccd02b5..40a2dfc544 100644
> --- a/contrib/vhost-user-blk/vhost-user-blk.c
> +++ b/contrib/vhost-user-blk/vhost-user-blk.c
> @@ -474,7 +474,7 @@ static int unix_sock_new(char *unix_fn)
>      assert(unix_fn);
>
>      sock = socket(AF_UNIX, SOCK_STREAM, 0);
> -    if (sock <= 0) {
> +    if (sock < 0) {
>          perror("socket");
>          return -1;
>      }
> diff --git a/contrib/vhost-user-scsi/vhost-user-scsi.c b/contrib/vhost-user-scsi/vhost-user-scsi.c
> index 3c912384e9..0f9ba4b2a2 100644
> --- a/contrib/vhost-user-scsi/vhost-user-scsi.c
> +++ b/contrib/vhost-user-scsi/vhost-user-scsi.c
> @@ -320,7 +320,7 @@ static int unix_sock_new(char *unix_fn)
>      assert(unix_fn);
>
>      sock = socket(AF_UNIX, SOCK_STREAM, 0);
> -    if (sock <= 0) {
> +    if (sock < 0) {
>          perror("socket");
>          return -1;
>      }
> --
> 2.19.1
>

