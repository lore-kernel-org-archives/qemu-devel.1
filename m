Return-Path: <SRS0=/2J2=CK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 145F9C433E6
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:42:49 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D43F2206EB
	for <qemu-devel@archiver.kernel.org>; Tue,  1 Sep 2020 13:42:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OKgo9R09"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D43F2206EB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:47728 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kD6Yh-0001Sz-O4
	for qemu-devel@archiver.kernel.org; Tue, 01 Sep 2020 09:42:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47378)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kD6Y9-0000se-1Z
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 09:42:13 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:40230
 helo=us-smtp-delivery-1.mimecast.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kD6Y6-0008WR-A4
 for qemu-devel@nongnu.org; Tue, 01 Sep 2020 09:42:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598967729;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8t2KtR5JsO9qirZO7Y4PIadgDAQIuiayrxiOu5+cJk4=;
 b=OKgo9R09L9PcBPOYdLdLQnzn+L5cCQqwroXxAsdEP8AcGGG9RpEiHmP40ND3RfBFFmSYXo
 EHg2RTavUCAP92w7IK3GphHjeZo76zq1p0ewY29ttg/a8MFLSwZconTIHFFPBR3/kl4Vex
 gOI0yRAorX2tXteei0MjZtZhZEBkHTE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-353-UxvANUlcOFGuQzpJWxAA2A-1; Tue, 01 Sep 2020 09:41:54 -0400
X-MC-Unique: UxvANUlcOFGuQzpJWxAA2A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 559AE10ABDB9;
 Tue,  1 Sep 2020 13:41:53 +0000 (UTC)
Received: from redhat.com (ovpn-114-215.ams2.redhat.com [10.36.114.215])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id F2ED85D9DD;
 Tue,  1 Sep 2020 13:41:49 +0000 (UTC)
Date: Tue, 1 Sep 2020 14:41:47 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 (BROKEN) 0/6] migration: bring improved
 savevm/loadvm/delvm to QMP
Message-ID: <20200901134147.GL345480@redhat.com>
References: <20200727150843.3419256-1-berrange@redhat.com>
 <877dtls8ux.fsf@dusky.pond.sub.org>
 <20200826182824.GA190807@redhat.com>
 <874koonyd0.fsf@dusky.pond.sub.org>
 <20200827113411.GP192458@redhat.com>
 <87d035ws1b.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <87d035ws1b.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=207.211.31.81; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-1.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/09/01 02:08:15
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Cc: Kevin Wolf <kwolf@redhat.com>, Peter Krempa <pkrempa@redhat.com>,
 "Denis V. Lunev" <den@virtuozzo.com>, qemu-block@nongnu.org,
 Juan Quintela <quintela@redhat.com>, qemu-devel@nongnu.org,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>, Max Reitz <mreitz@redhat.com>,
 John Snow <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Tue, Sep 01, 2020 at 03:22:24PM +0200, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Thu, Aug 27, 2020 at 01:04:43PM +0200, Markus Armbruster wrote:
