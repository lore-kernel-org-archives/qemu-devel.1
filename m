Return-Path: <SRS0=Y1tr=UJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 385C8C4321A
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 22:48:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44D620820
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Jun 2019 22:48:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=extremeground.com header.i=@extremeground.com header.b="NzhDzWPN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D44D620820
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=extremeground.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:50170 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1haT5y-0002HI-Mb
	for qemu-devel@archiver.kernel.org; Mon, 10 Jun 2019 18:48:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49566)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <gary@extremeground.com>) id 1haT4s-0001jM-Ud
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 18:47:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <gary@extremeground.com>) id 1haT4q-0000Xz-Ua
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 18:47:46 -0400
Received: from ahs5.r4l.com ([158.69.52.156]:34413)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <gary@extremeground.com>)
 id 1haT4o-0000VU-40
 for qemu-devel@nongnu.org; Mon, 10 Jun 2019 18:47:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=extremeground.com; s=default; h=Content-Transfer-Encoding:Content-Type:
 In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
 :Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=SNdH4AlrrTqd+DXj/mtVgjyljKi+GcOqyPrzOYV3Dd0=; b=NzhDzWPNNjUbr6WSrSDQ571NRa
 Z4GhxZcigD25tQigIGlacm1x7fdelWNUjNUDqbHSWJsmdV30psdNq16hrhehVc6gND11VpPoJmYTD
 5TrGkxWEREWyYnUk67Dfb3QsL2ZtXVrIboOkzIuC4yxlV35u1f2+ZBtd12W+Wmox66kWDiq7sj4S9
 hOULuA+/SyJ2m9eYEqgp5Yk6s2J7DklnEyCHUwdmRzTqF/LuU8VwJvVBtvF3O5p/vjkFOYswAdtb6
 dSuf6jksc4+a3p/zpQnoyn4D8MFnxG/irH3YFtmawVEZskguJC9XyuMowvuG0iVk8qfIoJoWMWEJx
 ihSDUPKQ==;
Received: from cpeac202ed5e073-cmac202ed5e070.cpe.net.cable.rogers.com
 ([99.237.87.227]:36496 helo=[192.168.1.20])
 by ahs5.r4l.com with esmtpsa (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128)
 (Exim 4.92) (envelope-from <gary@extremeground.com>)
 id 1haT4j-0001F4-NQ; Mon, 10 Jun 2019 18:47:37 -0400
To: Eric Blake <eblake@redhat.com>, Stefan Hajnoczi <stefanha@gmail.com>
References: <abb7990e-0331-67a4-af92-05276366478c@extremeground.com>
 <20190610121941.GI14257@stefanha-x1.localdomain>
 <dc7a70ea-c94f-e975-df44-b0199da698e2@extremeground.com>
 <28719bbe-fcce-9e37-f146-ad6ce3edda51@redhat.com>
From: Gary Dale <gary@extremeground.com>
Message-ID: <976b1c32-a7ff-fbfd-9176-040c61649cb7@extremeground.com>
Date: Mon, 10 Jun 2019 18:47:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
MIME-Version: 1.0
In-Reply-To: <28719bbe-fcce-9e37-f146-ad6ce3edda51@redhat.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-CA
X-AntiAbuse: This header was added to track abuse,
 please include it with any abuse report
X-AntiAbuse: Primary Hostname - ahs5.r4l.com
X-AntiAbuse: Original Domain - nongnu.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - extremeground.com
X-Get-Message-Sender-Via: ahs5.r4l.com: authenticated_id:
 gary@extremeground.com
