Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3CA4C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 12:35:16 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2C1B205ED
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 12:35:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2C1B205ED
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:47953 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hRc4x-0008MZ-Mt
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 08:35:15 -0400
Received: from eggs.gnu.org ([209.51.188.92]:47351)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRc3L-0007Uf-Ne
	for qemu-devel@nongnu.org; Fri, 17 May 2019 08:33:37 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRc0c-0003lr-7H
	for qemu-devel@nongnu.org; Fri, 17 May 2019 08:30:47 -0400
Received: from 5.mo178.mail-out.ovh.net ([46.105.51.53]:51497)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hRc0c-0003a5-0v
	for qemu-devel@nongnu.org; Fri, 17 May 2019 08:30:46 -0400
Received: from player759.ha.ovh.net (unknown [10.108.42.88])
	by mo178.mail-out.ovh.net (Postfix) with ESMTP id D9829669AA
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 14:30:34 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player759.ha.ovh.net (Postfix) with ESMTPSA id 006FD5E88C17;
	Fri, 17 May 2019 12:30:30 +0000 (UTC)
Date: Fri, 17 May 2019 14:30:29 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190517143029.25454663@bahia.lan>
In-Reply-To: <8706106.MIJVTSuNya@silver>
References: <590216e2666653bac21d950aaba98f87d0a53324.1557093245.git.qemu_oss@crudebyte.com>
	<20190507174239.59ad26d1@bahia.lan> <1714809.tFt2Qa06yj@silver>
	<8706106.MIJVTSuNya@silver>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 12207569740520462656
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddtvddgheegucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 46.105.51.53
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

On Fri, 17 May 2019 10:40:48 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Dienstag, 7. Mai 2019 18:16:08 CEST Christian Schoenebeck wrote:
> > Here are the archive links for latest v3 patch set [5(+1) patches total]:
> > 
> > [PATCH v3 0/5] 9p: Fix file ID collisions:
> > https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01143.html
> > 
> > [PATCH v3 1/5] 9p: mitigates most QID path collisions:
> > https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01142.html
> > 
> > [PATCH v3 2/5] 9P: trivial cleanup of QID path collision mitigation:
> > https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01140.html
> > 
> > [PATCH v3 3/5] 9p: persistency of QID path beyond reboots / suspensions:
> > https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01144.html
> > 
> > [PATCH v3 4/5] 9p: use variable length suffixes for inode mapping:
> > https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01141.html
> > 
> > [PATCH v3 5/5] 9p: adds virtfs 'vii' device parameter
> > https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01138.html
> > 
> > And the optional libvirt patch:
> > 
> > [libvirt patch] qemu: adds support for virtfs 9p argument 'vii':
> > https://lists.gnu.org/archive/html/qemu-devel/2019-05/msg01223.html
> >   
> > > > Please just have a glimpse on that v3 thread, and before I address the
> > > > details that you requested (I have reviewed them all already and will
> > > > address them), I would like you to ask you for a coarse feedback on
> > > > design/features first.  
> > >   
> > > > Because there are some things where I am unresolved on design level yet:  
> > > 
> > > I'll try but probably not before next week.  
> 
> Hi Greg, you have not forgotten about me, did you? ;-)
> 

Hi Christian,

I have certainly not forgotten but I had (and still have) some more urgent
work to do and I couldn't find time for this... Sorry :)

> Or should I go ahead and provide a v4 next week addressing the issues 
> discussed so far?
> 

Thinking again about the initial issue raised by Antonios, I agree we
should at least detect collisions in the existing 9pfs code and
emit an error rather than silently returning duplicate QIDs to the
client. This would be patch 2 from Antonios's series: only allow
a single host device for a given fs device.

Then, we come to the bulk problem: how to handle the case where we
have multiple devices involved in a directory we want to share ?
Antonios's proposal is a clever way to address the collisions, but
your work proves it isn't enough... Before going forward, I'd like
to consider another approach.

What about:

1) de-compose the shared directory on a per-device basis,
   ie. identify all mount points under the shared directory

2) expose found mount points separately, each with its onw 9p device

3) re-compose the directory tree within the guest using the same topology
   as the host

ie. if you want to share /vm/fs and

/vm/fs on device A
/vm/fs/shares on device B
/vm/fs/tmp on device C

you would start QEMU with

-fsdev local,path=/vm/fs,id=fsdev0... \
-device virtio-9p,fsdev=fsdev0,mount_tag=tag0 \
-fsdev local,path=/vm/fs,id=fsdev1... \
-device virtio-9p,fsdev=fsdev1,mount_tag=tag1 \
-fsdev local,path=/vm/fs,id=fsdev2... \
-device virtio-9p,fsdev=fsdev2,mount_tag=tag2

and /etc/fstab in the guest:

tag0    /       9p      nofail,trans=virtio,version=9p2000.L   0 0
tag1    /shares 9p      nofail,trans=virtio,version=9p2000.L   0 0
tag2    /tmp    9p      nofail,trans=virtio,version=9p2000.L   0 0

This involves some more work for the user but it doesn't require
any changes in QEMU.

Would this approach solve the issues you've been hitting with Samba ?

Cheers,

--
Greg

