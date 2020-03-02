Return-Path: <SRS0=3Wv1=4U=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85ED1C3F2D7
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:01:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C50F217F4
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Mar 2020 00:01:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C50F217F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:39934 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1j8v0L-0002kg-Kn
	for qemu-devel@archiver.kernel.org; Mon, 02 Mar 2020 19:01:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39201)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1j8uzc-0002GU-5v
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:01:01 -0500
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1j8uza-0005Fb-SZ
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:01:00 -0500
Received: from indium.canonical.com ([91.189.90.7]:39532)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1j8uza-0005Ej-Mn
 for qemu-devel@nongnu.org; Mon, 02 Mar 2020 19:00:58 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1j8uzZ-0002pV-04
 for <qemu-devel@nongnu.org>; Tue, 03 Mar 2020 00:00:57 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id EE9042E804A
 for <qemu-devel@nongnu.org>; Tue,  3 Mar 2020 00:00:56 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Mon, 02 Mar 2020 23:52:00 -0000
From: liang yan <lyan@suse.com>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: liangy
X-Launchpad-Bug-Reporter: liang yan (liangy)
X-Launchpad-Bug-Modifier: liang yan (liangy)
Message-Id: <158319312084.12323.11221527653494995336.malonedeb@soybean.canonical.com>
Subject: [Bug 1865626] [NEW] qemu hang when ipl boot from a mdev dasd
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e0878392dc799b267dea80578fa65500a5d74155";
 Instance="production-secrets-lazr.conf"
X-Launchpad-Hash: 67bf979e2d9affaee29c5227aeae1dc5a0e7c046
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
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
Reply-To: Bug 1865626 <1865626@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

qemu latest
kernel 5.3.18

I am using a passthrough dasd as boot device, the installment looks fine
and gets into reboot process. However VM could not boot and just hang as
below after that. I have been checking on "s390: vfio-ccw dasd ipl
support" series right now but no clue yet. Could anyone take a look for
it? Thanks.


s390vsw188:~ # bash test.sh
LOADPARM=3D[        ]
executing ccw chain at : 0x0000000000000018
executing ccw chain at : 0x000000000000e000

2020-03-01T06:24:56.879314Z qemu-system-s390x: warning: vfio-ccw (devno
fe.0.0000): PFCH flag forced


s390zp12:~ # cat test.sh
/root/qemu/s390x-softmmu/qemu-system-s390x \
-machine s390-ccw-virtio,accel=3Dkvm \
-nographic \
-bios /root/qemu/pc-bios/s390-ccw/s390-ccw.img \
-device vfio-ccw,id=3Dhostdev0,sysfsdev=3D/sys/bus/mdev/devices/08e8c006-14=
6d-48d3-b21a-c005f9d3a04b,,devno=3Dfe.0.0000,bootindex=3D1 \
-global vfio-ccw.force-orb-pfch=3Dyes \

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1865626

Title:
  qemu hang when ipl boot from a mdev dasd

Status in QEMU:
  New

Bug description:
  qemu latest
  kernel 5.3.18

  I am using a passthrough dasd as boot device, the installment looks
  fine and gets into reboot process. However VM could not boot and just
  hang as below after that. I have been checking on "s390: vfio-ccw dasd
  ipl support" series right now but no clue yet. Could anyone take a
  look for it? Thanks.


  s390vsw188:~ # bash test.sh
  LOADPARM=3D[        ]
  executing ccw chain at : 0x0000000000000018
  executing ccw chain at : 0x000000000000e000

  2020-03-01T06:24:56.879314Z qemu-system-s390x: warning: vfio-ccw
  (devno fe.0.0000): PFCH flag forced


  s390zp12:~ # cat test.sh
  /root/qemu/s390x-softmmu/qemu-system-s390x \
  -machine s390-ccw-virtio,accel=3Dkvm \
  -nographic \
  -bios /root/qemu/pc-bios/s390-ccw/s390-ccw.img \
  -device vfio-ccw,id=3Dhostdev0,sysfsdev=3D/sys/bus/mdev/devices/08e8c006-=
146d-48d3-b21a-c005f9d3a04b,,devno=3Dfe.0.0000,bootindex=3D1 \
  -global vfio-ccw.force-orb-pfch=3Dyes \

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1865626/+subscriptions