X-Authenticated-Sender: ahs5.r4l.com: gary@extremeground.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 158.69.52.156
Subject: Re: [Qemu-devel] kvm / virsh snapshot management
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
Cc: Kevin Wolf <kwolf@redhat.com>, John Snow <jsnow@redhat.com>,
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On 2019-06-10 6:04 p.m., Eric Blake wrote:
> On 6/10/19 10:54 AM, Gary Dale wrote:
>
>>>> One explanation I've seen of the process is if I delete a snapshot, the
>>>> changes it contains are merged with its immediate child.
>>> Nope.  Deleting a snapshot decrements the reference count on all its
>>> data clusters.  If a data cluster's reference count reaches zero it will
>>> be freed.  That's all, there is no additional data movement or
>>> reorganization aside from this.
>> Perhaps not physically but logically it would appear that the data
>> clusters were merged.
> No.
>
> If I have an image that starts out as all blanks, then write to part of
> it (top line showing cluster number, bottom line showing representative
> data):
>
> 012345
> AA----
>
> then take internal snapshot S1, then write more:
>
> ABB---
>
> then take another internal snapshot S2, then write even more:
>
> ABCC--
>
> the single qcow2 image will have something like:
>
> L1 table for S1 => {
>    guest cluster 0 => host cluster 5 refcount 3 content A
>    guest cluster 1 => host cluster 6 refcount 1 content A
> }
> L1 table for S2 => {
>    guest cluster 0 => host cluster 5 refcount 3 content A
>    guest cluster 1 => host cluster 7 refcount 2 content B
>    guest cluster 2 => host cluster 8 refcount 1 content B
> }
> L1 table for active image => {
>    guest cluster 0 => host cluster 5 refcount 3 content A
>    guest cluster 1 => host cluster 7 refcount 2 content B
>    guest cluster 2 => host cluster 9 refcount 1 content C
>    guest cluster 3 => host cluster 10 refcount 1 content C
> }
>
>
> If I then delete S2, I'm left with:
>
> L1 table for S1 => {
>    guest cluster 0 => host cluster 5 refcount 2 content A
>    guest cluster 1 => host cluster 6 refcount 1 content A
> }
> L1 table for active image => {
>    guest cluster 0 => host cluster 5 refcount 2 content A
>    guest cluster 1 => host cluster 7 refcount 1 content B
>    guest cluster 2 => host cluster 9 refcount 1 content C
>    guest cluster 3 => host cluster 10 refcount 1 content C
> }
>
> and host cluster 8 is no longer in use.
>
> Or, if I instead use external snapshots, I have a chain of images:
>
> base <- mid <- active
>
> L1 table for image base => {
>    guest cluster 0 => host cluster 5 refcount 1 content A
>    guest cluster 1 => host cluster 6 refcount 1 content A
> }
> L1 table for image mid => {
>    guest cluster 1 => host cluster 5 refcount 1 content B
>    guest cluster 2 => host cluster 6 refcount 1 content B
> }
> L1 table for image active => {
>    guest cluster 2 => host cluster 5 refcount 1 content C
>    guest cluster 3 => host cluster 6 refcount 1 content C
> }
>
> If I then delete image mid, I can do so in one of two ways:
>
> blockcommit mid into base:
> base <- active
> L1 table for image base => {
>    guest cluster 0 => host cluster 5 refcount 1 content A
>    guest cluster 1 => host cluster 6 refcount 1 content B
>    guest cluster 2 => host cluster 7 refcount 1 content B
> }
> L1 table for image active => {
>    guest cluster 2 => host cluster 5 refcount 1 content C
>    guest cluster 3 => host cluster 6 refcount 1 content C
> }
>
>
> blockpull mid into active:
> base <- active
> L1 table for image base => {
>    guest cluster 0 => host cluster 5 refcount 1 content A
>    guest cluster 1 => host cluster 6 refcount 1 content A
> }
> L1 table for image active => {
>    guest cluster 1 => host cluster 7 refcount 1 content B
>    guest cluster 2 => host cluster 5 refcount 1 content C
>    guest cluster 3 => host cluster 6 refcount 1 content C
> }
>
>
>>>> Can some provide a little clarity on this? Thanks!
>>> If you want an analogy then git(1) is a pretty good one.  qcow2 internal
>>> snapshots are like git tags.  Unlike branches, tags are immutable.  In
>>> qcow2 you only have a master branch (the current disk state) from which
>>> you can create a new tag or you can use git-checkout(1) to apply a
>>> snapshot (discarding whatever your current disk state is).
>>>
>>> Stefan
>> That's just making things less clear - I've never tried to understand
>> git either. Thanks for the attempt though.
>>
>> If I've gotten things correct, once the base image is established, there
>> is a current disk state that points to a table containing all the writes
>> since the base image. Creating a snapshot essentially takes that pointer
>> and gives it the snapshot name, while creating a new current disk state
>> pointer and data table where subsequent writes are recorded.
> Not quite. Rather, for internal snapshots, there is a table pointing to
> ALL the contents that should be visible to the guest at that point in
> time (one table for each snapshot, which is effectively read-only, and
> one table for the active image, which is updated dynamically as guest
> writes happen).  But the table does NOT track provenance of a cluster,
> only a refcount.
>
>> Deleting snapshots removes your ability to refer to a data table by
>> name, but the table itself still exists anonymously as part of a chain
>> of data tables between the base image and the current state.
> Wrong for internal snapshots. There is no chain of data tables, and if a
> cluster's refcount goes to 0, you no longer have access to the
> information that the guest saw at the time that cluster was created.
>
> Also wrong for external snapshots - there, you do have a chain of data
> between images, but when you delete an external snapshot, you should
> only do so after moving the relevant data elsewhere in the chain, at
> which point you reduced the length of the chain.
>
>> This leaves a problem. The chain will very quickly get quite long which
>> will impact performance. To combat this, you can use blockcommit to
>> merge a child with its parent or blockpull to merge a parent with its
>> child.
> Wrong for internal snapshots, where blockcommit and blockpull do not
> really work.
>
> More accurate for external snapshots.
>
>> In my situation, I want to keep a week of daily snapshots in case
>> something goes horribly wrong with the VM (I recently had a database
>> file become corrupt, and reverting to the previous working day's image
>> would have been a quick and easy solution, faster than recovering all
>> the data tables from the prefious day). I've been shutting down the VM,
>> deleting the oldest snapshot and creating a new one before restarting
>> the VM.
>>
>> While your explanation confirms that this is safe, it also implies that
>> I need to manage the data table chains. My first instinct is to use
>> blockcommit before deleting the oldest snapshot, such as:
>>
>>      virsh blockcommit <vm name> <qcow2 file path> --top <oldest
>> snapshot> --delete --wait
>>      virsh snapshot-delete  --domain <vm name> --snapshotname <oldest
>> snapshot>
>>
>> so that the base image contains the state as of one week earlier and the
>> snapshot chains are limited to 7 links.
>>
>> 1) does this sound reasonable?
> If you want to track WHICH clusters have changed since the last backup
> (which is the goal of incremental/differential backups), you probably
> also want to be using persistent bitmaps.  At the moment, internal
> snapshots have very little upstream development compared to external
> snapshots, and are less likely to have ways to do what you want.
>
>> 2) I note that the syntax in virsh man page is different from the syntax
>> at
>> https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/virtualization_deployment_and_administration_guide/sect-backing-chain
>> (RedHat uses --top and --base while the man page just has optional base
>> and top names). I believe the RedHat guide is correct because the man
>> page doesn't allow distinguishing between the base and the top for a
>> commit.
> Questions about virsh are outside the realm of what qemu does (that's
> what libvirt adds on top of qemu); and the parameters exposed by virsh
> may differ according to what versions you are running. Also be aware
> that I'm trying to get a new incremental backup API
> virDomainBackupBegin() added to libvirt that will make support for
> incremental/differential backups by using qcow2 persistent bitmaps much
> easier from libvirt's point of use.
>
>> However the need for specifying the path isn't obvious to me. Isn't the
>> path contained in the VM definition?
>>
>> Since blockcommit would make it impossible for me to revert to an
>> earlier state (because I'm committing the oldest snapshot, if it screws
>> up, I can't undo within virsh), I need to make sure this command is
>> correct.
>>
>>
Interesting. Your comments are quite different from what the Redhat 
online documentation suggests. It spends some time talking about 
flattening the chains (e.g. 
https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/6/html/virtualization_administration_guide/sub-sect-domain_commands-using_blockcommit_to_shorten_a_backing_chain) 
while you are saying the chains don't exist. I gather this is because 
Redhat doesn't like internal snapshots, so they focus purely on 
documenting external ones.

It does strike me as a little bizarre to handle internal and external 
snapshots differently since the essential difference only seems to be 
where the data is stored. Using chains for one and reference counts for 
the other sounds like a recipe for for things not working right.

Anyway, if I understand what you are saying, with internal snapshots, i 
can simply delete old ones and create new ones without worrying about 
there being any performance penalty. All internal snapshots are one hop 
away from the base image.

Thanks.


