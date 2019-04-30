Return-Path: <SRS0=TP+Q=TA=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_MUTT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A84EC43219
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 11:10:27 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CC7A72080C
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2019 11:10:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CC7A72080C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43355 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hLQeX-0007YL-Qx
	for qemu-devel@archiver.kernel.org; Tue, 30 Apr 2019 07:10:25 -0400
Received: from eggs.gnu.org ([209.51.188.92]:45146)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLQdc-00077H-Ue
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:09:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hLQdb-0003J7-Tu
	for qemu-devel@nongnu.org; Tue, 30 Apr 2019 07:09:28 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51510)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hLQdZ-0003F5-9d; Tue, 30 Apr 2019 07:09:25 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
	[10.5.11.14])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 3D2E481F0E;
	Tue, 30 Apr 2019 11:09:24 +0000 (UTC)
Received: from linux.fritz.box (unknown [10.36.118.15])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id 392466C21E;
	Tue, 30 Apr 2019 11:09:20 +0000 (UTC)
Date: Tue, 30 Apr 2019 13:09:18 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190430110918.GF5607@linux.fritz.box>
References: <20190423125706.26989-1-vsementsov@virtuozzo.com>
	<20190423125706.26989-3-vsementsov@virtuozzo.com>
	<20190430092437.jbecehdkqa4zdavd@steredhat>
	<4dabb261-f2d1-b6e0-8d97-ace159b87a54@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
In-Reply-To: <4dabb261-f2d1-b6e0-8d97-ace159b87a54@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.27]);
	Tue, 30 Apr 2019 11:09:24 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH v5 2/3] block/io: bdrv_pdiscard: support
 int64_t bytes parameter
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
Cc: "fam@euphon.net" <fam@euphon.net>, Denis Lunev <den@virtuozzo.com>,
	"qemu-block@nongnu.org" <qemu-block@nongnu.org>,
	"qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
	"mreitz@redhat.com" <mreitz@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190430110918.CO40GH8BZtC4zg0FhpjQUoJ0ix6L3_LN7DADEttWDjI@z>

Am 30.04.2019 um 12:03 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 30.04.2019 12:24, Stefano Garzarella wrote:
> > On Tue, Apr 23, 2019 at 03:57:05PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> >> This fixes at least one overflow in qcow2_process_discards, which
> >> passes 64bit region length to bdrv_pdiscard where bytes (or sectors in
> >> the past) parameter is int since its introduction in 0b919fae.
> >>
> >> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
> >> ---
> >>   include/block/block.h |  4 ++--
> >>   block/io.c            | 16 ++++++++--------
> >>   2 files changed, 10 insertions(+), 10 deletions(-)
> >>
> >> diff --git a/include/block/block.h b/include/block/block.h
> >> index c7a26199aa..69fa18867e 100644
> >> --- a/include/block/block.h
> >> +++ b/include/block/block.h
> >> @@ -432,8 +432,8 @@ void bdrv_drain_all(void);
> >>       AIO_WAIT_WHILE(bdrv_get_aio_context(bs_),              \
> >>                      cond); })
> >>   
> >> -int bdrv_pdiscard(BdrvChild *child, int64_t offset, int bytes);
> >> -int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes);
> >> +int bdrv_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
> >> +int bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int64_t bytes);
> >>   int bdrv_has_zero_init_1(BlockDriverState *bs);
> >>   int bdrv_has_zero_init(BlockDriverState *bs);
> >>   bool bdrv_unallocated_blocks_are_zero(BlockDriverState *bs);
> >> diff --git a/block/io.c b/block/io.c
> >> index dfc153b8d8..16b6c5d855 100644
> >> --- a/block/io.c
> >> +++ b/block/io.c
> >> @@ -2653,7 +2653,7 @@ int bdrv_flush(BlockDriverState *bs)
> >>   typedef struct DiscardCo {
> >>       BdrvChild *child;
> >>       int64_t offset;
> >> -    int bytes;
> >> +    int64_t bytes;
> >>       int ret;
> >>   } DiscardCo;
> >>   static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
> >> @@ -2664,14 +2664,15 @@ static void coroutine_fn bdrv_pdiscard_co_entry(void *opaque)
> >>       aio_wait_kick();
> >>   }
> >>   
> >> -int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset, int bytes)
> >> +int coroutine_fn bdrv_co_pdiscard(BdrvChild *child, int64_t offset,
> >> +                                  int64_t bytes)
> >>   {
> >>       BdrvTrackedRequest req;
> >>       int max_pdiscard, ret;
> >>       int head, tail, align;
> >>       BlockDriverState *bs = child->bs;
> >>   
> >> -    if (!bs || !bs->drv) {
> >> +    if (!bs || !bs->drv || !bdrv_is_inserted(bs)) {
> > 
> > Should we describe this change in the commit message?
> 
> Honestly, don't want to resend the series for this.

I haven't reviewed the patches yet, but if this remains the only thing
to change, it can be updated while applying the series if we have a
specific proposal for a new commit message.

Kevin

