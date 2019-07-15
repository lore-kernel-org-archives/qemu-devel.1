Return-Path: <SRS0=IjNW=VM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9137CC76195
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:49:22 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BE06212F5
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jul 2019 14:49:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BE06212F5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39682 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hn2I4-0004vG-8l
	for qemu-devel@archiver.kernel.org; Mon, 15 Jul 2019 10:49:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:39619)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hn2Hq-0004Sw-9H
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:49:07 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hn2Hp-0007zg-0k
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:49:06 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:42986)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hn2Ho-0007ym-QI
 for qemu-devel@nongnu.org; Mon, 15 Jul 2019 10:49:04 -0400
Received: by mail-wr1-f65.google.com with SMTP id x1so2418724wrr.9
 for <qemu-devel@nongnu.org>; Mon, 15 Jul 2019 07:49:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=mUjDpDF41N9BmAcyyi0NYzcOIzxt8hPObUj2BTGDXtU=;
 b=OQpvGnHo/qnxjzJ4xr8ZsmHtQtc2XP4okfvl7CkpR7dqljjPa/AdgcXfDU1iuyhjBF
 4clpxpAniSUn5Rc91ft1wufKe5TRy2cFNJRcYmPZl/t4yoe0xdSI3A8qK6lOWQdiu5up
 5w+5UPBRVerG915ycC9buR8TtwjBZXbx/Pq/l5V3rt29vjvt+LfMajC251Ud8mTeOEuB
 7VoSgPdBKTS7GlgzevmIcxVerPL26+jXoGcBF7eCcvyMAfPu9mU+rGutkVPKJKcdOUsA
 fwd7CZpfXd7gu9+wxulLT25FCN5XDs+BLI/7jf9N/7Gp9/v00BnPZjCgfQmcQPjrWVMm
 YJEQ==
X-Gm-Message-State: APjAAAX48bUGwD5uaQUWj2qaP4kkahQDC1+YVFvT8R9UTQN6T1FWBsvn
 wLuYOZBKyqCamCPXNk3UTa2w9Q==
X-Google-Smtp-Source: APXvYqwTptChLlkfpeRNMwJdzAVbpGBO2nLhb5dFjK5X4Hkor6IJC+BwbRAuoCzCIK98lYFeLD+q7A==
X-Received: by 2002:adf:f088:: with SMTP id n8mr29353290wro.58.1563202143173; 
 Mon, 15 Jul 2019 07:49:03 -0700 (PDT)
Received: from steredhat (host122-201-dynamic.13-79-r.retail.telecomitalia.it.
 [79.13.201.122])
 by smtp.gmail.com with ESMTPSA id x8sm14330668wmc.5.2019.07.15.07.49.02
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 15 Jul 2019 07:49:02 -0700 (PDT)
Date: Mon, 15 Jul 2019 16:49:00 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190715144900.nbdlzeoga2qklgqq@steredhat>
References: <20190715104508.7568-1-mreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190715104508.7568-1-mreitz@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] [PATCH for-4.1? 0/4] block: Fix three
 .bdrv_has_zero_init()s
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
Cc: Kevin Wolf <kwolf@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 Jeff Cody <codyprime@gmail.com>, qemu-devel@nongnu.org, qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Mon, Jul 15, 2019 at 12:45:04PM +0200, Max Reitz wrote:
> Hi,
> 
> .bdrv_has_zero_init() must not return 1 if the (newly created[1]) image
> may not return zeroes when read.
> 
> [1] This is guaranteed by the caller.
> 
> If the image is preallocated, this generally depends on the protocol
> layer, because the format layer will just allocate the necessary
> metadata, make it point to data blocks and leave their initialization to
> the protocol layer.  For example, qcow2:
> 
> - leaves the blocks uninitialized with preallocation=metadata,
> - and passes preallocation=falloc and =full on to the protocol node.
> 
> In either case, the data then stored in these blocks fully depends on
> the protocol level.
> 
> Therefore, format drivers have to pass through .bdrv_has_zero_init() to
> the data storage node when dealing with preallocated images.
> 
> Protocol drivers OTOH have to be accurate in what they return from
> .bdrv_has_zero_init().  They are free to return 0 even for preallocated
> images.
> 
> 
> So let’s look at the existing .bdrv_has_zero_init() implementations:
> 
> - file-posix: Always returns 1 (for regular files).  Correct, because it
>   makes sure the image always reads as 0, preallocated or not.
> 
> - file-win32: Same.  (But doesn’t even support preallocation.)
> 
> - gluster: Always returns 0.  Safe.
> 
> - nfs: Only returns 1 for regular files, similarly to file-posix.  Seems
>   reasonable.
> 
> - parallels: Always returns 1.  This format does not support
>   preallocation, but apparently ensures that it always writes out data
>   that reads back as 0 (where necessary), because if the protocol node
>   does not have_zero_init, it explicitly writes zeroes to it instead of
>   just truncating it.
>   So this driver seems OK, too.
> 
> - qcow2: Always returns 1.  This is wrong for preallocated images, and
>   really wrong for preallocated encrypted images.  Addressed by patch 1.
> 
> - qcow: Always returns 1.  Has no preallocation support, so that seems
>   OK.
> 
> - qed: Same as qcow.
> 
> - raw: Always forwards the value from the filtered node.  OK.
> 
> - rbd: Always returns 1.  This is a protocol driver, so I’ll just trust
>   it knows what it’s doing.
> 
> - sheepdog: Always returns 1.  From the fact that its preallocation code
>   simply reads the image and writes it back, this seems correct to me.
> 
> - ssh: Same as nfs.
> 
> - vdi: Always returns 1.  It does support preallocation=metadata, in
>   which case this may be wrong.  Addressed by patch 2.
> 
> - vhdx: Similar to vdi, except it doesn’t support @preallocation, but
>   has its own option “subformat=fixed”.  Addressed by patch 3.
> 
> - vmdk: Hey, this one is already exactly what we want.  If any of the
>   extents is flat, it goes to the respective protocol node, and if that
>   does not have_zero_init, it returns 0.  Great.
>   (Added in commit da7a50f9385.)
> 
> - vpc: Hey, this one, too.  With subformat=fixed, it returns what the
>   protocol node has to say about has_zero_init.
>   (Added in commit 72c6cc94daa.)
> 
> So that leaves three cases to fix, which are the first three patches in
> this series.  The final patch adds a test case for qcow2.  (It’s
> difficult to test the other drivers, because that would require a
> protocol driver with image creation support and has_zero_init=0, which
> is not so easily available.)

Acked-by: Stefano Garzarella <sgarzare@redhat.com>
Tested-by: Stefano Garzarella <sgarzare@redhat.com>

Thanks,
Stefano

> 
> 
> Max Reitz (4):
>   qcow2: Fix .bdrv_has_zero_init()
>   vdi: Fix .bdrv_has_zero_init()
>   vhdx: Fix .bdrv_has_zero_init()
>   iotests: Convert to preallocated encrypted qcow2
> 
>  block/qcow2.c              | 90 +++++++++++++++++++++++++++++++++++++-
>  block/vdi.c                | 13 +++++-
>  block/vhdx.c               | 21 ++++++++-
>  tests/qemu-iotests/188     | 20 ++++++++-
>  tests/qemu-iotests/188.out |  4 ++
>  5 files changed, 144 insertions(+), 4 deletions(-)
> 

