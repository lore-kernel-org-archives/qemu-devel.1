Return-Path: <SRS0=GSUr=WR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 458F2C3A59E
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 21:22:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EAF28206DD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Aug 2019 21:21:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EAF28206DD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35434 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i0Y3K-0006eX-Q2
	for qemu-devel@archiver.kernel.org; Wed, 21 Aug 2019 17:21:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:51764)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <jsnow@redhat.com>) id 1i0Y15-00059D-Fx
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 17:19:43 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <jsnow@redhat.com>) id 1i0Y11-0002NV-B3
 for qemu-devel@nongnu.org; Wed, 21 Aug 2019 17:19:39 -0400
Received: from mx1.redhat.com ([209.132.183.28]:22983)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <jsnow@redhat.com>)
 id 1i0Y0s-0002MA-PD; Wed, 21 Aug 2019 17:19:27 -0400
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id E0F273082149;
 Wed, 21 Aug 2019 21:19:25 +0000 (UTC)
Received: from [10.18.17.187] (dhcp-17-187.bos.redhat.com [10.18.17.187])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 31B671B5B4;
 Wed, 21 Aug 2019 21:19:21 +0000 (UTC)
To: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 Qemu-block <qemu-block@nongnu.org>
References: <5777a218-1ba4-78e0-ef73-bdfeecf04b25@redhat.com>
 <436c161e-fe05-da2c-835c-562da489ba82@virtuozzo.com>
From: John Snow <jsnow@redhat.com>
Openpgp: preference=signencrypt
Autocrypt: addr=jsnow@redhat.com; prefer-encrypt=mutual; keydata=
 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
Message-ID: <2cd9d887-0a14-771a-3cee-64f9a50056d1@redhat.com>
Date: Wed, 21 Aug 2019 17:19:21 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <436c161e-fe05-da2c-835c-562da489ba82@virtuozzo.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.42]); Wed, 21 Aug 2019 21:19:26 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 209.132.183.28
Subject: Re: [Qemu-devel] QEMU bitmap backup usability FAQ
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
Cc: Peter Krempa <pkrempa@redhat.com>,
 "libvir-list@redhat.com" <libvir-list@redhat.com>,
 qemu-devel <qemu-devel@nongnu.org>, Nir Soffer <nsoffer@redhat.com>,
 Nikolay Shirokovskiy <nshirokovskiy@virtuozzo.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>



On 8/21/19 10:21 AM, Vladimir Sementsov-Ogievskiy wrote:
> [CC Nikolay]
> 
> 21.08.2019 1:25, John Snow wrote:
>> Hi, downstream here at Red Hat I've been fielding some questions about
>> the usability and feature readiness of Bitmaps (and related features) in
>> QEMU.
>>
>> Here are some questions I answered internally that I am copying to the
>> list for two reasons:
>>
>> (1) To make sure my answers are actually correct, and
>> (2) To share this pseudo-reference with the community at large.
>>
>> This is long, and mostly for reference. There's a summary at the bottom
>> with some todo items and observations about the usability of the feature
>> as it exists in QEMU.
>>
>> Before too long, I intend to send a more summarized "roadmap" mail which
>> details all of the current and remaining work to be done in and around
>> the bitmaps feature in QEMU.
>>
>>
>> Questions:
>>
>>> "What format(s) is/are required for this functionality?"
>>
>>  From the QEMU API, any format can be used to create and author
>> incremental backups. The only known format limitations are:
>>
>> 1. Persistent bitmaps cannot be created on any format except qcow2,
>> although there are hooks to add support to other formats at a later date
>> if desired.
>>
>> DANGER CAVEAT #1: Adding bitmaps to QEMU by default creates transient
>> bitmaps instead of persistent ones.
>>
>> Possible TODO: Allow users to 'upgrade' transient bitmaps to persistent
>> ones in case they made a mistake.
> 
> I doubt, as in my opinion real users of Qemu are not people but libvirt, which
> should never make such mistake.
> 

Right, that's largely been the consensus here; but there is some concern
that libvirt might not be the only user of QEMU, so I felt it was worth
documenting some of the crucial moments where it was "easy" to get it wrong.

I think like it or not, the API that QEMU presents has to be considered
on its own without libvirt because it's not a given that libvirt will
forever and always be the only user of QEMU.

