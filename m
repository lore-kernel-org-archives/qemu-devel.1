Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A99A3C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 12:08:51 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6830420989
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 12:08:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6830420989
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53407 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOhr0-0002ht-LD
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 08:08:50 -0400
Received: from eggs.gnu.org ([209.51.188.92]:60159)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOhpu-0001pm-Qx
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:07:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <armbru@redhat.com>) id 1hOhpt-0005HM-Eh
	for qemu-devel@nongnu.org; Thu, 09 May 2019 08:07:42 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33382)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <armbru@redhat.com>)
	id 1hOhpq-0005DZ-1d; Thu, 09 May 2019 08:07:38 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
	[10.5.11.13])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 2275E81224;
	Thu,  9 May 2019 12:07:37 +0000 (UTC)
Received: from blackfin.pond.sub.org (ovpn-116-28.ams2.redhat.com
	[10.36.116.28])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 31AEC611C3;
	Thu,  9 May 2019 12:07:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
	id AA2AF1132B35; Thu,  9 May 2019 14:07:34 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20190427113625.46594-1-sgarzare@redhat.com>
	<877eb2hiwk.fsf@dusky.pond.sub.org>
	<20190507083615.as7shlq7fwjgwz54@steredhat>
	<8736lp5fxg.fsf@dusky.pond.sub.org>
	<20190509082646.lrfllcqszjlmnyfe@steredhat>
Date: Thu, 09 May 2019 14:07:34 +0200
In-Reply-To: <20190509082646.lrfllcqszjlmnyfe@steredhat> (Stefano Garzarella's
	message of "Thu, 9 May 2019 10:26:46 +0200")
Message-ID: <87a7fv4yrd.fsf@dusky.pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.25]);
	Thu, 09 May 2019 12:07:37 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
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

Stefano Garzarella <sgarzare@redhat.com> writes:

