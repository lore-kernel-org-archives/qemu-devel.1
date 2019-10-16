Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25901FA372A
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 14:01:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF6282067B
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 14:01:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF6282067B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kaod.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:43010 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKjrq-0001UZ-Cn
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 10:01:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:33430)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <groug@kaod.org>) id 1iKjqo-0000yv-HV
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:00:31 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <groug@kaod.org>) id 1iKjqj-00018m-6n
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:00:30 -0400
Received: from 6.mo178.mail-out.ovh.net ([46.105.53.132]:57305)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <groug@kaod.org>) id 1iKjqj-00015g-0i
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 10:00:25 -0400
Received: from player746.ha.ovh.net (unknown [10.109.159.191])
 by mo178.mail-out.ovh.net (Postfix) with ESMTP id 1DD027C432
 for <qemu-devel@nongnu.org>; Wed, 16 Oct 2019 16:00:15 +0200 (CEST)
Received: from kaod.org (lns-bzn-46-82-253-208-248.adsl.proxad.net
 [82.253.208.248]) (Authenticated sender: groug@kaod.org)
 by player746.ha.ovh.net (Postfix) with ESMTPSA id EDF6BB22DFE0;
 Wed, 16 Oct 2019 14:00:09 +0000 (UTC)
Date: Wed, 16 Oct 2019 16:00:08 +0200
From: Greg Kurz <groug@kaod.org>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: virtio-fs: Fix file ID collisions (was: 9p: Fix file ID
 collisions)
Message-ID: <20191016160008.353ec96a@bahia.lan>
In-Reply-To: <4114483.KuMf1QML1b@silver>
References: <cover.1567680121.git.qemu_oss@crudebyte.com>
 <2456208.kOTvEbKLdM@silver> <20191015112039.620997e3@bahia.lan>
 <4114483.KuMf1QML1b@silver>
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Ovh-Tracer-Id: 2481201923411450176
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: -100
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedufedrjeehgdejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfqggfjpdevjffgvefmvefgnecuuegrihhlohhuthemucehtddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 46.105.53.132
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>, qemu-devel@nongnu.org,
 Antonios Motakis <antonios.motakis@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Wed, 16 Oct 2019 11:42:52 +0200
Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:

