Return-Path: <SRS0=S/IU=TU=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D552C04AAC
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 14:06:28 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1652A216B7
	for <qemu-devel@archiver.kernel.org>; Mon, 20 May 2019 14:06:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1652A216B7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:36262 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hSivr-0003AO-1l
	for qemu-devel@archiver.kernel.org; Mon, 20 May 2019 10:06:27 -0400
Received: from eggs.gnu.org ([209.51.188.92]:33393)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hSiv1-0002mf-Lp
	for qemu-devel@nongnu.org; Mon, 20 May 2019 10:05:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hSiuu-0004dv-LW
	for qemu-devel@nongnu.org; Mon, 20 May 2019 10:05:31 -0400
Received: from 5.mo68.mail-out.ovh.net ([46.105.62.179]:40349)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hSiur-0004T0-LJ
	for qemu-devel@nongnu.org; Mon, 20 May 2019 10:05:26 -0400
Received: from player730.ha.ovh.net (unknown [10.109.159.69])
	by mo68.mail-out.ovh.net (Postfix) with ESMTP id 09DF212E7FA
	for <qemu-devel@nongnu.org>; Mon, 20 May 2019 16:05:13 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player730.ha.ovh.net (Postfix) with ESMTPSA id F39E65D67FD6;
	Mon, 20 May 2019 14:05:09 +0000 (UTC)
Date: Mon, 20 May 2019 16:05:09 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190520160509.3a435d8b@bahia.lan>
In-Reply-To: <4886143.bCxdSxxvz5@silver>
References: <590216e2666653bac21d950aaba98f87d0a53324.1557093245.git.qemu_oss@crudebyte.com>
	<1723391.cvQaRflHa6@silver> <20190517164746.5c653a0e@bahia.lan>
	<4886143.bCxdSxxvz5@silver>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12977403801669114176
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddtkedgjeefucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.62.179
Subject: Re: [Qemu-devel] [libvirt patch] qemu: adds support for virtfs 9p
 argument 'vii'
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
Cc: "Daniel P. =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>,
	qemu-devel@nongnu.org, Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Hi Christian,

On Fri, 17 May 2019 22:53:41 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Freitag, 17. Mai 2019 16:47:46 CEST Greg Kurz wrote:
> > Potentially yes if another approach is satisfying enough, as I wouldn't
> > want to over-engineer too much around this 9p imposed limitation. The
> > right thing to do would be to come up with a new version of the protocol
> > with variable sized QIDs and call it a day.  
> 
> Yes, but that's the long-term solution which will still take a very long 
> while. This patch set is already a functional solution until that happens, and 
> this 9p issue is IMO quite severe (as minor as data corruption, data loss and 
> exists for several years already).
> 

On the other hand, I'm afraid that having a functional solution won't
motivate people to come up with a new spec... Anyway, I agree that the
data corruption/loss issues must be prevented, ie, the 9p server should
at least return an error to the client rather than returning a colliding
QID. A simple way to avoid that is to enforce a single device, ie. patch
2 in Antonios's series. Of course this may break some setups where
multiple devices are involved, but it is pure luck if they aren't already
broken with the current code base. I assume that this covers most 9p users,
based on the fact that Antonios and now yourself are the only people who
ever reported this issue. Then, I'm okay if we try to cover some more
scenarios, but it must take the maintainance burden into account.

> > > plus it completely destroys the fundamental idea about 9p, which is about
> > > transparency of the higher level(s).  
> > 
> > That's a point indeed, even if again I'm not sure if this is a frequent
> > case to share a directory tree spanning over multiple devices.  
> 
> When the use case is mass storage then it is very likely that you will have 
> several devices. Times have changed. With modern file systems like ZFS it is 
> very common to create a large amount of "data sets" for all kinds of 
> individual purposes and mount points which is cheap to get. Each fs data set 
> is a separate "device" from OS (i.e. Linux) point of view, even if all those 
> FS data sets are in the same FS pool and even on the same physical IO device.
> 
> Background: The concept of FS "data sets" combines the benefits of classical  
> partitions (e.g. logical file space separation, independent fs configurations 
> like compression on/off/algorithm, data deduplication on/off, snapshot 
> isolation, snapshots on/off) without the disadvantages of classical real 
> partitions (physical space is dynamically shared, no space wasted on fixed 
> boundaries; physical device pool management is transparent for all data sets, 
> configuration options can be inherited from parent data sets).
> 

Ok. I must admit my ignorance around ZFS and "data sets"... so IIUC, even with
a single underlying physical device you might end up with lstat() returning
different st_dev values on the associated files, correct ?

I take your word for the likeliness of the issue to popup in such setups. :)

