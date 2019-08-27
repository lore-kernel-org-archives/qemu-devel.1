Return-Path: <SRS0=HeXf=WX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 09215C3A5A3
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:36:21 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 90B26206BF
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Aug 2019 15:36:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 90B26206BF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:52838 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i2dW7-0007Ts-Ep
	for qemu-devel@archiver.kernel.org; Tue, 27 Aug 2019 11:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:48696)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <nsoffer@redhat.com>) id 1i2d32-0001b4-Od
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:06:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <nsoffer@redhat.com>) id 1i2d31-0007zA-0e
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:06:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:53276)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <nsoffer@redhat.com>) id 1i2d30-0007yR-Ne
 for qemu-devel@nongnu.org; Tue, 27 Aug 2019 11:06:14 -0400
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 4FCB38830F
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 15:06:13 +0000 (UTC)
Received: by mail-ot1-f72.google.com with SMTP id c25so12031381otp.15
 for <qemu-devel@nongnu.org>; Tue, 27 Aug 2019 08:06:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=1oF5hqBWB/BlGTMhdyOGW4VxX7aY/MGz3/mARbGBTF8=;
 b=Dh7a/hxWaJHybK9HCl4fT9G9XTn3pEvTKfaoIdTH+zsDtkQMY9DlnzjfGwToLq3n9b
 VMuz9Zm7TzkiWJlPXP79ZRjaeLXKHeKBQlvHLxGVWq4WY26p7KlLOyopB1YabsdQzLSo
 6ilvZaieBDZVNHvjx8o19zTFdTta3/POu03TLf+KB6sE2X79MAtfM+MGE11QYDJ2oXrj
 /HZS6jFLUsWt1KEZbCW4lTYmZxJEYtKA1ZbUjMwOT/Cc9HodcZ4j4YLhEqMxqo9HWHIk
 cxYgkXP7lbMPAdnZgSkg75HHb4RNywgIe25XghBO4r2M1jv3kRaGt7Sw2mIpjPlyJCfp
 0h/Q==
X-Gm-Message-State: APjAAAUQQKPpKCIBZ0snKFtmUYdlFBbjUqKPH7n0h4hfCzT6cxVuCmvP
 cCnX0yOQPL7MzgGgkwu0lzbhN6Ckhk7cJbHGDPxFPnv6JCZEmiyBQaVlXfgOkhrfelXOYDOG1xB
 kNKtxnOQasuiPXbqaFCcKv5/2gCN42JY=
X-Received: by 2002:aca:b20b:: with SMTP id b11mr16604719oif.16.1566918372716; 
 Tue, 27 Aug 2019 08:06:12 -0700 (PDT)
X-Google-Smtp-Source: APXvYqyIQ6g/FePSvwFc3kkvgta964mVCymxepQHfH7e10I3DdEskCMvd9XlTTWO/iWlxCzi8stWhA/ixLsCUMRfVVQ=
X-Received: by 2002:aca:b20b:: with SMTP id b11mr16604693oif.16.1566918372454; 
 Tue, 27 Aug 2019 08:06:12 -0700 (PDT)
MIME-Version: 1.0
References: <20190827010528.8818-1-nsoffer@redhat.com>
In-Reply-To: <20190827010528.8818-1-nsoffer@redhat.com>
From: Nir Soffer <nsoffer@redhat.com>
Date: Tue, 27 Aug 2019 18:06:00 +0300
Message-ID: <CAMRbyysA=MxE2cADm_AcNsPdiPR2+Q6UXvDr6tS9iXb=-dK3_A@mail.gmail.com>
To: Nir Soffer <nirsof@gmail.com>
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Content-Type: text/plain; charset="UTF-8"
X-Content-Filtered-By: Mailman/MimeDel 2.1.23
Subject: Re: [Qemu-devel] [PATCH v3 0/2] Optimize alignment probing
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
 qemu-block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Adding Eric

On Tue, Aug 27, 2019 at 4:05 AM Nir Soffer <nirsof@gmail.com> wrote:

> When probing unallocated area on remote XFS filesystem we cannot detect
> request
> alignment and we fallback to safe value which may not be optimal. Avoid
> this
> fallback by always allocating the first block when creating a new image or
> resizing empty image.
>
> Tested with all formats:
>
>     for fmt in raw bochs cloop parallels qcow qcow2 qed vdi vpc vhdx vmdk
> luks dmg; do
>         ./check -$fmt
>     done
>
> Changes in v3:
> - Allocating first block works now when 512 <= size < 4096, storage sector
> size
>   is 512 bytes, and using block_resize with O_DIRECT (Max)
> - Fix return value on errors if qemu_vfree() modified errno (Eric)
> - Improve comment about using allocate_first_block in FALLOC mode (Max)
> - Remove unneeded $(()) in _filter_block (Max)
> - Add _default_cache_mode and _supported_cache_mode to new test (Max)
> - Fix disk size in vmdk tests
>
> v2 was here:
> https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg01265.html
>
> Changes in v2:
> - Support file descriptor opened with O_DIRECT (e.g. in block_resize) (Max)
> - Remove unneeded change in 160 (Max)
> - Fix block filter in 175 on filesystem allocating extra blocks (Max)
> - Comment why we ignore errors in allocte_first_block() (Max)
> - Comment why allocate_first_block() is needed in FALLOC mode (Max)
> - Clarify commit message about user visible changes (Maxim)
> - Fix 178.out.qcow2
> - Fix 150.out with -qcow2 by splitting to 150.out.{raw,qcow2}
> - Add test for allocate_first_block() with block_resize (Max)
> - Drop provisioning tests results since I ran them only once
>
> v1 was here:
> https://lists.nongnu.org/archive/html/qemu-block/2019-08/msg00821.html
>
> Nir Soffer (2):
>   block: posix: Always allocate the first block
>   iotests: Test allocate_first_block() with O_DIRECT
>
>  block/file-posix.c                            | 51 +++++++++++++++++++
>  tests/qemu-iotests/059.out                    |  2 +-
>  tests/qemu-iotests/{150.out => 150.out.qcow2} |  0
>  tests/qemu-iotests/150.out.raw                | 12 +++++
>  tests/qemu-iotests/175                        | 47 ++++++++++++++---
>  tests/qemu-iotests/175.out                    | 16 ++++--
>  tests/qemu-iotests/178.out.qcow2              |  4 +-
>  tests/qemu-iotests/221.out                    | 12 +++--
>  tests/qemu-iotests/253.out                    | 12 +++--
>  9 files changed, 135 insertions(+), 21 deletions(-)
>  rename tests/qemu-iotests/{150.out => 150.out.qcow2} (100%)
>  create mode 100644 tests/qemu-iotests/150.out.raw
>
> --
> 2.20.1
>
>
