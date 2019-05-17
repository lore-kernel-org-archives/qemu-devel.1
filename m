Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C2ADC04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 21:07:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3F0DA2087B
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 21:07:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="aBMJuc25"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F0DA2087B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=nongnu.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:53706 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRk4f-0001MC-EJ
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 17:07:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:54645)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hRk3D-0000Ry-Hr
	for qemu-devel@nongnu.org; Fri, 17 May 2019 17:06:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <qemu_oss@crudebyte.com>) id 1hRjrR-0005CQ-DK
	for qemu-devel@nongnu.org; Fri, 17 May 2019 16:53:50 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:39575)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
	id 1hRjrQ-00055i-Tj
	for qemu-devel@nongnu.org; Fri, 17 May 2019 16:53:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=DmtBDD0M0Dh3SW8ggr0kK747mii3ZwKo4rcBwehnXNY=;
	b=aBMJuc25BDUKWpCVWUm1bRKRRx
	e9gucssOqIfZk1NyVKfgeP87VWkE9qndwbMmRFqyF3g5WSCfc6JtKUERe9399kiVK8HOPSWR0Vptm
	NNMVnwideockpsUcj5rEcCyegybGPS8M+UgZ8GvgD1ff+h447CbrLu9v7JZDjD/tDjRUYOkIm7fFB
	tkMijRqMN589C3XdYMACtB6nJowAIvawcZtTmhEJ1mwWR2Xa8Hui0W6gKOKj1r6EC0fw55h7QbCsP
	3UkIYpnyllQOyAetQDmVbB3lWrH2nP38TuyatrDZIV84H8W4lHSuh3oPygTlTLUW6WEQinoDheU4p
	LOditd6oWmw5FgFxmgI2pw/Qo4bmi1DxPmuwjQC2gszUAEi0QdMpv+qzrsGzDOA//2e2kBT23EqDo
	Vb6gTPuCUkwgcZQF51rA3zOePuS4yeBhsg0fEIOnbPiLWLuCqU7vNCIyWa0URMUvnYhcW0isBA6uu
	IdXnOb+vlhmVW7bT+7o0xHiiMmgs+MBxKdXmMJfWlG09nQ7HTPXAL6rDm0ivYV7tSr3bes0tJgnVr
	W1Rm79YB2AN3UnM5LfDBA+cTd5jrtY0a/8shHGOlb8KDtDRwOABKqSiohArQvW+Txda5CX93Y25jB
	nJlZGR9tMAsB4/g7GLDMX2TJBoMgm8dNhEuwV9YlQ=;
To: qemu-devel@nongnu.org
Date: Fri, 17 May 2019 22:53:41 +0200
Message-ID: <4886143.bCxdSxxvz5@silver>
In-Reply-To: <20190517164746.5c653a0e@bahia.lan>
References: <590216e2666653bac21d950aaba98f87d0a53324.1557093245.git.qemu_oss@crudebyte.com>
	<1723391.cvQaRflHa6@silver> <20190517164746.5c653a0e@bahia.lan>
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

On Freitag, 17. Mai 2019 16:47:46 CEST Greg Kurz wrote:
> Potentially yes if another approach is satisfying enough, as I wouldn't
> want to over-engineer too much around this 9p imposed limitation. The
> right thing to do would be to come up with a new version of the protocol
> with variable sized QIDs and call it a day.

Yes, but that's the long-term solution which will still take a very long 
while. This patch set is already a functional solution until that happens, and 
this 9p issue is IMO quite severe (as minor as data corruption, data loss and 
exists for several years already).

> > plus it completely destroys the fundamental idea about 9p, which is about
> > transparency of the higher level(s).
> 
> That's a point indeed, even if again I'm not sure if this is a frequent
> case to share a directory tree spanning over multiple devices.

When the use case is mass storage then it is very likely that you will have 
several devices. Times have changed. With modern file systems like ZFS it is 
very common to create a large amount of "data sets" for all kinds of 
individual purposes and mount points which is cheap to get. Each fs data set 
is a separate "device" from OS (i.e. Linux) point of view, even if all those 
FS data sets are in the same FS pool and even on the same physical IO device.

