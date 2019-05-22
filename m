Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E90DC18E7D
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:00:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 32E5520856
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 09:00:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 32E5520856
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:38718 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTN6N-00042P-9W
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 04:59:59 -0400
Received: from eggs.gnu.org ([209.51.188.92]:37730)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hTN4j-0003A1-Jl
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:58:19 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <sgarzare@redhat.com>) id 1hTN4i-0001cn-17
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:58:17 -0400
Received: from mail-oi1-f193.google.com ([209.85.167.193]:41932)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <sgarzare@redhat.com>) id 1hTN4h-0001GW-Px
	for qemu-devel@nongnu.org; Wed, 22 May 2019 04:58:15 -0400
Received: by mail-oi1-f193.google.com with SMTP id y10so1007221oia.8
	for <qemu-devel@nongnu.org>; Wed, 22 May 2019 01:57:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=1e100.net; s=20161025;
	h=x-gm-message-state:mime-version:references:in-reply-to:from:date
	:message-id:subject:to:cc;
	bh=gb0AXCb3iwz6UL959Wp9UIaH28HKckoG8RGRpixAEdw=;
	b=RBaMq3Gp5NPlLdP7zMfyBwukgePFynTJG2UQMzDvEBPucLY9f4AFgDtd3VlnH3qvsh
	X0dB3AwfhMVK9x+380vlxUstvYLs3GpkgV05n0YRV/AWe4hne0BHh6FLlqAw0OzqU81t
	HsFGbArMHceH1lJV9UxwzIQwe/FMUdldSTtDKvOin0zOKmXJEEGSew9aj7GLNJPtfi0z
	Lj4yOhxKpyzffn704duhxxIVprkwbreOkwRmp09wO+Z4gGxuxm1xVa9ONIx9+k78mD/z
	sgD3H/l8efPAi+BXMijz2bp9VzS3ycHlsfvcKD9tNO8HFk6sFUrM0nijsB6DaDeo68nI
	apTQ==
X-Gm-Message-State: APjAAAVcyl3rSmAuRfZdJE7uq1HeyFBKkQuhOvk/AUx+uA59uY1D+n/a
	ZHi/l9lAMKmVIFChBa4u/Yb8mO9883LFF57FuqfMhg==
X-Google-Smtp-Source: APXvYqy/cAq6BBeBVzR6SzB8G2tarpIUr/ZnEShITz8KM0JDwYGTtvktEQ/IZHLWzbL6F/ICVyU05COggNaFozSnlmA=
X-Received: by 2002:aca:54d8:: with SMTP id i207mr6578867oib.9.1558515470844; 
	Wed, 22 May 2019 01:57:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190427113625.46594-1-sgarzare@redhat.com>
	<877eb2hiwk.fsf@dusky.pond.sub.org>
	<20190507083615.as7shlq7fwjgwz54@steredhat>
	<8736lp5fxg.fsf@dusky.pond.sub.org>
In-Reply-To: <8736lp5fxg.fsf@dusky.pond.sub.org>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Wed, 22 May 2019 10:57:39 +0200
Message-ID: <CAGxU2F6r0hKy_Egwf=xfMkFH-3bxL8Yjz3z6GTT0QTrkYoHCDQ@mail.gmail.com>
To: Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
	[fuzzy]