> On Dienstag, 15. Oktober 2019 11:20:39 CEST Greg Kurz wrote:
> > On Tue, 08 Oct 2019 14:05:28 +0200
> > 
> > Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > > I wonder though whether virtio-fs suffers from the same file ID collisions
> > > problem when sharing multiple file systems.
> > 
> > I gave a try and it seems that virtio-fs might expose the inode numbers from
> > different devices in the host, unvirtualized AND with the same device in
> > the guest:
> > 
> > # mkdir -p /var/tmp/virtio-fs/proc
> > # mount --bind /proc /var/tmp/virtio-fs/proc
> > # virtiofsd -o vhost_user_socket=/tmp/vhostqemu -o source=/var/tmp/virtio-fs
> > -o cache=always
> > 
> > and then started QEMU with:
> > 
> > -chardev socket,id=char0,path=/tmp/vhostqemu \
> > -device vhost-user-fs-pci,queue-size=1024,chardev=char0,tag=myfs \
> > -m 4G -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on
> > \ -numa node,memdev=mem
> > 
> > In the host:
> > 
> > $ stat /var/tmp/virtio-fs
> >   File: /var/tmp/virtio-fs
> >   Size: 4096            Blocks: 8          IO Block: 4096   directory
> > Device: fd00h/64768d    Inode: 787796      Links: 4
> > Access: (0775/drwxrwxr-x)  Uid: ( 1000/    greg)   Gid: ( 1000/    greg)
> > Context: unconfined_u:object_r:user_tmp_t:s0
> > Access: 2019-10-15 11:08:52.070080922 +0200
> > Modify: 2019-10-15 11:02:09.887404446 +0200
> > Change: 2019-10-15 11:02:09.887404446 +0200
> >  Birth: 2019-10-13 19:13:04.009699354 +0200
> > [greg@bahia ~]$ stat /var/tmp/virtio-fs/FOO
> >   File: /var/tmp/virtio-fs/FOO
> >   Size: 0               Blocks: 0          IO Block: 4096   regular empty
> > file Device: fd00h/64768d    Inode: 790740      Links: 1
> > Access: (0664/-rw-rw-r--)  Uid: ( 1000/    greg)   Gid: ( 1000/    greg)
> > Context: unconfined_u:object_r:user_tmp_t:s0
> > Access: 2019-10-15 11:02:09.888404448 +0200
> > Modify: 2019-10-15 11:02:09.888404448 +0200
> > Change: 2019-10-15 11:02:09.888404448 +0200
> >  Birth: 2019-10-15 11:02:09.887404446 +0200
> > [greg@bahia ~]$ stat /var/tmp/virtio-fs/proc/fs
> >   File: /var/tmp/virtio-fs/proc/fs
> >   Size: 0               Blocks: 0          IO Block: 1024   directory
> > Device: 4h/4d   Inode: 4026531845  Links: 5
> > Access: (0555/dr-xr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> > Context: system_u:object_r:proc_t:s0
> > Access: 2019-10-01 14:50:09.223233901 +0200
> > Modify: 2019-10-01 14:50:09.223233901 +0200
> > Change: 2019-10-01 14:50:09.223233901 +0200
> >  Birth: -
> > 
> > In the guest:
> > 
> > [greg@localhost ~]$ stat /mnt
> >   File: /mnt
> >   Size: 4096            Blocks: 8          IO Block: 4096   directory
> > Device: 2dh/45d Inode: 787796      Links: 4
> > Access: (0775/drwxrwxr-x)  Uid: ( 1000/    greg)   Gid: ( 1000/    greg)
> > Context: system_u:object_r:unlabeled_t:s0
> > Access: 2019-10-15 11:08:52.070080922 +0200
> > Modify: 2019-10-15 11:02:09.887404446 +0200
> > Change: 2019-10-15 11:02:09.887404446 +0200
> >  Birth: -
> > [greg@localhost ~]$ stat /mnt/FOO
> >   File: /mnt/FOO
> >   Size: 0               Blocks: 0          IO Block: 4096   regular empty
> > file Device: 2dh/45d Inode: 790740      Links: 1
> > Access: (0664/-rw-rw-r--)  Uid: ( 1000/    greg)   Gid: ( 1000/    greg)
> > Context: system_u:object_r:unlabeled_t:s0
> > Access: 2019-10-15 11:02:09.888404448 +0200
> > Modify: 2019-10-15 11:02:09.888404448 +0200
> > Change: 2019-10-15 11:02:09.888404448 +0200
> >  Birth: -
> > [greg@localhost ~]$ stat /mnt/proc/fs
> >   File: /mnt/proc/fs
> >   Size: 0               Blocks: 0          IO Block: 1024   directory
> > Device: 2dh/45d Inode: 4026531845  Links: 5
> > Access: (0555/dr-xr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> > Context: system_u:object_r:unlabeled_t:s0
> > Access: 2019-10-01 14:50:09.223233901 +0200
> > Modify: 2019-10-01 14:50:09.223233901 +0200
> > Change: 2019-10-01 14:50:09.223233901 +0200
> >  Birth: -
> > 
> > Unless I'm missing something, it seems that "virtio-fs" has the same
> > issue we had on 9pfs before Christian's patches... :-\
> 
> Is a fix for this desired for virtio-fs?
> 

Probably. Dave and/or Stefan should know what is needed.

> Greg, did you have to update kernel version on either host or guest side to 

I didn't change the kernel on the host (5.2.17-200.fc30.x86_64) but the 
victim guest was running upstream kernel (SHA1 5bc52f64e8841).

> get virtio-fs running? Or were the discussed kernel changes just for optional 
> acceleration purposes (i.e. DAX)?
> 
> Best regards,
> Christian Schoenebeck
> 
> 


