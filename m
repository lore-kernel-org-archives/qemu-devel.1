Return-Path: <SRS0=Un+l=ED=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0693C388F7
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 13:52:36 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1930824728
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Oct 2020 13:52:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1930824728
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33588 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kXlsQ-0005xk-W2
	for qemu-devel@archiver.kernel.org; Wed, 28 Oct 2020 09:52:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50812)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kXlqY-0004iT-Ov
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 09:50:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:60138)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kXlqW-0002lC-IC
 for qemu-devel@nongnu.org; Wed, 28 Oct 2020 09:50:38 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kXlqU-0007XH-AV
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 13:50:34 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 495452E811E
 for <qemu-devel@nongnu.org>; Wed, 28 Oct 2020 13:50:34 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2020 13:40:55 -0000
From: Pablo Schandin <1901892@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: rq23a
X-Launchpad-Bug-Reporter: Pablo Schandin (rq23a)
X-Launchpad-Bug-Modifier: Pablo Schandin (rq23a)
Message-Id: <160389245558.14992.8062184889310483170.malonedeb@wampee.canonical.com>
Subject: [Bug 1901892] [NEW] qemu-img create corrupts the qcow2 if the file
 already exists
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="96ff31b88b65a0d0ea73b89333fe7c4a2669d8fb"; Instance="production"
X-Launchpad-Hash: 6161d98a7e26d18f3388485ac13fe23bb459f96c
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/10/28 09:50:34
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9,
 HEADER_FROM_DIFFERENT_DOMAINS=0.25, RCVD_IN_DNSWL_HI=-5,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
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
Reply-To: Bug 1901892 <1901892@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

When creating a disk using qemu-img create command, if the destination
path of the qcow2 file already exists, it will show the error saying
that it cannot get a lock so it exits with exit status 1 but it will
corrupt the qcow2 file anyway.

Steps to reproduce:
1. Have a guest running with a root (vda) and a second device (vdc).
In my case is a clean Ubuntu 16.04 image with kernel 4.4.0-190-generic x86_=
64
vdc disk is called testadddisk-3.qcow2
2. vdc is an xfs over lvm.
pvcreacte /dev/vdc
vgcreate myVg /dev/vdc
lvcreate -l+100%FREE -n myLv myVg
mkfs.xfs /dev/mapper/myVg-myLv
mount /dev/mapper/myVg-myLv /mnt
3. Create disk IO on that device in the guest.
while true ; do dd if=3D/dev/zero of=3D/mnt/testfile bs=3D1024 count=3D1000=
 ; sleep 1; done
4. Execute the command to create a new device but use the same name of the =
device attached:
sudo qemu-img create -f qcow2 testadddisk-3.qcow2 20G
The output of the command is this:
Formatting 'testadddisk-3.qcow2', fmt=3Dqcow2 size=3D21474836480 cluster_si=
ze=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
qemu-img: testadddisk-3.qcow2: Failed to get "write" lock
Is another process using the image?

The write continues in the guest but when it is shutdown, when it is powere=
d on again you get this:
error: Failed to start domain testadddisk
error: internal error: process exited while connecting to monitor: 2020-10-=
27T22:00:51.628374Z qemu-system-x86_64: -drive file=3D/var/lib/vmImages/tes=
tadddisk-3.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk2: Image is=
 not in qcow2 format

I run the qemu-img create command with an strace and I believe that
first it tries to open the file in write mode, then does a truncate on
it and after that says it cannot get a lock. The output is in the file
attached. As well as the guest xml just in case.

The host: =

Ubuntu 18.04.5 LTS
4.15.0-112-generic x86_64
qemu packages installed:
ii  qemu-block-extra:amd64                 1:2.11+dfsg-1ubuntu7.32         =
                amd64        extra block backend modules for qemu-system an=
d qemu-utils
ii  qemu-kvm                               1:2.11+dfsg-1ubuntu7.31         =
                amd64        QEMU Full virtualization on x86 hardware