> > I don't have that much time to spend on 9p maintainership, for both
> > reviewing and fixing bugs (CVEs most of the time). So, yes it may
> > sound like I want to drop the patchset, but it's just I need to be
> > convinced I won't regret having merged a huge change like this...
> > when I'll have to support it alone later ;-)  
> 
> Actually I already assumed this to be the actual root cause.
> 
> I see that you are currently the only maintainer, and my plan was not to just 
> provide a one time shot but eventually hang along helping with maintaining it 
> due my use of 9p and its huge potential I see (as universal and efficient root 
> file system for all guests, not just for exotically sharing a small tree 
> portion between guests). I also have plans for supporting native file forks 

What are "native file forks" ?

> BTW. But if you are seriously suggesting to simply omit a fundamental issue in 
> 9p, then my plans would obviously no longer make sense. :)
> 

It would be very much appreciated to have someone else investing time in 9p
of course. :)

> I mean I am completely tolerant to all kinds of religious views on bit level, 
> languages, code style, libs, precise implementation details, parameters, 
> source structure, etc.; but saying to simply leave a fundamental bug open for 
> years to come, that's where I have to drop out.
> 

I guess I was unclear... As said above, I do want to avoid QID collisions,
at least by enforcing a single device per shared path. Then, supporting
multiple devices will depend on the benefice/expense ratio.

> > For the moment, I'm not convinced by the "vii" solution. It even
> > motivated my suggestion of having several devices actually, since
> > the paths you would put in there are known before starting QEMU.  
> 
> Well, that "vii" configuration and the QID persistency are 2 optional patches 
> on top of the core fixes. It is a huge difference to suggest dropping these 2 
> patches than saying to completely drop the entire patch set and to leave this 
> bug open.
> 
> The mandatory core fixes that I see (for the short/mid term) are at least 
> Antonios' patches plus my variable length prefix patch, the latter significantly 
> reduces the inode numbers on guest and significantly increases the inode name 
> space, and hence also significanlty reduces the propability that 9p might ever 
> need to kick in with any kind of expensive remapping actions (or even 
> something worse like stat fatally returning -ENFILE to the user).
> 
> About the "vii" configuration, even though you don't like the idea: there is 

Hmm... I was objecting on the fact that "vii" would cope with runtime
changes on the host while the guest is running.

> also a big difference giving the user the _optional_ possibility to define e.g. 
> one path (not device) on guest said to be sensitive regarding high inode 
> numbers on guest; and something completely different telling the user that he 
> _must_ configure every single device from host that is ever supposed to pop up 
> with 9p on guest and forcing the user to update that configuration whenever a 
> new device is added or removed on host. The "vii" configuration feature does 
> not require any knowledge of how many and which kinds of devices are actually 
> ever used on host (nor on any higher level host in case of nested 
> virtualization), nor does that "vii" config require any changes ever when host 
> device setup changes. So 9p's core transparency feature would not be touched 
> at all.
> 

I guess this all boils down to I finding some time to read/understand more :)

As usual, a series with smaller and simpler patches will be easier to
review, and more likely to be merged.

> > It might take me some more rounds of discussion to decide. I understand
> > it is frustrating but bear with me :)  
> 
> Let me make a different suggestion: how about putting these fixes into a 
> separate C unit for now and making the default behaviour (if you really want) 
> to not use any of that code by default at all. So the user would just get an 
> error message in the qemu log files by default if he tries to export several 
> devices with one 9p device, suggesting him either to map them as separate 9p 
> devices (like you suggested) and informing the user about the alternative of 
> enabling support for the automatic inode remapping code (from that separate C 
> unit) instead by adding one convenient config option if he/she really wants.
> 

It seems that we may be reaching some consensus here :)

I like the approach, provided this is configurable from the command line, off
by default and doesn't duplicate core 9p code. Not sure this needs to sit in
its own C unit though.

> That way we would have a fix now, not in years, people can decide to use the 
> automatic and hardware transparent solution, instead of being forced to write 
> dozens of config lines for each single guest, or they might decide to stick 
> with your "solution" ;-).
> 
> And once the long term solution for this issue with variable length QIDs is in 
> place, the inode remapping code can very simply be dropped from the code base 
> completley by just deleting the C unit and about a hand full of lines in 9p.c 
> or so, and hence this fix would not bloat the existing 9p units nor cause 
> maintenance nightmares of any kind.
> 

The 9p code has a long history of CVEs and limitations that prevented it
to reach full production grade quality. Combined with the poor quality of
the code, this has scared off many experienced QEMU developpers, which
prefer to work on finding an alternative solution. Such alternative is
virtio-fs, which is being actively worked on:

https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg02746.html

Note: I'm not telling "stay away from 9p" but maybe worth taking a look,
      because if virtio-fs gets merged, it is likely to become the official
      and better supported way to share files between host and guest.

> Best regards,
> Christian Schoenebeck

Please repost a series, possibly based on some of Antonios's patches that
allows to avoid the QID collision, returns an error to the client instead
and possibly printing out some useful messages in the QEMU log. Then, on
top of that, you can start introducing hashing and variable prefix length.

Cheers,

--
Greg

