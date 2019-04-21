Return-Path: <SRS0=ydMe=SX=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 292A9C10F14
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 11:16:35 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E2B6820869
	for <qemu-devel@archiver.kernel.org>; Sun, 21 Apr 2019 11:16:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E2B6820869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=fnordpol.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:51781 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hIASX-0004fr-Tp
	for qemu-devel@archiver.kernel.org; Sun, 21 Apr 2019 07:16:33 -0400
Received: from eggs.gnu.org ([209.51.188.92]:38914)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIARj-0004Dz-Kt
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 07:15:44 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hIARg-0003Vj-77
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 07:15:42 -0400
Received: from indium.canonical.com ([91.189.90.7]:53804)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hIARg-0003UO-1n
	for qemu-devel@nongnu.org; Sun, 21 Apr 2019 07:15:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hIARd-00005Q-P6
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 11:15:37 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id B7FD82E80C7
	for <qemu-devel@nongnu.org>; Sun, 21 Apr 2019 11:15:37 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 21 Apr 2019 11:05:30 -0000
From: Hans <zem@fnordpol.de>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Tags: glusterfs qemu
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: jnsnow zem-g
X-Launchpad-Bug-Reporter: Hans (zem-g)
X-Launchpad-Bug-Modifier: Hans (zem-g)
References: <153763821634.24720.16203204034487714411.malonedeb@gac.canonical.com>
Message-Id:
 <155584473078.16775.3319459602933563233.malone@soybean.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18928";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: c9869ee40f3ef93265c67282b26468461f78ba1d
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1793904] Re: files are randomly overwritten by
 Zero Bytes
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.21
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <http://lists.nongnu.org/archive/html/qemu-devel/>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
	<mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Bug 1793904 <1793904@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
Message-ID: <20190421110530.Ow5Vcnu8rVpWmVCgf4H3wBnmMnFsyttDUrb5_OGaZPA@z>

I will have to put more efford into that: The bug applies to oVirt 4.3
too which seems to use a fuse filesystem.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1793904

Title:
  files are randomly overwritten by Zero Bytes

Status in QEMU:
  New

Bug description:
  Hello together,

  I am currently tracking down a "Hard to reproduce" bug on my systems
  that I first discovered during gitlab installation:

  =

  Here is the Text from the Gitlab Bug https://gitlab.com/gitlab-org/gitlab=
-ce/issues/51023
  -------------------------------------------------------------------------=
---------------------

  Steps to reproduce

  I still do not have all the steps together to reproduce, so far it is:
  apt install gitlab-ce and
  gitlab-rake backup:recovery
  Then it works for some time before it fails.

  What is the current bug behavior?

  I have a 12 hour old Installation of gitlab ce 11.2.3-ce.0 for debian
  stretch on a fresh debian stretch system together with our imported
  data. However it turns out that some gitlab related files contain Zero
  bytes instead of actual data.

  root@gitlab:~# xxd -l 16 /opt/gitlab/bin/gitlab-ctl
  00000000: 0000 0000 0000 0000 0000 0000 0000 0000  ................

  This behaviour is somewhat strange because it was working for a few
  minutes/hours. I did write a shell script to find out which files are
  affected of this memory loss. It turns out that only files located
  under /opt/gitlab are affected, if I rule out files like
  /var/log/faillog and some postgresql table files.

  What I find even stranger is that it does not seem to affect
  Logfiles/databases/git_repositorys but application files, like .rb
  scripts. and not all of them. No non gitlab package is affected.

  What is the expected correct behavior?
  Binarys and .rb files should stay as they are.

  Possible fixes

  I am still investigating, I hope that it is not an infrastructure problem=
 (libvirt/qemu/glusterfs) it can still be one but the point that files of /=
opt/gitlab are affected and not any logfile and that we to not have similar=
 problems with any other system leads me to the application for now.
  If I would have used docker the same problem might have caused a reboot o=
f the container.
  But for the Debian package it is a bit of work to recover. That is all a =
workaround, however.
  -------------------------------------------------------------------------=
--------------------

  I do have found 2 more systems having the same problem with different
  software:

  root@erp:~# xxd -l 16 /usr/share/perl/5.26.2/constant.pm
  00000000: 0000 0000 0000 0000 0000 0000 0000 0000  ................

  The Filesize itself is, compared with another machine 00001660 Bytes
  for both the corrupted and the intact file. It looks to me from the
  outside that if some data in the qcow2 file is written too many bytes
  get written so it sometimes overwites data of existing files located
  right after the position in memory where the write goes to.

  I would like to rule out Linux+Ext4 filesystems because I find it
  highly unlikely that such an error keeps undiscovered in that part of
  the environment for long. I think the same might go for qemu.

  Which leaves qemu, gemu+gluster:// mount, qcow2 volumes, glusterfs,
  network. So I am now going to check if I can find any system which
  gets its volumes via fusermount instead of gluster:// path if the
  error is gone there. This may take a while.

  =

  ----- some software versions---------------

  QEMU emulator version 2.12.0 (Debian 1:2.12+dfsg-3)
  Copyright (c) 2003-2017 Fabrice Bellard and the QEMU Project developers

  libvirt-daemon-driver-storage-gluster/testing,unstable,now 4.6.0-2
  amd64 [installed]

  ii  glusterfs-client   4.1.3-1        amd64

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1793904/+subscriptions

