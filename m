Return-Path: <SRS0=kvq2=23=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA996C33C8C
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:49:14 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 706AB20731
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jan 2020 16:49:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="C3bY1Ha2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 706AB20731
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:54862 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1ioVZ3-0004yk-H5
	for qemu-devel@archiver.kernel.org; Mon, 06 Jan 2020 11:49:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:55678)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <peter.maydell@linaro.org>) id 1ioVYP-0004YA-GG
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:48:34 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <peter.maydell@linaro.org>) id 1ioVYO-0006zc-7k
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:48:33 -0500
Received: from mail-ot1-x32a.google.com ([2607:f8b0:4864:20::32a]:34553)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <peter.maydell@linaro.org>)
 id 1ioVYO-0006yZ-2C
 for qemu-devel@nongnu.org; Mon, 06 Jan 2020 11:48:32 -0500
Received: by mail-ot1-x32a.google.com with SMTP id a15so72426489otf.1
 for <qemu-devel@nongnu.org>; Mon, 06 Jan 2020 08:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=dd3eFaX38WKRkYtWozo41hwFNGeCQSTQPk1N/ZxPPNM=;
 b=C3bY1Ha2/6RTC7ZT9MXLuj5Dm/HXWMealmubJsDjP52r1IcOr8uvZoaxM7FeMxmeqU
 XkQ84DH0YUogDE5RcJPhhOdlI/aNQx42nyArsqsZlvY9GbysuwV6CH4sK8k4u8gkAk6a
 YcnDAlfOvJjMx7pnpfVPSXYnXz3Db5rrfQqoc+BXnuoBznaLQOB0y6Kkz4VOMmnFxO7w
 yom0APHJy2kOIja9GV453L21/JU0IgMO8+JGSq8usJzJAvkvRouGyUd7Nzw23fJ5g0el
 fpBOM3DucOAq9QHCu8SyTrJATYz7O5qV2Z6MTg80qebpFOrmpp296nCANNbwRgsQXx1M
 2yIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=dd3eFaX38WKRkYtWozo41hwFNGeCQSTQPk1N/ZxPPNM=;
 b=ojkFnpX5KoglMUJuqjeYpwAz/uu2Fkwx+Le+l6u+nJzo7PaX3K6MwzF+o47+eUNSxq
 midUdhWFlGpTmRpR9NAm3dUHWlcN2heq8Rx3TmNtAyrnxukPCsI4kmZx7OBt0/140UPV
 h6z/0lwmuLhiewyFYpE0MEz2eDUHI52ZyWHK3jQ3FYHD/6KMrKhBQ6U1h03Dwu3nPBPZ
 UPw/co/4SswZBbfDz9cCFopi708WvmOsA6oTw/DBhykoQCEzEz2mjwxK6b3oQsY7wFiL
 EP75OjJpOYIaVAbiRs3xcfarZ7xfft3gbx15mb2EbTN2+D1EPORDjX0RpB2ywy7VSu2Z
 FMWg==
X-Gm-Message-State: APjAAAVumhT4uQpWDbQ2U5JwHzBDMb5MCI9WcwoW31o/xT/EuWa7dPaD
 t2S+D3E0pdHiexQGjtb+N7hg9cXRft3X5Iv60UL7zQ==
X-Google-Smtp-Source: APXvYqyRe0zQ6wvjlXamcE9hbxJlw31GfceQvzo4guo+mGMjVMZqPM0qU22+4ygIJFNThvanArLoJSuYBCN3w6dQzr0=
X-Received: by 2002:a05:6830:4a4:: with SMTP id
 l4mr117653944otd.91.1578329310806; 
 Mon, 06 Jan 2020 08:48:30 -0800 (PST)
MIME-Version: 1.0
References: <20200105125622.27231-1-mst@redhat.com>
In-Reply-To: <20200105125622.27231-1-mst@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 6 Jan 2020 16:48:19 +0000
Message-ID: <CAFEAcA8u56NW2634q7_6BrgVOUxcNt037EQ_dNDg0RdqgUWUMQ@mail.gmail.com>
Subject: Re: [PULL v3 00/32] virtio, pci, pc: fixes, features
To: "Michael S. Tsirkin" <mst@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: Genre and OS details not
 recognized.
X-Received-From: 2607:f8b0:4864:20::32a
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

On Sun, 5 Jan 2020 at 12:57, Michael S. Tsirkin <mst@redhat.com> wrote:
>
> Changes from v2:
> - rebased on master
> - a couple more bugfixes
>
> The following changes since commit f0dcfddecee8b860e015bb07d67cfcbdfbfd51d9:
>
>   Merge remote-tracking branch 'remotes/stefanha/tags/block-pull-request' into staging (2020-01-03 17:18:08 +0000)
>
> are available in the Git repository at:
>
>   git://git.kernel.org/pub/scm/virt/kvm/mst/qemu.git tags/for_upstream
>
> for you to fetch changes up to 93ef96f3258f489f7bff28ca7b9e0dc74de2a75b:
>
>   intel_iommu: add present bit check for pasid table entries (2020-01-05 07:41:10 -0500)
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

Build failure for OSX:

/Users/pm215/src/qemu-for-merges/hw/scsi/virtio-scsi.c:904:35: error:
format specifies type 'unsigned short' but the argument has type
'uint32_t' (aka 'unsigned int') [-Werror,-Wformat]
                   "must be > 2", s->conf.virtqueue_size);
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~~~~~~~~~~~~~~~~~~~~
/Users/pm215/src/qemu-for-merges/include/qapi/error.h:166:35: note:
expanded from macro 'error_setg'
                        (fmt), ## __VA_ARGS__)
                                  ^~~~~~~~~~~
1 error generated.

(Everything else passed OK.)

thanks
-- PMM