I do think that any problems of this kind that can be solved in libvirt
are not immediate, crucial action items. libvirt WILL be the major user
of these features.

However, try as we might, releasing a set of primitive operations that
offer 998 ways to corrupt your data and 2 ways to manage it correctly
are going to provoke some questions from people who are trying to work
with that API, including from libvirt developers.

It might be the conclusion that it's libvirt's job to safeguard the user
from themselves, but we at least need to present consistent and clear
information about the way we expect/anticipate people to use the APIs,
because people DO keep asking me about several of these issues and the
usability problems they perceive with the QEMU API.

So this thread was largely in attempt to explore what some "solutions"
to perceived problems look like, mostly to come to the conclusion that
the actual "must-haves" list in QEMU is not very long compared to the
"nice-to-haves?" list.

>>
>>
>> 2. When using push backups (blockdev-backup, drive-backup), you may use
>> any format as a target format. >
>> DANGER CAVEAT #2: without backing file and/or filesystem-less sparse
>> support, these images will be unusable.
> 
> You mean incremental backups of course, as the whole document is about bitmaps.
> 

Ah, yes, incremental push backups. Full backups are of course not a
problem. :)

>>
>> EXAMPLE: Backing up to a raw file loses allocation information, so we
>> can no longer distinguish between zeroes and unallocated regions. The
>> cluster size is also lost. This file will not be usable without
>> additional metadata recorded elsewhere.*
>>
>> (* This is complicated, but it is in theory possible to do a push backup
>> to e.g. an NBD target with custom server code that saves allocation
>> information to a metadata file, which would allow you to reconstruct
>> backups. For instance, recording in a .json file which extents were
>> written out would allow you to -- with a custom binary -- write this
>> information on top of a base file to reconstruct a backup.)
>>
>>
>> 3. Any format can be used for either shared storage or live storage
>> migrations. There are TWO distinct mechanisms for migrating bitmaps:
>>
>> A) The bitmap is flushed to storage and re-opened on the destination.
>> This is only supported for qcow2 and shared-storage migrations.
> 
> cons: flushing/reopening is done during migration downtime, so if you have
> a lot of bitmap data (for example, 64k granulared bitmap for 16tb disk is
> ~30MB, and there may be several bitmaps) downtime will become long.
> 

Worth documenting the drawback, yes.

>>
>> B) The bitmap is live-migrated to the destination. This is supported for
>> any format and can be used for either shared storage or live storage
>> migrations.
>>
>> DANGER CAVEAT #3: The second bitmap migration technique there is an
>> optional migration capability that must be enabled explicitly.
>> Otherwise, some migration combinations may drop bitmaps.
> 
> Also, bad thing may happen if we try to migrate persistent bitmap to not qcow2.
> 
> Also, with enabled capability, flushing/reopening is automatically disabled.
> 

Yes, worth documenting (for developers and power users doing performance
tuning) that at present we "prefer" the capability whenever it is
enabled and conflicts with the persistence technique.

>>
>> Matrix:
>>
>>> migrate = migrate_capability or (persistent and shared_storage)
>>
>> Enumerated:
>>
>> live storage + raw : transient + no-capability: Dropped
>> live-storage + raw : transient + bm-capability: Migrated
>> live-storage + qcow2 : transient + no-capability: Dropped
>> live-storage + qcow2 : transient + bm-capability: Migrated
>> live-storage + qcow2 : persistent + no-capability: Dropped (!)
>> live-storage + qcow2 : persistent + bm-capability: Migrated
>>
>> shared-storage + raw : transient - no-capability: Dropped
>> shared-storage + raw : transient + bm-capability: Migrated
>> shared-storage + qcow2 : transient + no-capability: Migrated
> 
> Dropped you mean
> 

Argh, whoops. Yes. Thank you for spotting this.

I should document this on bitmaps.rst, too.

