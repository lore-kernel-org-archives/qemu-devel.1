Return-Path: <SRS0=8zLO=TW=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85140C282CE
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:05:33 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0247F20879
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2019 16:05:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="GNklqxNc"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0247F20879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47116 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hTTkB-0000AP-PH
	for qemu-devel@archiver.kernel.org; Wed, 22 May 2019 12:05:31 -0400
Received: from eggs.gnu.org ([209.51.188.92]:56257)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hTTi7-0007PD-5Q
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:03:28 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hTTi5-0006p8-8N
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:03:23 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:39079)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
	id 1hTTi4-0006bd-Mw
	for qemu-devel@nongnu.org; Wed, 22 May 2019 12:03:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y2/LeN2vku8FCUER8ksaeDePZkO+e5VX4bACOK7VUVY=;
	b=GNklqxNcplFX2yoHqZO9FQ1PrV
	Dsf7cmdWsiSIX3RFTJ3M50vCIst2z9kMyBcPySNBnnB9B5IARJyMZqZA8Lf7dgXR3n6FNRTV3wXkL
	4IAT/h3QQO/kfsOnd42SCRIZKQf7uxOKIz9Ny4WiFVJ2o5h9Y5bCo+oNOyDeKoHcUzhFNkpVNpuLG
	087HMGmXQLvSSI/OABDYnVa1CyhGMUDIOWSMlOHjlxmjqz7LYYGxGaOcBb/fcwBS4ITEBDrlMvuQy
	4NLwWM4Lqrezso9U/SNJ707NkLcHdro3RR7+n6N0TWclPHqYutOPpnwNjbe2s5fynXXSup8bcToqH
	5As8zxdb9wgXqBtyDGH5AeelkmTOx0xlGmcV5WrIldVg0nKEL1shxikzSUaUsdxxnKqjDzxYf557q
	A22mRF9p804M9asUqvWqj+/4GJLuaXqzcF6LWQ4yJx+ECPjh+WZ4nE9Dh7N9/slucGJZzVzSnSTsJ
	s1C/nf5zLxoQoHfMHX5TGTWJgoK/9zuFe4VPMj53c8SKq5r1q2LYCzNIWylEpEjkeeFwfbsxhR3zI
	ULuPTN8GVuJt7fJLn06GtS1jCZCQ707assZbC1BYnM2Os6UVDFoSNpLazu6uPNo/pVR9LU/9Hm3wc
	5STVCR9gIZ5cyu/73dlwnbtV5obLMmqmss4Zt2wJc=;
To: qemu-devel@nongnu.org
Date: Wed, 22 May 2019 18:03:13 +0200
Message-ID: <3878644.JKHuFhRL4E@silver>
In-Reply-To: <20190520160509.3a435d8b@bahia.lan>
References: <590216e2666653bac21d950aaba98f87d0a53324.1557093245.git.qemu_oss@crudebyte.com>
	<4886143.bCxdSxxvz5@silver> <20190520160509.3a435d8b@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 5.189.157.229
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
From: Christian Schoenebeck via Qemu-devel <qemu-devel@nongnu.org>
Reply-To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
	Christian Schoenebeck <qemu_oss@crudebyte.com>, Greg Kurz <groug@kaod.org>,
	Antonios Motakis <antonios.motakis@huawei.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Montag, 20. Mai 2019 16:05:09 CEST Greg Kurz wrote:
> Hi Christian,

Hi Greg,

> On the other hand, I'm afraid that having a functional solution won't
> motivate people to come up with a new spec... Anyway, I agree that the
> data corruption/loss issues must be prevented, ie, the 9p server should
> at least return an error to the client rather than returning a colliding
> QID. 

Ok, I will extend Antonios' patch to log that error on host. I thought about 
limiting that error message to once per session (for not flooding the logs), 
but it is probably not worth it, so if you don't veto then I will just log 
that error simply on every file access.

> A simple way to avoid that is to enforce a single device, ie. patch
> 2 in Antonios's series. Of course this may break some setups where
> multiple devices are involved, but it is pure luck if they aren't already
> broken with the current code base. 

Yes, the worst thing you can have is this collision silently being ignored, 
like it is actually right now. Because you end up getting all sorts of 
different misbehaviours on guests, and these are just symptoms that take a 
while to debug and realise that the actual root cause is an inode collision. 
So enforcing a single device is still better than undefined behaviour.

