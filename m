Return-Path: <SRS0=iAYr=VY=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBB7C433FF
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2019 13:30:50 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 499EE2075C
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Jul 2019 13:30:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 499EE2075C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:45832 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hrMmf-0004SJ-5i
	for qemu-devel@archiver.kernel.org; Sat, 27 Jul 2019 09:30:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:34244)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hrMmU-000448-7c
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 09:30:39 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hrMmT-0008R9-1K
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 09:30:38 -0400
Received: from indium.canonical.com ([91.189.90.7]:56438)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hrMmS-0008Pq-S2
 for qemu-devel@nongnu.org; Sat, 27 Jul 2019 09:30:36 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hrMmR-00037b-HP
 for <qemu-devel@nongnu.org>; Sat, 27 Jul 2019 13:30:35 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 7BF7B2E8047
 for <qemu-devel@nongnu.org>; Sat, 27 Jul 2019 13:30:35 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jul 2019 13:24:19 -0000
From: "Steffen \(Daode\) Nurpmeso" <1838066@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: sdaoden xanclic
X-Launchpad-Bug-Reporter: Steffen (Daode) Nurpmeso (sdaoden)
X-Launchpad-Bug-Modifier: Steffen (Daode) Nurpmeso (sdaoden)
References: <156416003866.5869.12093759540682814562.malonedeb@soybean.canonical.com>
 <156422889569.6195.8735825632650411110.malone@soybean.canonical.com>
Message-Id: <20190727132419.VsB7Z%steffen@sdaoden.eu>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19010";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 594ad5a80a94b532369ec5f9eb30c81ed2027865
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: Re: [Qemu-devel] [Bug 1838066] Re: unexpected error:
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

Hello!

Max Reitz wrote in <156422889569.6195.8735825632650411110.malone@soybean\
.canonical.com>:
 |Hi,
 |
 |Can you retry with any 4.1 release candidate (like 4.1.0-rc2)?  (Or wait
 |for the 4.1.0 release in hopefully about a week?)  The error message
 |sounds like it should be fixed by https://lists.nongnu.org/archive/html
 |/qemu-block/2019-05/msg00775.html .

Ok?  Great news, i will wait until then, it does not really hurt
me (i do not even see it when now setting up a new VM with debug
and thus -display enabled).

Thanks!!

 |Though I have no idea why you would hit that if you didn=E2=80=99t add an=
y block
 |devices.

Was missing a line in the ps output, i see.
Yeah, sorry. ^_^
A nice weekend if at all possible i wish!

--steffen
|
|Der Kragenbaer,                The moon bear,
|der holt sich munter           he cheerfully and one by one
|einen nach dem anderen runter  wa.ks himself off
|(By Robert Gernhardt)

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