>> shared-storage + qcow2 : transient + bm-capability: Migrated
>> shared-storage + qcow2 : persistent + no-capability: Migrated
>> shared-storage + qcow2 : persistent + bm-capability: Migrated
>>
>> Enabling the bitmap migration capability will ALWAYS migrate the bitmap.
>> If it's disabled, we will only migrate the bitmaps for shared storage
>> migrations where the bitmap is persistent, which is a qcow2-only case.
>>
>> There is no warning or error if you attempt to migrate in a manner that
>> loses your bitmaps.
>>
>> (I might be persuaded to add a case for when you are doing a live
>> storage migration of qcow2 with persistent bitmaps, which is somewhat a
>> conflicting case: you've asked for the bitmap to be persistent, but it
>> seems likely that if this ever happens in practice, it's because you
>> have neglected to ask for it to be migrated to the new host.)
>>
>> See iotest 169 for more details on this.
>>
>> At present, these are the only format limitations I am consciously aware
>> of. From a management API/GUI perspective, it makes sense to restrict
>> the feature set to "qcow2 only" to minimize edge cases.
>>
>>
>>> "Is libvirt aware of these 'gotcha' cases?"
>>
>>  From talks I've had with Eric Blake and Peter Krempa, they certainly are
>> now.
>>
>>
>>> "Is it possible to make persistent the default?"
>>
>> Not quickly.
>>
>> In QEMU, not without a deprecation period or some other incompatibility.
>> Default values are not (yet?) introspectable via the schema. We need
>> (possibly) up to two QAPI extensions:
>>
>> I) The ability to return deprecation warnings when issuing a command
>> that will cease to work in the future.
>>
>> This has been being discussed somewhat on-list recently. It seems like
>> there is not a big appetite for tackling something perceived as
>> low-value because it is likely to be ignored.
>>
>> II) The ability to document default values in the QAPI schema for the
>> purposes of introspection.
>>
>> With one or both of these extensions, we could remove the default value
>> for persistence and promote it to a required argument with a
>> transitionary period where it will work with a warning. Then, in the
>> future, users will be forced to specify if they want persistent=true or
>> persistent=false.
>>
>> This is not on my personal roadmap to implement.
>>
>>
>>> "Is it possible to make bitmap migration the default?"
>>
>> I don't know at present. Migration capabilities are either "on" or "off"
>> and the existing negotiation mechanisms for capabilities are extremely
>> rudimentary.
>>
>> Changing this might require fiddling with machine compat properties,
>> adding features to the migration protocol, or more. I don't know what I
>> don't know, so I will estimate this change as likely invasive.
>>
>> I've discussed this with David Gilbert and it seems like a complicated
>> project for the benefit of this sub-project alone, so this isn't on my
>> personal roadmap to resolve.
>>
>> The general consensus appears to be that protecting the user is
>> libvirt's job.
>>
>>
>>> "Where do we stand with external snapshot support?"
>>
>> Still broken. In the aftermath of 4.1, it's the most obvious outstanding
>> broken feature. Vladimir has patches to fix it, but they need some
>> attention.
> 
> You mean "[PATCH v4 00/10] qcow2-bitmaps: rewrite reopening logic"
> yes, reviews are welcome.
> 

Yes! This is the only outstanding patch series on my radar right now. I
had been avoiding reviewing the reopen mechanism rework because I didn't
want to "distract" with a non-comprehensive review, but I think I'll
just jump in to get it moving again.

>>
>>
>>> "What needs to happen to bitmaps when doing stream or commit?"
>>
>> Uncertain in QEMU; creating an external snapshot implicitly ends the
>> timeslice represented by the old bitmap, but an explicit checkpoint is
>> better.
> 
> With recent patches to QAPI we moved to the following way:
> Qemu don't care and don't do any magic around bitmaps automatically, so
> bitmap is staying at the same node and do its work. So, ofcourse, if we commit top
> to base, enabled bitmaps in base will track all writes of this commit job. And same
> thing with stream job. So if user wants, it should move, copy, enable/disable bitmaps
> as desired by hand.
> 

Yes, I think that's the right answer as far as libvirt is concerned. The
only caveat is how difficult it is to enable/disable bitmaps that aren't
in the top layer for the purposes of fine-grained control over commit
with bitmaps, which I discuss more later in the mail.