> On Wed, May 08, 2019 at 01:44:27PM +0200, Markus Armbruster wrote:
>> Stefano Garzarella <sgarzare@redhat.com> writes:
>> 
>> > On Tue, May 07, 2019 at 08:34:51AM +0200, Markus Armbruster wrote:
>> >> Cc: Peter for a libvirt perspective.
>> >> 
>> >> Stefano Garzarella <sgarzare@redhat.com> writes:
>> >> 
>> >> > This patch adds the support of preallocation (off/full) for the RBD
>> >> > block driver.
>> >> > If available, we use rbd_writesame() to quickly fill the image when
>> >> > full preallocation is required.
>> >> >
>> >> > Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
>> >> > ---
>> >> >  block/rbd.c          | 149 ++++++++++++++++++++++++++++++++++++++-----
>> >> >  qapi/block-core.json |   4 +-
>> >> >  2 files changed, 136 insertions(+), 17 deletions(-)
>> >> >
>> >> > diff --git a/block/rbd.c b/block/rbd.c
>> >> > index 0c549c9935..29dd1bb040 100644
>> >> > --- a/block/rbd.c
>> >> > +++ b/block/rbd.c
>> >> > @@ -13,6 +13,7 @@
>> >> >  
>> >> >  #include "qemu/osdep.h"
>> >> >  
>> >> > +#include "qemu/units.h"
>> >> >  #include <rbd/librbd.h>
>> >> >  #include "qapi/error.h"
>> >> >  #include "qemu/error-report.h"
>> >> > @@ -331,6 +332,110 @@ static void qemu_rbd_memset(RADOSCB *rcb, int64_t offs)
>> >> >      }
>> >> >  }
>> >> >  
>> >> > +static int qemu_rbd_do_truncate(rbd_image_t image, int64_t offset,
>> >> > +                                PreallocMode prealloc, Error **errp)
>> >> > +{
>> >> > +    uint64_t current_length;
>> >> > +    char *buf = NULL;
>> >> > +    int ret;
>> >> > +
>> >> > +    ret = rbd_get_size(image, &current_length);
>> >> > +    if (ret < 0) {
>> >> > +        error_setg_errno(errp, -ret, "Failed to get file length");
>> >> > +        goto out;
>> >> > +    }
>> >> > +
>> >> > +    if (current_length > offset && prealloc != PREALLOC_MODE_OFF) {
>> >> > +        error_setg(errp, "Cannot use preallocation for shrinking files");
>> >> > +        ret = -ENOTSUP;
>> >> > +        goto out;
>> >> > +    }
>> >> > +
>> >> > +    switch (prealloc) {
>> >> > +    case PREALLOC_MODE_FULL: {
>> >> [...]
>> >> > +    case PREALLOC_MODE_OFF:
>> >> [...]
>> >> > +    default:
>> >> > +        error_setg(errp, "Unsupported preallocation mode: %s",
>> >> > +                   PreallocMode_str(prealloc));
>> >> > +        ret = -ENOTSUP;
>> >> > +        goto out;
>> >> > +    }
>> >> 
>> >> Other block drivers also accept only some values of PreallocMode.  Okay.
>> >> 
>> >> I wonder whether management applications need to know which values are
>> >> supported.
>> >
>> > Good point!
>> 
>> We can continue to assume they don't until somebody tells us otherwise.
>> 
>> >> Let me review support in drivers:
>> >> 
>> >> * file (file-win32.c)
>> >> * iscsi
>> >> * nfs
>> >> * qed
>> >> * ssh
>> >> 
>> >>   - Reject all but PREALLOC_MODE_OFF
>> >> 
>> >> * copy-on-read
>> >> * luks (crypto.c)
>> >> * raw
>> >> 
>> >>   - Pass through only
>> >> 
>> >> * file host_cdrom host_device (file-posix.c)
>> >> 
>> >>   - Reject all but PREALLOC_MODE_OFF when shrinking and for non-regular
>> >>     files
>> >>   - Reject PREALLOC_MODE_FALLOC unless CONFIG_POSIX_FALLOCATE
>> >>   - Reject PREALLOC_MODE_METADATA
>> >> 
>> >> * gluster
>> >> 
>> >>   - Reject all but PREALLOC_MODE_OFF when shrinking
>> >>   - Reject PREALLOC_MODE_FALLOC unless CONFIG_GLUSTERFS_FALLOCATE
>> >>   - Reject PREALLOC_MODE_FULL unless CONFIG_GLUSTERFS_ZEROFILL
>> >>   - Reject PREALLOC_MODE_METADATA
>> >> 
>> >> * qcow2
>> >> 
>> >>   - Reject all but PREALLOC_MODE_OFF when shrinking and with a backing
>> >>     file
>> >>   
>> >> * rbd with this patch
>> >> 
>> >>   - Reject all but PREALLOC_MODE_OFF when shrinking
>> >>   - Reject PREALLOC_MODE_METADATA and PREALLOC_MODE_FALLOC
>> >> 
>> >> * sheepdog
>> >> 
>> >>   - Reject PREALLOC_MODE_METADATA and PREALLOC_MODE_FALLOC
>> >>   - Doesn't support shrinking
>> >> 
>> >> * vdi
>> >> 
>> >>   - Reject PREALLOC_MODE_FALLOC and PREALLOC_MODE_FULL
>> >>   - Doesn't support shrinking
>> >> 
>> >> * blkdebug
>> >> * blklogwrites
>> >> * blkverify
>> >> * bochs
>> >> * cloop
>> >> * dmg
>> >> * ftp
>> >> * ftps
>> >> * http
>> >> * https
>> >> * luks
>> >> * nbd
>> >> * null-aio
>> >> * null-co
>> >> * nvme
>> >> * parallels
>> >> * qcow
>> >> * quorum
>> >> * replication
>> >> * throttle
>> >> * vhdx
>> >> * vmdk
>> >> * vpc
>> >> * vvfat
>> >> * vxhs
>> >> 
>> >>   - These appear not to use PreallocMode: they don't implement
>> >>     .bdrv_co_truncate(), and either don't implement .bdrv_co_create() or
>> >>     implement it without a prealloc parameter.
>> >> 
>> >> Looks good to me.
>> >>
>> >
>> > Thanks for the analysis!
>> >
>> >> > +
>> >> > +    ret = 0;
>> >> > +
>> >> > +out:
>> >> > +    g_free(buf);
>> >> > +    return ret;
>> >> > +}
>> >> > +
>> >> >  static QemuOptsList runtime_opts = {
>> >> >      .name = "rbd",
>> >> >      .head = QTAILQ_HEAD_INITIALIZER(runtime_opts.head),
>> >> [...]
>> >> > diff --git a/qapi/block-core.json b/qapi/block-core.json
>> >> > index 7ccbfff9d0..db25a4065b 100644
>> >> > --- a/qapi/block-core.json
>> >> > +++ b/qapi/block-core.json
>> >> > @@ -4277,13 +4277,15 @@
>> >> >  #                   point to a snapshot.
>> >> >  # @size             Size of the virtual disk in bytes
>> >> >  # @cluster-size     RBD object size
>> >> > +# @preallocation    Preallocation mode (allowed values: off, full)
>> >> >  #
>> >> >  # Since: 2.12
>> >> >  ##
>> >> >  { 'struct': 'BlockdevCreateOptionsRbd',
>> >> >    'data': { 'location':         'BlockdevOptionsRbd',
>> >> >              'size':             'size',
>> >> > -            '*cluster-size' :   'size' } }
>> >> > +            '*cluster-size' :   'size',
>> >> > +            '*preallocation':   'PreallocMode' } }
>> >> >  
>> >> >  ##
>> >> >  # @BlockdevVmdkSubformat:
>> >> 
>> >> The non-support of values 'metadata' and 'falloc' is not visible in
>> >> introspection, only in documentation.  No reason to block this patch, as
>> >> the other block drivers have the same introspection weakness (only
>> >> sheepdog and vdi bother to document).
>> >> 
>> >> Should we address the introspection weakness?  Only if there's a use for
>> >> the information, I think.
>> >
>> > If the management applications will use that information (or maybe also
>> > our help pages), could be useful to have an array of 'PreallocMode'
>> > supported per-driver.
>> 
>> Ideally, query-qmp-schema would show only the supported values.
>> 
>> Not hard to do, just tedious: we'd get a number of sub-enums in addition
>> to the full one, and we'd have to map from sub-enum to the full one.
>> 
>> QAPI language support for sub-enums would remove most of the tedium.
>> Not worthwhile unless the need for sub-enums is actually common.
>
> I should study better the QMP and QAPI to understand how to implement
> the sub-enums.

Sub-enums of

    { 'enum': 'PreallocMode',
      'data': [ 'off', 'metadata', 'falloc', 'full' ] }

done the obvious way:

    { 'enum': 'PreallocModeOff',
      'data': [ 'off' ] }
    { 'enum': 'PreallocModeOffPosix',
      'data': [ 'off', 'metadata',
                 { 'name': 'falloc', 'if': 'defined(CONFIG_POSIX_FALLOCATE)' },
                 'full' ] }

and so forth.

This generates a bunch of different C enum types in addition to
PreallocMode: PreallocModeOff, PreallocModePosix, ...

Common C code continues to use just PreallocMode.  The QMP command
handlers using sub-enums will have to map between the sub-enums and
PreallocMode.

Tedious.

With QAPI language support for sub-enums, we could eliminate the
additional C enums.

> If you agree, I'll put it as a background task, until somebody from
> management applications tell us his interest.

Only act if there's a compelling use case.

>> >> Should we improve documentation for the other block drivers?
>> >> 
>> >
>> > Yes, e.g. for Gluster it is not updated.
>> > If you agree, I can check and update the documentation of all drivers following
>> > your analysis.
>> 
>> Yes, please!
>
> Okay, I'll send a patch to update it.
>
> Thanks,
> Stefano

