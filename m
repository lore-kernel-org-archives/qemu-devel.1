Return-Path: <SRS0=H0ck=CE=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82722C433DF
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:29:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3200B20737
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2020 18:29:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UuUr0XAN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3200B20737
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50632 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kB0BF-0001FC-Cy
	for qemu-devel@archiver.kernel.org; Wed, 26 Aug 2020 14:29:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:55800)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kB0AE-0000DH-Ti
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 14:28:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:51502)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_CBC_SHA1:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1kB0A9-0007b6-La
 for qemu-devel@nongnu.org; Wed, 26 Aug 2020 14:28:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1598466523;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+paFAaEDiUUK3T6U8/uTfm9aHXWUJmAKUiyarpno+yE=;
 b=UuUr0XAN31TvYgmwzaXBL4n/JMOaxEkbqaCFR6hC9NiYtP+4hPOXq5pYsqGBBDsvS/5ekq
 cObrDxc+yHydfnIC8Fi7lnrsozpDdq8ijotLCfVm+4iJ50Ic0YsjOWMG/idEmnwIgcJsh4
 Sac7743W/VSRw1dnQ1abujSvnjfj6zw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-gm-9V9cEPnCYLogU0rD-6Q-1; Wed, 26 Aug 2020 14:28:32 -0400
X-MC-Unique: gm-9V9cEPnCYLogU0rD-6Q-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8BB610082EB;
 Wed, 26 Aug 2020 18:28:30 +0000 (UTC)
Received: from redhat.com (ovpn-114-142.ams2.redhat.com [10.36.114.142])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A0B6C704AE;
 Wed, 26 Aug 2020 18:28:27 +0000 (UTC)
Date: Wed, 26 Aug 2020 19:28:24 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 (BROKEN) 0/6] migration: bring improved
 savevm/loadvm/delvm to QMP
Message-ID: <20200826182824.GA190807@redhat.com>
References: <20200727150843.3419256-1-berrange@redhat.com>
 <877dtls8ux.fsf@dusky.pond.sub.org>
