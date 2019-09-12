Return-Path: <SRS0=eeqW=XH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44200C4CEC5
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:02:38 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0E41B20830
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2019 12:02:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0E41B20830
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33666 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1i8No5-0001id-0M
	for qemu-devel@archiver.kernel.org; Thu, 12 Sep 2019 08:02:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:47216)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1i8Nmo-0000rw-Dr
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:01:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1i8Nmm-0008TC-F0
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:01:18 -0400
Received: from indium.canonical.com ([91.189.90.7]:57620)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1i8Nml-0008Rs-Gx
 for qemu-devel@nongnu.org; Thu, 12 Sep 2019 08:01:16 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1i8Nmk-00054q-5G
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 12:01:14 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 23BE92E80C7
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2019 12:01:14 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Sep 2019 11:50:48 -0000
From: Stefan Hajnoczi <1842787@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jamespharvey20 stefanha
X-Launchpad-Bug-Reporter: James Harvey (jamespharvey20)
X-Launchpad-Bug-Modifier: Stefan Hajnoczi (stefanha)
References: <156765384458.824.9301349840467221970.malonedeb@wampee.canonical.com>
 <156765492325.17024.3771322746781962015.launchpad@gac.canonical.com>
Message-Id: <20190912115048.GE23174@stefanha-x1.localdomain>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19044";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 0e4dbeeb712b13ec442aff92fe19d2c2cb72cec7
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: Re: [Qemu-devel] [Bug 1842787] Re: Writes permanently hang with
 very heavy I/O on virtio-scsi - worse on virtio-blk
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.23
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1842787 <1842787@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190912115048.BwxAPpOLDEbZIoW7KUL0uytXMcdKQ5a5ivu6x62OoGI@z>

On Thu, Sep 05, 2019 at 03:42:03AM -0000, James Harvey wrote:
> ** Description changed:
> =

>   Up to date Arch Linux on host and guest.  linux 5.2.11.  QEMU 4.1.0.
>   Full command line at bottom.
>   =

>   Host gives QEMU two thin LVM volumes.  The first is the root filesystem,
>   and the second is for heavy I/O, on a Samsung 970 Evo 1TB.
>   =

>   When maxing out the I/O on the second virtual block device using virtio-
>   blk, I often get a "lockup" in about an hour or two.  From the advise of
>   iggy in IRC, I switched over to virtio-scsi.  It ran perfectly for a few
>   days, but then "locked up" in the same way.
>   =

>   By "lockup", I mean writes to the second virtual block device
>   permanently hang.  I can read files from it, but even "touch foo" never
>   times out, cannot be "kill -9"'ed, and is stuck in uninterruptible
>   sleep.
>   =

>   When this happens, writes to the first virtual block device with the
>   root filesystem are fine, so the O/S itself remains responsive.
>   =

>   The second virtual block device uses BTRFS.  But, I have also tried XFS
>   and reproduced the issue.
>   =

>   In guest, when this starts, it starts logging "task X blocked for more
>   than Y seconds".  Below is an example of one of these.  At this point,
>   anything that is or does in the future write to this block device gets
>   stuck in uninterruptible sleep.
>   =

>   -----
>   =

>   INFO: task kcompactd:232 blocked for more than 860 seconds.
>   =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Not tained 5.2.11-1 #1
>   "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messae.
>   kcompactd0      D    0   232      2 0x80004000
>   Call Trace:
>   =C2=A0? __schedule+0x27f/0x6d0
>   =C2=A0schedule+0x3d/0xc0
>   =C2=A0io_schedule+0x12/0x40
>   =C2=A0__lock_page+0x14a/0x250
>   =C2=A0? add_to_page_cache_lru+0xe0/0xe0
>   =C2=A0migrate_pages+0x803/0xb70
>   =C2=A0? isolate_migratepages_block+0x9f0/0x9f0
>   =C2=A0? __reset_isolation_suitable+0x110/0x110
>   =C2=A0compact_zone+0x6a2/0xd30
>   =C2=A0kcompactd_do_work+0x134/0x260
>   =C2=A0? kvm_clock_read+0x14/0x30
>   =C2=A0? kvm_sched_clock_read+0x5/0x10
>   =C2=A0kcompactd+0xd3/0x220
>   =C2=A0? wait_woken+0x80/0x80
>   =C2=A0kthread+0xfd/0x130
>   =C2=A0? kcompactd_do_work+0x260/0x260
>   =C2=A0? kthread_park+0x80/0x80
>   =C2=A0ret_from_fork+0x35/0x40
>   =

>   -----
>   =

>   In guest, there are no other dmesg/journalctl entries other than
>   "task...blocked".
>   =

>   On host, there are no dmesg/journalctl entries whatsoever.  Everything
>   else in host continues to work fine, including other QEMU VM's on the
>   same underlying SSD (but obviously different lvm volumes.)
>   =

>   I understand there might not be enough to go on here, and I also
>   understand it's possible this isn't a QEMU bug.  Happy to run given
>   commands or patches to help diagnose what's going on here.
>   =

>   I'm now running a custom compiled QEMU 4.1.0, with debug symbols, so I
>   can get a meaningful backtrace from the host point of view.
>   =

