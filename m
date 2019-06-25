Return-Path: <SRS0=PhvJ=UY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44101C48BD4
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:37:04 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 200A92080C
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Jun 2019 15:37:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 200A92080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33170 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hfnVH-0001EC-8U
	for qemu-devel@archiver.kernel.org; Tue, 25 Jun 2019 11:37:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:60405)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <sgarzare@redhat.com>) id 1hfnNc-0004mV-Hm
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:29:09 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <sgarzare@redhat.com>) id 1hfnNa-0000bB-Vt
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:29:08 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36749)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hfnNW-0000Po-5i
 for qemu-devel@nongnu.org; Tue, 25 Jun 2019 11:29:03 -0400
Received: by mail-wm1-f65.google.com with SMTP id u8so3423659wmm.1
 for <qemu-devel@nongnu.org>; Tue, 25 Jun 2019 08:28:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to:user-agent;
 bh=maX/9ZztO3o0ap2K1rEyN53t8p8liQm0W+YzEPOCuR4=;
 b=IA0eaX2zyYxHYEHoAYVzHGAmy+OXByEbbgPWz4UE7XxsLwTa78MQ97qAmFSk8YiuMH
 g/LbqRW94ORxRc2q6ik3FW9s3oFPY/8omgEwlsCvESILhWvCLWR357s6DMcHpd7P0eNB
 yie+GY2J9VrCcu52z4himh5Ohi2E2043oKOPQUM5Sq7DJ/gYr4/D6xke05WoJZAGM0n9
 NTsBeN9jai8mg4M6tHpOHxJST3pz3N85uG0jjmIvD6w8iDk1AqccCZqLcKwGy3ifqbFn
 Md8jeGPeGoPMSzNUThrmr+xutMjUB7M1cCOmm8vkRaotdhixegxpuwwycLmPqpuW5/bb
 rxAA==
X-Gm-Message-State: APjAAAV1KdOkMNHHOqlePFnDymwEXJI5PyTYlVrxVr4rYm5oITsiYDrQ
 wd2KMgLn3/CM3UmwPiRGt8Mtng==
X-Google-Smtp-Source: APXvYqwD+C8CpdGTf0vCXVjHgzKxV5G803HHIeULW8hWC/syH1G7ZLjpdWIZsn54iBqsGyfFyFoQIg==
X-Received: by 2002:a05:600c:228b:: with SMTP id
 11mr20662968wmf.26.1561476535681; 
 Tue, 25 Jun 2019 08:28:55 -0700 (PDT)
Received: from steredhat (host21-207-dynamic.52-79-r.retail.telecomitalia.it.
 [79.52.207.21])
 by smtp.gmail.com with ESMTPSA id x3sm15155729wrp.78.2019.06.25.08.28.54
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Tue, 25 Jun 2019 08:28:55 -0700 (PDT)
Date: Tue, 25 Jun 2019 17:28:52 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Max Reitz <mreitz@redhat.com>
Message-ID: <20190625152852.6xbswgit7f5gszq5@steredhat>
References: <20190509145927.293369-1-sgarzare@redhat.com>
 <7a3e37bd-dd24-a97f-5354-7793df44c53e@redhat.com>
 <20190625144710.xvlwcqcbp5bipbku@steredhat>
 <b02a2b04-4955-c341-8639-b03d3a125927@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b02a2b04-4955-c341-8639-b03d3a125927@redhat.com>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.85.128.65
Subject: Re: [Qemu-devel] [PATCH v3] block/rbd: increase dynamically the
 image size
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
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
 Jason Dillaman <jdillama@redhat.com>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Jun 25, 2019 at 04:57:53PM +0200, Max Reitz wrote:
> On 25.06.19 16:47, Stefano Garzarella wrote:
> > On Tue, Jun 25, 2019 at 04:02:04PM +0200, Max Reitz wrote:
> >> On 09.05.19 16:59, Stefano Garzarella wrote:
> >>> RBD APIs don't allow us to write more than the size set with
> >>> rbd_create() or rbd_resize().
> >>> In order to support growing images (eg. qcow2), we resize the
> >>> image before write operations that exceed the current size.
> >>>
> >>> Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >>> ---
> >>> v3:
> >>>   - add 'image_size' field in the BDRVRBDState to keep track of the
> >>>     current size of the RBD image [Jason, Kevin]
> >>> ---
> >>>  block/rbd.c | 42 +++++++++++++++++++++++++++++++++++++++---
> >>>  1 file changed, 39 insertions(+), 3 deletions(-)
> >>>
> >>> diff --git a/block/rbd.c b/block/rbd.c
> >>> index 0c549c9935..b0355a2ce0 100644
> >>> --- a/block/rbd.c
> >>> +++ b/block/rbd.c
> >>
> >> [...]
> >>
> >>> @@ -833,6 +842,22 @@ static void qemu_rbd_close(BlockDriverState *bs)
> >>>      rados_shutdown(s->cluster);
> >>>  }
> >>>  
> >>> +/* Resize the RBD image and update the 'image_size' with the current size */
> >>> +static int qemu_rbd_resize(BlockDriverState *bs, uint64_t size)
> >>> +{
> >>> +    BDRVRBDState *s = bs->opaque;
> >>> +    int r;
> >>> +
> >>> +    r = rbd_resize(s->image, size);
> >>> +    if (r < 0) {
> >>> +        return r;
> >>> +    }
> >>> +
> >>> +    s->image_size = size;
> >>
> >> I think this should update bs->total_sectors, too.  In fact, I’m
> >> wondering why you don’t just use bs->total_sectors (or bdrv_getlength(),
> >> which returns bs->total_sectors * 512) instead of adding this new field?
> >>
> > 
> > Hi Max,
> > thanks for taking a look!
> > 
> > I used bs->total_sectors in the v2, but Jason pointed out a possible
> > issue with this, so I proposed to add a variable in the BDRVRBDState to
> > track the latest resize and Kevin acked [1].
> > 
> > IIUC what Kevin said on his comment, the 'bs->total_sectors' should be
> > updated by bdrv_co_write_req_finish(), for this reason I didn't update
> > it.
> > 
> > [1] https://www.mail-archive.com/qemu-devel@nongnu.org/msg615195.html
> 
> Ah, right!  Yeah, sure, now that I think about it, the block layer must
> have general code for successful writes beyond EOF...  (Read: Now that
> I’m pointed towards it...)

Yeah, do you mean for example to call .bdrv_co_truncate() (or a new
callback implemented only in the driver that need to be resized like
rbd) in the bdrv_driver_pwritev() if we will write beyond EOF?

> 
> OK then; thanks for the patch, applied to my block branch:

Thanks to take this!
Stefano


