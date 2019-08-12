Return-Path: <SRS0=mi2X=WI=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3172CC31E40
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:50:26 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 01EEF2067D
	for <qemu-devel@archiver.kernel.org>; Mon, 12 Aug 2019 16:50:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 01EEF2067D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47282 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hxDWb-000679-A6
	for qemu-devel@archiver.kernel.org; Mon, 12 Aug 2019 12:50:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:56850)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <kwolf@redhat.com>) id 1hxDWC-0005Yy-CQ
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:50:01 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <kwolf@redhat.com>) id 1hxDWB-0003Fp-9H
 for qemu-devel@nongnu.org; Mon, 12 Aug 2019 12:50:00 -0400
Received: from mx1.redhat.com ([209.132.183.28]:54136)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <kwolf@redhat.com>)
 id 1hxDW8-0003EY-B8; Mon, 12 Aug 2019 12:49:56 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 0C2AB3E806;
 Mon, 12 Aug 2019 16:49:54 +0000 (UTC)
Received: from localhost.localdomain (ovpn-116-66.ams2.redhat.com
 [10.36.116.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C5D4C5C54A;
 Mon, 12 Aug 2019 16:49:29 +0000 (UTC)
Date: Mon, 12 Aug 2019 18:49:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>
Message-ID: <20190812164928.GC6400@localhost.localdomain>
References: <6826e3c2-bc6e-b2a2-1bf1-3ed31079f0ee@virtuozzo.com>
 <20190812132352.GA6400@localhost.localdomain>
 <1b4f5b7c-ca3c-365d-f4ec-d3009b0bde59@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1b4f5b7c-ca3c-365d-f4ec-d3009b0bde59@virtuozzo.com>
User-Agent: Mutt/1.11.3 (2019-02-01)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Mon, 12 Aug 2019 16:49:54 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] backup bug or question
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
Cc: John Snow <jsnow@redhat.com>, qemu-devel <qemu-devel@nongnu.org>,
 qemu block <qemu-block@nongnu.org>, Max Reitz <mreitz@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Am 12.08.2019 um 18:09 hat Vladimir Sementsov-Ogievskiy geschrieben:
> 12.08.2019 16:23, Kevin Wolf wrote:
> > Am 09.08.2019 um 15:18 hat Vladimir Sementsov-Ogievskiy geschrieben:
> >> Hi!
> >>
> >> Hmm, hacking around backup I have a question:
> >>
> >> What prevents guest write request after job_start but before setting
> >> write notifier?
> >>
> >> code path:
> >>
> >> qmp_drive_backup or transaction with backup
> >>
> >>      job_start
> >>         aio_co_enter(job_co_entry) /* may only schedule execution, isn't it ? */
> >>
> >> ....
> >>
> >> job_co_entry
> >>      job_pause_point() /* it definitely yields, isn't it bad? */
> >>      job->driver->run() /* backup_run */
> >>
> >> ----
> >>
> >> backup_run()
> >>      bdrv_add_before_write_notifier()
> >>
> >> ...
> >>
> >> And what guarantees we give to the user? Is it guaranteed that write notifier is
> >> set when qmp command returns?
> >>
> >> And I guess, if we start several backups in a transaction it should be guaranteed
> >> that the set of backups is consistent and correspond to one point in time...
> > 
> > Do the patches to switch backup to a filter node solve this
> > automatically because that node would be inserted in
> > backup_job_create()?
> > 
> 
> Hmm, great, looks like they should. At least it moves scope of the
> problem to do_drive_backup and do_blockdev_backup functions..
> 
> Am I right that aio_context_acquire/aio_context_release guarantees no
> new request created during the section? Or should we add
> drained_begin/drained_end pair, or at least drain() at start of
> qmp_blockdev_backup and qmp_drive_backup?

Holding the AioContext lock should be enough for this.

But note that it doesn't make a difference if new requests are actually
incoming. The timing of the QMP command to start a backup job versus the
timing of guest requests is essentially random. QEMU doesn't know what
guest requests you mean to be included in the backup and which you don't
unless you stop sending new requests well ahead of time.

If you send a QMP request to start a backup, the backup will be
consistent for some arbitrary point in time between the time that you
sent the QMP request and the time that you received the reply to it.

Draining in the QMP command handler wouldn't change any of this, because
even the drain section starts at some arbitrary point in time.

> Assume scenario like the this,
> 
> 1. fsfreeze
> 2. qmp backup
> 3. fsthaw
> 
> to make sure that backup starting point is consistent. So in our qmp command we should:
> 1. complete all current requests to make drives corresponding to fsfreeze point
> 2. initialize write-notifiers or filter before any new guest request, i.e. before fsthaw,
> i.e. before qmp command return.

If I understand correctly, fsfreeze only returns success after it has
made sure that the guest has quiesced the device. So at any point
between receiving the successful return of the fsfreeze and calling
fsthaw, the state should be consistent.

> Transactions should be OK, as they use drained_begin/drained_end
> pairs, and additional aio_context_acquire/aio_context_release pairs.

Here, draining is actually important because you don't synchronise
against something external that you don't control anyway, but you just
make sure that you start the backup of all disks at the same point in
time (which is still an arbitrary point between the time that you send
the transaction QMP command and the time that you receive success), even
if no fsfreeze/fsthaw was used.

Kevin

