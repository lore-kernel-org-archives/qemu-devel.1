Return-Path: <SRS0=uFRu=5R=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89524C43331
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 18:28:56 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5908720787
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2020 18:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5908720787
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=proxmox.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:35764 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1jJi6h-0008Uy-7f
	for qemu-devel@archiver.kernel.org; Wed, 01 Apr 2020 14:28:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:53378)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <dietmar@proxmox.com>) id 1jJi62-00080X-FF
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:28:15 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <dietmar@proxmox.com>) id 1jJi61-0005mT-76
 for qemu-devel@nongnu.org; Wed, 01 Apr 2020 14:28:14 -0400
Received: from proxmox-new.maurer-it.com ([212.186.127.180]:26528)
 by eggs.gnu.org with esmtps (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
 (Exim 4.71) (envelope-from <dietmar@proxmox.com>)
 id 1jJi5y-00051L-MY; Wed, 01 Apr 2020 14:28:10 -0400
Received: from proxmox-new.maurer-it.com (localhost.localdomain [127.0.0.1])
 by proxmox-new.maurer-it.com (Proxmox) with ESMTP id 8695B45939;
 Wed,  1 Apr 2020 20:28:06 +0200 (CEST)
Date: Wed, 1 Apr 2020 20:28:01 +0200 (CEST)
From: Dietmar Maurer <dietmar@proxmox.com>
To: Kevin Wolf <kwolf@redhat.com>
Message-ID: <1403939459.52.1585765681569@webmail.proxmox.com>
In-Reply-To: <20200401181256.GB27663@linux.fritz.box>
References: <658260883.24.1585644382441@webmail.proxmox.com>
 <20200331125804.GE7030@linux.fritz.box>
 <303038276.59.1585665152860@webmail.proxmox.com>
 <787d7517-bf56-72c7-d197-2313a864e05f@virtuozzo.com>
 <713436887.61.1585668262838@webmail.proxmox.com>
 <20200331153719.GI7030@linux.fritz.box>
 <518198448.62.1585671498399@webmail.proxmox.com>
 <20200401103748.GA4680@linux.fritz.box>
 <997901084.0.1585755465486@webmail.proxmox.com>
 <20200401181256.GB27663@linux.fritz.box>
Subject: Re: bdrv_drained_begin deadlock with io-threads
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Priority: 3
Importance: Normal
X-Mailer: Open-Xchange Mailer v7.10.2-Rev23
X-Originating-Client: open-xchange-appsuite
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 212.186.127.180
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
Reply-To: Dietmar Maurer <dietmar@proxmox.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@virtuozzo.com>,
 qemu-block@nongnu.org, Sergio Lopez <slp@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, Max Reitz <mreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, "jsnow@redhat.com" <jsnow@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

> That's a pretty big change, and I'm not sure how it's related to
> completed requests hanging in the thread pool instead of reentering the
> file-posix coroutine. But I also tested it enough that I'm confident
> it's really the first bad commit.
> 
> Maybe you want to try if your problem starts at the same commit?

Stefan already found that by bisecting last week:

See: https://lists.gnu.org/archive/html/qemu-devel/2020-03/msg07629.html

But, IMHO the commit is not the reason for (my) bug - It just makes
it easier to trigger... I can see (my) bug sometimes with 4.1.1, although
I have no easy way to reproduce it reliable.

Also, Stefan sent some patches to the list to fix some of the problems.

https://lists.gnu.org/archive/html/qemu-devel/2020-04/msg00022.html

Does that fix your problem?

I will run further tests with your script, thanks.

> Kevin
> 
> 
> #!/bin/bash
> 
> qmp() {
> cat <<EOF
> {'execute':'qmp_capabilities'}
> EOF
> 
> while true; do
> cat <<EOF
> { "execute": "drive-backup", "arguments": {
>   "job-id":"drive_image1","device": "drive_image1", "sync": "full", "target": "/tmp/backup.raw" } }
> EOF
> sleep 1
> cat <<EOF
> { "execute": "block-job-cancel", "arguments": { "device": "drive_image1"} }
> EOF
> sleep 2
> done
> }
> 
> ./qemu-img create -f qcow2 /tmp/test.qcow2 4G
> for i in $(seq 0 1); do echo "write ${i}G 1G"; done | ./qemu-io /tmp/test.qcow2
> 
> qmp | x86_64-softmmu/qemu-system-x86_64 \
>     -enable-kvm \
>     -machine pc \
>     -m 1G \
>     -object 'iothread,id=iothread-virtioscsi0' \
>     -device 'virtio-scsi-pci,id=virtioscsi0,iothread=iothread-virtioscsi0' \
>     -blockdev node-name=my_drive,driver=file,filename=/tmp/test.qcow2 \
>     -blockdev driver=qcow2,node-name=drive_image1,file=my_drive \
>     -device scsi-hd,drive=drive_image1,id=image1 \
>     -cdrom ~/images/iso/RHEL-8.0-20190116.1-x86_64-dvd1.iso \
>     -boot d \
>     -qmp stdio -monitor vc


