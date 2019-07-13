Return-Path: <SRS0=hUdw=VK=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4563EC31E40
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 16:25:46 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12E0B2064A
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jul 2019 16:25:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12E0B2064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:57266 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.86_2)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hmKqG-0000c1-V9
	for qemu-devel@archiver.kernel.org; Sat, 13 Jul 2019 12:25:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:49940)
 by lists.gnu.org with esmtp (Exim 4.86_2)
 (envelope-from <bounces@canonical.com>) id 1hmKq0-0008Gg-Vx
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 12:25:30 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hmKpz-0008PV-R2
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 12:25:28 -0400
Received: from indium.canonical.com ([91.189.90.7]:48938)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hmKpz-0008PJ-LP
 for qemu-devel@nongnu.org; Sat, 13 Jul 2019 12:25:27 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hmKpy-0007ML-UQ
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2019 16:25:26 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id E350C2E80C8
 for <qemu-devel@nongnu.org>; Sat, 13 Jul 2019 16:25:26 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Sat, 13 Jul 2019 15:40:53 -0000
From: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <1836451@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=New; importance=Undecided; assignee=None;
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
Message-Id: <156303245351.28480.9481024859968233865.malonedeb@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19007";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: 3597f951c94998264ead3228d5b8c678fc0ecf3a
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1836451] [NEW] 'make info' fails due to errors in
 qemu-tech.texi
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
Reply-To: Bug 1836451 <1836451@bugs.launchpad.net>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: "Qemu-devel"
 <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>

Public bug reported:

git tag: v4.1.0-rc0
host: Fedora 29, x86_64

$ make info
make[1]: Entering directory 'qemu/slirp'
make[1]: Nothing to be done for 'all'.
make[1]: Leaving directory 'qemu/slirp'
  GEN     docs/version.texi
  GEN     qemu-options.texi
  GEN     qemu-monitor.texi
  GEN     qemu-img-cmds.texi
  GEN     qemu-monitor-info.texi
  GEN     qemu-doc.info
qemu/qemu-tech.texi:6: @menu reference to nonexistent node `Translator Inte=
rnals'
qemu/qemu-tech.texi:7: @menu reference to nonexistent node `QEMU compared t=
o other emulators'
qemu/qemu-tech.texi:9: @menu reference to nonexistent node `Bibliography'
Makefile:960: recipe for target 'qemu-doc.info' failed
make: *** [qemu-doc.info] Error 1

** Affects: qemu
     Importance: Undecided
         Status: New

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1836451

Title:
  'make info' fails due to errors in qemu-tech.texi

Status in QEMU:
  New

Bug description:
  git tag: v4.1.0-rc0
  host: Fedora 29, x86_64

  $ make info
  make[1]: Entering directory 'qemu/slirp'
  make[1]: Nothing to be done for 'all'.
  make[1]: Leaving directory 'qemu/slirp'
    GEN     docs/version.texi
    GEN     qemu-options.texi
    GEN     qemu-monitor.texi
    GEN     qemu-img-cmds.texi
    GEN     qemu-monitor-info.texi
    GEN     qemu-doc.info
  qemu/qemu-tech.texi:6: @menu reference to nonexistent node `Translator In=
ternals'
  qemu/qemu-tech.texi:7: @menu reference to nonexistent node `QEMU compared=
 to other emulators'
  qemu/qemu-tech.texi:9: @menu reference to nonexistent node `Bibliography'
  Makefile:960: recipe for target 'qemu-doc.info' failed
  make: *** [qemu-doc.info] Error 1

To manage notifications about this bug go to:
https://bugs.launchpad.net/qemu/+bug/1836451/+subscriptions

