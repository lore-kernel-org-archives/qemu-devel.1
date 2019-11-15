Return-Path: <SRS0=pQgJ=ZH=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BFA2C432C3
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 18:15:23 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DCB22073B
	for <qemu-devel@archiver.kernel.org>; Fri, 15 Nov 2019 18:15:23 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DCB22073B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:44184 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1iVg7u-0007cj-5W
	for qemu-devel@archiver.kernel.org; Fri, 15 Nov 2019 13:15:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:45979)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1iVg3U-0003C7-Ge
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 13:10:49 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1iVg3T-0005FM-1s
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 13:10:48 -0500
Received: from indium.canonical.com ([91.189.90.7]:51068)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1iVg3S-0005EM-SP
 for qemu-devel@nongnu.org; Fri, 15 Nov 2019 13:10:47 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1iVg3S-0003tT-4y
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 18:10:46 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 2072E2E80C3
 for <qemu-devel@nongnu.org>; Fri, 15 Nov 2019 18:10:46 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 15 Nov 2019 18:03:20 -0000
From: Colin Ian King <1852781@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: colin-king
X-Launchpad-Bug-Reporter: Colin Ian King (colin-king)
X-Launchpad-Bug-Modifier: Colin Ian King (colin-king)
References: <157384084797.7162.9983011521410421204.malonedeb@gac.canonical.com>
Message-Id: <157384100044.6190.8114127303659620615.malone@gac.canonical.com>
Subject: [Bug 1852781] Re: qemu s390x on focal - applications breaking
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="c597c3229eb023b1e626162d5947141bf7befb13";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: d0b0eec422547ac4f8e251bf7ee4e51c2917500e
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
 [fuzzy]
X-Received-From: 91.189.90.7
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
Reply-To: Bug 1852781 <1852781@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

ps is showing QEMU is running as follows:

/usr/bin/qemu-system-s390x -name guest=3Dubuntu20.04-focal-s390x,debug-
threads=3Don -S -object
secret,id=3DmasterKey0,format=3Draw,file=3D/var/lib/libvirt/qemu/domain-10-=
ubuntu20.04-focal-s3
/master-key.aes -machine s390-ccw-virtio-eoan,accel=3Dtcg,usb=3Doff,dump-
guest-core=3Doff -m 2048 -overcommit mem-lock=3Doff -smp
2,sockets=3D2,cores=3D1,threads=3D1 -uuid 6501dfbf-16d7-4412-a9d5-1ee808b42=
804
-display none -no-user-config -nodefaults -chardev
socket,id=3Dcharmonitor,fd=3D24,server,nowait -mon
chardev=3Dcharmonitor,id=3Dmonitor,mode=3Dcontrol -rtc base=3Dutc -no-shutd=
own
-boot strict=3Don -device virtio-scsi-ccw,id=3Dscsi0,devno=3Dfe.0.0002 -dev=
ice
virtio-serial-ccw,id=3Dvirtio-serial0,devno=3Dfe.0.0003 -drive file=3D/pool-
ssd/virt/ubuntu19.10-eaon-s390x-clone,format=3Dqcow2,if=3Dnone,id=3Ddrive-
virtio-disk0 -device virtio-blk-ccw,scsi=3Doff,devno=3Dfe.0.0000,drive
=3Ddrive-virtio-disk0,id=3Dvirtio-disk0,bootindex=3D1 -drive if=3Dnone,id=
=3Ddrive-
scsi0-0-0-0,readonly=3Don -device scsi-cd,bus=3Dscsi0.0,channel=3D0,scsi-
id=3D0,lun=3D0,device_id=3Ddrive-scsi0-0-0-0,drive=3Ddrive-
scsi0-0-0-0,id=3Dscsi0-0-0-0 -netdev tap,fd=3D27,id=3Dhostnet0 -device virt=
io-
net-ccw,netdev=3Dhostnet0,id=3Dnet0,mac=3D52:54:00:a3:21:68,devno=3Dfe.0.00=
01
-chardev socket,id=3Dcharchannel0,fd=3D28,server,nowait -device
virtserialport,bus=3Dvirtio-
serial0.0,nr=3D1,chardev=3Dcharchannel0,id=3Dchannel0,name=3Dorg.qemu.guest=
_agent.0
-chardev pty,id=3Dcharconsole0 -device
sclpconsole,chardev=3Dcharconsole0,id=3Dconsole0 -device virtio-balloon-
ccw,id=3Dballoon0,devno=3Dfe.0.0004 -object rng-
random,id=3Dobjrng0,filename=3D/dev/urandom -device virtio-rng-
ccw,rng=3Dobjrng0,id=3Drng0,devno=3Dfe.0.0005 -sandbox
on,obsolete=3Ddeny,elevateprivileges=3Ddeny,spawn=3Ddeny,resourcecontrol=3D=
deny
-msg timestamp=3Don

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1852781

Title:
  qemu s390x on focal - applications breaking

Status in QEMU:
  New

Bug description:
  Running qemu-system-s390x (1:4.0+dfsg-0ubuntu10) on an x86-64 Focal
  host with an upgrade of a Eoan s390x VM to a Focal s390x is triggering
  random breakage, for example:

  sudo apt-get update && sudo apt-get dist-upgrade

  ...
  ...

  Unpacking debianutils (4.9) over (4.8.6.3) ...
  Setting up debianutils (4.9) ...
  Use of uninitialized value $ARGV[0] in string ne at /usr/sbin/update-mime=
 line 43.
  (Reading database ... 83640 files and directories currently installed.)
  Preparing to unpack .../bash_5.0-5ubuntu1_s390x.deb ...
  Unpacking bash (5.0-5ubuntu1) over (5.0-4ubuntu1) ...
  Setting up bash (5.0-5ubuntu1) ...
  [12124.788618] User process fault: interruption code 0007 ilc:3 in bash[2=
aa3d780000+149000]
  dpkg: error processing package bash (--configure):
   installed bash package post-installation script subprocess was killed by=
 signal (Floating point exception), core du
  mped
  Errors were encountered while processing:
   bash
  E: Sub-process /usr/bin/dpkg returned an error code (1)

  And now bash is completely broken:

  cking@eoan-s390x:~$ bash
  [12676.204389] User process fault: interruption code 0007 ilc:3 in bash[2=
aa14780000+149000]

  Floating point exception (core dumped)

  The upgrade works OK on a s390x, so I'm assuming it's something to do
  with the qemu emulation.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1852781/+subscriptions

