Return-Path: <SRS0=xKZ8=TK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_NEOMUTT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E572DC04A6B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 08:37:55 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A60802087E
	for <qemu-devel@archiver.kernel.org>; Fri, 10 May 2019 08:37:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A60802087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:39007 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hP12R-00035c-0B
	for qemu-devel@archiver.kernel.org; Fri, 10 May 2019 04:37:55 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60586)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hP11D-0002UX-1Y
	for qemu-devel@nongnu.org; Fri, 10 May 2019 04:36:40 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hP11B-0008Ow-By
	for qemu-devel@nongnu.org; Fri, 10 May 2019 04:36:39 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:43641)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hP11B-0008Og-2R
	for qemu-devel@nongnu.org; Fri, 10 May 2019 04:36:37 -0400
Received: by mail-wr1-f65.google.com with SMTP id r4so6704385wro.10
	for <qemu-devel@nongnu.org>; Fri, 10 May 2019 01:36:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:date:from:to:cc:subject:message-id:references
	:mime-version:content-disposition:in-reply-to:user-agent;
	bh=lsbd6bql17kRkrC1yusUvgL1wdr7xQqjrMhaj4j0aDU=;
	b=tDpNGTcHHZxM3YROrV7crY9jhmeezFJ8HeYYxyJl2c6QhL1CcHfPJYRo7NG5F1Makj
	GkDABW69MWruDhmnY73MP/mYww6TMHJoid8rLsYs1Evx99MOIcMeJsS4dM1ewjS25M1g
	62odOQFhpwF9CJNtJUcIc5Vr/fIAUrg646X1gpMnPAG2RZAS256s7MDcPitAwbxQM7eX
	9cHrVkJ3RE9ZPWhnXFnuStCKsy/c+vXkp9tkoeiVItWhgMFZhbXmM74f8IdTdpSKV4BL
	p39EEqulmBFPzUobxXt0F1kry6ZGGjgAk6zwfMKc5Cbs3TLY8sGu/vosv+z5EPBI5nwH
	9QLA==
X-Gm-Message-State: APjAAAXXN6kxmPsDp9MTltIdIGhFPaCSRkehFIJgpGGH13SoUwFSSNZz
	wNCMfoR1KmR8QsOuSs9ActConw==
X-Google-Smtp-Source: APXvYqxXLzLobYf8M7xwDqJLoX89cIArwSe68yElJSrZOQcffGuLEGZzV4m+dN53UJ3Ng0mRvhQN9Q==
X-Received: by 2002:a5d:4648:: with SMTP id j8mr4025407wrs.53.1557477395981;
	Fri, 10 May 2019 01:36:35 -0700 (PDT)