>   I've only recently tried this level of I/O, so can't say if this is a
>   new issue.
>   =

> + When writes are hanging, on host, I can connect to the monitor.  Running
> + "info block" shows nothing unusual.
> + =

>   -----
>   =

>   /usr/bin/qemu-system-x86_64
>   =C2=A0=C2=A0=C2=A0-name arch,process=3Dqemu:arch
>   =C2=A0=C2=A0=C2=A0-no-user-config
>   =C2=A0=C2=A0=C2=A0-nodefaults
>   =C2=A0=C2=A0=C2=A0-nographic
>   =C2=A0=C2=A0=C2=A0-uuid 0528162b-2371-41d5-b8da-233fe61b6458
>   =C2=A0=C2=A0=C2=A0-pidfile /tmp/0528162b-2371-41d5-b8da-233fe61b6458.pid
>   =C2=A0=C2=A0=C2=A0-machine q35,accel=3Dkvm,vmport=3Doff,dump-guest-core=
=3Doff
>   =C2=A0=C2=A0=C2=A0-cpu SandyBridge-IBRS
>   =C2=A0=C2=A0=C2=A0-smp cpus=3D24,cores=3D12,threads=3D1,sockets=3D2
>   =C2=A0=C2=A0=C2=A0-m 24G
>   =C2=A0=C2=A0=C2=A0-drive if=3Dpflash,format=3Draw,readonly,file=3D/usr/=
share/ovmf/x64/OVMF_CODE.fd
>   =C2=A0=C2=A0=C2=A0-drive if=3Dpflash,format=3Draw,readonly,file=3D/var/=
qemu/0528162b-2371-41d5-b8da-233fe61b6458.fd
>   =C2=A0=C2=A0=C2=A0-monitor telnet:localhost:8000,server,nowait,nodelay
>   =C2=A0=C2=A0=C2=A0-spice unix,addr=3D/tmp/0528162b-2371-41d5-b8da-233fe=
61b6458.sock,disable-ticketing
>   =C2=A0=C2=A0=C2=A0-device ioh3420,id=3Dpcie.1,bus=3Dpcie.0,slot=3D0
>   =C2=A0=C2=A0=C2=A0-device virtio-vga,bus=3Dpcie.1,addr=3D0
>   =C2=A0=C2=A0=C2=A0-usbdevice tablet
>   =C2=A0=C2=A0=C2=A0-netdev bridge,id=3Dnetwork0,br=3Dbr0
>   =C2=A0=C2=A0=C2=A0-device virtio-net-pci,netdev=3Dnetwork0,mac=3D02:37:=
de:79:19:09,bus=3Dpcie.0,addr=3D3
>   =C2=A0=C2=A0=C2=A0-device virtio-scsi-pci,id=3Dscsi1
>   =C2=A0=C2=A0=C2=A0-drive driver=3Draw,node-name=3Dhd0,file=3D/dev/lvm/a=
rch_root,if=3Dnone,discard=3Dunmap
>   =C2=A0=C2=A0=C2=A0-device scsi-hd,drive=3Dhd0,bootindex=3D1
>   =C2=A0=C2=A0=C2=A0-drive driver=3Draw,node-name=3Dhd1,file=3D/dev/lvm/a=
rch_nvme,if=3Dnone,discard=3Dunmap
>   =C2=A0=C2=A0=C2=A0-device scsi-hd,drive=3Dhd1,bootindex=3D2

Please post backtrace of all QEMU threads when I/O is hung.  You can use
"gdb -p $(pidog qemu-system-x86_64)" to connect GDB and "thread apply
all bt" to produce a backtrace of all threads.

Stefan

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1842787

Title:
  Writes permanently hang with very heavy I/O on virtio-scsi - worse on
  virtio-blk

Status in QEMU:
  New