X-Received-From: 209.85.167.193
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
Cc: qemu devel list <qemu-devel@nongnu.org>, Qemu-block <qemu-block@nongnu.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, May 8, 2019 at 1:44 PM Markus Armbruster <armbru@redhat.com> wrote:
>
> Stefano Garzarella <sgarzare@redhat.com> writes:
>
> > On Tue, May 07, 2019 at 08:34:51AM +0200, Markus Armbruster wrote:
> >> Cc: Peter for a libvirt perspective.
> >>
> >> Stefano Garzarella <sgarzare@redhat.com> writes:
> >>
> >> > This patch adds the support of preallocation (off/full) for the RBD
> >> > block driver.
> >> > If available, we use rbd_writesame() to quickly fill the image when
> >> > full preallocation is required.
> >> >
> >> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
> >> > ---
> >> >  block/rbd.c          | 149 ++++++++++++++++++++++++++++++++++++++-----
> >> >  qapi/block-core.json |   4 +-
> >> >  2 files changed, 136 insertions(+), 17 deletions(-)
> >> >
> >> > diff --git a/block/rbd.c b/block/rbd.c
> >> > index 0c549c9935..29dd1bb040 100644
> >> > --- a/block/rbd.c
> >> > +++ b/block/rbd.c
> >> > @@ -13,6 +13,7 @@
> >> >
> >> >  #include "qemu/osdep.h"
> >> >
> >> > +#include "qemu/units.h"
> >> >  #include <rbd/librbd.h>
> >> >  #include "qapi/error.h"
> >> >  #include "qemu/error-report.h"
> >> > @@ -331,6 +332,110 @@ static void qemu_rbd_memset(RADOSCB *rcb, int64_t offs)
> >> >      }
> >> >  }
> >> >
> >> > +static int qemu_rbd_do_truncate(rbd_image_t image, int64_t offset,
> >> > +                                PreallocMode prealloc, Error **errp)
> >> > +{
> >> > +    uint64_t current_length;
> >> > +    char *buf = NULL;
> >> > +    int ret;
> >> > +
> >> > +    ret = rbd_get_size(image, &current_length);
> >> > +    if (ret < 0) {
> >> > +        error_setg_errno(errp, -ret, "Failed to get file length");
> >> > +        goto out;
> >> > +    }
> >> > +
> >> > +    if (current_length > offset && prealloc != PREALLOC_MODE_OFF) {
> >> > +        error_setg(errp, "Cannot use preallocation for shrinking files");
> >> > +        ret = -ENOTSUP;
> >> > +        goto out;
> >> > +    }
> >> > +
> >> > +    switch (prealloc) {
> >> > +    case PREALLOC_MODE_FULL: {
> >> [...]
> >> > +    case PREALLOC_MODE_OFF:
> >> [...]
> >> > +    default:
> >> > +        error_setg(errp, "Unsupported preallocation mode: %s",
> >> > +                   PreallocMode_str(prealloc));
> >> > +        ret = -ENOTSUP;
> >> > +        goto out;
> >> > +    }
> >>
> >> Other block drivers also accept only some values of PreallocMode.  Okay.
> >>
> >> I wonder whether management applications need to know which values are
> >> supported.
> >
> > Good point!
>
> We can continue to assume they don't until somebody tells us otherwise.
>
> >> Let me review support in drivers:
> >>
> >> * file (file-win32.c)
> >> * iscsi
> >> * nfs
> >> * qed
> >> * ssh
> >>
> >>   - Reject all but PREALLOC_MODE_OFF
> >>
> >> * copy-on-read
> >> * luks (crypto.c)
> >> * raw
> >>
> >>   - Pass through only
> >>
> >> * file host_cdrom host_device (file-posix.c)
> >>
> >>   - Reject all but PREALLOC_MODE_OFF when shrinking and for non-regular
> >>     files
> >>   - Reject PREALLOC_MODE_FALLOC unless CONFIG_POSIX_FALLOCATE
> >>   - Reject PREALLOC_MODE_METADATA
> >>
> >> * gluster
> >>
> >>   - Reject all but PREALLOC_MODE_OFF when shrinking
> >>   - Reject PREALLOC_MODE_FALLOC unless CONFIG_GLUSTERFS_FALLOCATE
> >>   - Reject PREALLOC_MODE_FULL unless CONFIG_GLUSTERFS_ZEROFILL
> >>   - Reject PREALLOC_MODE_METADATA
> >>
> >> * qcow2
> >>
> >>   - Reject all but PREALLOC_MODE_OFF when shrinking and with a backing
> >>     file
> >>
> >> * rbd with this patch
> >>
> >>   - Reject all but PREALLOC_MODE_OFF when shrinking
> >>   - Reject PREALLOC_MODE_METADATA and PREALLOC_MODE_FALLOC
> >>
> >> * sheepdog
> >>
> >>   - Reject PREALLOC_MODE_METADATA and PREALLOC_MODE_FALLOC
> >>   - Doesn't support shrinking
> >>
> >> * vdi
> >>
> >>   - Reject PREALLOC_MODE_FALLOC and PREALLOC_MODE_FULL
> >>   - Doesn't support shrinking
> >>
> >> * blkdebug
> >> * blklogwrites
> >> * blkverify
> >> * bochs
> >> * cloop
> >> * dmg
> >> * ftp
> >> * ftps
> >> * http
> >> * https
> >> * luks
> >> * nbd
> >> * null-aio
> >> * null-co
> >> * nvme
> >> * parallels
> >> * qcow
> >> * quorum
> >> * replication
> >> * throttle
> >> * vhdx
> >> * vmdk
> >> * vpc
> >> * vvfat
> >> * vxhs
> >>
> >>   - These appear not to use PreallocMode: they don't implement
> >>     .bdrv_co_truncate(), and either don't implement .bdrv_co_create() or
> >>     implement it without a prealloc parameter.
> >>
> >> Looks good to me.
> >>
> >
> > Thanks for the analysis!
> >
> >> > +
> >> > +    ret = 0;
> >> > +
> >> > +out:
> >> > +    g_free(buf);
> >> > +    return ret;
> >> > +}
> >> > +
> >> >  static QemuOptsList runtime_opts = {
> >> >      .name = "rbd",
> >> >      .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
> >> [...]
> >> > diff --git a/qapi/block-core.json b/qapi/block-core.json
> >> > index 7ccbfff9d0..db25a4065b 100644
> >> > --- a/qapi/block-core.json
> >> > +++ b/qapi/block-core.json
> >> > @@ -4277,13 +4277,15 @@
> >> >  #                   point to a snapshot.
> >> >  # @size             Size of the virtual disk in bytes
> >> >  # @cluster-size     RBD object size
> >> > +# @preallocation    Preallocation mode (allowed values: off, full)
> >> >  #
> >> >  # Since: 2.12
> >> >  ##
> >> >  { 'struct': 'BlockdevCreateOptionsRbd',
> >> >    'data': { 'location':         'BlockdevOptionsRbd',
> >> >              'size':             'size',
> >> > -            '*cluster-size' :   'size' } }
> >> > +            '*cluster-size' :   'size',
> >> > +            '*preallocation':   'PreallocMode' } }
> >> >
> >> >  ##
> >> >  # @BlockdevVmdkSubformat:
> >>
> >> The non-support of values 'metadata' and 'falloc' is not visible in
> >> introspection, only in documentation.  No reason to block this patch, as
> >> the other block drivers have the same introspection weakness (only
> >> sheepdog and vdi bother to document).
> >>
> >> Should we address the introspection weakness?  Only if there's a use for
> >> the information, I think.
> >
> > If the management applications will use that information (or maybe also
> > our help pages), could be useful to have an array of 'PreallocMode'
> > supported per-driver.
>
> Ideally, query-qmp-schema would show only the supported values.
>
> Not hard to do, just tedious: we'd get a number of sub-enums in addition
> to the full one, and we'd have to map from sub-enum to the full one.
>
> QAPI language support for sub-enums would remove most of the tedium.
> Not worthwhile unless the need for sub-enums is actually common.
>
> >> Should we improve documentation for the other block drivers?
> >>
> >
> > Yes, e.g. for Gluster it is not updated.
> > If you agree, I can check and update the documentation of all drivers following
> > your analysis.
>
> Yes, please!


Hi Markus,
I'm finally updating the documentation of preallocation modes
supported by block drivers and protocols in qapi/block-core.json.
As sheepdog and vdi I'm adding the supported values for each driver or
protocol that supports 'preallocation' parameter during the creation,
I'm also updating the '.help' in the QemuOptsList.

My doubt is: where is better to put the documentation about
preallocation modes supported during the resize? (e.g. some drivers
support only PREALLOC_MODE_OFF when shrinking)

Thanks,
Stefano

