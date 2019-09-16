Return-Path: <SRS0=kH2x=XL=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00BD5C49ED7
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 07:54:12 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CB2BC20650
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Sep 2019 07:54:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CB2BC20650
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:59618 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i9lpq-0002St-W0
	for qemu-devel@archiver.kernel.org; Mon, 16 Sep 2019 03:54:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53727)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <kwolf@redhat.com>) id 1i9lp4-0001zp-M1
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:53:23 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1i9lp3-0003Tc-IZ
 for qemu-devel@nongnu.org; Mon, 16 Sep 2019 03:53:22 -0400
Received: from mx1.redhat.com ([209.132.183.28]:33490)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1i9lp1-0003SE-GQ; Mon, 16 Sep 2019 03:53:19 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0783A4E926;
 Mon, 16 Sep 2019 07:53:18 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-251.ams2.redhat.com
 [10.36.116.251])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2A25A5D6B2;
 Mon, 16 Sep 2019 07:53:04 +0000 (UTC)
Date: Mon, 16 Sep 2019 09:53:03 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190916075303.GA10930@localhost.localdomain>
References: <20190913152507.56197-1-slp@redhat.com>
 <20190913152507.56197-2-slp@redhat.com>
 <f10c8f6d-5ad2-b37c-16b7-659a3f02661c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f10c8f6d-5ad2-b37c-16b7-659a3f02661c@redhat.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.38]); Mon, 16 Sep 2019 07:53:18 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [Qemu-block] [PATCH v2 1/2] blockdev: release the
 AioContext at drive_backup_prepare
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
Cc: qemu-devel@nongnu.org, mreitz@redhat.com, qemu-block@nongnu.org,
 Sergio Lopez <slp@redhat.com>, armbru@redhat.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 13.09.2019 um 21:54 hat John Snow geschrieben:
> 
> 
> On 9/13/19 11:25 AM, Sergio Lopez wrote:
> > do_drive_backup() already acquires the AioContext, so release it
> > before the call.
> > 
> > Signed-off-by: Sergio Lopez <slp@redhat.com>
> > ---
> >  blockdev.c | 6 +-----
> >  1 file changed, 1 insertion(+), 5 deletions(-)
> > 
> > diff --git a/blockdev.c b/blockdev.c
> > index fbef6845c8..3927fdab80 100644
> > --- a/blockdev.c
> > +++ b/blockdev.c
> > @@ -1783,20 +1783,16 @@ static void drive_backup_prepare(BlkActionState *common, Error **errp)
> >  
> >      aio_context = bdrv_get_aio_context(bs);
> >      aio_context_acquire(aio_context);
> > -

Are you removing this unrelated empty line intentionally?

> >      /* Paired with .clean() */
> >      bdrv_drained_begin(bs);
> 
> Do we need to make this change to blockdev_backup_prepare as well?

Actually, the whole structure feels a bit wrong. We get the bs here and
take its lock, then release the lock again and forget the reference,
only to do both things again inside do_drive_backup().

The way snapshots work is that the "normal" snapshot commands are
wrappers that turn it into a single-entry transaction. Then you have
only one code path where you can resolve the ID and take the lock just
once. So maybe backup should work like this, too?

Kevin

