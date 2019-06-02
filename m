Return-Path: <SRS0=s7fR=UB=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94095C28CC3
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 00:44:30 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6F5502776C
	for <qemu-devel@archiver.kernel.org>; Sun,  2 Jun 2019 00:44:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6F5502776C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([127.0.0.1]:43028 helo=lists.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hXEbt-0006yr-OR
	for qemu-devel@archiver.kernel.org; Sat, 01 Jun 2019 20:44:29 -0400
Received: from eggs.gnu.org ([209.51.188.92]:59184)
	by lists.gnu.org with esmtp (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hXEal-0006Lj-4D
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 20:43:20 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
	(envelope-from <bounces@canonical.com>) id 1hXEOW-0003ex-It
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 20:30:41 -0400
Received: from indium.canonical.com ([91.189.90.7]:56174)
	by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
	(Exim 4.71) (envelope-from <bounces@canonical.com>)
	id 1hXEOW-0003eA-D0
	for qemu-devel@nongnu.org; Sat, 01 Jun 2019 20:30:40 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
	by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
	id 1hXEOU-000348-HG
	for <qemu-devel@nongnu.org>; Sun, 02 Jun 2019 00:30:38 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
	by loganberry.canonical.com (Postfix) with ESMTP id 7A7EA2E8076
	for <qemu-devel@nongnu.org>; Sun,  2 Jun 2019 00:30:38 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sun, 02 Jun 2019 00:21:57 -0000
From: Olie Hilt <1831354@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: ohilt
X-Launchpad-Bug-Reporter: Olie Hilt (ohilt)
X-Launchpad-Bug-Modifier: Olie Hilt (ohilt)
References: <155943483504.16885.17011343834954742829.malonedeb@chaenomeles.canonical.com>
Message-Id: <155943491760.16274.10660364226991324686.malone@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="18968";
	Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 517df38031523de5899c229d7e36f3d8e572c6de
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1831354] Re: unable to read symlinks when
 mounting 9p filesystem with security_model=mapped
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
Reply-To: Bug 1831354 <1831354@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
	<qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

On the host: readlink clang
clang-9

and guest:

ls: cannot read symbolic link 'clang': No such file or directory
lrwxrwxrwx 1 root root 7 May 30 02:21 clang

readlink clang

returns nothing.

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1831354

Title:
  unable to read symlinks when mounting 9p filesystem with
  security_model=3Dmapped

Status in QEMU:
  New

Bug description:
  I am trying to use clang that is mounted from a 9p filesystem that has th=
e options =

   -fsdev local,id=3Dvirtfs3,path=3D/clang,security_model=3Dmapped-file -de=
vice virtio-9p-pci,fsdev=3Dvirtfs3,mount_tag=3Dclang

  clang has symlinks to clang-9. eg /clang/clang/bin/clang is a symlink
  that points to clang-9 in the current directory.

  the clang filesystem is on a bind mount point on /clang/clang on the
  host and this is mapped to the same place on the guest. If I have the
  same virtfs mount point with the security_model=3Dnone I don't have this
  problem.

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1831354/+subscriptions