Received: from steredhat (host151-251-static.12-87-b.business.telecomitalia.it.
	[87.12.251.151]) by smtp.gmail.com with ESMTPSA id
	i17sm1465969wrr.46.2019.05.10.01.36.34
	(version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
	Fri, 10 May 2019 01:36:35 -0700 (PDT)
Date: Fri, 10 May 2019 10:36:27 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Message-ID: <20190510083627.gumo2f72vdmzv6tx@steredhat>
References: <20190427113625.46594-1-sgarzare@redhat.com>
	<877eb2hiwk.fsf@dusky.pond.sub.org>
	<20190507083615.as7shlq7fwjgwz54@steredhat>
	<8736lp5fxg.fsf@dusky.pond.sub.org>
	<20190509082646.lrfllcqszjlmnyfe@steredhat>
	<87a7fv4yrd.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87a7fv4yrd.fsf@dusky.pond.sub.org>
User-Agent: NeoMutt/20180716
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.221.65
Subject: Re: [Qemu-devel] Use of PreallocMode in block drivers
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

On Thu, May 09, 2019 at 02:07:34PM +0200, Markus Armbruster wrote:
> Stefano Garzarella <sgarzare@redhat.com> writes:
> 
> > On Wed, May 08, 2019 at 01:44:27PM +0200, Markus Armbruster wrote:
> >> Stefano Garzarella <sgarzare@redhat.com> writes:
> >> 
> >> > On Tue, May 07, 2019 at 08:34:51AM +0200, Markus Armbruster wrote:
> >> >> Cc: Peter for a libvirt perspective.
> >> >> 
> >> >> Stefano Garzarella <sgarzare@redhat.com> writes:
> >> >> 
> >> >> > This patch adds the support of preallocation (off/full) for the RBD
> >> >> > block driver.
> >> >> > If available, we use rbd_writesame() to quickly fill the image when
> >> >> > full preallocation is required.
> >> >> >
> >> >> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> >> > ---
> >> >> >  block/rbd.c          | 149 ++++++++++++++++++++++++++++++++++++++-----
> >> >> >  qapi/block-core.json |   4 +-
> >> >> >  2 files changed, 136 insertions(+), 17 deletions(-)
> >> >> >
> >> >> > diff --git a/block/rbd.c b/block/rbd.c
> >> >> > index 0c549c9935..29dd1bb040 100644
> >> >> > --- a/block/rbd.c
> >> >> > +++ b/block/rbd.c
> >> >> > @@ -13,6 +13,7 @@
> >> >> >  
> >> >> >  #include "qemu/osdep.h"
> >> >> >  
> >> >> > +#include "qemu/units.h"
> >> >> >  #include <rbd/librbd.h>
> >> >> >  #include "qapi/error.h"
> >> >> >  #include "qemu/error-report.h"
> >> >> > @@ -331,6 +332,110 @@ static void qemu_rbd_memset(RADOSCB *rcb, int64_t offs)
> >> >> >      }
> >> >> >  }
> >> >> >  
> >> >> > +static int qemu_rbd_do_truncate(rbd_image_t image, int64_t offset,
> >> >> > +                                PreallocMode prealloc, Error **errp)
> >> >> > +{
> >> >> > +    uint64_t current_length;
> >> >> > +    char *buf = NULL;
> >> >> > +    int ret;
> >> >> > +
> >> >> > +    ret = rbd_get_size(image, &current_length);
> >> >> > +    if (ret < 0) {
> >> >> > +        error_setg_errno(errp, -ret, "Failed to get file length");
> >> >> > +        goto out;
> >> >> > +    }
> >> >> > +
> >> >> > +    if (current_length > offset && prealloc != PREALLOC_MODE_OFF) {
> >> >> > +        error_setg(errp, "Cannot use preallocation for shrinking files");
> >> >> > +        ret = -ENOTSUP;
> >> >> > +        goto out;
> >> >> > +    }
> >> >> > +
> >> >> > +    switch (prealloc) {
> >> >> > +    case PREALLOC_MODE_FULL: {
> >> >> [...]
> >> >> > +    case PREALLOC_MODE_OFF:
> >> >> [...]
> >> >> > +    default:
> >> >> > +        error_setg(errp, "Unsupported preallocation mode: %s",
> >> >> > +                   PreallocMode_str(prealloc));
> >> >> > +        ret = -ENOTSUP;
> >> >> > +        goto out;
> >> >> > +    }
> >> >> 
> >> >> Other block drivers also accept only some values of PreallocMode.  Okay.
> >> >> 
> >> >> I wonder whether management applications need to know which values are
> >> >> supported.
> >> >
> >> > Good point!
> >> 
> >> We can continue to assume they don't until somebody tells us otherwise.
> >> 
> >> >> Let me review support in drivers:
> >> >> 
> >> >> * file (file-win32.c)
> >> >> * iscsi
> >> >> * nfs
> >> >> * qed
> >> >> * ssh
> >> >> 
> >> >>   - Reject all but PREALLOC_MODE_OFF
> >> >> 
> >> >> * copy-on-read
> >> >> * luks (crypto.c)
> >> >> * raw
> >> >> 
> >> >>   - Pass through only
> >> >> 
> >> >> * file host_cdrom host_device (file-posix.c)
> >> >> 
> >> >>   - Reject all but PREALLOC_MODE_OFF when shrinking and for non-regular
> >> >>     files
> >> >>   - Reject PREALLOC_MODE_FALLOC unless CONFIG_POSIX_FALLOCATE
> >> >>   - Reject PREALLOC_MODE_METADATA
> >> >> 
> >> >> * gluster
> >> >> 
> >> >>   - Reject all but PREALLOC_MODE_OFF when shrinking
> >> >>   - Reject PREALLOC_MODE_FALLOC unless CONFIG_GLUSTERFS_FALLOCATE
> >> >>   - Reject PREALLOC_MODE_FULL unless CONFIG_GLUSTERFS_ZEROFILL
> >> >>   - Reject PREALLOC_MODE_METADATA
> >> >> 
> >> >> * qcow2
> >> >> 
> >> >>   - Reject all but PREALLOC_MODE_OFF when shrinking and with a backing
> >> >>     file
> >> >>   
> >> >> * rbd with this patch
> >> >> 
> >> >>   - Reject all but PREALLOC_MODE_OFF when shrinking
> >> >>   - Reject PREALLOC_MODE_METADATA and PREALLOC_MODE_FALLOC
> >> >> 
> >> >> * sheepdog
> >> >> 
> >> >>   - Reject PREALLOC_MODE_METADATA and PREALLOC_MODE_FALLOC
> >> >>   - Doesn't support shrinking
> >> >> 
> >> >> * vdi
> >> >> 
> >> >>   - Reject PREALLOC_MODE_FALLOC and PREALLOC_MODE_FULL
> >> >>   - Doesn't support shrinking
> >> >> 
> >> >> * blkdebug
> >> >> * blklogwrites
> >> >> * blkverify
> >> >> * bochs
> >> >> * cloop
> >> >> * dmg
> >> >> * ftp
> >> >> * ftps
> >> >> * http
> >> >> * https
> >> >> * luks
> >> >> * nbd
> >> >> * null-aio
> >> >> * null-co
> >> >> * nvme
> >> >> * parallels
> >> >> * qcow
> >> >> * quorum
> >> >> * replication
> >> >> * throttle
> >> >> * vhdx
> >> >> * vmdk
> >> >> * vpc
> >> >> * vvfat
> >> >> * vxhs
> >> >> 
> >> >>   - These appear not to use PreallocMode: they don't implement
> >> >>     .bdrv_co_truncate(), and either don't implement .bdrv_co_create() or
> >> >>     implement it without a prealloc parameter.
> >> >> 
> >> >> Looks good to me.
> >> >>
> >> >
> >> > Thanks for the analysis!
> >> >
> >> >> > +
> >> >> > +    ret = 0;
> >> >> > +
> >> >> > +out:
> >> >> > +    g_free(buf);
> >> >> > +    return ret;
> >> >> > +}
> >> >> > +
> >> >> >  static QemuOptsList runtime_opts = {
> >> >> >      .name = "rbd",
> >> >> >      .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
> >> >> [...]
> >> >> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> >> > index 7ccbfff9d0..db25a4065b 100644
> >> >> > --- a/qapi/block-core.json
> >> >> > +++ b/qapi/block-core.json
> >> >> > @@ -4277,13 +4277,15 @@
> >> >> >  #                   point to a snapshot.
> >> >> >  # @size             Size of the virtual disk in bytes
> >> >> >  # @cluster-size     RBD object size
> >> >> > +# @preallocation    Preallocation mode (allowed values: off, full)
> >> >> >  #
> >> >> >  # Since: 2.12
> >> >> >  ##
> >> >> >  { 'struct': 'BlockdevCreateOptionsRbd',
> >> >> >    'data': { 'location':         'BlockdevOptionsRbd',
> >> >> >              'size':             'size',
> >> >> > -            '*cluster-size' :   'size' } }
> >> >> > +            '*cluster-size' :   'size',
> >> >> > +            '*preallocation':   'PreallocMode' } }
> >> >> >  
> >> >> >  ##
> >> >> >  # @BlockdevVmdkSubformat:
> >> >> 
> >> >> The non-support of values 'metadata' and 'falloc' is not visible in
> >> >> introspection, only in documentation.  No reason to block this patch, as
> >> >> the other block drivers have the same introspection weakness (only
> >> >> sheepdog and vdi bother to document).
> >> >> 
> >> >> Should we address the introspection weakness?  Only if there's a use for
> >> >> the information, I think.
> >> >
> >> > If the management applications will use that information (or maybe also
> >> > our help pages), could be useful to have an array of 'PreallocMode'
> >> > supported per-driver.
> >> 
> >> Ideally, query-qmp-schema would show only the supported values.
> >> 
> >> Not hard to do, just tedious: we'd get a number of sub-enums in addition
> >> to the full one, and we'd have to map from sub-enum to the full one.
> >> 
> >> QAPI language support for sub-enums would remove most of the tedium.
> >> Not worthwhile unless the need for sub-enums is actually common.
> >
> > I should study better the QMP and QAPI to understand how to implement
> > the sub-enums.
> 
> Sub-enums of
> 
>     { 'enum': 'PreallocMode',
>       'data': [ 'off', 'metadata', 'falloc', 'full' ] }
> 
> done the obvious way:
> 
>     { 'enum': 'PreallocModeOff',
>       'data': [ 'off' ] }
>     { 'enum': 'PreallocModeOffPosix',
>       'data': [ 'off', 'metadata',
>                  { 'name': 'falloc', 'if': 'defined(CONFIG_POSIX_FALLOCATE)' },
>                  'full' ] }
> 
> and so forth.
> 
> This generates a bunch of different C enum types in addition to
> PreallocMode: PreallocModeOff, PreallocModePosix, ...
> 
> Common C code continues to use just PreallocMode.  The QMP command
> handlers using sub-enums will have to map between the sub-enums and
> PreallocMode.
> 
> Tedious.
> 
> With QAPI language support for sub-enums, we could eliminate the
> additional C enums.
> 

Okay, I understood your idea.
Thanks for the explanation!

> > If you agree, I'll put it as a background task, until somebody from
> > management applications tell us his interest.
> 
> Only act if there's a compelling use case.

Sure.

Thanks,
Stefano

