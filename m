Return-Path: <SRS0=/TIv=YJ=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04E0AC4360C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 09:43:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C408120872
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Oct 2019 09:43:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (4096-bit key) header.d=crudebyte.com header.i=@crudebyte.com header.b="XOM4MLH7"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C408120872
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=crudebyte.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:40192 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iKfqS-0006Qn-W3
	for qemu-devel@archiver.kernel.org; Wed, 16 Oct 2019 05:43:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:58026)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iKfpc-0005gN-QE
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 05:43:02 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <qemu_oss@crudebyte.com>) id 1iKfpb-0000FG-HO
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 05:43:00 -0400
Received: from kylie.crudebyte.com ([5.189.157.229]:42811)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <qemu_oss@crudebyte.com>)
 id 1iKfpb-0000Ei-11
 for qemu-devel@nongnu.org; Wed, 16 Oct 2019 05:42:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=78CcBbfs0w6l5MAR8UwHCVul7YOQocHD7+6l3P7gSkg=; b=XOM4MLH7sAYL1+NlcY5BS5ZIeR
 FbAoyTUTDJXrivTKPk/UexVdU2w7LViQFScdTK4On8LqKqOipkw1ZrMBRZrZfbu2TwMHL/nYfvR1L
 XL9mBb6zRs5+aVQuOiYd2cWU3C60SVcgKBchW/AhRX9k3CAVRVJh1rgYXuJEkPkF2PzRUcrKLE3wx
 zfUAzTEYgTNCLNHXUyo//sVJ3D9Q1OSPHGQCXIeJHQLyRL96a9KDUeKMFT8hRsjPWZm6M8Rt+7TaG
 JjDpUupBqet7FoHcoMzJxG9kR+QCOpehS4beSy4/NNBhdDTT70mKu/bYY8t3XJNbLTT7jjGIDxBE5
 YCrFRNKe19y2led03G7LEqIPJEmzpmndeNKfI9UPf0lIIyoifPGLhlA2m9eKZMMxckxZqVsYJf+gB
 +HzOZTSNgM+psO9RpabDey3DwDUH+VpsP1uMY+VKsggpz5Y5Xte/rNWaebp3q2SMu+NCutJyJAVix
 7eEn1HMha55wgJviNrtJ7OR7LtGr8Ci5iKp8sDMbpqfFjaP/vIJTcRsgWEJuSn5A81TvfgnduKlxn
 wmdAD28w2hIzmo9NRZ37rU4kA+ncyNxPTWDH1KAKyGTzH9gYwubwdQrKUfl5hJ5peu4zq9kTwiKy3
 663j4ZS+zbyTjJOOeeXUaZaUbcgEjC1lmq5ZJdRxY=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Stefan Hajnoczi <stefanha@gmail.com>,
 Daniel =?ISO-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Antonios Motakis <antonios.motakis@huawei.com>,
 "Dr. David Alan Gilbert" <dgilbert@redhat.com>
Subject: Re: virtio-fs: Fix file ID collisions (was: 9p: Fix file ID
 collisions)
