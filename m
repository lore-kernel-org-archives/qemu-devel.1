Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE25EFA3728
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 13:45:17 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A6A1421928
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 13:45:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A6A1421928
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:42846 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKjc4-0001WY-Mm
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 09:45:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:59362)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dgilbert@redhat.com>) id 1iKjb6-00016h-Vy
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 09:44:18 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dgilbert@redhat.com>) id 1iKjb5-0001Jc-8w
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 09:44:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38342)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dgilbert@redhat.com>) id 1iKjb5-0001Il-0j
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 09:44:15 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 2CC2B693CB;
 Wed, 16 Oct 2019 13:44:13 +0000 (UTC)
Received: from work-vm (ovpn-117-133.ams2.redhat.com [10.36.117.133])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 948991048128;
 Wed, 16 Oct 2019 13:44:11 +0000 (UTC)
Date: Wed, 16 Oct 2019 14:44:09 +0100
From: "Dr. David Alan Gilbert" <dgilbert@redhat.com>
To: Christian Schoenebeck <qemu_oss@crudebyte.com>
Subject: Re: virtio-fs: Fix file ID collisions (was: 9p: Fix file ID
 collisions)
Message-ID: <20191016134409.GG2978@work-vm>
References: <cover.1567680121.git.qemu_oss@crudebyte.com>
 <2456208.kOTvEbKLdM@silver> <20191015112039.620997e3@bahia.lan>
 <4114483.KuMf1QML1b@silver>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4114483.KuMf1QML1b@silver>
User-Agent: Mutt/1.12.1 (2019-06-15)
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.25]); Wed, 16 Oct 2019 13:44:13 +0000 (UTC)
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 209.132.183.28
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
Cc: Stefan Hajnoczi <stefanha@gmail.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Antonios Motakis <antonios.motakis@huawei.com>,
 Greg Kurz <groug@kaod.org>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

* Christian Schoenebeck (qemu_oss@crudebyte.com) wrote:
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

Yes I think so;  we had originally thought we were hiding the host inode
numbers; but that's not true - since we pass both a device and inode
number in virtiofs, unlike 9p, it seems we can probably get away with
only remapping device IDs rather than inode numbers; but that requires
some understanding of how multiple block device IDs are supposed to look
like to the guest kernel.

Dave

> Greg, did you have to update kernel version on either host or guest side to 
> get virtio-fs running? Or were the discussed kernel changes just for optional 
> acceleration purposes (i.e. DAX)?
> 
> Best regards,
> Christian Schoenebeck
> 
> 
--
Dr. David Alan Gilbert / dgilbert@redhat.com / Manchester, UK