>>
>> I think some little ascii charts will help people understand what we're
>> talking about here, so let's cover some examples.
>>
>>
>> SCENARIO 1)
>>
>> Here's a timeline for a single node (one image, no backing files), with
>> some points in time highlighted:
>>
>> Time T = 0.........................n
>> +rec:    [--X------Y------Z--------]
>> -rec:    [---------x------y--------]
>> region:  [aabbbbbbbcccccccddddddddd]
>>
>>
>> X, Y, and Z are points in time where bitmaps 'x', 'y', and 'z' were
>> created and began recording. x and y are points in time where bitmaps
>> 'x' and 'y' stopped recording.
>>
>> This creates a few distinct regions / timeslices.
>>
>> a: Data written before we began tracking writes.
>> b: Data written to bitmap 'x'
>> c: Data written to bitmap 'y'
>> d: data written to bitmap 'z'
>>
>> region 'a' is of an unknown size and indeterminate length, because there
>> is no reference point (checkpoint) prior to it.
>>
>> regions 'b' and 'c' are of finite size and determinate length, because
>> they have fixed reference points on either sides of their timeslice.
>>
>> region 'd' is also of an unknown size and indeterminate length, because
>> it is actively recording and has no checkpoint to its right. It may be
>> fixed at any time by disabling bitmap 'z'.
>>
>> In QEMU, generally what we want to do is to do several things at one
>> atomic moment to keep these regions adjacent, contiguous, and disjoint.
>> So from a high-level (using a fictional simplified syntax), we do:
>>
>> Transaction(
>>      create('y'),
>>      disable('x'),
>>      backup('x')
>> )
>>
>> which together performs a backup+checkpoint.
>>
>> We can do a backup without a checkpoint:
>>
>> 4.1:
>> Transaction(
>>      create('tmp')
>>      merge('tmp', 'x')
>>      backup('tmp')
>> )
>>
>> 4.2:
>>> backup('x', bitmap_sync=never)
>>
>> Or a checkpoint without a backup:
>>
>> Transaction(
>>      create('y'),
>>      disable('x')
>> )
>>
>>
>> SCENARIO 2)
>>
>> Now, what happens when we make an external snapshot and do nothing at
>> all to our bitmaps?
>>
>> Time T = 0.......................................n
>> +rec:    [--X------Y------Z--------] <-- [-------]
>> -rec:    [---------x------y--------] <-- [-------]
>> region:  [aabbbbbbbcccccccddddddddd] <-- [eeeeeee]
>>           {          base           } <-- {  top  }
>>
>> We've created a new implicit timeslice, "e" without creating a new
>> bitmap. Because the bitmap 'z' was still active at the time of the
>> snapshot, it now has a temporarily-determinate endpoint to its region.
>>
>> This is kind of like an "implied checkpoint", but it's a very poor one
>> because it's not really addressable.
>>
>> DANGER CAVEAT #4: We have no way to create incremental backups anymore,
>> because the current moment in time has no addressable point.
>>
>> That's not great; but it is likely a fixable scenario when commit is
> 
> both commit and snapshot are to be fixed, or more precisely reopening bitmaps
> ro->rw and rw->ro are all broken.
> 

Yep. I have some tests I want to check in once we have more consensus on
your series. It's the last major outstanding piece for basic
comprehensive functionality, I think.

>> fixed: committing the top layer back down into the base layer will add
>> all new writes to the end of the old region; restoring our backup chain:
>>
>> Time T = 0.........................C.......n
>> +rec:    [--X------Y------Z-------- -------]
>> -rec:    [---------x------y-------- -------]
>> region:  [aabbbbbbbcccccccddddddddd ddddddd]
>>
>> Here, region 'e' just gets appended to region d, and we can make
>> incremental backups from any checkpoint X, Y, Z to the current moment again.
>>
>>
>> SCENARIO 3)
>>
>> What happens if we make a firm checkpoint at the same time we make the
>> snapshot?
>>
>> Transaction(
>>      disable('z'),
>>      snapshot('top'),
>>      create('w')
>> )
>>
>> Time T = 0.........................         ......n
>> +rec:    [--X------Y------Z-------- ] <-- [W------]
>> -rec:    [---------x------y--------z] <-- [-------]
>> region:  [aabbbbbbbcccccccddddddddd ] <-- [eeeeeee]
>>           {          base            } <-- {  top  }
>>
>> Now instead of the new region 'e' being implied, it's explicit. We can
>> make backups between any point and the current moment *across* the gap.
>>
>> It was my thought that this was the most preferable method that libvirt
>> should use, but there is some doubt from Peter Krempa. We'll see how it
>> shakes out.
>>
>>
>>
>> There are questions about what QEMU should do by default, without
>> libvirt's help. At the moment, it's "nothing" but there have been
>> questions about "something".
>>
>> Keeping in mind that we likely can't change our existing behavior
>> without some kind of flag, there are still some API/usability questions:
>>
>>
>>> If we create an external snapshot on top of an image with actively
>>> recording bitmaps, should we disable them?
>>
>> We can leave them enabled, but they'll never see any writes. Or we can
>> explicitly disable them. Explicitly disabling them may make more sense
>> to prevent modifying bitmaps accidentally on commit.
>>
>> My guess: No. we should leave them alone; allow checkpoint creation
>> mechanisms to do the disable+create dance for bitmaps as needed.
> 
> Agreed: No. We've exposed APIs for the user to enable/disable/move bitmaps in
> any way, so default to do nothing is the safest way.
> 
> And making bitmap disabled automatically is a great danger of losing dirty
> bits and finally produce inconsistent backup.
> 