Date: Wed, 16 Oct 2019 11:42:52 +0200
Message-ID: <4114483.KuMf1QML1b@silver>
In-Reply-To: <20191015112039.620997e3@bahia.lan>
References: <cover.1567680121.git.qemu_oss@crudebyte.com>
 <2456208.kOTvEbKLdM@silver> <20191015112039.620997e3@bahia.lan>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 5.189.157.229
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On Dienstag, 15. Oktober 2019 11:20:39 CEST Greg Kurz wrote:
> On Tue, 08 Oct 2019 14:05:28 +0200
> 
> Christian Schoenebeck <qemu_oss@crudebyte.com> wrote:
> > I wonder though whether virtio-fs suffers from the same file ID collisions
> > problem when sharing multiple file systems.
> 
> I gave a try and it seems that virtio-fs might expose the inode numbers from
> different devices in the host, unvirtualized AND with the same device in
> the guest:
> 
> # mkdir -p /var/tmp/virtio-fs/proc
> # mount --bind /proc /var/tmp/virtio-fs/proc
> # virtiofsd -o vhost_user_socket=/tmp/vhostqemu -o source=/var/tmp/virtio-fs
> -o cache=always
> 
> and then started QEMU with:
> 
> -chardev socket,id=char0,path=/tmp/vhostqemu \
> -device vhost-user-fs-pci,queue-size=1024,chardev=char0,tag=myfs \
> -m 4G -object memory-backend-file,id=mem,size=4G,mem-path=/dev/shm,share=on
> \ -numa node,memdev=mem
> 
> In the host:
> 
> $ stat /var/tmp/virtio-fs
>   File: /var/tmp/virtio-fs
>   Size: 4096            Blocks: 8          IO Block: 4096   directory
> Device: fd00h/64768d    Inode: 787796      Links: 4
> Access: (0775/drwxrwxr-x)  Uid: ( 1000/    greg)   Gid: ( 1000/    greg)
> Context: unconfined_u:object_r:user_tmp_t:s0
> Access: 2019-10-15 11:08:52.070080922 +0200
> Modify: 2019-10-15 11:02:09.887404446 +0200
> Change: 2019-10-15 11:02:09.887404446 +0200
>  Birth: 2019-10-13 19:13:04.009699354 +0200
> [greg@bahia ~]$ stat /var/tmp/virtio-fs/FOO
>   File: /var/tmp/virtio-fs/FOO
>   Size: 0               Blocks: 0          IO Block: 4096   regular empty
> file Device: fd00h/64768d    Inode: 790740      Links: 1
> Access: (0664/-rw-rw-r--)  Uid: ( 1000/    greg)   Gid: ( 1000/    greg)
> Context: unconfined_u:object_r:user_tmp_t:s0
> Access: 2019-10-15 11:02:09.888404448 +0200
> Modify: 2019-10-15 11:02:09.888404448 +0200
> Change: 2019-10-15 11:02:09.888404448 +0200
>  Birth: 2019-10-15 11:02:09.887404446 +0200
> [greg@bahia ~]$ stat /var/tmp/virtio-fs/proc/fs
>   File: /var/tmp/virtio-fs/proc/fs
>   Size: 0               Blocks: 0          IO Block: 1024   directory
> Device: 4h/4d   Inode: 4026531845  Links: 5
> Access: (0555/dr-xr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> Context: system_u:object_r:proc_t:s0
> Access: 2019-10-01 14:50:09.223233901 +0200
> Modify: 2019-10-01 14:50:09.223233901 +0200
> Change: 2019-10-01 14:50:09.223233901 +0200
>  Birth: -
> 
> In the guest:
> 
> [greg@localhost ~]$ stat /mnt
>   File: /mnt
>   Size: 4096            Blocks: 8          IO Block: 4096   directory
> Device: 2dh/45d Inode: 787796      Links: 4
> Access: (0775/drwxrwxr-x)  Uid: ( 1000/    greg)   Gid: ( 1000/    greg)
> Context: system_u:object_r:unlabeled_t:s0
> Access: 2019-10-15 11:08:52.070080922 +0200
> Modify: 2019-10-15 11:02:09.887404446 +0200
> Change: 2019-10-15 11:02:09.887404446 +0200
>  Birth: -
> [greg@localhost ~]$ stat /mnt/FOO
>   File: /mnt/FOO
>   Size: 0               Blocks: 0          IO Block: 4096   regular empty
> file Device: 2dh/45d Inode: 790740      Links: 1
> Access: (0664/-rw-rw-r--)  Uid: ( 1000/    greg)   Gid: ( 1000/    greg)
> Context: system_u:object_r:unlabeled_t:s0
> Access: 2019-10-15 11:02:09.888404448 +0200
> Modify: 2019-10-15 11:02:09.888404448 +0200
> Change: 2019-10-15 11:02:09.888404448 +0200
>  Birth: -
> [greg@localhost ~]$ stat /mnt/proc/fs
>   File: /mnt/proc/fs
>   Size: 0               Blocks: 0          IO Block: 1024   directory
> Device: 2dh/45d Inode: 4026531845  Links: 5
> Access: (0555/dr-xr-xr-x)  Uid: (    0/    root)   Gid: (    0/    root)
> Context: system_u:object_r:unlabeled_t:s0
> Access: 2019-10-01 14:50:09.223233901 +0200
> Modify: 2019-10-01 14:50:09.223233901 +0200
> Change: 2019-10-01 14:50:09.223233901 +0200
>  Birth: -
> 
> Unless I'm missing something, it seems that "virtio-fs" has the same
> issue we had on 9pfs before Christian's patches... :-\

Is a fix for this desired for virtio-fs?

Greg, did you have to update kernel version on either host or guest side to 
get virtio-fs running? Or were the discussed kernel changes just for optional 
acceleration purposes (i.e. DAX)?

Best regards,
Christian Schoenebeck



