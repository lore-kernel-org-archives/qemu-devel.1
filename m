Return-Path: <SRS0=hH57=EK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32150C2D0A3
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 22:41:54 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5B31920825
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Nov 2020 22:41:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5B31920825
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:41112 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1kaRTS-0004Bb-VY
	for qemu-devel@archiver.kernel.org; Wed, 04 Nov 2020 17:41:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10]:39792)
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaRSX-0003dc-Pz
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 17:40:53 -0500
Received: from indium.canonical.com ([91.189.90.7]:36304)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bounces@canonical.com>)
 id 1kaRSV-00062m-Uf
 for qemu-devel@nongnu.org; Wed, 04 Nov 2020 17:40:53 -0500
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1kaRST-0006q1-OT
 for <qemu-devel@nongnu.org>; Wed, 04 Nov 2020 22:40:49 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id B7E122E802E
 for <qemu-devel@nongnu.org>; Wed,  4 Nov 2020 22:40:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2020 22:34:35 -0000
From: John Snow <1893667@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Committed; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug: distribution=fedora; sourcepackage=qemu; component=None;
 status=Unknown; importance=Unknown; assignee=None; 
X-Launchpad-Bug-Tags: linux-user
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jnsnow ngompa13
X-Launchpad-Bug-Reporter: Neal Gompa (ngompa13)
X-Launchpad-Bug-Modifier: John Snow (jnsnow)
References: <159888546236.27779.1997908478541755158.malonedeb@soybean.canonical.com>
Message-Id: <160452927609.13286.10839590188936997723.malone@gac.canonical.com>
Subject: [Bug 1893667] Re: Btrfs commands don't work when using user-space
 emulation of other architectures
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com);
 Revision="e39939c02bd86af4202bc6e2123a7708215ec8ea"; Instance="production"
X-Launchpad-Hash: 613d68da6be6709bd16f0c0bab37cdfea22b626b
Received-SPF: none client-ip=91.189.90.7; envelope-from=bounces@canonical.com;
 helo=indium.canonical.com
X-detected-operating-system: by eggs.gnu.org: First seen = 2020/11/04 17:35:34
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
Reply-To: Bug 1893667 <1893667@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Laurent, I am assuming that the commits here:
https://gitlab.com/qemu-project/qemu/-/commits/master?utf8=3D%E2%9C%93&sear=
ch=3DFilip+Bozuta

are sufficient to mark this issue as Fix Committed. It looks like the
Downstream bug tracker for Fedora has marked the related bug as CLOSED
ERRATA already.

If I'm wrong, please reopen.

** Changed in: qemu
       Status: In Progress =3D> Fix Committed

** Changed in: qemu
       Status: Fix Committed =3D> In Progress

** Changed in: qemu
       Status: In Progress =3D> Fix Committed

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1893667

Title:
  Btrfs commands don't work when using user-space emulation of other
  architectures

Status in QEMU:
  Fix Committed
Status in qemu package in Fedora:
  Unknown

Bug description:
  Description of problem:
  When doing cross-arch builds with mock, it uses qemu-user-static under th=
e hood, and qemu-user-static lacks support for Btrfs ioctls to emulate so t=
hat btrfs(8) commands work correctly.

  This is especially important for being able to do cross-arch image
  builds.

  How reproducible:
  Always (on Fedora 33 with qemu-5.1.0-2.fc33)

  Steps to Reproduce:

  $ sudo dnf install mock qemu-user-static wget
  $ sudo usermod -a -G mock $USER
  $ newgrp mock
  $ mock --root fedora-rawhide-armhfp --install btrfs-progs util-linux
  $ mock --root fedora-rawhide-armhfp --chroot 'rm -f foo.img && dd if=3D/d=
ev/zero of=3Dfoo.img bs=3D1G count=3D1 && losetup /dev/loop9 foo.img &&  mk=
fs.btrfs /dev/loop9 && mkdir /foo && mount /dev/loop9 /foo && btrfs subvol =
create /foo/subvol && umount /foo && losetup -d /dev/loop9'

  =

  Actual results:
  Fails with errors like "ERROR: cannot create subvolume: Function not impl=
emented"

  Expected results:
  Succeeds and creates subvolumes properly.

  Additional info:
  There is a patch series from a few days ago to add support for many btrfs=
 ioctls which could fix this...

  https://lists.gnu.org/archive/html/qemu-devel/2020-08/msg05594.html

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1893667/+subscriptions

