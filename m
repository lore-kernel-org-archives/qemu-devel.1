Return-Path: <SRS0=nSdt=TJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_MUTT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB1A8C04AB1
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:04:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 80B8F21019
	for <qemu-devel@archiver.kernel.org>; Thu,  9 May 2019 08:04:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 80B8F21019
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49992 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hOe2X-0004kt-MN
	for qemu-devel@archiver.kernel.org; Thu, 09 May 2019 04:04:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:40933)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hOdzQ-0002VK-Jc
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:01:21 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <kwolf@redhat.com>) id 1hOdzP-000588-Bc
	for qemu-devel@nongnu.org; Thu, 09 May 2019 04:01:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:50462)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <kwolf@redhat.com>)
	id 1hOdzH-00053d-L2; Thu, 09 May 2019 04:01:07 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
	[10.5.11.15])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx1.redhat.com (Postfix) with ESMTPS id 61205306034D;
	Thu,  9 May 2019 08:01:06 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-186.ams2.redhat.com
	[10.36.116.186])
	by smtp.corp.redhat.com (Postfix) with ESMTPS id ED6765B680;
	Thu,  9 May 2019 08:00:57 +0000 (UTC)
Date: Thu, 9 May 2019 10:00:56 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: John Snow <jsnow@redhat.com>
Message-ID: <20190509080056.GA6850@localhost.localdomain>
References: <20190506203344.30781-1-jsnow@redhat.com>
	<20190507085021.GB5808@localhost.localdomain>
	<a7ce7d95-7c77-b087-372f-a22b4dc8bfcd@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a7ce7d95-7c77-b087-372f-a22b4dc8bfcd@redhat.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
	(mx1.redhat.com [10.5.110.47]);
	Thu, 09 May 2019 08:01:06 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] [PATCH] blockdev-backup: don't check aio_context
 too early
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
Cc: aihua liang <aliang@redhat.com>, qemu-block@nongnu.org,
	qemu-devel@nongnu.org, qemu-stable@nongnu.org,
	Markus Armbruster <armbru@redhat.com>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 09.05.2019 um 00:55 hat John Snow geschrieben:
> 
> On 5/7/19 4:50 AM, Kevin Wolf wrote:
> > Am 06.05.2019 um 22:33 hat John Snow geschrieben:
> >> in blockdev_backup_prepare, we check to make sure that the target is
> >> associated with a compatible aio context. However, do_blockdev_backup is
> >> called later and has some logic to move the target to a compatible
> >> aio_context. The transaction version will fail certain commands
> >> needlessly early as a result.
> >>
> >> Allow blockdev_backup_prepare to simply call do_blockdev_backup, which
> >> will ultimately decide if the contexts are compatible or not.
> >>
> >> Note: the transaction version has always disallowed this operation since
> >> its initial commit bd8baecd (2014), whereas the version of
> >> qmp_blockdev_backup at the time, from commit c29c1dd312f, tried to
> >> enforce the aio_context switch instead. It's not clear, and I can't see
> >> from the mailing list archives at the time, why the two functions take a
> >> different approach. It wasn't until later in efd7556708b (2016) that the
> >> standalone version tried to determine if it could set the context or
> >> not.
> >>
> >> Reported-by: aihua liang <aliang@redhat.com>
> >> Fixes: https://bugzilla.redhat.com/show_bug.cgi?id=1683498
> > 
> > Signed-off-by is missing, and a testcase, too. :-)
> > 
> >> diff --git a/blockdev.c b/blockdev.c
> >> index 79fbac8450..a81d88980c 100644
> >> --- a/blockdev.c
> >> +++ b/blockdev.c
> >> @@ -1872,10 +1872,6 @@ static void blockdev_backup_prepare(BlkActionState *common, Error **errp)
> >>      }
> >>  
> >>      aio_context = bdrv_get_aio_context(bs);
> >> -    if (aio_context != bdrv_get_aio_context(target)) {
> >> -        error_setg(errp, "Backup between two IO threads is not implemented");
> >> -        return;
> >> -    }
> >>      aio_context_acquire(aio_context);
> >>      state->bs = bs;
> > 
> > The actual change looks good to me.
> > 
> > Kevin
> > 
> 
> (See the Red Hat BZ for details on the test I am more or less trying to
> replicate in iotests -- but the jist of it is using an iothread on one
> device and not specifying one for the other, then backing up both to two
> blockdev-add created nodes not attached to any device.)
> 
> Is there some trick to getting this to fail with accel=qtest? I'm
> noticing that if the VM is paused or if I use accel=qtest, the iothread
> contexts for the drives appear to go ... unresolved? and the test passes.
> 
> I've only had luck (so far) reproducing this with accel=kvm on a running
> VM (the drives can be empty) and I don't actually know why that is just
> yet -- I guess these aio_context objects get resolved at runtime?
> 
> Anyway, this seems to be a little tricky so far, maybe you have some
> advice for me?

Are you using virtio-blk? I think it only actually enables dataplane
(and moves its node to an iothread) during initialisation of the guest
driver. This makes it quite annoying for testing, I've had the same
problem before.

However, virtio-scsi does what you would expect and puts the node into
the right AioContext directly on creation.

So maybe just switching to virtio-scsi solves you problem?

> (Also note: doing a full backup and an incremental backup for two
> perfectly empty 64GB qcow2 drives takes over 6 seconds in total. It
> probably shouldn't, right? There's something about the initial backup
> that appears to take a pretty long time.)

Sounds like Someone (TM) should have a closer look, yes.

Kevin

