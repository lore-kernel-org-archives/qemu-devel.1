Return-Path: <SRS0=nSo8=TI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 998EBC04A6B
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:25:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6BA8821479
	for <qemu-devel@archiver.kernel.org>; Wed,  8 May 2019 12:25:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6BA8821479
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36228 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOLdZ-0006SK-9w
	for qemu-devel@archiver.kernel.org; Wed, 08 May 2019 08:25:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:50171)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hOLca-00064h-PP
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:24:29 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hOLcY-00040c-2e
	for qemu-devel@nongnu.org; Wed, 08 May 2019 08:24:27 -0400
Received: from mx1.redhat.com ([209.132.183.28]:42104)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hOLcT-0003xl-C0; Wed, 08 May 2019 08:24:23 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
	[10.5.11.22])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 39553C00735C;
	Wed,  8 May 2019 12:24:18 +0000 (UTC)
Received: from dhcp-200-226.str.redhat.com (dhcp-200-226.str.redhat.com
	[10.33.200.226])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id A13D910027C3;
	Wed,  8 May 2019 12:24:16 +0000 (UTC)
Date: Wed, 8 May 2019 14:24:15 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190508122415.GC15525@dhcp-200-226.str.redhat.com>
References: <cover.1556732434.git.berto@igalia.com>
	<f64d9b6b1bc90d45c9be5aae63176b34879182c2.1556732434.git.berto@igalia.com>
	<e5d0505d-9696-2df0-7ce3-c7e28122b5d1@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e5d0505d-9696-2df0-7ce3-c7e28122b5d1@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.32]);
	Wed, 08 May 2019 12:24:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v2 2/5] vdi: Replace bdrv_{read,
 write}() with bdrv_{pread, pwrite}()
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
Cc: Alberto Garcia <berto@igalia.com>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 06.05.2019 um 18:38 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 01.05.2019 21:13, Alberto Garcia wrote:
> > There's only a couple of bdrv_read() and bdrv_write() calls left in
> > the vdi code, and they can be trivially replaced with the byte-based
> > bdrv_pread() and bdrv_pwrite().
> > 
> > Signed-off-by: Alberto Garcia <berto@igalia.com>
> > ---
> >   block/vdi.c | 15 +++++++++------
> >   1 file changed, 9 insertions(+), 6 deletions(-)
> > 
> > diff --git a/block/vdi.c b/block/vdi.c
> > index e1c42ad732..9caeb50dd1 100644
> > --- a/block/vdi.c
> > +++ b/block/vdi.c
> > @@ -171,6 +171,8 @@ typedef struct {
> >       uint64_t unused2[7];
> >   } QEMU_PACKED VdiHeader;
> >   
> > +QEMU_BUILD_BUG_ON(sizeof(VdiHeader) != 512);
> > +
> >   typedef struct {
> >       /* The block map entries are little endian (even in memory). */
> >       uint32_t *bmap;
> > @@ -384,7 +386,7 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
> >   
> >       logout("\n");
> >   
> > -    ret = bdrv_read(bs->file, 0, (uint8_t *)&header, 1);
> > +    ret = bdrv_pread(bs->file, 0, (uint8_t *)&header, sizeof(header));
> 
> bdrv_pread parameter buf parameter is void, so (uint8_t *) conversion is not needed
> (and even confusing)
> 
> >       if (ret < 0) {
> >           goto fail;
> >       }
> > @@ -484,8 +486,8 @@ static int vdi_open(BlockDriverState *bs, QDict *options, int flags,
> >           goto fail;
> >       }
> >   
> > -    ret = bdrv_read(bs->file, s->bmap_sector, (uint8_t *)s->bmap,
> > -                    bmap_size);
> > +    ret = bdrv_pread(bs->file, header.offset_bmap, (uint8_t *)s->bmap,
> > +                     bmap_size * SECTOR_SIZE);
> 
> and here
> 
> >       if (ret < 0) {
> >           goto fail_free_bmap;
> >       }
> > @@ -704,7 +706,7 @@ nonallocating_write:
> >           assert(VDI_IS_ALLOCATED(bmap_first));
> >           *header = s->header;
> >           vdi_header_to_le(header);
> > -        ret = bdrv_write(bs->file, 0, block, 1);
> > +        ret = bdrv_pwrite(bs->file, 0, block, sizeof(VdiHeader));
> 
> maybe, more self-descriptive:
>   ret = bdrv_pwrite(bs->file, 0, header, sizeof(*header));
> 
> 
> with at least extra conversion dropped:
> Reviewed-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>

I'll drop the casts while applying.

Kevin

