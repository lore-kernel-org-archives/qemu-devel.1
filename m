Return-Path: <SRS0=60fc=TH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC53C004C9
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:37:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B394D20B7C
	for <qemu-devel@archiver.kernel.org>; Tue,  7 May 2019 08:37:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B394D20B7C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:42321 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hNvbR-0003DA-2p
	for qemu-devel@archiver.kernel.org; Tue, 07 May 2019 04:37:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33599)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hNvaV-0002sp-Lr
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:36:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hNvaS-0001Pk-V9
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:36:35 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:39537)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hNvaP-0001Kz-3T
	for qemu-devel@nongnu.org; Tue, 07 May 2019 04:36:30 -0400
Received: by mail-wr1-f65.google.com with SMTP id v10so8774841wrt.6
	for <qemu-devel@nongnu.org>; Tue, 07 May 2019 01:36:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=+vQ16xWwk3D39j2x+lipmi6J6D/KPmKWgwy9hAOBxQw=;
	b=jEk+WIVrg/QIMcdfKPlQay4J8MvIyfQzFKSF/+6GkfviMhzUKFa+E86J/2iGGS/MQU
	4YPomqOSw4KiuWF3CE/4EHQCFczuKUIaezxEKiWZ+2Lueh3os0gNpzJX2aDPlleNt1x7
	iBbowwDnI6h1KO0EfK/I1TU2ktf8f+wgkWG/Pu9BYYu3TxwEhTi1YuWN2IhD+FlBy+dH
	cSdNsC7pPWybf2WgaK2hdTNqZFs/pWz82y5vtv1YHtmkJi+yTn0Z8dRWTFvMTHo5Cfk6
	XI49B7x2K7DrFjcMZ1/LPtb1jN5yM5SZN7JSb6d06KrohwPEo0fZPdALc8xdq+lqXO5W
	1VDQ==
X-Gm-Message-State: APjAAAVtV/rPB+Tj4EK5k1194WLFrqbAIGBdUcZoXmJtBq1mZEPOCmpA
	dAsUwjZ59z+7usYHGfE/4nZvpw==
X-Google-Smtp-Source: APXvYqyak1991BmQRv6SQIgsFUBfysEw/pwnmi5txUCms8KyKtWKwdOEetvyM2xyQ+vVQ83pdKe7CQ==
X-Received: by 2002:a5d:65cc:: with SMTP id e12mr8067745wrw.315.1557218178882; 
	Tue, 07 May 2019 01:36:18 -0700 (PDT)
Received: from steredhat (host103-125-dynamic.46-79-r.retail.telecomitalia.it.
	[79.46.125.103]) by smtp.gmail.com with ESMTPSA id
	u14sm9116333wrn.30.2019.05.07.01.36.17
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Tue, 07 May 2019 01:36:18 -0700 (PDT)
Date: Tue, 7 May 2019 10:36:15 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190507083615.as7shlq7fwjgwz54@steredhat>
References: <20190427113625.46594-1-sgarzare@redhat.com>
	<877eb2hiwk.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <877eb2hiwk.fsf@dusky.pond.sub.org>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] Use of PreallocMode in block drivers (was: [PATCH]
 block/rbd: add preallocation support)
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Cc: Kevin Wolf <kwolf@redhat.com>, Josh Durgin <jdurgin@redhat.com>,
	Peter Krempa <pkrempa@redhat.com>, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, May 07, 2019 at 08:34:51AM +0200, Markus Armbruster wrote:
