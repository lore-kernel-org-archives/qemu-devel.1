Return-Path: <SRS0=pVGd=WM=nongnu.org=qemu-devel-bounces+qemu-devel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CDAEC3A59C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:22:02 +0000 (UTC)
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 53E422064A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2019 05:22:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 53E422064A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=bugs.launchpad.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Received: from localhost ([::1]:49420 helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>)
	id 1hyUgb-0004vh-Fq
	for qemu-devel@archiver.kernel.org; Fri, 16 Aug 2019 01:22:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10]:50439)
 by lists.gnu.org with esmtp (Exim 4.90_1)
 (envelope-from <bounces@canonical.com>) id 1hyUfP-00048g-Fz
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:20:48 -0400
Received: from Debian-exim by eggs.gnu.org with spam-scanned (Exim 4.71)
 (envelope-from <bounces@canonical.com>) id 1hyUfO-000067-6a
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:20:47 -0400
Received: from indium.canonical.com ([91.189.90.7]:53894)
 by eggs.gnu.org with esmtps (TLS1.0:RSA_AES_128_CBC_SHA1:16)
 (Exim 4.71) (envelope-from <bounces@canonical.com>)
 id 1hyUfO-0008Uw-1D
 for qemu-devel@nongnu.org; Fri, 16 Aug 2019 01:20:46 -0400
Received: from loganberry.canonical.com ([91.189.90.37])
 by indium.canonical.com with esmtp (Exim 4.86_2 #2 (Debian))
 id 1hyUfN-0004gj-CX
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:20:45 +0000
Received: from loganberry.canonical.com (localhost [127.0.0.1])
 by loganberry.canonical.com (Postfix) with ESMTP id 576192E8053
 for <qemu-devel@nongnu.org>; Fri, 16 Aug 2019 05:20:45 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Date: Fri, 16 Aug 2019 05:14:23 -0000
From: Thomas Huth <1836451@bugs.launchpad.net>
To: qemu-devel@nongnu.org
X-Launchpad-Notification-Type: bug
X-Launchpad-Bug: product=qemu; status=Fix Released; importance=Undecided;
 assignee=None; 
X-Launchpad-Bug-Tags: docs
X-Launchpad-Bug-Information-Type: Public
X-Launchpad-Bug-Private: no
X-Launchpad-Bug-Security-Vulnerability: no
X-Launchpad-Bug-Commenters: philmd
X-Launchpad-Bug-Reporter: =?utf-8?q?Philippe_Mathieu-Daud=C3=A9_=28philmd?=
 =?utf-8?q?=29?=
X-Launchpad-Bug-Modifier: Thomas Huth (th-huth)
References: <156303245351.28480.9481024859968233865.malonedeb@chaenomeles.canonical.com>
Message-Id: <156593246465.22768.17668278720978741435.launchpad@chaenomeles.canonical.com>
X-Launchpad-Message-Rationale: Subscriber (QEMU) @qemu-devel-ml
X-Launchpad-Message-For: qemu-devel-ml
Precedence: bulk
X-Generated-By: Launchpad (canonical.com); Revision="19022";
 Instance="launchpad-lazr.conf"
X-Launchpad-Hash: dae73493722e600cfe66916eeabcf6be956112bd
X-detected-operating-system: by eggs.gnu.org: GNU/Linux 2.2.x-3.x [generic]
X-Received-From: 91.189.90.7
Subject: [Qemu-devel] [Bug 1836451] Re: 'make info' fails due to errors in
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

** Changed in: qemu
       Status: Fix Committed =3D> Fix Released

-- =

You received this bug notification because you are a member of qemu-
devel-ml, which is subscribed to QEMU.
https://bugs.launchpad.net/bugs/1836451

Title:
  'make info' fails due to errors in qemu-tech.texi

Status in QEMU:
  Fix Released

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