I'm not sure that I agree it's a "great" danger, but doing nothing is at
least the consistent and obvious thing.

>>
>> Potential problems: The backing image is read-only, and if we change our
>> mind later, we will need to find a way to re-open the backing image as
>> read-write for the purposes of toggling the recording bit prior to any
>> legitimate guest usage of that node. Then, re-open as RO again.
>>
>>
>>
>>> Should we fork bitmaps (on snapshot)?
>>
>> If a bitmap named 'z' is recording when we create an external snapshot,
>> should that bitmap be *copied* into the top layer?
>>
>> My guess: No.
> 
> Agreed. Nothing automatically. If user wants let him copy by hands. Consider
> case when user uses UUIDs to name bitmaps and is not prepared to appearing
> of two bitmaps with the same name in the system.
> 
>>
>> This would allow us to create external snapshots *without* creating a
>> checkpoint, but conceptually that's a nightmare: It would allow for
>> mutually independent creation of snapshots OR checkpoints. This would be
>> hard to corral when undoing a snapshot, for instance.
>>
>> In my opinion, snapshots MUST be checkpoints, and therefore allowing a
>> snapshot without creating a checkpoint is a no-go.
>>
>>
>>> (Should we fork bitmaps) if we're not using checkpoints?
>>
>> If we are using a checkpoint-less paradigm (i.e. the rolling incremental
>> backup using only one bitmap) we might want to copy the bitmap up to
>> make the next incremental backup as if nothing ever happened.
>>
>> However, rolling incremental backups doesn't need any kind of auto-copy
>> feature. This is possible today:
>>
>>> create('base', 'A')
>>> transact(snapshot('top'), create('top', 'B'))
>>> merge('B', [('base', 'A'), ('top', 'B')])
> 
> Exactly. As I noted, we are already on the way of exposing APIs instead of
> automatic logic.
> 

Yep.

>>
>> i.e., we create a new bitmap on the top layer, then merge in the old
>> data from the backing file, which remains addressable.
>>
>> Whether the user wants to copy up or not, there are commands that will
>> do that already.
>>
>>
>>> Should we create new bitmaps by default when we can?
>>
>> If a backing image has bitmaps, should QEMU automatically create a new
>> bitmap for the top layer? Should it be named something new, something
>> user-provided, or based on existing active bitmaps?
>>
>> If a user creates a new external snapshot with no consideration paid to
>> bitmaps (like "SCENARIO 2" above), they temporarily lose the ability to
>> do incremental backups. They might be able to commit the image back to
>> "try again."
>>
>> That's not great. Here are some options for resolving this:
> 
> But I don't see any problem with it. If user forget to create bitmap, it's
> not our problem and not the reason to create bitmaps automatically.
> Libvirt will not forget. Managing layer will not foreget, or it has bug which
> should be fixed. Libvirt will not be able to use any bitmaps with automatic
> names, as it don't know "what is it" anyway.

Mostly true, but I wanted to explore the options, the pros and the cons
anyway to say that we paid due diligence to it.

> 
>>
>> - Automatic names: Might cause collisions out-of-band with management
>> tooling by accident, tooling has to query to discover what bitmaps were
>> automatically created.
> 
> And "when" they are created.. And create separate naming namespace by restricting
> naming or additional bitmap field..
> 

Yeah, it's messy. Best to avoid much of this entirely if possible.

>>
>> - Same names: Can create namespace confusion when committing snapshots
>> later; although each layer of a backing chain can have bitmaps named the
>> same thing, it causes future problems when committing together that can
>> be hard to resolve.
> 
> And user may be unprepared to appearing of bitmaps with the same name, if bitmap
> names directly bound to checkpoints.
> 

