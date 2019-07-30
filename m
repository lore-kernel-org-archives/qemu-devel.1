Return-Path: <SRS0=D7Ry=V3=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFE39C0650F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 16:03:32 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9B6E920693
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2019 16:03:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="z6sd3F34"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9B6E920693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:34332 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hsUb5-0006fI-RM
	for qemu-devel@archiver.kernel.org; Tue, 30 Jul 2019 12:03:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48794)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <peter.maydell@linaro.org>) id 1hsUXt-0003M2-Q4
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:00:14 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1hsUXs-0004gu-6e
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:00:13 -0400
Received: from mail-ot1-x344.google.com ([2607:f8b0:4864:20::344]:39109)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1hsUXs-0004fk-0Y
 for qemu-devel@nongnu.org; Tue, 30 Jul 2019 12:00:12 -0400
Received: by mail-ot1-x344.google.com with SMTP id r21so60807436otq.6
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2019 09:00:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gRMnRWoXl3oQLImyup6XsLxAex+GVKvx/B2knZ28Jhc=;
 b=z6sd3F34zydE1cFV3x3UfIphSpn8DJsRXn46/4otaE/9ah9MDLtNqgsKW/Lb7VUcOm
 Iz7JWoiZdG2Em0bHpRLqPv2VgYlW0H3rwJe9ymVL+wRqRlbx6RZxna+mLhSxbrB4+Y2m
 0HABAo9SS371bRZKzZzOcl4evPt3h9Ns8/DWz/SguWGqnqm0sHkwCQCCScCW3+E3xbjU
 Yi1HPBeyc7+3zbfKQHCJoNpztffOUnaxPpon9YW99r6WTgzbZ8u7GB+0L/yPLU7hwWaL
 t1ZFjfYIRmxdxdi72yWzecJWXBdVIzIcT/SrlDjn4vkMGra3YFNwU71zXsfpy7aBLiu1
 sZRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gRMnRWoXl3oQLImyup6XsLxAex+GVKvx/B2knZ28Jhc=;
 b=NuVlhVSYUQtj9wN9eoKtzmipiIs39khwmIC/XTWi5HTg7YL0CG1YkB77mbiAhBXvX3
 T6CxfiPJO9TC6xiZRWFv2cxkpk0t6POKfB4z/aN0rlyBTXzifhsqvAArTWe3KRG0lvUx
 KZdVgAlkRKhZrCjHe4TCZCx4wY/MykWAVopdJGhaLJSrVCrE7AWo6jU/tdPX8GZjjA2o
 gI/u5n6YT9OZRBBvIxzTZ9dAW/UXQfHm6LWUoTW/bJUponB4IHA0gsuyuf2d+Xg1UTNe
 3fFvmZYFBgAKYOTPK/skm02rc9bUcY4O5d69bXi1HxuGydfHwTvUBeKqUA2fKLLiLAvj
 BrPA==
X-Gm-Message-State: APjAAAV/0EfsCkMTQEdr5tJpljblNXzpvfFmtqI100I2Qahjo7UOyDBi
 1giNo/DsuJU3oC8eLeSbH6mdXwZugrQjsnHSzQ08aw==
X-Google-Smtp-Source: APXvYqxgzG3IMf8jWI44pOz9gLOkV4tpaeWIb99zifDcVUxlh3U2KUcfr4XTh2+iF/uH9LPgEGkEmst4yhlm1TAdxv8=
X-Received: by 2002:a9d:5f1a:: with SMTP id f26mr27871428oti.91.1564502410945; 
 Tue, 30 Jul 2019 09:00:10 -0700 (PDT)
MIME-Version: 1.0
References: <20190730125910.32060-1-mreitz@redhat.com>
In-Reply-To: <20190730125910.32060-1-mreitz@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 30 Jul 2019 17:00:00 +0100
Message-ID: <CAFEAcA8US1DPidO1XArsBB50qD=SQkDH4u7euiD97Vrb2wJN1g@mail.gmail.com>
To: Max Reitz <mreitz@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::344
Subject: Re: [Qemu-devel] [PULL 0/1] Block patches for 4.1.0-rc3
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

On Tue, 30 Jul 2019 at 13:59, Max Reitz <mreitz@redhat.com> wrote:
>
> The following changes since commit 6e9a6cbe7d56107f5e0d7711905dc19bb4d7e3f0:
>
>   Merge remote-tracking branch 'remotes/kevin/tags/for-upstream' into staging (2019-07-30 12:25:35 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/XanClic/qemu.git tags/pull-block-2019-07-30
>
> for you to fetch changes up to 1120407bdf70a2c4681464ae08bdb7c615566200:
>
>   nvme: Limit blkshift to 12 (for 4 kB blocks) (2019-07-30 14:49:24 +0200)
>
> ----------------------------------------------------------------
> Block patch for 4.1.0-rc3:
> - Fix CID 1403771 in block/nvme.c
>
> ----------------------------------------------------------------
> Max Reitz (1):
>   nvme: Limit blkshift to 12 (for 4 kB blocks)
>
>  block/nvme.c | 22 +++++++++++-----------
>  1 file changed, 11 insertions(+), 11 deletions(-)
>

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/4.1
for any user-visible changes.

-- PMM

