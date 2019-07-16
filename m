Return-Path: <SRS0=+QfZ=VN=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DECC7C7618F
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:45:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B2DCD20693
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jul 2019 15:45:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B2DCD20693
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50328 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hnPe4-0004Vd-1h
	for qemu-devel@archiver.kernel.org; Tue, 16 Jul 2019 11:45:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:38404)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <mlevitsk@redhat.com>) id 1hnPds-00043j-7n
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:45:25 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <mlevitsk@redhat.com>) id 1hnPdq-000763-Rj
 for qemu-devel@nongnu.org; Tue, 16 Jul 2019 11:45:24 -0400
Received: from mx1.redhat.com ([209.132.183.28]:41028)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <mlevitsk@redhat.com>)
 id 1hnPdl-00072m-Vb; Tue, 16 Jul 2019 11:45:18 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 42F3081F33;
 Tue, 16 Jul 2019 15:45:16 +0000 (UTC)
Received: from maximlenovopc.usersys.redhat.com (unknown [10.35.206.67])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 0372C600C4;
 Tue, 16 Jul 2019 15:45:14 +0000 (UTC)
Message-ID: <8dddcc60d9eac5535af9390e054dbfca9c08db2f.camel@redhat.com>
From: Maxim Levitsky <mlevitsk@redhat.com>
To: Max Reitz <mreitz@redhat.com>, qemu-block@nongnu.org
Date: Tue, 16 Jul 2019 18:45:13 +0300
In-Reply-To: <9d9af2d86805036334efd17baabf2ec2a0804615.camel@redhat.com>
References: <20190712173600.14554-1-mreitz@redhat.com>
 <20190712173600.14554-3-mreitz@redhat.com>
 <9d9af2d86805036334efd17baabf2ec2a0804615.camel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Tue, 16 Jul 2019 15:45:16 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH 2/7] block: Add
 blk_truncate_for_formatting()
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
Cc: Kevin Wolf <kwolf@redhat.com>, qemu-devel@nongnu.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, 2019-07-16 at 16:08 +0300, Maxim Levitsky wrote:
> On Fri, 2019-07-12 at 19:35 +0200, Max Reitz wrote:
> > Signed-off-by: Max Reitz <mreitz@redhat.com>
> > ---
> >  include/sysemu/block-backend.h | 12 ++++++++
> >  block/block-backend.c          | 54 ++++++++++++++++++++++++++++++++++
> >  2 files changed, 66 insertions(+)
> > 
> > diff --git a/include/sysemu/block-backend.h b/include/sysemu/block-backend.h
> > index 733c4957eb..cd9ec8bf52 100644
> > --- a/include/sysemu/block-backend.h
> > +++ b/include/sysemu/block-backend.h
> > @@ -236,6 +236,18 @@ int blk_pwrite_compressed(BlockBackend *blk, int64_t offset, const void *buf,
> >                            int bytes);
> >  int blk_truncate(BlockBackend *blk, int64_t offset, PreallocMode prealloc,
> >                   Error **errp);
> > +
> > +/**
> > + * Wrapper of blk_truncate() for format drivers that need to truncate
> > + * their protocol node before formatting it.
> > + * Invoke blk_truncate() to truncate the file to @offset; if that
> > + * fails with -ENOTSUP (and the file is already big enough), try to
> > + * overwrite the first sector with zeroes.  If that succeeds, return
> > + * success.
> > + */
> > +int blk_truncate_for_formatting(BlockBackend *blk, int64_t offset,
> > +                                Error **errp);
> > +
> >  int blk_pdiscard(BlockBackend *blk, int64_t offset, int bytes);
> >  int blk_save_vmstate(BlockBackend *blk, const uint8_t *buf,
> >                       int64_t pos, int size);
> > diff --git a/block/block-backend.c b/block/block-backend.c
> > index a8d160fd5d..c0e64b1ee1 100644
> > --- a/block/block-backend.c
> > +++ b/block/block-backend.c
> > @@ -2041,6 +2041,60 @@ int blk_truncate(BlockBackend *blk, int64_t offset, PreallocMode prealloc,
> >      return bdrv_truncate(blk->root, offset, prealloc, errp);
> >  }
> >  
> > +int blk_truncate_for_formatting(BlockBackend *blk, int64_t offset, Error **errp)
> > +{
> > +    Error *local_err = NULL;
> > +    int64_t current_size;
> > +    int bytes_to_clear;
> > +    int ret;
> > +
> > +    ret = blk_truncate(blk, offset, PREALLOC_MODE_OFF, &local_err);
> > +    if (ret < 0 && ret != -ENOTSUP) {
> > +        error_propagate(errp, local_err);
> > +        return ret;
> > +    } else if (ret >= 0) {
> > +        return ret;
> > +    }
> 
> What if the truncate does succeed? For example the current implementation of raw_co_truncate,
> does return zero when you truncate to less that block device size 
> (and this is kind of wrong since you can't really change the block device size)
> 
> Even more, I see is that in the later patch, you call this with offset == 0 which
> I think will always succeed on a raw block device, thus skipping the zeroing code.
> 
> How about just doing the zeroing in the bdrv_create_file_fallback?
> 
> 
> Another idea:
> 
> blk_truncate_for_formatting would first truncate the file to 0, then
> check if the size of the file became zero in addition to the successful return value.
> 
> If the file size became zero, truncate the file to the requested size - this should make sure that file is empty.
> Otherwise, zero the first sector.
> 
> It might also be nice to add a check that if the size didn't became zero, that it remained the same
> to avoid strange situations of semi broken truncate.
> 
> 
> Also I would rename the function to something like blk_raw_format_file,
> basically a function which tries its best to erase an existing file contents
> 
> 
> Yet another idea would to drop the lying in the raw_co_truncate (on block devices), and fail always,
> unless asked to truncate to the exact file size, and let the callers deal with that.
> Callers where it is not critical for the truncate to work can just ignore this failure.
> That is probably hard to implement 
> 
> Or we can add a truncate 'mode' to .bdrv_co_truncate, which would let the caller indicate its intention,
> that is if the caller must truncate to that size or it can accept truncate ending up in bigger file that it asked for. 
> 
> As we once discussed on IRC, the fact that truncate on a block device 'succeeds',
> despite not really beeing able to change the block device size, causes other issues,
> like not beeing able to use preallocation=full when creating a qcow2 image on a block device.
> 
> Best regards,
> 	Maxim Levitsky
> 
> > +
> > +    current_size = blk_getlength(blk);
> > +    if (current_size < 0) {
> > +        error_free(local_err);
> > +        error_setg_errno(errp, -current_size,
> > +                         "Failed to inquire new image file's current length");
> > +        return current_size;
> > +    }
> > +
> > +    if (current_size < offset) {
> > +        /* Need to grow the image, but we failed to do that */
> > +        error_propagate(errp, local_err);
> > +        return -ENOTSUP;
> > +    }
> > +
> > +    error_free(local_err);
> > +    /*
> > +     * We can deal with images that are too big.  We just need to
> > +     * clear the first sector.
> > +     */
> > +
> > +    bytes_to_clear = MIN(current_size, BDRV_SECTOR_SIZE) - offset;
Also this I think is wrong when offset !=0, since assuming real world device, the
MIN will be just BDRV_SECTOR_SIZE, so the result of this statement is negative number.

I think you want just
bytes_to_clear = MIN(current_size, BDRV_SECTOR_SIZE);


Best regards,
	Maxim Levitsky



> > +    if (bytes_to_clear) {
> > +        if (!(blk->root->perm & BLK_PERM_WRITE)) {
> > +            error_setg(errp, "Cannot clear first sector of new image: "
> > +                       "Write permission missing");
> > +            return -EPERM;
> > +        }
> > +
> > +        ret = blk_pwrite_zeroes(blk, offset, bytes_to_clear, 0);
> > +        if (ret < 0) {
> > +            error_setg_errno(errp, -ret, "Failed to clear the first sector of "
> > +                             "the new image");
> > +            return ret;
> > +        }
> > +    }
> > +
> > +    return 0;
> > +}
> > +
> >  static void blk_pdiscard_entry(void *opaque)
> >  {
> >      BlkRwCo *rwco = opaque;
> 
> 