Agreed.

>>
>> - User-provided name: This is workable, and requires an amendment to the
>> snapshot command to automatically create a new bitmap on the snapshot.
> 
> We have transactions to combine commands, so I don't think that combining commands
> into one command is a good idea.
> 

It's a personal weakness of mine. :)

I just like to think out loud if such commands would be more helpful
than burdensome sometimes. QEMU is definitely not a project that likes
such frivolity in general :]

>>
>>
>> My guess: No, we can't automatically create a new bitmap for the user.
>> We can amend the snapshot commands to accept bitmap names, but at that
>> point we've just duplicated transactions:
>>
>> Transact(
>>      snapshot('top'),
>>      create('top', 'new-bitmap')
>> )
>>
>>
>> All that said (Mostly a lot "No, let's not do anything"), maybe there's
>> room for an "assistive" mode for users, a bitmap-aware snapshot creation
>> command. It could do the following well-defined magic:
>>
>> bitmap-snapshot(base, top, bitmap_name):
>>      1. disable any active bitmaps in the base node.
>>      2. create a bitmap named "bitmap_name" in the top node, failing if
>>         a bitmap by that name already exists on either node.
> 
> We don't have bitmap-creation option even for backup command which is the
> main user of bitmaps.. I don't think we need to implement new commands only
> to move in libvirt code from transaction to one command (and libvirt will have
> firstly to check existence of newer command and if it exist use it instead of
> transaction? It's not a simplification)
> 

I did start making a gentle push in the direction of bitmap management
for backup commands with the addition of separate bitmap sync policies
-- it's now possibly to have a full backup clear a bitmap on success,
for instance.

But you're right, it can't create them.

Maybe doing these sorts of things in QEMU is indeed wrong, but I can't
help shake the feeling that I want to create "QMP recipes" that help
provide some kind of sugar for common tasks that helps take the
guesswork out of it, but at a layer before we're doing complete and full
management at e.g. libvirt layer.

Ah well... dreams for another day.

>>
>> What this accomplishes:
>> - Disables any bitmaps in the base layer ahead of time, in preparation
>> for an eventual commit operation.
> 
> I really doubt that we should disable bitmaps in the base layer on snapshot..
> Why? On commit they must be enabled. On separate opening of this image later
> they must be enabled. The only reason to store disabled bitmap A in the image
> is when we have the bitmap B which starts its history from the point when A
> was disabled and B is in the _same_ image.
> 
> And automatic disabling of bitmaps is always dangerous. We'll never predict all
> possible effects.
> 

I feel like there's genuine room to wonder what the best policy is.

We can leave it up to the management layer, but I think there are cases
to be made for either approach. Disabling them lets you commit without
accidentally dirtying existing checkpoints. Enabling them lets you
resume using a base layer with no further action later on.

I think there's a strong case to be made for either, really.

But as we are in violent agreement over, the API is powerful enough to
make any decision you want already; but I wasn't convinced that anyone
had a clear idea of what the "right" thing to do was, yet.

>> - Always creates a new, enabled bitmap on the snapshot mode which is
>> guaranteed not to conflict with a name on the base node. This bitmap can
>> be used to create additional copies post-hoc, if desired.
>> - Formalizes our "best practice" suggestion for mixing bitmaps and
>> snapshots into a single, documented command.
>>
>> Is this strictly needed? No, if you have the foresight, you can do this
>> instead:
>>
>> Transact(
>>      disable('a'),
>>      disable('b'),
>>      disable('c'),
>>      # plus however many more ...
> 
> Why do you think we should disable bitmaps in the base? Am I missing something?
> 
>>      snapshot('top', ...),
>>      create('top', 'd')
>> )
>>
>> but a convenience command might still have a role to play in helping
>> take the guesswork out for non-libvirt users.
> 
> Hmm, my problem is that I don't know, do we really have such users? Of course
> some vendors have to workaround libvirt sometimes and call QMP directly (for
> example, Virtuozzo), but it's not a problem to use transaction for us.. But
> do we have real users which are not programmers and not testers but real users
> of Qemu and QMP? OK, my view is a bit one-sided, as I mostly think about
> Virtuozzo usecases and we don't have such users.
> 

I think we probably don't have many, but I do see lots of users of QEMU
popping up on e.g. reddit that want to use QEMU for gaming and stuff
like that, but how hard it is to use is a frequent complaint they have.

I just usually don't like to accept "Well, libvirt can do it" as a good
excuse for why QEMU APIs have to be complex, hard to use, or poorly
documented.

I probably focus on making QEMU "nice for end users" too much, but at
the end of the day I'm fine with people NACKing my patches as
unnecessary sugar instead of never trying, I guess.

Sorry for the noise in that case ;)

