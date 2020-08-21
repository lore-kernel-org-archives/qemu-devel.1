Return-Path: <SRS0=atk5=B7=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D400EC433E1
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 02:12:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AAE3F2076E
	for <qemu-devel@archiver.kernel.org>; Fri, 21 Aug 2020 02:12:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AAE3F2076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:33298 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1k8wX9-000204-Ui
	for qemu-devel@archiver.kernel.org; Thu, 20 Aug 2020 22:11:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49250)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8wVw-0001Xr-BL
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 22:10:44 -0400
Received: from indium.canonical.com ([91.189.90.7]:42944)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1k8wVu-0000AU-Ck
 for qemu-devel@nongnu.org; Thu, 20 Aug 2020 22:10:44 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1k8wVs-0006yo-Bx
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 02:10:40 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 4C4512E80DB
 for <qemu-devel@nongnu.org>; Fri, 21 Aug 2020 02:10:40 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2020 02:04:16 -0000
From: Ahmed Karaman <1892441@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: s390x softmmu
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ahmedkrmn
X-Launchpad-Bug-Reporter: Ahmed Karaman (ahmedkrmn)
X-Launchpad-Bug-Modifier: Ahmed Karaman (ahmedkrmn)
Message-Id: <159797545688.2805.5115079878417995484.malonedeb@chaenomeles.canonical.com>
Subject: [Bug 1892441] [NEW] "No zIPL section in IPL2 record" error when
 emulating Debian 10.5.0 on s390x
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="99c2d833c8d727fd05148486920aca032e908071"; Instance="production"
X-Launchpad-Hash: 86b729490371dd3b7bea2b04819b236bede48a45
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/08/20 22:10:40
X-ACL-Warn: Detected OS   = Linux 3.11 and newer [fuzzy]
X-Spam_score_int: -58
X-Spam_score: -5.9
X-Spam_bar: -----
X-Spam_report: (-5.9 / 5.0 requ) BAYES_00=-1.9, HEADER_FROM_DIFFERENT_DOMAINS=1,
 RCVD_IN_DNSWL_HI=-5, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
Reply-To: Bug 1892441 <1892441@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

Hi,

I want to emulate Debian 10.5.0 for the s390x architecture. =

The Debian image is downloaded from the following link:
https://cdimage.debian.org/debian-cd/current/s390x/iso-cd/debian-10.5.0-s39=
0x-netinst.iso =


Using the latest QEMU version 5.1.0, running the debian image using the giv=
en command:
qemu-system-s390x -boot d -m 4096 -hda debian.qcow -cdrom debian-10.5.0-s39=
0x-netinst.iso -nographic

causes the error output below:

LOADPARM=3D[        ]
Using virtio-blk.
Using guessed DASD geometry.
Using ECKD scheme (block size  4096), CDL

! No zIPL section in IPL2 record. !

** Affects: qemu
     Importance: Undecided
         Status: New


** Tags: s390x softmmu

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1892441

Title:
  "No zIPL section in IPL2 record" error when emulating Debian 10.5.0 on
  s390x

Status in QEMU:
  New

Bug description:
  Hi,

  I want to emulate Debian 10.5.0 for the s390x architecture. =

  The Debian image is downloaded from the following link:
  https://cdimage.debian.org/debian-cd/current/s390x/iso-cd/debian-10.5.0-s=
390x-netinst.iso =


  Using the latest QEMU version 5.1.0, running the debian image using the g=
iven command:
  qemu-system-s390x -boot d -m 4096 -hda debian.qcow -cdrom debian-10.5.0-s=
390x-netinst.iso -nographic

  causes the error output below:

  LOADPARM=3D[        ]
  Using virtio-blk.
  Using guessed DASD geometry.
  Using ECKD scheme (block size  4096), CDL

  ! No zIPL section in IPL2 record. !

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1892441/+subscriptions

