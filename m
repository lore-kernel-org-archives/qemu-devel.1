Return-Path: <SRS0=PxdI=TR=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6783C04AB4
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:49:47 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 98EB52166E
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2019 14:49:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 98EB52166E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:49719 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hReB8-0006tu-Sf
	for qemu-devel@archiver.kernel.org; Fri, 17 May 2019 10:49:46 -0400
Received: from eggs.gnu.org ([209.51.188.92]:46871)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRe9N-0005xm-SQ
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:47:58 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <groug@kaod.org>) id 1hRe9M-0004cc-K7
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:47:57 -0400
Received: from 18.mo4.mail-out.ovh.net ([188.165.54.143]:38278)
	by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.71) (envelope-from <groug@kaod.org>) id 1hRe9L-0004Vy-6w
	for qemu-devel@nongnu.org; Fri, 17 May 2019 10:47:56 -0400
Received: from player786.ha.ovh.net (unknown [10.108.57.72])
	by mo4.mail-out.ovh.net (Postfix) with ESMTP id 0429E1E7CB9
	for <qemu-devel@nongnu.org>; Fri, 17 May 2019 16:47:51 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
	[82.253.208.248]) (Authenticated sender: groug@kaod.org)
	by player786.ha.ovh.net (Postfix) with ESMTPSA id ECBA05FCC24A;
	Fri, 17 May 2019 14:47:47 +0000 (UTC)
Date: Fri, 17 May 2019 16:47:46 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Message-ID: <20190517164746.5c653a0e@bahia.lan>
In-Reply-To: <1723391.cvQaRflHa6@silver>
References: <590216e2666653bac21d950aaba98f87d0a53324.1557093245.git.qemu_oss@crudebyte.com>
	<8706106.MIJVTSuNya@silver> <20190517143029.25454663@bahia.lan>
	<1723391.cvQaRflHa6@silver>
X-Mailer: Claws Mail 3.16.0 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 14526079126470826304
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgeduuddruddtvddgkedvucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucesvcftvggtihhpihgvnhhtshculddquddttddm
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 188.165.54.143
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

On Fri, 17 May 2019 15:23:01 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Freitag, 17. Mai 2019 14:30:29 CEST Greg Kurz wrote:
> > Then, we come to the bulk problem: how to handle the case where we
> > have multiple devices involved in a directory we want to share ?
> > Antonios's proposal is a clever way to address the collisions, but
> > your work proves it isn't enough...  
> 
> With the patch set I have right now, things finally bahave smooth.
> 
> > Before going forward, I'd like
> > to consider another approach.
> > 
> > What about:
> > 
> > 1) de-compose the shared directory on a per-device basis,
> >    ie. identify all mount points under the shared directory
> > 
> > 2) expose found mount points separately, each with its onw 9p device
> > 
> > 3) re-compose the directory tree within the guest using the same topology
> >    as the host
> > 
> > ie. if you want to share /vm/fs and
> > 
> > /vm/fs on device A
> > /vm/fs/shares on device B
> > /vm/fs/tmp on device C
> > 
> > you would start QEMU with
> > 
> > -fsdev local,path=/vm/fs,id=fsdev0... \
> > -device virtio-9p,fsdev=fsdev0,mount_tag=tag0 \
> > -fsdev local,path=/vm/fs,id=fsdev1... \
> > -device virtio-9p,fsdev=fsdev1,mount_tag=tag1 \
> > -fsdev local,path=/vm/fs,id=fsdev2... \
> > -device virtio-9p,fsdev=fsdev2,mount_tag=tag2
> > 
> > and /etc/fstab in the guest:
> > 
> > tag0    /       9p      nofail,trans=virtio,version=9p2000.L   0 0
> > tag1    /shares 9p      nofail,trans=virtio,version=9p2000.L   0 0
> > tag2    /tmp    9p      nofail,trans=virtio,version=9p2000.L   0 0
> > 
> > This involves some more work for the user but it doesn't require
> > any changes in QEMU.  
> 
> So your suggestion is actually: don't fix it.
> 

Potentially yes if another approach is satisfying enough, as I wouldn't
want to over-engineer too much around this 9p imposed limitation. The
right thing to do would be to come up with a new version of the protocol
with variable sized QIDs and call it a day.

> "Some" more work for the user is a quantity of how many guests you are 
> running, multiplied by the nested virtualization levels you might have = 
> potentially a lot of work for admins.
> 

Maybe, I don't have enough feedback on 9p use cases to have a clear
picture...

> > Would this approach solve the issues you've been hitting with Samba ?  
> 
> No, because that completely neglects runtime changes on a higher level (host), 

Unless I'm missing something, runtime changes would be neglected as well
with the "vii" property since it is static for the device lifetime.

> plus it completely destroys the fundamental idea about 9p, which is about 
> transparency of the higher level(s).
> 

That's a point indeed, even if again I'm not sure if this is a frequent
case to share a directory tree spanning over multiple devices.

> May I ask, do you have concrete reasons why you want to abondon the entire 
> patch set? Because that's what it sounds to me.
> 

I don't have that much time to spend on 9p maintainership, for both
reviewing and fixing bugs (CVEs most of the time). So, yes it may
sound like I want to drop the patchset, but it's just I need to be
convinced I won't regret having merged a huge change like this...
when I'll have to support it alone later ;-)

For the moment, I'm not convinced by the "vii" solution. It even
motivated my suggestion of having several devices actually, since
the paths you would put in there are known before starting QEMU.

It might take me some more rounds of discussion to decide. I understand
it is frustrating but bear with me :)

> Best regards,
> Christian Schoenebeck

Cheers,

--
Greg