>>
>>
>>
>> That's the bulk of what was discussed.
>>
>> Summary:
>>
>>
>> GOTCHAs:
>> #1: Bitmaps are created non-persistent by default, and can't be changed.
> 
> IMHO, not a problem
> 

Not a technical one, anyway. I think it's a design problem.

>>
>> #2: Push backup destination formats will happily back up to a format
>> that isn't semantically useful.
> 
> That is interesting one.. We have some checks and warning around cluster
> sizes of target and source, but all it is not very reliable..
> 

Yes, it's not necessarily easy to determine this. It's a documentation
problem, I think. The only sad thing is that if you make this mistake
and you let your bitmap get reset, it's non-correctable.

(Yes, non-fatal though, because they're only bitmaps.)

>>
>> #3: Migrating non-shared block storage can drop even persistent bitmaps
>> if you don't pass the bitmap migration capability flag to both QEMU
>> instances.
> 
> Losing a bitmap was never considered as a real problem as it just means
> "do full backup".. Also, actually they may be dropped even if we enabled
> the capability: bitmaps are migrated through "postcopy" mechanism, so any
> error leads to unrecoverable loss of bitmaps.
> 

Yes, not a fatal problem -- just the sort of thing I want to help people
feel confident they can avoid. I want to inspire trust in the feature.
Highlighting the *EXACT* cases that will cause problems can help people
avoid those cases.

Not a huge problem overall, no, but I have been talking to product
managers who can smell edge cases like a shark can smell blood in the water.

>>
>> #4: Creating a snapshot without doing some bitmap manipulation
>> beforehand can temporarily render your bitmaps unusable. Failing to
>> disable bitmaps before creating a snapshot might make commits very
>> tricky later on.
> 
> Aha, understand now why you want to disable bitmaps in base: you don't want
> them to catch commit writes, for which we most probably have bitmap in top
> which we are going to move to the base...
> 
> Anyway, I think it is more correct to disable bitmaps in one transaction with
> commit command. Ok, we don't have transaction for commit, may bit we want it.
> As a workaround user may disable bitmaps after commit start. They will become
> a bit more dirty than they should but it's not a problem.
> 

Exactly, yes: If you create a "new" checkpoint in the top layer but
forgot to disable the "old" checkpoint, committing back down might be a
tricky ordeal.

So the good news is that if you remember to do it when you create the
snapshot, it should be easy.

The bad news is that trying to manage the explicit behavior on commit
seems tricky. I think we DO want to fix this, but only after your series
goes through.

>>
>> Gotchas 1 and 4 can be at least partially alleviated. gotcha 2 remains a
>> pain point we cannot intercept at the QEMU layer. gotcha 3 has potential
>> remedies, but they are complicated.
>>
>>
>> QEMU todo items:
>> - Fix bitmap data corruption on commit (Ongoing, by Vladimir@Virtuozzo)
> 
> ;)
> 
>>
>> - add a set_persistence method for bitmaps that allows us to change the
>> storage class of a bitmap after creation. (Helps alleviate gotcha #1.)
> 
> Still, I just don't know users who need it.
> 

Yeah, I only sent it as an RFC. I'm still trying to determine how
serious various parties are about bypassing libvirt for using these
features.

It's a question that gets asked more than never, so I consider it idly.

I also like to consider the use case of literal power users who use e.g.
qmp-shell to do basic administration, because as far as UX goes, I
believe that a simple, hard to mess up API is good advertising for more
complex layered products built on top of those technologies.

Happy power users are salespeople in the data center.

Anyway, I promise I won't really pursue many of these "nice to have"
ideas very much in the coming quarter unless I get strong incentive to
do so.

>>
>> - Add a command that allows us to merge allocation data into a bitmap.
>> This helps alleviate gotcha #4: If we create a new image but neglected
>> to do the proper transaction dance, we can simply copy the allocation
>> data into a new bitmap. (Note, we'd still need set_persistence to help
>> us disable the old bitmap before any commit happens.)
> 
> Ooops. You are going to use set_persistence to disable persitence to workaround
> the fact that you can't disable bitmap without marking it IN_USE in the image?

No, I just meant to say that we need a method to prevent commit from
dirtying bitmaps that we don't want to dirty. I am not sure how hard
that is to do right now. I'm not trying to avoid the IN_USE flag or
anything like that.

The point of this thought was to highlight that we can populate bitmaps
with allocation data, though, which will let us create bitmaps post-hoc
that instead of being completely empty can be initialized to alloc data,
which helps in this kind of case:

- Install a VM
- Create a snapshot
- Create a bitmap
- Initialize the bitmap with allocation data

You can now copy out the backing file and treat it as a backup using
arbitrary tooling, and the bitmap is perfectly in sync.

It's a limited use case, but was a thought I had to add some flexibility
to the process regardless.

> This is wrong. We must not modify bitmap which is not marked IN_USE in the image,
> as it may lead to any kind of data corruption (in case of crash, we'll finish up
> with bitmap not marked IN_USE but invalid, and we'll consider it valid on next
> vm start).. So, it's a reason to never implement set_persistence (or at least
> set_persistence must set IN_USE flag in the image, and will not help in considered
> case).
> 

