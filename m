Return-Path: <SRS0=FTQm=VX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A2A2C7618B
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:01:00 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D80F220869
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Jul 2019 17:00:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D80F220869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41908 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hr3aV-0003TS-1m
	for qemu-devel@archiver.kernel.org; Fri, 26 Jul 2019 13:00:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:44943)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hr3aH-000350-Ts
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:00:47 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hr3aF-0007iY-Ll
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:00:45 -0400
Received: from indium.canonical.com ([91.189.90.7]:45980)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hr3aF-0007bY-G0
 for qemu-devel@nongnu.org; Fri, 26 Jul 2019 13:00:43 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hr3aD-00064P-Lz
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 17:00:41 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id A0CB92E80C7
 for <qemu-devel@nongnu.org>; Fri, 26 Jul 2019 17:00:41 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 26 Jul 2019 16:53:58 -0000
From: "Steffen \(Daode\) Nurpmeso" <1838066@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: sdaoden
X-Launchpad-Bug-Reporter: Steffen (Daode) Nurpmeso (sdaoden)
X-Launchpad-Bug-Modifier: Steffen (Daode) Nurpmeso (sdaoden)
Message-Id: <156416003866.5869.12093759540682814562.malonedeb@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: d8efd2366ee64d463fe0f68129b80165e9fcc219
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1838066] [NEW] unexpected error:
 raw_reconfigure_getfd(): qemu-system-x86_64: Could not reopen file
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
Reply-To: Bug 1838066 <1838066@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

  Unexpected error in raw_reconfigure_getfd() at block/file-posix.c:923:
  qemu-system-x86_64: Could not reopen file: Permission denied
  Aborted

Is what i sometimes (only) get, mostly for Linux guests i'd say (Arch just =
a few moments ago).
This is on CRUX-Linux, thus a self-compiled qemu 4.0.0 with default recipe,=
 without special compiler flags (-O2 -march=3Dx86-64 -pipe) on an Intel i5 =
laptop.
But what i do is running this via sudo:

     sudo=3D'sudo --preserve-env=3DVMNAME,VMADDR' runas=3D'-runas vm -chroo=
t .'
  fi

  VMADDR=3D$addr VMNAME=3D$vmname
  export VMADDR VMNAME
  eval exec $sudo qemu-system-x86_64 -name $vmname $runas \
      $host $accel $display $net $vmcustom $vmimg $redir

the last run ends up like (via sudo)

  qemu-system-x86_64 -name arch-2019 -runas vm -chroot . -cpu host -m
size=3D1984 -smp cpus=3D2 -enable-kvm -accel accel=3Dkvm,thread=3Dmulti -di=
splay
curses -net nic,netdev=3Dnet0,macaddr=3D..  -netdev
tap,id=3Dnet0,script=3D./.ifup.sh,downscript=3D./.ifdown.sh,ifname=3Dvm_arc=
h-2019

vm is a user effectively living in the chroot only without any rights anywh=
ere.
Hope this helps, thanks a lot for qemu!!

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1838066

Title:
  unexpected error: raw_reconfigure_getfd(): qemu-system-x86_64: Could
  not reopen file

Status in QEMU:
  New

Bug description:
    Unexpected error in raw_reconfigure_getfd() at block/file-posix.c:923:
    qemu-system-x86_64: Could not reopen file: Permission denied
    Aborted

  Is what i sometimes (only) get, mostly for Linux guests i'd say (Arch jus=
t a few moments ago).
  This is on CRUX-Linux, thus a self-compiled qemu 4.0.0 with default recip=
e, without special compiler flags (-O2 -march=3Dx86-64 -pipe) on an Intel i=
5 laptop.
  But what i do is running this via sudo:

       sudo=3D'sudo --preserve-env=3DVMNAME,VMADDR' runas=3D'-runas vm -chr=
oot .'
    fi

    VMADDR=3D$addr VMNAME=3D$vmname
    export VMADDR VMNAME
    eval exec $sudo qemu-system-x86_64 -name $vmname $runas \
        $host $accel $display $net $vmcustom $vmimg $redir

  the last run ends up like (via sudo)

    qemu-system-x86_64 -name arch-2019 -runas vm -chroot . -cpu host -m
  size=3D1984 -smp cpus=3D2 -enable-kvm -accel accel=3Dkvm,thread=3Dmulti
  -display curses -net nic,netdev=3Dnet0,macaddr=3D..  -netdev
  tap,id=3Dnet0,script=3D./.ifup.sh,downscript=3D./.ifdown.sh,ifname=3Dvm_a=
rch-2019

  vm is a user effectively living in the chroot only without any rights any=
where.
  Hope this helps, thanks a lot for qemu!!

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1838066/+subscriptions