> >> Daniel P. Berrangé <berrange@redhat.com> writes:
> >> 
> >> > On Wed, Aug 26, 2020 at 05:52:06PM +0200, Markus Armbruster wrote:
> >> > From the POV of practicality, making a design that unifies internal
> >> > and external snapshots is something I'm considering out of scope.
> >> > It increases the design time burden, as well as implementation burden.
> >> > On my side, improving internal snapshots is a "spare time" project,
> >> > not something I can justify spending weeks or months on.
> >> 
> >> I'm not demanding a solution that unifies internal and external
> >> snapshots.  I'm asking for a bit of serious thought on an interface that
> >> could compatibly evolve there.  Hours, not weeks or months.
> >> 
> >> > My goal is to implement something that is achievable in a short
> >> > amount of time that gets us out of the hole we've been in for 10
> >> > years. Minimal refactoring of the internal snapshot code aside
> >> > from fixing the critical limitations we have today around choice
> >> > of disks to snapshot.
> >> >
> >> > If someone later wants to come up with a grand unified design
> >> > for everything that's fine, we can deprecate the new QMP commands
> >> > I'm proposing now.
> >> 
> >> Failing at coming up with an interface that has a reasonable chance to
> >> be future-proof is okay.
> >> 
> >> Not even trying is not okay.
> >
> > This was raised in my v1 posting:
> >
> >   https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg01346.html
> >
> > but the conclusion was that it was a non-trivial amount of extra
> > implementation work
> 
> Thanks for the pointer.  I've now read that review thread.
> 
> >> Specifically, I'd like you to think about monolothic snapshot command
> >> (internal snapshots only by design) vs. transaction of individual
> >> snapshot commands (design is not restricted to internal snapshots, but
> >> we may want to accept implementation restrictions).
> >> 
> >> We already have transactionable individual storage snapshot commands.
> >> What's missing is a transactionable machine state snapshot command.
> >
> > At a high level I consider what I've proposed as being higher level
> > syntax sugar vs a more generic future impl based on multiple commands
> > for snapshotting disk & state. I don't think I'd claim that it will
> > evolve to become the design you're suggesting here, as they are designs
> > from different levels in the stack. IOW, I think the would ultimately
> > just exist in parallel. I don't think that's a real problem from a
> > maint POV, as the large burden from the monolithic snapshot code is
> > not the HMP/QMP interface, but rather the guts of the internal
> > impl in the migration/savevm.c and block/snapshot.c files. That code
> > will exist for as long as the HMP commands exist, and adding a QMP
> > interface doesn't make that situation worse unless we were intending
> > to drop the existing HMP commands. If we did change our minds though,
> > we can just deprecate the QMP command at any time we like.
> >
> >
> >> One restriction I'd readily accept at this time is "the machine state
> >> snapshot must write to a QCOW2 that is also internally snapshot in the
> >> same transaction".
> >> 
> >> Now explain to me why this is impractical.
> >
> > The issues were described by Kevin here:
> >
> >   https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg02057.html
> >
> > Assuming the migration impl is actually possible to solve, there is
> > still the question of actually writing it. That's a non-trivial
> > amount of work someone has to find time for.
> 
> Kevin explained how the transactionable machine state snapshot command
> should be made non-blocking: post-copy.
> 
> I don't dispute that creating such a post-copy snapshot is a non-trivial
> task.  It is out of reach for you and me.  I didn't actually ask for it,
> though.
> 
> You argue that providing a blocking snapshot in QMP is better than
> nothing, and good enough for quite a few applications.  I agree!  I
> blocked prior attempts at porting HMP's savevm/loadvm to QMP not because
> they were blocking, but because they stuck to the HMP interface, and the
> HMP interface is bonkers.  I would accept the restriction "snapshotting
> machine state is blocking, i.e. it stops the machine."  As I wrote in
> 2016, "Limitations: No live internal machine snapshot, yet."

FYI, when I documented the new QAPI commands I implemented, i choose to
*not* say that the snapshot is blocking. Instead I said:

  # Applications should not assume that the snapshot load is complete
  # when this command returns. Completion is indicated by the job
  # status. Clients can wait for the JOB_STATUS_CHANGE event. If the
  # job aborts, errors can be obtained via the 'query-jobs' command,
  # though.

The idea was that if we fix these QAPI commands to not block in future,
we want to minimize the risk of breaking clients, by discouraging them
from assuming the impl will always be blocking in future. IOW they
should assume the commands are asynchronous right now, even though they
are not.

> Aside: unless I'm mistaken, taking an internal block device snapshot is
> also blocking, but unlike taking a machine state snapshot, it's fast
> enough for the blocking not to matter.  That's the "sync" in
> blockdev-snapshot-internal-sync.


> Let me elaborate a bit on the desugaring, just to make sure we're on the
> same page.  Please correct me where I'm talking nonsense.
> 
> snapshot-save creates job that snapshots a set of block devices and the
> machine state.  The snapshots are consistent, i.e. they are all taken at
> the same point in time.  The block device snapshots are all internal.
> The machine state snapshot is saved together with one of the (internal)
> block device snapshots.

Yep

> This is basically a transaction of blockdev-snapshot-internal-sync
> (which exists) plus machine-snapshot-internal-sync (which doesn't exist)
> wrapped in a job.

Yes, except it isn't clear to me whether you can separate out the
functionality into two separate commands. It might be neccessary
to save the vmstate at the same time as the disk snapshot. In such
a case, instead of machine-snapshot-internal-sync, we might end up
having a "include vmstate" bool option to blockdev-snapshot-internal-sync
Either way though, we'd end up with a series of commands inside a
transaction.

> Likweise or snapshot-load, except there not even the command for block
> snapshots exists.
> 
> I doubt creating the (transactionable, but blocking) low-level commands
> is actually out of reach.  It's a matter of adding interfaces to parts
> of the code you already got working.

If we're splitting it up into one command per disk, and another command
for vmstate, then it will require refactoring the current migration/savevm.c
and block/snapshot.c code AFAICT, because its all written around the idea
of processing all disks at the same time.

> I'm not demanding you do that, though.  As I said, my chief concerns are
> keeping "bonkers" out of QMP, and not boxing us in needlessly.

Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


