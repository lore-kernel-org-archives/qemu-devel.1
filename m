Return-Path: <SRS0=mdN/=VA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EDDE8C0650E
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:29:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C3AFB2184C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Jul 2019 15:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C3AFB2184C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:36880 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hihCm-0004Ov-38
	for qemu-devel@archiver.kernel.org; Wed, 03 Jul 2019 11:29:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:40597)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hihBL-00032o-A3
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:28:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hihBJ-0000EN-UA
 for qemu-devel@nongnu.org; Wed, 03 Jul 2019 11:28:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:52678)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hihB9-0000AJ-Ph; Wed, 03 Jul 2019 11:28:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id F3C8B3082B67;
 Wed,  3 Jul 2019 15:28:08 +0000 (UTC)
Received: from dhcp-4-67.tlv.redhat.com (dhcp-4-67.tlv.redhat.com [10.35.4.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3EA6D19698;
 Wed,  3 Jul 2019 15:28:07 +0000 (UTC)
Message-ID: <e33c43847b8a5056d64031a3141e083ecb709f9e.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org
Date: Wed, 03 Jul 2019 18:28:06 +0300
In-Reply-To: <70330e00-ebe9-ce2a-5155-6f7e032e0aae@redhat.com>
References: <20190630150855.1016-1-mlevitsk@redhat.com>
 <20190630150855.1016-2-mlevitsk@redhat.com>
 <70330e00-ebe9-ce2a-5155-6f7e032e0aae@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.45]); Wed, 03 Jul 2019 15:28:09 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH 1/1] raw-posix.c - use max transfer length
 / max segemnt count only for SCSI passthrough
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
Cc: Fam Zheng <fam@euphon.net>, Kevin Wolf <kwolf@redhat.com>,
 Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org,
 John Ferlan <jferlan@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 2019-07-03 at 09:50 -0500, Eric Blake wrote:
> On 6/30/19 10:08 AM, Maxim Levitsky wrote:
> > Regular block devices (/dev/sda*, /dev/nvme*, etc) interface is not limited
> 
> The regular block device interface is
> 
> or
> 
> Regular block devices interfaces are
> 
> > by the underlying storage limits, but rather the kernel block layer
> > takes care to split the requests that are too large/fragmented.
> > 
> > Doing so allows us to have less overhead in qemu.
> > 
> > Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> > ---
> >  block/file-posix.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/block/file-posix.c b/block/file-posix.c
> > index ab05b51a66..66dad34f8a 100644
> > --- a/block/file-posix.c
> > +++ b/block/file-posix.c
> > @@ -1038,15 +1038,13 @@ static void raw_reopen_abort(BDRVReopenState *state)
> >      s->reopen_state = NULL;
> >  }
> >  
> > -static int hdev_get_max_transfer_length(BlockDriverState *bs, int fd)
> > +static int sg_get_max_transfer_length(BlockDriverState *bs, int fd)
> >  {
> >  #ifdef BLKSECTGET
> >      int max_bytes = 0;
> > -    short max_sectors = 0;
> > -    if (bs->sg && ioctl(fd, BLKSECTGET, &max_bytes) == 0) {
> > +
> > +    if (ioctl(fd, BLKSECTGET, &max_bytes) == 0) {
> >          return max_bytes;
> > -    } else if (!bs->sg && ioctl(fd, BLKSECTGET, &max_sectors) == 0) {
> > -        return max_sectors << BDRV_SECTOR_BITS;
> >      } else {
> >          return -errno;
> >      }
> > @@ -1055,7 +1053,7 @@ static int hdev_get_max_transfer_length(BlockDriverState *bs, int fd)
> >  #endif
> >  }
> >  
> > -static int hdev_get_max_segments(const struct stat *st)
> > +static int sg_get_max_segments(const struct stat *st)
> >  {
> >  #ifdef CONFIG_LINUX
> >      char buf[32];
> > @@ -1106,12 +1104,12 @@ static void raw_refresh_limits(BlockDriverState *bs, Error **errp)
> >      struct stat st;
> >  
> >      if (!fstat(s->fd, &st)) {
> > -        if (S_ISBLK(st.st_mode) || S_ISCHR(st.st_mode)) {
> > -            int ret = hdev_get_max_transfer_length(bs, s->fd);
> 
> Is it worth delaying the fstat()...
> 
> > +        if (bs->sg) {
> > +            int ret = sg_get_max_transfer_length(bs, s->fd);
> >              if (ret > 0 && ret <= BDRV_REQUEST_MAX_BYTES) {
> >                  bs->bl.max_transfer = pow2floor(ret);
> >              }
> > -            ret = hdev_get_max_segments(&st);
> > +            ret = sg_get_max_segments(&st);
> 
> ...until inside the if (bs->sg) condition, to avoid wasted work for
> other scenarios?
> 
> >              if (ret > 0) {
> >                  bs->bl.max_transfer = MIN(bs->bl.max_transfer,
> >                                            ret * getpagesize());
> > 
> 
> Reviewed-by: Eric Blake <eblake@redhat.com>
> 

Thank you very much for the review. I'll send a V2 soon.

Best regards,
	Maxim Levitsky




