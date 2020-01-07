Return-Path: <SRS0=ZO09=24=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0048FC33C8C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:09:42 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C26F42087F
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Jan 2020 17:09:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fQR2t5gH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C26F42087F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:53570 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iosMO-0007w3-D4
	for qemu-devel@archiver.kernel.org; Tue, 07 Jan 2020 12:09:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:47689)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1iosL2-00062x-PT
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:08:17 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1iosL1-00086w-K2
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:08:16 -0500
Received: from mail-ot1-x332.google.com ([2607:f8b0:4864:20::332]:35846)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1iosL1-00086M-DA
 for qemu-devel@nongnu.org; Tue, 07 Jan 2020 12:08:15 -0500
Received: by mail-ot1-x332.google.com with SMTP id 19so653206otz.3
 for <qemu-devel@nongnu.org>; Tue, 07 Jan 2020 09:08:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=JxkB8/7jMhi+HLHG7mnECaKInwX4cuU9w/wehdGsoE8=;
 b=fQR2t5gHcEVdzfzMxZt75c76BGakJeBZDcGztfBq3J1qp38j7JxZOAdgQLuYQEZAJf
 WP8fQbEM1X28fA3y+UCzi19N+OynYEGEOyqd9zCx+ZwZ9JUKNhwLEdgqS2J+Afk9b8s7
 bbSHvSZzy2ONpijVtBx3KLN49xmytw91kt1Yy1cr1n+TyFj89uBRu65EAHJ9GJWZyLqv
 tSYrJ4xsWkQHT+vtsGk4Km7wIw3EtjVMf1vlQWt+cFyJ+IYCc9PaARENwo2AXLZ62Wrg
 aeWbkVPOLknK1nLi9w7NTeLfdPlMD3g5TIeHeXpDnvkTV6X9EjWiZWSmlC6FBssAvcKM
 ATaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=JxkB8/7jMhi+HLHG7mnECaKInwX4cuU9w/wehdGsoE8=;
 b=cMDqsrwMM5U86fvdLgymm+qFpf1MnZvXYDgkGnmiIugG/oA08LrUGJ8BE8f4xc0tB4
 RPnNnq5ZrKNa5d5I2zOhVlIFbk4qGQClLHacRv8JX/Sh0knNYoRjUC8gBdel9ozgYT5R
 YANW6G4VgZ3THnaV/21OgwDqqhulgHXAvxjVHvIvERcbZp0UArCZNTHdsqlo3AhihAX+
 TAnt0VTF5v1izwDKfj1ifDjzDQhzbvalbMDyYiX3+XWRagQMcuuOfVPjruD3YBfASZZc
 IKy/nnJPSCZdlAerz9mjfz6SAGlGzY6SOokkMXAjX2CpSN8iLvCct2ckSO8gwdiO0idk
 2yLA==
X-Gm-Message-State: APjAAAVWUgv/QJbKi3zh/iYSXb6epfqE9eHJsBYqyzQdYTFoCPzeETvs
 +xRpJo9j2Kk1aATelA/SbTYNjCckI61GfH6/56lZh/RWAL8=
X-Google-Smtp-Source: APXvYqwEe+4b7lUexElGiXAdCpN2gOXqnmpI7I8uwYQjIdVCCxPjUI2IOLlofjECosMXHZZjD6u/pV2jWD4SIIvEYAU=
X-Received: by 2002:a05:6830:13d3:: with SMTP id
 e19mr754357otq.135.1578416894478; 
 Tue, 07 Jan 2020 09:08:14 -0800 (PST)
MIME-Version: 1.0
References: <20200107073451.298261-1-mst@redhat.com>
In-Reply-To: <20200107073451.298261-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 7 Jan 2020 17:08:03 +0000
Message-ID: <CAFEAcA9a9_WbLSkOcAoubHj60k5jh-t-R0jF5RNPYgqr1xabcA@mail.gmail.com>
Subject: Re: [PULL v2 00/32] virtio, pci, pc: fixes, features
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::332
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

On Tue, 7 Jan 2020 at 07:35, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> The following changes since commit f0dcfddecee8b860e015bb07d67cfcbdfbfd51d9:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-01-03 17:18:08 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 56fc1e6ac6bde95bc0369d358587f2234d4dddad:
>
>   intel_iommu: add present bit check for pasid table entries (2020-01-06 12:04:51 -0500)
>
> ----------------------------------------------------------------
> virtio, pci, pc: fixes, features
>
> Bugfixes all over the place.
> HMAT support.
> New flags for vhost-user-blk utility.
> Auto-tuning of seg max for virtio storage.
>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/5.0
for any user-visible changes.

-- PMM