MIME-Version: 1.0
In-Reply-To: <877dtls8ux.fsf@dusky.pond.sub.org>
User-Agent: Mutt/1.14.6 (2020-07-11)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=berrange@redhat.com
X-Mimecast-Spam-Score: 0.005
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Received-SPF: pass client-ip=63.128.21.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/26 14:05:19
X-ACL-Warn: Detected OS   = Linux 2.2.x-3.x [generic] [fuzzy]
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.959,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Aug 26, 2020 at 05:52:06PM +0200, Markus Armbruster wrote:
> Sorry for taking so long to reply.
> 
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > A followup to:
> >
> >  v1: https://lists.gnu.org/archive/html/qemu-devel/2020-07/msg00866.html
> >
> > When QMP was first introduced some 10+ years ago now, the snapshot
> > related commands (savevm/loadvm/delvm) were not converted. This was
> > primarily because their implementation causes blocking of the thread
> > running the monitor commands. This was (and still is) considered
> > undesirable behaviour both in HMP and QMP.
> 
> One of several reasons.
> 
> > In theory someone was supposed to fix this flaw at some point in the
> > past 10 years and bring them into the QMP world. Sadly, thus far it
> > hasn't happened as people always had more important things to work
> > on. Enterprise apps were much more interested in external snapshots
> > than internal snapshots as they have many more features.
> 
> Several attempts have been made to bring the functionality to QMP.
> Sadly, they went nowhere.
> 
> I posted an analysis of the issues in reply to one of the more serious
> attempts:
> 
>     Message-ID: <87lh7l783q.fsf@blackfin.pond.sub.org>
>     https://lists.nongnu.org/archive/html/qemu-devel/2016-01/msg03593.html
> 
> I'd like to hear your take on it.  I append the relevant part for your
> convenience.  Perhaps your code is already close to what I describe
> there.  I'm interested in where it falls short.
> 
> > Meanwhile users still want to use internal snapshots as there is
> > a certainly simplicity in having everything self-contained in one
> > image, even though it has limitations. Thus the apps that end up
> > executing the savevm/loadvm/delvm via the "human-monitor-command"
> > QMP command.
> >
> > IOW, the problematic blocking behaviour that was one of the reasons
> > for not having savevm/loadvm/delvm in QMP is experienced by applications
> > regardless. By not portting the commands to QMP due to one design flaw,
> > we've forced apps and users to suffer from other design flaws of HMP (
> > bad error reporting, strong type checking of args, no introspection) for
> > an additional 10 years. This feels rather sub-optimal :-(
> >
> > In practice users don't appear to care strongly about the fact that these
> > commands block the VM while they run. I might have seen one bug report
> > about it, but it certainly isn't something that comes up as a frequent
> > topic except among us QEMU maintainers. Users do care about having
> > access to the snapshot feature.
> >
> > Where I am seeing frequent complaints is wrt the use of OVMF combined
> > with snapshots which has some serious pain points. This is getting worse
> > as the push to ditch legacy BIOS in favour of UEFI gain momentum both
> > across OS vendors and mgmt apps. Solving it requires new parameters to
> > the commands, but doing this in HMP is super unappealing.
> >
> > After 10 years, I think it is time for us to be a little pragmatic about
> > our handling of snapshots commands. My desire is that libvirt should never
> > use "human-monitor-command" under any circumstances, because of the
> > inherant flaws in HMP as a protocol for machine consumption.
> >
> > Thus in this series I'm proposing a fairly direct mapping of the existing
> > HMP commands for savevm/loadvm/delvm into QMP as a first step. This does
> > not solve the blocking thread problem, but it does put in a place a
> > design using the jobs framework which can facilitate solving it later.
> > It does also solve the error reporting, type checking and introspection
> > problems inherant to HMP. So we're winning on 3 out of the 4 problems,
> > and pushed apps to a QMP design that will let us solve the last
> > remaining problem.
> >
> > With a QMP variant, we reasonably deal with the problems related to OVMF:
> >
> >  - The logic to pick which disk to store the vmstate in is not
> >    satsifactory.
> >
> >    The first block driver state cannot be assumed to be the root disk
> >    image, it might be OVMF varstore and we don't want to store vmstate
> >    in there.
> 
> Yes, this is one of the issues.  Glad you're addressing it.
> 
> >  - The logic to decide which disks must be snapshotted is hardwired
> >    to all disks which are writable
> >
> >    Again with OVMF there might be a writable varstore, but this can be
> >    raw rather than qcow2 format, and thus unable to be snapshotted.
> >    While users might wish to snapshot their varstore, in some/many/most
> >    cases it is entirely uneccessary. Users are blocked from snapshotting
> >    their VM though due to this varstore.
> 
> Another one.  Glad again.
> 
> > These are solved by adding two parameters to the commands. The first is
> > a block device node name that identifies the image to store vmstate in,
> > and the second is a list of node names to include for the snapshots.
> > If the list of nodes isn't given, it falls back to the historical
> > behaviour of using all disks matching some undocumented criteria.
> >
> > In the block code I've only dealt with node names for block devices, as
> > IIUC, this is all that libvirt should need in the -blockdev world it now
> > lives in. IOW, I've made not attempt to cope with people wanting to use
> > these QMP commands in combination with -drive args.
> >
> > I've done some minimal work in libvirt to start to make use of the new
> > commands to validate their functionality, but this isn't finished yet.
> >
> > My ultimate goal is to make the GNOME Boxes maintainer happy again by
> > having internal snapshots work with OVMF:
> >
> >   https://gitlab.gnome.org/GNOME/gnome-boxes/-/commit/c486da262f6566326fbcb5e=
> > f45c5f64048f16a6e
> >
> > HELP NEEDED:  this series starts to implement the approach that Kevin
> > suggested wrto use of generic jobs.
> 
> Does this mean you're trying to use the jobs infrastructure?

Yes, this is working now.


> Relevant part of Message-ID: <87lh7l783q.fsf@blackfin.pond.sub.org>
> 
> If we can't make a sane QMP interface, I'd rather have no QMP interface.

I strongly disagree with this. This absolutist position is why we
have made zero progress in 10+ years, leaving mgmt apps suffering
with HMP passthrough, as described above. 

This is a prime example of perfect being the enemy of good.

> However, I believe we *can* make a sane QMP interface if we put in the
> design work.

We should make a credible attempt at QMP design, but if perfection
isn't practical, we should none the less do *something* in QMP, even
if we find we need to deprecate & replace it later.

> The design work must start with a review of what we're trying to
> accomplish, and how to fit it into the rest of the system.  Here's my
> attempt.  Since my knowledge on snapshots is rather superficial, I'm
> cc'ing Kevin for additional snapshot expertise.  Kevin, please correct
> me when I talk nonsense.  I'm further cc'ing Eric and Peter for the
> management layer perspective.

The things I'm trying to accomplish as listed in the text above.
Primarily this is about fixing the ability to snapshot guests where
QEMU's heuristics for picking block devices is broken. ie explicitly
list the disks to snapshot and which to store vmstate in.

Converting from HMP to QMP is esentially an enabler, because adding
new args to existing savevm/loadvm HMP commands is just too horrible
to contemplate, as mgmt apps have no sane way to probe HMP. That's
what QMP is for.

Essentially the goal is to fix the inability to use internal snapshots
with UEFI based VMs that is causing immediate pain for mgmt apps due
to increased need to support UEFI.

> A point-in-time snapshot of a system consists of a snapshot of its
> machine state and snapshots of its storage.  All the snapshots need to
> be made at the same point in time for the result to be consistent.
> 
> Snapshots of read-only storage carry no information and are commonly
> omitted.
> 
> Isolated storage snapshots can make sense, but snapshotting the machine
> state without also snapshotting the machine's storage doesn't sound
> useful to me.
> 
> Both storage and machine state snapshots come in two flavours: internal
> and external.
> 
> External ones can be made with any block backend, but internal storage
> snapshots work only with certain formats, notably qcow2.  QMP supports
> both kinds of storage snapshots.
> 
> Both kinds of storage snapshots need exclusive access while they work.
> They're relatively quick, but the delay could be noticable for large
> internal snapshots, and perhaps for external snapshots on really slow
> storage.
> 
> Internal machine state snapshots are currently only available via HMP's
> savevm, which integrates internal machine state and storage snapshots.
> This is non-live, i.e. the guest is stopped while the snapshot gets
> saved.  I figure we could make it live if we really wanted to.  Another
> instance of the emerging background job concept.
> 
> On the implementation level, QCOW2 can't currently store a machine state
> snapshot without also storing a storage snapshot.  I guess we could
> change this if we really wanted to.
> 
> External machine state snapshots are basically migrate to file.
> Supported by QMP.
> 
> Live migration to file is possible, but currently wastes space, because
> memory dirtied during migration gets saved multiple times.  Could be
> fixed either by making migration update previously saved memory instead
> of appending (beware, random I/O), or by compacting the file afterwards.
> 
> Non-live migration to file doesn't waste space that way.
> 
> To take multiple *consistent* snapshots, you have to bundle them up in a
> transaction.  Transactions currently support only *storage* snapshots,
> though.
> 
> Work-around for external machine state snapshot: migrate to file
> (possibly live), leaving the guest sopped on completion, take storage
> snapshots, resume guest.
> 
> You can combine internal and external storage snapshots with an external
> machine state snapshot to get a mixed system snapshot.
> 
> You currently can't do that with an internal machine state snapshot: the
> only way to take one is HMP savevm, which insists on internally
> snapshotting all writable storage, and doesn't transact together with
> external storage snapshots.
> 
> Except for the case "purely internal snapshot with just one writable
> storage device", a system snapshot consists of multiple parts stored in
> separate files.  Tying the parts together is a management problem.  QEMU
> provides rudimentary management for purely internal snapshots, but it's
> flawed: missing storage isn't detected, and additional storage can creep
> in if snapshot tags or IDs happen to match.  I guess managing the parts
> is better left to the management layer.
> 
> I figure a fully general QMP interface would let you perform a system
> snapshot by combining storage snapshots of either kind with either kind
> of machine state snapshot.
> 
> We already have most of the building blocks: we can take external and
> internal storage snapshots, and combine them in transactions.
> 
> What's missing is transactionable machine state snapshots.
> 
> We know how to work around it for external machine state snapshots (see
> above), but a transaction-based solution might be nicer.
> 
> Any solution for internal machine state snapshots in QMP should at least
> try to fit into this.  Some restrictions are okay.  For instance, we
> probably need to restrict internal machine state snapshots to piggyback
> on an internal storage snapshot for now, so we don't have to dig up
> QCOW2 just to get QMP support.

From the POV of practicality, making a design that unifies internal
and external snapshots is something I'm considering out of scope.
It increases the design time burden, as well as implementation burden.
On my side, improving internal snapshots is a "spare time" project,
not something I can justify spending weeks or months on.

My goal is to implement something that is achievable in a short
amount of time that gets us out of the hole we've been in for 10
years. Minimal refactoring of the internal snapshot code aside
from fixing the critical limitations we have today around choice
of disks to snapshot.

If someone later wants to come up with a grand unified design
for everything that's fine, we can deprecate the new QMP commands
I'm proposing now.

> We can talk about more convenient interfaces for common special cases,
> but I feel we need to design for the general case.  We don't have to
> implement the completely general case right away, though.  As long as we
> know where we want to go, incremental steps towards that goal are fine.
> 
> Can we create a transactionable QMP command to take an internal machine
> state snapshot?
> 
> This would be like HMP savevm with the following differences:
> 
> * Separate parameters for tag and ID.  I'll have none of this
>   overloading nonsense in QMP.
> 
> * Specify the destination block device.  I'll have none of this "pick a
>   device in some magic, undocumented way" in QMP.
> 
> * Leave alone the other block devices.  Adding transaction actions to
>   snapshot all the writable block devices to get a full system snapshot
>   is the user's responsibility.
> 
> Limitations:
> 
> * No live internal machine snapshot, yet.
> 
> * The storage device taking the internal snapshot must also be
>   internally snapshot for now.  In fact, the command does both
>   (tolerable wart).
> 
> Open questions:
> 
> * Do we want the QMP command to delete existing snapshots with
>   conflicting tag / ID, like HMP savevm does?  Or do we want it to fail
>   the transaction?

The intent is for the QMP commands to operate exclusively on
'tags', and never consider "ID".

> * Do we need transactions for switching to a system snapshot, too?
> 
> Opinions?



Regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