> > Background: The concept of FS "data sets" combines the benefits of
> > classical partitions (e.g. logical file space separation, independent fs
> > configurations like compression on/off/algorithm, data deduplication
> > on/off, snapshot isolation, snapshots on/off) without the disadvantages
> > of classical real partitions (physical space is dynamically shared, no
> > space wasted on fixed boundaries; physical device pool management is
> > transparent for all data sets, configuration options can be inherited
> > from parent data sets).
> 
> Ok. I must admit my ignorance around ZFS and "data sets"... so IIUC, even
> with a single underlying physical device you might end up with lstat()
> returning different st_dev values on the associated files, correct ?
> 
> I take your word for the likeliness of the issue to popup in such setups. :)

Yes, that is correct, you _always_ get a different stat::st_dev value for each 
ZFS data set. Furthermore, each ZFS data set has its own inode number sequence 
generator starting from one. So consider you create two new ZFS data sets, 
then you create one file on each data set, then both files will have inode 
number 1.

That probably makes it clear why you hit this ID collision bug very easily 
when using the combination ZFS & 9p.

> > also a big difference giving the user the _optional_ possibility to define
> > e.g. one path (not device) on guest said to be sensitive regarding high
> > inode numbers on guest; and something completely different telling the
> > user that he _must_ configure every single device from host that is ever
> > supposed to pop up with 9p on guest and forcing the user to update that
> > configuration whenever a new device is added or removed on host. The
> > "vii" configuration feature does not require any knowledge of how many
> > and which kinds of devices are actually ever used on host (nor on any
> > higher level host in case of nested
> > virtualization), nor does that "vii" config require any changes ever when
> > host device setup changes. So 9p's core transparency feature would not be
> > touched at all.
> 
> I guess this all boils down to I finding some time to read/understand more
> :)

Yes, that helps sometimes. :)

> As usual, a series with smaller and simpler patches will be easier to
> review, and more likely to be merged.

Of course.

In the next patch series I will completely drop a) the entire QID persistency 
feature code and b) that disputed "vii" feature. But I will still suggest the 
variable inode suffix length patch as last patch in that new patch series.

That should make the amount of changes manageable small.

> > Let me make a different suggestion: how about putting these fixes into a
> > separate C unit for now and making the default behaviour (if you really
> > want) to not use any of that code by default at all. So the user would
> > just get an error message in the qemu log files by default if he tries to
> > export several devices with one 9p device, suggesting him either to map
> > them as separate 9p devices (like you suggested) and informing the user
> > about the alternative of enabling support for the automatic inode
> > remapping code (from that separate C unit) instead by adding one
> > convenient config option if he/she really wants.
> It seems that we may be reaching some consensus here :)
> 
> I like the approach, provided this is configurable from the command line,
> off by default and doesn't duplicate core 9p code. Not sure this needs to
> sit in its own C unit though.

Any preference for a command line argument name and/or libvirt XML config tag/
attribute for switching the inode remapping code on?

About that separate C unit: I leave that up to you to decide, it does not 
matter to me. I just suggested it since you consider these patches as 
temporary workaround until there are appropriate protocol changes. So clear 
code separation for them might help to get rid of the entire code later on. 
Plus for distribution maintainers it might be easiert to cherry pick them as 
backports.

However since I will drop the persistency and "vii" feature in the next patch 
series, it probably does not make a huge difference anyway. As you prefer.

> The 9p code has a long history of CVEs and limitations that prevented it
> to reach full production grade quality. Combined with the poor quality of
> the code, this has scared off many experienced QEMU developpers, which
> prefer to work on finding an alternative solution. 

And I already wondered about the obvious low activity on this particular qemu 
feature. I mean I don't find it contemporary still running guests to use their 
own file system being emulated on a file ontop of yet another file system and 
loosing essentially all benefits of the host's actual backend file system 
features.

> Such alternative is virtio-fs, which is being actively worked on:
> 
> https://lists.gnu.org/archive/html/qemu-devel/2019-04/msg02746.html
> 
> Note: I'm not telling "stay away from 9p" but maybe worth taking a look,
>       because if virtio-fs gets merged, it is likely to become the official
>       and better supported way to share files between host and guest.

Ah, good to know! That's new to me, thanks!

Makes sense to me, especially its performance will certainly be much better.

> Please repost a series, possibly based on some of Antonios's patches that
> allows to avoid the QID collision, returns an error to the client instead
> and possibly printing out some useful messages in the QEMU log. Then, on
> top of that, you can start introducing hashing and variable prefix length.

So you want that as its own patch series first, or can I continue with my 
suggestion to deliver the hash patch and variable suffix length patch as last 
patches within the same series?

Best regards,
Christian Schoenebeck