ii  qemu-system-common                     1:2.11+dfsg-1ubuntu7.32         =
                amd64        QEMU full system emulation binaries (common fi=
les)
ii  qemu-system-x86                        1:2.11+dfsg-1ubuntu7.31         =
                amd64        QEMU full system emulation binaries (x86)
ii  qemu-utils                             1:2.11+dfsg-1ubuntu7.32         =
                amd64        QEMU utilities

** Affects: qemu
     Importance: Undecided
         Status: New

** Attachment added: "testadddisk-strace-dumxml.txt"
   https://bugs.launchpad.net/bugs/1901892/+attachment/5428520/+files/testa=
dddisk-strace-dumxml.txt

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1901892

Title:
  qemu-img create corrupts the qcow2 if the file already exists

Status in QEMU:
  New

Bug description:
  When creating a disk using qemu-img create command, if the destination
  path of the qcow2 file already exists, it will show the error saying
  that it cannot get a lock so it exits with exit status 1 but it will
  corrupt the qcow2 file anyway.

  Steps to reproduce:
  1. Have a guest running with a root (vda) and a second device (vdc).
  In my case is a clean Ubuntu 16.04 image with kernel 4.4.0-190-generic x8=
6_64
  vdc disk is called testadddisk-3.qcow2
  2. vdc is an xfs over lvm.
  pvcreacte /dev/vdc
  vgcreate myVg /dev/vdc
  lvcreate -l+100%FREE -n myLv myVg
  mkfs.xfs /dev/mapper/myVg-myLv
  mount /dev/mapper/myVg-myLv /mnt
  3. Create disk IO on that device in the guest.
  while true ; do dd if=3D/dev/zero of=3D/mnt/testfile bs=3D1024 count=3D10=
00 ; sleep 1; done
  4. Execute the command to create a new device but use the same name of th=
e device attached:
  sudo qemu-img create -f qcow2 testadddisk-3.qcow2 20G
  The output of the command is this:
  Formatting 'testadddisk-3.qcow2', fmt=3Dqcow2 size=3D21474836480 cluster_=
size=3D65536 lazy_refcounts=3Doff refcount_bits=3D16
  qemu-img: testadddisk-3.qcow2: Failed to get "write" lock
  Is another process using the image?

  The write continues in the guest but when it is shutdown, when it is powe=
red on again you get this:
  error: Failed to start domain testadddisk
  error: internal error: process exited while connecting to monitor: 2020-1=
0-27T22:00:51.628374Z qemu-system-x86_64: -drive file=3D/var/lib/vmImages/t=
estadddisk-3.qcow2,format=3Dqcow2,if=3Dnone,id=3Ddrive-virtio-disk2: Image =
is not in qcow2 format

  I run the qemu-img create command with an strace and I believe that
  first it tries to open the file in write mode, then does a truncate on
  it and after that says it cannot get a lock. The output is in the file
  attached. As well as the guest xml just in case.

  The host: =

  Ubuntu 18.04.5 LTS
  4.15.0-112-generic x86_64
  qemu packages installed:
  ii  qemu-block-extra:amd64                 1:2.11+dfsg-1ubuntu7.32       =
                  amd64        extra block backend modules for qemu-system =
and qemu-utils
  ii  qemu-kvm                               1:2.11+dfsg-1ubuntu7.31       =
                  amd64        QEMU Full virtualization on x86 hardware
  ii  qemu-system-common                     1:2.11+dfsg-1ubuntu7.32       =
                  amd64        QEMU full system emulation binaries (common =
files)
  ii  qemu-system-x86                        1:2.11+dfsg-1ubuntu7.31       =
                  amd64        QEMU full system emulation binaries (x86)
  ii  qemu-utils                             1:2.11+dfsg-1ubuntu7.32       =
                  amd64        QEMU utilities

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1901892/+subscriptions