Bug description:
  Up to date Arch Linux on host and guest.  linux 5.2.11.  QEMU 4.1.0.
  Full command line at bottom.

  Host gives QEMU two thin LVM volumes.  The first is the root
  filesystem, and the second is for heavy I/O, on a Samsung 970 Evo 1TB.

  When maxing out the I/O on the second virtual block device using
  virtio-blk, I often get a "lockup" in about an hour or two.  From the
  advise of iggy in IRC, I switched over to virtio-scsi.  It ran
  perfectly for a few days, but then "locked up" in the same way.

  By "lockup", I mean writes to the second virtual block device
  permanently hang.  I can read files from it, but even "touch foo"
  never times out, cannot be "kill -9"'ed, and is stuck in
  uninterruptible sleep.

  When this happens, writes to the first virtual block device with the
  root filesystem are fine, so the O/S itself remains responsive.

  The second virtual block device uses BTRFS.  But, I have also tried
  XFS and reproduced the issue.

  In guest, when this starts, it starts logging "task X blocked for more
  than Y seconds".  Below is an example of one of these.  At this point,
  anything that is or does in the future write to this block device gets
  stuck in uninterruptible sleep.

  -----

  INFO: task kcompactd:232 blocked for more than 860 seconds.
  =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0Not tained 5.2.11-1 #1
  "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messae.
  kcompactd0      D    0   232      2 0x80004000
  Call Trace:
  =C2=A0? __schedule+0x27f/0x6d0
  =C2=A0schedule+0x3d/0xc0
  =C2=A0io_schedule+0x12/0x40
  =C2=A0__lock_page+0x14a/0x250
  =C2=A0? add_to_page_cache_lru+0xe0/0xe0
  =C2=A0migrate_pages+0x803/0xb70
  =C2=A0? isolate_migratepages_block+0x9f0/0x9f0
  =C2=A0? __reset_isolation_suitable+0x110/0x110
  =C2=A0compact_zone+0x6a2/0xd30
  =C2=A0kcompactd_do_work+0x134/0x260
  =C2=A0? kvm_clock_read+0x14/0x30
  =C2=A0? kvm_sched_clock_read+0x5/0x10
  =C2=A0kcompactd+0xd3/0x220
  =C2=A0? wait_woken+0x80/0x80
  =C2=A0kthread+0xfd/0x130
  =C2=A0? kcompactd_do_work+0x260/0x260
  =C2=A0? kthread_park+0x80/0x80
  =C2=A0ret_from_fork+0x35/0x40

  -----

  In guest, there are no other dmesg/journalctl entries other than
  "task...blocked".

  On host, there are no dmesg/journalctl entries whatsoever.  Everything
  else in host continues to work fine, including other QEMU VM's on the
  same underlying SSD (but obviously different lvm volumes.)

  I understand there might not be enough to go on here, and I also
  understand it's possible this isn't a QEMU bug.  Happy to run given
  commands or patches to help diagnose what's going on here.

  I'm now running a custom compiled QEMU 4.1.0, with debug symbols, so I
  can get a meaningful backtrace from the host point of view.

  I've only recently tried this level of I/O, so can't say if this is a
  new issue.

  When writes are hanging, on host, I can connect to the monitor.
  Running "info block" shows nothing unusual.

  -----

  /usr/bin/qemu-system-x86_64
  =C2=A0=C2=A0=C2=A0-name arch,process=3Dqemu:arch
  =C2=A0=C2=A0=C2=A0-no-user-config
  =C2=A0=C2=A0=C2=A0-nodefaults
  =C2=A0=C2=A0=C2=A0-nographic
  =C2=A0=C2=A0=C2=A0-uuid 0528162b-2371-41d5-b8da-233fe61b6458
  =C2=A0=C2=A0=C2=A0-pidfile /tmp/0528162b-2371-41d5-b8da-233fe61b6458.pid
  =C2=A0=C2=A0=C2=A0-machine q35,accel=3Dkvm,vmport=3Doff,dump-guest-core=
=3Doff
  =C2=A0=C2=A0=C2=A0-cpu SandyBridge-IBRS
  =C2=A0=C2=A0=C2=A0-smp cpus=3D24,cores=3D12,threads=3D1,sockets=3D2
  =C2=A0=C2=A0=C2=A0-m 24G
  =C2=A0=C2=A0=C2=A0-drive if=3Dpflash,format=3Draw,readonly,file=3D/usr/sh=
are/ovmf/x64/OVMF_CODE.fd
  =C2=A0=C2=A0=C2=A0-drive if=3Dpflash,format=3Draw,readonly,file=3D/var/qe=
mu/0528162b-2371-41d5-b8da-233fe61b6458.fd
  =C2=A0=C2=A0=C2=A0-monitor telnet:localhost:8000,server,nowait,nodelay
  =C2=A0=C2=A0=C2=A0-spice unix,addr=3D/tmp/0528162b-2371-41d5-b8da-233fe61=
b6458.sock,disable-ticketing
  =C2=A0=C2=A0=C2=A0-device ioh3420,id=3Dpcie.1,bus=3Dpcie.0,slot=3D0
  =C2=A0=C2=A0=C2=A0-device virtio-vga,bus=3Dpcie.1,addr=3D0
  =C2=A0=C2=A0=C2=A0-usbdevice tablet
  =C2=A0=C2=A0=C2=A0-netdev bridge,id=3Dnetwork0,br=3Dbr0
  =C2=A0=C2=A0=C2=A0-device virtio-net-pci,netdev=3Dnetwork0,mac=3D02:37:de=
:79:19:09,bus=3Dpcie.0,addr=3D3
  =C2=A0=C2=A0=C2=A0-device virtio-scsi-pci,id=3Dscsi1
  =C2=A0=C2=A0=C2=A0-drive driver=3Draw,node-name=3Dhd0,file=3D/dev/lvm/arc=
h_root,if=3Dnone,discard=3Dunmap
  =C2=A0=C2=A0=C2=A0-device scsi-hd,drive=3Dhd0,bootindex=3D1
  =C2=A0=C2=A0=C2=A0-drive driver=3Draw,node-name=3Dhd1,file=3D/dev/lvm/arc=
h_nvme,if=3Dnone,discard=3Dunmap
  =C2=A0=C2=A0=C2=A0-device scsi-hd,drive=3Dhd1,bootindex=3D2

  -----

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1842787/+subscriptions