I'm not sure if we're on the same page about what I'm trying to
alleviate here, but maybe you've realized something about my idea that I
haven't :)

> And also, I don't know users who may forget to create bitmap if they need.. It's
> not about libvirt of course.
> 
>>
>> - Add convenience command for easy + safe combination of bitmaps +
>> snapshots. Helps prevent #4.
>>
>>
>> Research items:
>> - How hard is it to reopen a backing image as RW while it's in-use,
>> disable a bitmap, and then reopen as RO? This is to partially address
>> gotcha #4; if we forget to disable bitmaps before creating the snapshot.
> 
> It's unsafe to have an image with disabled topmost bitmap. So I think the right way is
> to disable it in one transaction with commit, or after commit start. And may be even
> create new enabled top bitmap in base to really catch writes, so in case of failure we
> can finish up with valid bitmap chain... But I'm afraid I don't have a complete view
> of how it should work.
> 

Yeah, ideally it's something you do right the first time -- but when you
go to commit, I think we do have to cope with the idea that the bitmap
statuses may not be what we want when it comes time to perform the
operation, so understanding how to enable/disable bitmaps in the backing
images (or just /effectively/ enable/disable them) I think will be
important.

>>
>> - How hard is the reverse operation? Can we reopen a backing image RW,
>> enable a bitmap, and then reopen as RO? This gives us better control
>> over what happens on commit.
>>
>> - After we fix the commit bug, what does/should commit actually do with
>> bitmaps? What about bitmaps that collide? The current behavior is that
>> any bitmaps don't transfer from top to base. Any bitmaps active in the
>> base record all the new writes from the top.
> 
> I think current behavior (after bug fix) is correct thing for Qemu and all
> customizations should be done with help of bitmaps API and transactions.
> 

Yeah, there's very little that *needs* to happen in QEMU, and I agree. I
still might propose some "nice to have" things here and there, perhaps
if only as reference for people.

(Hmm, speaking of nice-to-haves, maybe I could add a bitmap management
module on top of python/qemu/machine.py at some point? That'd be a good
place for some "magic" that also serves as a good reference
implementation on how to do things the right way... and it could be
useful for our test suite, too.)

Still, it's just wishlist stuff, nothing really on my plate to *do*
right now. For 4.2 all I am really concerned with is your reopen fixes,
commit and stream tests, and documentation revisions.

>>
>>
>> That's all!
>> --js
>>
> 
> 

I think we are largely on the same page; there's a lot of convenience
stuff I talked about but I think we both agree that none of it is really
necessary.

In terms of strictly necessary things, I believe it's just:

1. Fix commit (Via your series that reworks reopen)
2. Ensure that commit is capable of dealing with either enabled or
disabled bitmaps in the base images.


I have a todo list I'm working on that I'll try to send out soon; it's
mostly documentation TODOs and a few things related to bringing bitmaps
to mirror which I want to do before 4.2 goes out the door. Nothing too
surprising, I think.

--js