Background: The concept of FS "data sets" combines the benefits of classical  
partitions (e.g. logical file space separation, independent fs configurations 
like compression on/off/algorithm, data deduplication on/off, snapshot 
isolation, snapshots on/off) without the disadvantages of classical real 
partitions (physical space is dynamically shared, no space wasted on fixed 
boundaries; physical device pool management is transparent for all data sets, 
configuration options can be inherited from parent data sets).

> I don't have that much time to spend on 9p maintainership, for both
> reviewing and fixing bugs (CVEs most of the time). So, yes it may
> sound like I want to drop the patchset, but it's just I need to be
> convinced I won't regret having merged a huge change like this...
> when I'll have to support it alone later ;-)

Actually I already assumed this to be the actual root cause.

I see that you are currently the only maintainer, and my plan was not to just 
provide a one time shot but eventually hang along helping with maintaining it 
due my use of 9p and its huge potential I see (as universal and efficient root 
file system for all guests, not just for exotically sharing a small tree 
portion between guests). I also have plans for supporting native file forks 
BTW. But if you are seriously suggesting to simply omit a fundamental issue in 
9p, then my plans would obviously no longer make sense. :)

I mean I am completely tolerant to all kinds of religious views on bit level, 
languages, code style, libs, precise implementation details, parameters, 
source structure, etc.; but saying to simply leave a fundamental bug open for 
years to come, that's where I have to drop out.

> For the moment, I'm not convinced by the "vii" solution. It even
> motivated my suggestion of having several devices actually, since
> the paths you would put in there are known before starting QEMU.

Well, that "vii" configuration and the QID persistency are 2 optional patches 
on top of the core fixes. It is a huge difference to suggest dropping these 2 
patches than saying to completely drop the entire patch set and to leave this 
bug open.

The mandatory core fixes that I see (for the short/mid term) are at least 
Antonios' patches plus my variable length prefix patch, the latter significantly 
reduces the inode numbers on guest and significantly increases the inode name 
space, and hence also significanlty reduces the propability that 9p might ever 
need to kick in with any kind of expensive remapping actions (or even 
something worse like stat fatally returning -ENFILE to the user).

About the "vii" configuration, even though you don't like the idea: there is 
also a big difference giving the user the _optional_ possibility to define e.g. 
one path (not device) on guest said to be sensitive regarding high inode 
numbers on guest; and something completely different telling the user that he 
_must_ configure every single device from host that is ever supposed to pop up 
with 9p on guest and forcing the user to update that configuration whenever a 
new device is added or removed on host. The "vii" configuration feature does 
not require any knowledge of how many and which kinds of devices are actually 
ever used on host (nor on any higher level host in case of nested 
virtualization), nor does that "vii" config require any changes ever when host 
device setup changes. So 9p's core transparency feature would not be touched 
at all.

> It might take me some more rounds of discussion to decide. I understand
> it is frustrating but bear with me :)

Let me make a different suggestion: how about putting these fixes into a 
separate C unit for now and making the default behaviour (if you really want) 
to not use any of that code by default at all. So the user would just get an 
error message in the qemu log files by default if he tries to export several 
devices with one 9p device, suggesting him either to map them as separate 9p 
devices (like you suggested) and informing the user about the alternative of 
enabling support for the automatic inode remapping code (from that separate C 
unit) instead by adding one convenient config option if he/she really wants.

That way we would have a fix now, not in years, people can decide to use the 
automatic and hardware transparent solution, instead of being forced to write 
dozens of config lines for each single guest, or they might decide to stick 
with your "solution" ;-).

And once the long term solution for this issue with variable length QIDs is in 
place, the inode remapping code can very simply be dropped from the code base 
completley by just deleting the C unit and about a hand full of lines in 9p.c 
or so, and hence this fix would not bloat the existing 9p units nor cause 
maintenance nightmares of any kind.

Best regards,
Christian Schoenebeck