> Cc: Peter for a libvirt perspective.
> 
> Stefano Garzarella <sgarzare@redhat.com> writes:
> 
> > This patch adds the support of preallocation (off/full) for the RBD
> > block driver.
> > If available, we use rbd_writesame() to quickly fill the image when
> > full preallocation is required.
> >
> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> > ---
> >  block/rbd.c          | 149 ++++++++++++++++++++++++++++++++++++++-----
> >  qapi/block-core.json |   4 +-
> >  2 files changed, 136 insertions(+), 17 deletions(-)
> >
> > diff --git a/block/rbd.c b/block/rbd.c
> > index 0c549c9935..29dd1bb040 100644
> > --- a/block/rbd.c
> > +++ b/block/rbd.c
> > @@ -13,6 +13,7 @@
> >  
> >  #include "qemu/osdep.h"
> >  
> > +#include "qemu/units.h"
> >  #include <rbd/librbd.h>
> >  #include "qapi/error.h"
> >  #include "qemu/error-report.h"
> > @@ -331,6 +332,110 @@ static void qemu_rbd_memset(RADOSCB *rcb, int64_t offs)
> >      }
> >  }
> >  
> > +static int qemu_rbd_do_truncate(rbd_image_t image, int64_t offset,
> > +                                PreallocMode prealloc, Error **errp)
> > +{
> > +    uint64_t current_length;
> > +    char *buf = NULL;
> > +    int ret;
> > +
> > +    ret = rbd_get_size(image, &current_length);
> > +    if (ret < 0) {
> > +        error_setg_errno(errp, -ret, "Failed to get file length");
> > +        goto out;
> > +    }
> > +
> > +    if (current_length > offset && prealloc != PREALLOC_MODE_OFF) {
> > +        error_setg(errp, "Cannot use preallocation for shrinking files");
> > +        ret = -ENOTSUP;
> > +        goto out;
> > +    }
> > +
> > +    switch (prealloc) {
> > +    case PREALLOC_MODE_FULL: {
> [...]
> > +    case PREALLOC_MODE_OFF:
> [...]
> > +    default:
> > +        error_setg(errp, "Unsupported preallocation mode: %s",
> > +                   PreallocMode_str(prealloc));
> > +        ret = -ENOTSUP;
> > +        goto out;
> > +    }
> 
> Other block drivers also accept only some values of PreallocMode.  Okay.
> 
> I wonder whether management applications need to know which values are
> supported.

Good point!

> 
> Let me review support in drivers:
> 
> * file (file-win32.c)
> * iscsi
> * nfs
> * qed
> * ssh
> 
>   - Reject all but PREALLOC_MODE_OFF
> 
> * copy-on-read
> * luks (crypto.c)
> * raw
> 
>   - Pass through only
> 
> * file host_cdrom host_device (file-posix.c)
> 
>   - Reject all but PREALLOC_MODE_OFF when shrinking and for non-regular
>     files
>   - Reject PREALLOC_MODE_FALLOC unless CONFIG_POSIX_FALLOCATE
>   - Reject PREALLOC_MODE_METADATA
> 
> * gluster
> 
>   - Reject all but PREALLOC_MODE_OFF when shrinking
>   - Reject PREALLOC_MODE_FALLOC unless CONFIG_GLUSTERFS_FALLOCATE
>   - Reject PREALLOC_MODE_FULL unless CONFIG_GLUSTERFS_ZEROFILL
>   - Reject PREALLOC_MODE_METADATA
> 
> * qcow2
> 
>   - Reject all but PREALLOC_MODE_OFF when shrinking and with a backing
>     file
>   
> * rbd with this patch
> 
>   - Reject all but PREALLOC_MODE_OFF when shrinking
>   - Reject PREALLOC_MODE_METADATA and PREALLOC_MODE_FALLOC
> 
> * sheepdog
> 
>   - Reject PREALLOC_MODE_METADATA and PREALLOC_MODE_FALLOC
>   - Doesn't support shrinking
> 
> * vdi
> 
>   - Reject PREALLOC_MODE_FALLOC and PREALLOC_MODE_FULL
>   - Doesn't support shrinking
> 
> * blkdebug
> * blklogwrites
> * blkverify
> * bochs
> * cloop
> * dmg
> * ftp
> * ftps
> * http
> * https
> * luks
> * nbd
> * null-aio
> * null-co
> * nvme
> * parallels
> * qcow
> * quorum
> * replication
> * throttle
> * vhdx
> * vmdk
> * vpc
> * vvfat
> * vxhs
> 
>   - These appear not to use PreallocMode: they don't implement
>     .bdrv_co_truncate(), and either don't implement .bdrv_co_create() or
>     implement it without a prealloc parameter.
> 
> Looks good to me.
>

Thanks for the analysis!

> > +
> > +    ret = 0;
> > +
> > +out:
> > +    g_free(buf);
> > +    return ret;
> > +}
> > +
> >  static QemuOptsList runtime_opts = {
> >      .name = "rbd",
> >      .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
> [...]
> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> > index 7ccbfff9d0..db25a4065b 100644
> > --- a/qapi/block-core.json
> > +++ b/qapi/block-core.json
> > @@ -4277,13 +4277,15 @@
> >  #                   point to a snapshot.
> >  # @size             Size of the virtual disk in bytes
> >  # @cluster-size     RBD object size
> > +# @preallocation    Preallocation mode (allowed values: off, full)
> >  #
> >  # Since: 2.12
> >  ##
> >  { 'struct': 'BlockdevCreateOptionsRbd',
> >    'data': { 'location':         'BlockdevOptionsRbd',
> >              'size':             'size',
> > -            '*cluster-size' :   'size' } }
> > +            '*cluster-size' :   'size',
> > +            '*preallocation':   'PreallocMode' } }
> >  
> >  ##
> >  # @BlockdevVmdkSubformat:
> 
> The non-support of values 'metadata' and 'falloc' is not visible in
> introspection, only in documentation.  No reason to block this patch, as
> the other block drivers have the same introspection weakness (only
> sheepdog and vdi bother to document).
> 
> Should we address the introspection weakness?  Only if there's a use for
> the information, I think.

If the management applications will use that information (or maybe also
our help pages), could be useful to have an array of 'PreallocMode'
supported per-driver.

> 
> Should we improve documentation for the other block drivers?
> 

Yes, e.g. for Gluster it is not updated.
If you agree, I can check and update the documentation of all drivers following
your analysis.

Cheers,
Stefano

